/***********************************************************
 *
 * 说 明：用户登录、查看、保存处理
 * 作 者：yangjianliang
 * 日 期：2007-11-1
 *
 **********************************************************/
package com.yszoe.identity.action;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import com.yszoe.framework.util.PropDbUtil;
import com.yszoe.identity.IdConstants;
import com.yszoe.identity.entity.LoginUserVO;
import com.yszoe.identity.entity.TSysButton;
import com.yszoe.identity.entity.TSysDepart;
import com.yszoe.identity.entity.TSysMenu;
import com.yszoe.identity.entity.TSysUser;
import com.yszoe.identity.service.IdUserService;
import com.yszoe.sys.action.AbstractBaseActionSupport;
import com.yszoe.uniid.UniIdService;

public class IdUserAction extends AbstractBaseActionSupport {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private static final Log LOG = LogFactory.getLog(IdUserAction.class);

	private TSysUser tsysUser;
	private List<TSysUser> tsysUsers;
	private IdUserService idUserService;
	private UniIdService uniIdService;
	List<TSysMenu> tsysMenues;
	List<TSysButton> tsysMenueButtons;

	/**
	 * 打开登录页面，如果已经登录，自动转到管理页面
	 * 
	 * @return Struts配置的转向标记（字符串）
	 */
	@Override
	public String execute() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		if (session.getAttribute(IdConstants.SESSION_USER) != null) {
			return SUCCESS;
		}
		return LOGIN;
	}

	/**
	 * 登录，获取菜单
	 * 
	 * @param browserLogin 客户端游览器登录（非服务端自动登录）
	 * @return Struts配置的转向标记（字符串）
	 */
	public String login(boolean browserLogin) {
		if (tsysUser == null || tsysUser.getUserloginid() == null) {
			return LOGIN;
		}

		HttpSession session = getRequest().getSession(true);
		if (PropDbUtil.getBoolean(IdConstants.OPEN_U_V_I_C) && browserLogin) {
			// 开启登录验证码功能，且客户端游览器登录（非服务端自动登录）
			String u_v_i_c = getRequest().getParameter("u_v_i_c");// user

			if (u_v_i_c == null || u_v_i_c.replaceAll(" ", "").length() < 1) {
				this.addActionError("请输入验证码！");
				return LOGIN;
			}

			String v_i_c = (String) session.getAttribute(IdConstants.LOGIN_VALIDATE_IMAGE_CONTENT);
			if (!u_v_i_c.equals(v_i_c)) {
				this.addActionError("您输入的验证码错误！");
				return LOGIN;
			} else {
				// session.removeAttribute(IdConstants.LOGIN_VALIDATE_IMAGE_CONTENT);
			}
		}

		TSysUser userInDB = idUserService.entity(tsysUser.getUserloginid());
		if (userInDB == null) {
			addActionMessage("用户名不存在！");
			return LOGIN;
		}

		if (!userInDB.getUserpwd().equals(tsysUser.getUserpwd())) {
			addActionMessage("密码不正确！");
			return LOGIN;
		}

		if (IdConstants.USER_STATE_FORBID.equals(userInDB.getState())) {
			addActionMessage("该用户帐号暂停使用！");
			return LOGIN;
		}

		TSysDepart depart = userInDB.getDepart();
		if(depart==null){
			addActionMessage("该用户没有隶属单位信息！");
			return LOGIN;
		}
		final String departState = depart.getState();
		if (IdConstants.USER_STATE_FORBID.equals(departState)) {
			addActionMessage("该用户的单位已经被注销或暂停使用！");
			return LOGIN;
		}

		/****************************** 用户已经登陆，则退出前一个 *************************/
		String userLoginId = tsysUser.getUserloginid();
		boolean singleLogin = PropDbUtil.getBoolean(IdConstants.SINGLE_LOGIN);
		// 是否开启了同一用户同一时间所有节点上只能登录一个的要求
		if (singleLogin) {
			String NO_SINGLE_LOGIN_USERTYPE = PropDbUtil.get(IdConstants.NO_SINGLE_LOGIN_USERTYPE);
			String userType = userInDB.getUsertype();
			// 如果启用了单个登陆限制，下面判断是否开启针对指定用户类型开放任意登陆功能。20101026深圳资助需求学生自己申请
			if (StringUtils.isBlank(userType) || StringUtils.isBlank(NO_SINGLE_LOGIN_USERTYPE)
					|| !userType.equals(NO_SINGLE_LOGIN_USERTYPE)) {
				// 下面种种情况才需要做单个登陆控制
				HttpSession exsit_session = LoginUserVO.getThisUserSession(userLoginId);// 在当前节点session里找
				if (exsit_session == null) {
					if (uniIdService == null) {
						LOG.error("Lost the uniIdService's implement class. Notify uniId server failure!");
						addActionMessage("缺少统一身份认证服务对象！");
						return LOGIN;
					}
					// 用户未在当前节点登录，用远程接口检查是否在其他节点登录
					try {
						uniIdService.removeThisUser(userLoginId);
					} catch (Exception e1) {
						LOG.error(e1);
						addActionError(e1.getMessage());
						return LOGIN;
					}
				} else {
					// 用户已经在此节点登陆了
					if (session != exsit_session) {
						// 用户刷新的话2个session是同一个，说明此时不是在刷。
						// 退出已登录用户，让当前用户登陆
						if (LOG.isInfoEnabled()) {
							LOG.info("一个已经登录的账户强行登录系统！");
						}
						exsit_session.invalidate();// SESSION失效，自动从在线用户列表移除该用户
					}
				}
			}
		}

		/****************************** 用户已经登陆，则退出前一个 *************************/

		int maxOnlineCount = PropDbUtil.getInteger(IdConstants.MAX_ONLINE_COUNT);// 单个节点允许最大在线数
		if (maxOnlineCount < 1) {
			LOG.error("没有取到最大在线人数值，将使用默认最大人数1000！");
			maxOnlineCount = 1000;
		}
		if (LoginUserVO.getCurrentOnlineCount() >= maxOnlineCount) {
			// 目前在线人数达到最大数
			if (LOG.isWarnEnabled()) {
				LOG.warn("此服务器在线人数已达到最大数：" + maxOnlineCount);
			}
			addActionMessage("此服务器在线人数已达到最大数，请稍候再登录系统！");
			return LOGIN;
		}

		/**
		 * 版权控制start try { Copyright.validate(); } catch (Exception e) {
		 * addActionMessage(getText("MESSAGE_OPERATE_FAILURE") +" ["+
		 * e.getMessage() + "]"); } /** 版权控制end
		 */

		// tsysUser = userInDB;
		LoginUserVO loginUserVO = new LoginUserVO();
		loginUserVO.setDepart(userInDB.getDepart());
		loginUserVO.setState(userInDB.getState());
		loginUserVO.setUserid(userInDB.getUserid());
		loginUserVO.setUserloginid(userInDB.getUserloginid());
		loginUserVO.setUsername(userInDB.getUsername());
		loginUserVO.setUserpwd(userInDB.getUserpwd());
		loginUserVO.setUsertype(userInDB.getUsertype());
		loginUserVO.setClientIP(getRequest().getRemoteAddr());
		try {
			loginUserVO.setServerIP(InetAddress.getLocalHost().getHostAddress());
		} catch (UnknownHostException e1) {
			LOG.error(e1);
			addActionError("获取登录服务节点地址出错：" + e1.getMessage());
			return LOGIN;
		}
		loginUserVO.setLoginTime(new Date());
		loginUserVO.setSession(session);

		session.setAttribute(IdConstants.SESSION_USER, loginUserVO);

		tsysMenues = idUserService.loadMyMenu(loginUserVO);
		session.setAttribute(IdConstants.SESSION_USER_RIGHT_MENUS, tsysMenues);// 存储以后过滤URL权限用

		tsysMenueButtons = idUserService.loadMyMenuButton(loginUserVO);
		session.setAttribute(IdConstants.SESSION_USER_RIGHT_MENUBUTTONS, tsysMenueButtons);// 存储以后过滤URL权限用

		return SUCCESS;
	}

	public String login() {
		return login(true);
	}

	/**
	 * 打开左侧菜单页面
	 * 
	 * @return Struts配置的转向标记（字符串）
	 */
	public String leftMenu() {
		HttpSession session = getRequest().getSession();
		if (session != null && session.getAttribute(IdConstants.SESSION_USER) != null) {
			return "leftMenu";
		}
		return LOGIN;
	}

	/**
	 * 打开右上侧登录信息页面
	 * 
	 * @return Struts配置的转向标记（字符串）
	 */
	public String headMessage() {
		HttpSession session = getRequest().getSession();
		if (session != null && session.getAttribute(IdConstants.SESSION_USER) != null) {
			return "headMessage";
		}
		return LOGIN;
	}

	/**
	 * 用户修改密码
	 * 
	 * @return Struts配置的转向标记（字符串）
	 */
	public String modifyPassword() {

		HttpSession session = ServletActionContext.getRequest().getSession();
		TSysUser existMember = (TSysUser) session.getAttribute(IdConstants.SESSION_USER);

		String message = idUserService.modifyPassword(existMember, tsysUser);
		this.addActionMessage(message);

		return toView("repwd.jsp");
	}

	/**
	 * 用户退出登录
	 * 
	 * @return Struts配置的转向标记（字符串）
	 */
	public final String logout() {
		getSession().invalidate();// local session remove
		return LOGIN;
	}

	public TSysUser getTsysUser() {
		return tsysUser;
	}

	public void setTsysUser(TSysUser tsysUser) {
		this.tsysUser = tsysUser;
	}

	public IdUserService getIdUserService() {
		return idUserService;
	}

	public void setIdUserService(IdUserService idUserService) {
		this.idUserService = idUserService;
	}

	public List<TSysMenu> getTsysMenues() {
		return tsysMenues;
	}

	public void setTsysMenues(List<TSysMenu> tsysMenues) {
		this.tsysMenues = tsysMenues;
	}

	public List<TSysUser> getTsysUsers() {
		return tsysUsers;
	}

	public void setTsysUsers(List<TSysUser> tsysUsers) {
		this.tsysUsers = tsysUsers;
	}

	public UniIdService getUniIdService() {
		return uniIdService;
	}

	public void setUniIdService(UniIdService uniIdService) {
		this.uniIdService = uniIdService;
	}

	public List<TSysButton> getTsysMenueButtons() {
		return tsysMenueButtons;
	}

	public void setTsysMenueButtons(List<TSysButton> tsysMenueButtons) {
		this.tsysMenueButtons = tsysMenueButtons;
	}

}
