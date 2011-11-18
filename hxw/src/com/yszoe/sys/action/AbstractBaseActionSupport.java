package com.yszoe.sys.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.framework.action.BaseAction;
import com.yszoe.identity.IdConstants;
import com.yszoe.identity.entity.TSysButton;
import com.yszoe.identity.entity.TSysDepart;
import com.yszoe.identity.entity.TSysMenu;
import com.yszoe.identity.entity.TSysUser;
import com.yszoe.identity.security.CheckLoginInterceptor;
import com.yszoe.sys.entity.ApplicationEnum;
import com.yszoe.sys.service.ApplicationEnumService;

/**
 * 业务系统的基类Action 抽象、封装了一些共用业务方法
 * 
 * @author yangjianliang 2008-9-5
 */
@SuppressWarnings( { "serial", "unchecked" })
public abstract class AbstractBaseActionSupport extends BaseAction {

	// private static final Log log =
	// LogFactory.getLog(AbstractBaseActionSupport.class);

	/**
	 * 系统数据字典
	 */
	protected ApplicationEnumService applicationEnumService;

	/**
	 * 当前登录用户
	 */
	private TSysUser user;

	public ApplicationEnumService getApplicationEnumService() {
		return applicationEnumService;
	}

	public void setApplicationEnumService(ApplicationEnumService applicationEnumService) {
		this.applicationEnumService = applicationEnumService;
	}

	/**
	 * 返回当前登录用户的登录标识 不存在则返回空字符串
	 * 
	 * @return 当前登录用户的登录账户
	 */
	public String getUserloginid() {

		TSysUser user = (TSysUser) getSession().getAttribute(IdConstants.SESSION_USER);
		String userLoginId = user != null ? user.getUserloginid() : "";
		return userLoginId;
	}

	/**
	 * @return 当期登录用户的所属部门的部门编号
	 */
	public String getDepartid() {
		String currentDepartId = null;
		TSysUser tsu = getLoginuser();
		if (tsu != null) {
			TSysDepart tdp = tsu.getDepart();
			if (tdp != null) {
				currentDepartId = tdp.getDepartid();
			}
		}
		return currentDepartId;
	}

	/**
	 * @return 当前登录用户的所属部门的名称
	 */
	public String getDepartname() {
		return getDepart().getDepartname();
	}

	/**
	 * 取得当前登录用户的所属部门
	 * 
	 * @return 部门对象
	 */
	public TSysDepart getDepart() {
		TSysUser tsu = getLoginuser();
		if (tsu == null) {
			throw new RuntimeException(getText("EXCEPTION_NULL_USER"));
		}
		TSysDepart tdp = tsu.getDepart();
		return tdp;
	}

	/**
	 * 当前登录用户信息对象
	 * 
	 * @return TSysUser 对象
	 */
	public TSysUser getLoginuser() {
		if (user == null) {
			user = (TSysUser) getSession().getAttribute(IdConstants.SESSION_USER);
		}
		return user;
	}

	/*
	 * public TSysUser loadUserFromDB() {//这个临时演示加的判断，实际运营不需要 if(user==null){
	 * String userID =
	 * (String)getSession().getAttribute(Constants.SESSION_USERID_FLAG); user =
	 * userService.entity(userID); } return user; }
	 */
	public void setUser(TSysUser user) {
		this.user = user;
	}

	/**
	 * 系统字典
	 * 
	 * @return
	 */
	public List<ApplicationEnum> getSysCode(String zdlb) {

		List<ApplicationEnum> list = null;
		if (zdlb != null) {
			String hql = "select new ApplicationEnum(t.zdbm,t.zdmc) from TSysCode t where t.zdlb=? and t.sfsy='1' order by length(t.zdbm), t.zdbm ";
			list = applicationEnumService.getApplicationEnums(true, hql, zdlb);
		} else {
			list = new ArrayList<ApplicationEnum>(0);
		}
		return list;
	}

	/**
	 * 系统字典类别
	 * 
	 * @return
	 */
	public List<ApplicationEnum> getSysCodeSort() {

		String hql = "select new ApplicationEnum(t.zdlb,t.lbmc) from TSysCodesort t group by t.zdlb,t.lbmc order by t.zdlb";
		return applicationEnumService.getApplicationEnums(true, hql);
	}

	/**
	 * 历史年度，用于业务查询
	 * 
	 * @param entityName 要查询的表对象名称
	 * @param nd 年度字段列名称 带"_"表示是时间类型的字段,要处理
	 * @return 历史年度列表
	 */
	public List<ApplicationEnum> getNd(String entityName, String nd) {
		StringBuffer hql = new StringBuffer("");
		if (nd.indexOf("_") != -1) {
			nd = "to_char(" + nd.substring(0, nd.length() - 1) + ",'yyyy')";
		}
		String _nd_ = "substr(" + nd + ",0,4)";
		hql.append("select new ApplicationEnum(").append(_nd_).append(" as bbnd1, ").append(_nd_).append(
				" as bbnd2 ) from ").append(entityName).append(" group by ").append(_nd_).append(" order by ").append(
				_nd_).append(" desc");
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(false, hql.toString());
		ApplicationEnum a = new ApplicationEnum();
		a.setId("");
		a.setCaption("--请选择--");
		list.add(0, a);
		for (int i = 0; i < list.size(); i++) {
			ApplicationEnum b = list.get(i);
			if (StringUtils.isBlank(b.getCaption())) {
				list.remove(i);
				i--;
			}
		}
		return list;
	}

	/**
	 * 获取区域信息字典
	 * 
	 * @return
	 */
	public List<ApplicationEnum> getAreaCode() {

		String hql = "select new ApplicationEnum(t.areaid,t.areaname) from TSysArea t order by t.areaid";
		return applicationEnumService.getApplicationEnums(true, hql);
	}

	/**
	 * 获取用户菜单配置按钮信息
	 * 
	 * @throws Exception
	 */
	public void getUserRoleMenuButton() throws Exception {
		String userRoleMenuButton = "";
		TSysMenu tsysMenu = CheckLoginInterceptor.getCurrentAccessedMenuObject(getRequest());
		String menuid = tsysMenu.getMenuid();
		List<TSysButton> menubuttons = (List<TSysButton>) getSession().getAttribute(
				IdConstants.SESSION_USER_RIGHT_MENUBUTTONS);
		for (int i = 0; i < menubuttons.size(); i++) {
			TSysButton tsysButton = menubuttons.get(i);
			if (menuid.equals(tsysButton.getMenuid()))
				userRoleMenuButton += "<button onclick=\"" + tsysButton.getButtonevent()
						+ "\" class=\"button\" style=\"width: 66px; padding-left: 5px;\"><span class=\""
						+ tsysButton.getButtonicon() + " hand\" title=\""
						+ (tsysButton.getMemo() == null ? "" : tsysButton.getMemo()) + "\">"
						+ tsysButton.getButtonname() + "</span></button>\n";
		}
		setParameter("userRoleMenuButton", userRoleMenuButton);
	}

}