package com.yszoe.identity.entity;

import java.lang.reflect.InvocationTargetException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.PropDbUtil;
import com.yszoe.identity.IdConstants;
import com.yszoe.sys.util.SQLConfigUtil;
import com.yszoe.util.DateUtil;

/**
 * 实现HttpSessionBindingListener接口，为了统计在线人数
 * 往session中添加、移除本类，会触发valueBound和valueUnbound方法。无须其他配置。
 * 此类扩展于TSysUser，增加登录IP和登录时间记录
 * 
 * @author Yangjianliang datetime 2009-4-18
 */
public class LoginUserVO extends TSysUser implements HttpSessionBindingListener {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private static final Log LOG = LogFactory.getLog(LoginUserVO.class);

	private static ConcurrentHashMap<String, LoginUserVO> onlineUsers = new ConcurrentHashMap<String, LoginUserVO>(128);// 保存sessionID和username的映射

	private String clientIP;// 登录人的客户端IP

	private String serverIP;// 在哪个服务器上登录，服务器的IP

	private Date loginTime;// 登录时间

	private HttpSession session;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * javax.servlet.http.HttpSessionBindingListener#valueBound(javax.servlet
	 * .http.HttpSessionBindingEvent)
	 */
	public void valueBound(HttpSessionBindingEvent event) {

		LoginUserVO user = (LoginUserVO) event.getValue();
		onlineUsers.put(event.getSession().getId(), user);
		if (LOG.isInfoEnabled()) {
			LOG.info(user.getUsername() + "[账号：" + user.getUserloginid() + "]" + " 登录系统" + ",目前有"
					+ getCurrentOnlineCount() + "个用户已登录");
		}

		/************************ UniId begin *********************************/
		// 通知统一身份认证服务中心。此处的实现是通过数据库
		boolean singleLogin = PropDbUtil.getBoolean(IdConstants.SINGLE_LOGIN);// 是否开启了同一用户同一时间所有节点上只能登录一个的要求
		if (singleLogin) {
			try {
				String sql = SQLConfigUtil.getSql("sql.loginUserVO.count");
				int onlineNum = DBUtil.count(sql, getUserloginid());
				if (onlineNum == 0) {
					sql = SQLConfigUtil.getSql("sql.loginUserVO.insert");
					DBUtil.executeSQL(sql, getUserloginid(), getClientIP(), getServerIP(), DateUtil.currentTime());
				}
			} catch (SQLException e) {
				LOG.error(e);
			}
		}
		/************************ UniId end *********************************/
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * javax.servlet.http.HttpSessionBindingListener#valueUnbound(javax.servlet
	 * .http.HttpSessionBindingEvent)
	 */
	public void valueUnbound(HttpSessionBindingEvent event) {
		// 刷新页面的时候，TSysUser为null，所以要判断一下
		LoginUserVO user = (LoginUserVO) event.getValue();
		if (user != null) {
			/************************ UniId begin *********************************/
			// 通知统一身份认证服务中心。此处的实现是通过数据库
			boolean singleLogin = PropDbUtil.getBoolean(IdConstants.SINGLE_LOGIN);// 是否开启了同一用户同一时间所有节点上只能登录一个的要求
			if (singleLogin) {
				String sql = SQLConfigUtil.getSql("sql.loginUserVO.delete");
				DBUtil.executeSQL(sql, user.getUserloginid());// 移除在线用户表中用户信息
			}
			/************************ UniId end *********************************/

			onlineUsers.remove(event.getSession().getId());
			if (LOG.isInfoEnabled()) {
				LOG.info(user.getUsername() + "[账号：" + user.getUserloginid() + "]" + " 退出系统" + ",目前有"
						+ getCurrentOnlineCount() + "个用户已登录");
			}

		} else {
			if (LOG.isInfoEnabled()) {
				LOG.info(" 一个用户刷新系统" + ",目前有" + getCurrentOnlineCount() + "个用户已登录");
			}
		}
	}

	/**
	 * 验证在session中是否存在已相同的用户登录
	 * 
	 * @param userLoginID 用户登陆账号
	 * @return 已登录，返回true
	 */
	public static boolean isThisUserLogined(String userLoginID) {

		return getThisUserSession(userLoginID) != null;
	}

	/**
	 * 取指定用户的session
	 * 
	 * @param userLoginID 用户登陆账号
	 * @return 用户未登录，返回null
	 */
	public static HttpSession getThisUserSession(String userLoginID) {
		HttpSession ret = null;
		for (LoginUserVO userSrc : onlineUsers.values()) {
			if (userSrc.getUserloginid().equals(userLoginID)) {
				ret = userSrc.getSession();
				break;
			}
		}
		return ret;
	}

	public static int getCurrentOnlineCount() {
		return onlineUsers.size();
	}

	/**
	 * 返回在线人员列表数据，注意返回的是克隆出来的新集合，对它的修改不会影响到原集合
	 * 
	 * @return 克隆出来的新集合
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 * @throws InvocationTargetException
	 * @throws NoSuchMethodException
	 */
	public static List<LoginUserVO> getOnlineUsers() throws IllegalAccessException, InstantiationException,
			InvocationTargetException, NoSuchMethodException {
		List<LoginUserVO> newMap = new ArrayList<LoginUserVO>(onlineUsers.size());
		for (LoginUserVO userSrc : onlineUsers.values()) {
			TSysDepart newDepart = new TSysDepart();
			TSysDepart srcDepart = userSrc.getDepart();
			BeanUtils.copyProperties(newDepart, srcDepart);

			LoginUserVO newUser = new LoginUserVO();
			BeanUtils.copyProperties(newUser, userSrc);

			newUser.setDepart(newDepart);
			newMap.add(newUser);
		}
		return newMap;
	}

	public Date getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}

	public HttpSession getSession() {
		return session;
	}

	public void setSession(HttpSession session) {
		this.session = session;
	}

	public String getClientIP() {
		return clientIP;
	}

	public void setClientIP(String clientIP) {
		this.clientIP = clientIP;
	}

	public String getServerIP() {
		return serverIP;
	}

	public void setServerIP(String serverIP) {
		this.serverIP = serverIP;
	}

}
