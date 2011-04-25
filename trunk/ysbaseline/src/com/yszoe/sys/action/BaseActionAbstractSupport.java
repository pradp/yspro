package com.yszoe.sys.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.framework.action.BaseAction;
import com.yszoe.framework.identity.entity.TSysMenu;
import com.yszoe.framework.identity.entity.TSysUser;
import com.yszoe.framework.identity.security.CheckLoginInterceptor;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.sys.SysConstants;
import com.yszoe.sys.entity.ApplicationEnum;
import com.yszoe.sys.entity.TSysButtonRule;
import com.yszoe.sys.service.ApplicationEnumService;
import com.yszoe.sys.util.OpenTimeCtrlUtil;

/**
 * 业务系统的基类Action 抽象、封装了一些共用业务方法
 *
 * @author yangjianliang 2008-9-5
 */
@SuppressWarnings( { "serial", "unchecked" })
public abstract class BaseActionAbstractSupport extends BaseAction {

	private static final Log log = LogFactory.getLog(BaseActionAbstractSupport.class);

	/**
	 * 系统数据字典
	 */
	protected ApplicationEnumService applicationEnumService;

	/**
	 * 该系统中所有表的主键都是wid，所以抽象它放到这里
	 */
	private String wid;

	public ApplicationEnumService getApplicationEnumService() {
		return applicationEnumService;
	}

	public void setApplicationEnumService(ApplicationEnumService applicationEnumService) {
		this.applicationEnumService = applicationEnumService;
	}

	public String getWid() {
		return wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	/**
	 * 系统字典
	 *
	 * @return
	 */
	public List<ApplicationEnum> getSysCode() {

		String zdlb = getParameter("zdlb");
		return getSysCode(zdlb);
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

		String hql = "select new ApplicationEnum(t.zdlb,t.lbmc) from TSysCodeSort t group by t.zdlb,t.lbmc order by t.zdlb";
		return applicationEnumService.getApplicationEnums(true, hql);
	}

	/**
	 * 性别
	 *
	 * @return
	 */
	public List<ApplicationEnum> getXb() {
		setParameter("zdlb", "xb");
		List<ApplicationEnum> list = getSysCode();
		ApplicationEnum a = new ApplicationEnum();
		a.setId("");
		a.setCaption("--请选择--");
		list.add(0, a);
		return list;
	}

	/**
	 * 为了兼容以前的写法
	 *
	 * @deprecated
	 * @return 当前登录用户的对象
	 */
	public TSysUser getUser() {
		return getLoginUser();
	}

	/**
	 * 历史年度，用于业务查询
	 *
	 * @param entityName 要查询的表对象名称
	 * @param nd 年度字段列名称
	 * @return 历史年度列表
	 */
	public List<ApplicationEnum> getNd(String entityName, String nd) {
		StringBuffer hql = new StringBuffer("");
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
	 * 开放时间段控制模块中，用到的功能按钮列表
	 *
	 * @return 功能按钮列表
	 */
	public List<ApplicationEnum> getButtonList() {
		// 对本方法添加功能类型，需要同步更新Constants类里的常量。
		List<ApplicationEnum> list = new ArrayList<ApplicationEnum>(10);
		list.add(new ApplicationEnum(SysConstants.BUTTON_TYPE_ADD, "新增"));
		list.add(new ApplicationEnum(SysConstants.BUTTON_TYPE_MODIFY, "修改"));
		list.add(new ApplicationEnum(SysConstants.BUTTON_TYPE_DEL, "删除"));
		list.add(new ApplicationEnum(SysConstants.BUTTON_TYPE_SAVE, "保存"));
		list.add(new ApplicationEnum(SysConstants.BUTTON_TYPE_EXPORT, "导出"));
		list.add(new ApplicationEnum(SysConstants.BUTTON_TYPE_PRINT, "打印"));
		list.add(new ApplicationEnum(SysConstants.BUTTON_TYPE_HANDOVER, "上报"));
		list.add(new ApplicationEnum(SysConstants.BUTTON_TYPE_APPROVE, "审批"));

		return list;
	}

	/**
	 * 查询按钮控制规则
	 *
	 * @param menuId 菜单编号
	 * @param buttonEnumId 按钮类型编号
	 * @return 规则对象
	 */
	public TSysButtonRule getMenuButtonRule(String menuId, String buttonEnumId) {

		TSysButtonRule buttonRule = null;
		String hql = "select a from TSysButtonRule a, TSysButtonEnumRule b "
				+ "where a.wid=b.buttonRuleId and a.state='1' and b.menuId=? and b.buttonEnumId=? order by a.wid desc";

		List<TSysButtonRule> list = applicationEnumService.getApplicationEnums(true, hql, menuId, buttonEnumId);
		if (list != null && !list.isEmpty()) {
			buttonRule = list.get(0);
		}
		return buttonRule;
	}

	/**
	 * 判断当前访问的页面上的指定类型的按钮是否允许使用
	 *
	 * @param buttonTypeEnumValue 按钮类型枚举值 引用Constants获取
	 * @return 要显示的按钮符合规则，返回true，否则返回false
	 */
	public boolean getButton(String buttonTypeEnumValue) {

		if (StringUtils.isBlank(buttonTypeEnumValue)) {
			addActionError("功能按钮类型不对！");
			return false;
		}
		boolean hasPermission = false;

		HttpServletRequest request = getRequest();

		TSysMenu menu = CheckLoginInterceptor.getCurrentAccessedMenuObject(request);
		if (menu != null) {
			// 获取到当前访问的菜单对象后，查询它的开放规则
			String menuid = menu.getMenuid();
			TSysButtonRule tsysButtonRule = getMenuButtonRule(menuid, buttonTypeEnumValue);

			if (tsysButtonRule == null) {// 规则被禁用，或者根本没有定义规则。则默认开放。
				hasPermission = true;
			} else {
				hasPermission = OpenTimeCtrlUtil.checkButtonPermission(tsysButtonRule);
			}

		} else {
			log.info("查询当前访问的页面的MENU_ID为null！该页面上的按钮访问都将默认为允许使用。");
			hasPermission = false;
		}
		return hasPermission;
	}

	/**
	 * 查询通知公告
	 *
	 * @return
	 */
	public List<Object[]> getMessage() {
		List<Object[]> message;
		String sql = " select t.wid,t.xxbt,xxnr from t_sys_message t where rownum<5 order by t.xxfssj desc ";
		message = DBUtil.queryAllList(sql);
		return message;
	}

}