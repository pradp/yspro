/**
 * MyUserAction.java
 */
package com.yszoe.sys.action;

import java.util.List;

import com.yszoe.framework.identity.action.IdUserAction;
import com.yszoe.framework.identity.entity.TSysDepart;
import com.yszoe.sys.entity.ApplicationEnum;
import com.yszoe.sys.service.ApplicationEnumService;

/**
 * 管理自己下级用户
 * 
 * @author Yangjianliang datetime 2009-2-11
 */
@SuppressWarnings("serial")
public class MyUserAction extends IdUserAction {

	/**
	 * 系统数据字典
	 */
	protected ApplicationEnumService applicationEnumService;

	/**
	 * 所在高校
	 * 
	 * @return
	 */
	public List<ApplicationEnum> getMyDeparts() {
		TSysDepart d = getDepart();
		String mydepartid = d.getDepartid();
		String departtype = d.getDeparttype();
		String hql = "select new ApplicationEnum(departid,departname) from TSysDepart where state='1' and departid like ?";
		// modify by yangjianliang at 20090506 市县多用户需求，放开可以为本部门去添加其他账户
		if ("7".equals(departtype)) {// 市县才可以查看到本部门名称，进行添加同级账户操作
			hql += " order by departid";
			return applicationEnumService.getApplicationEnums(false, hql,
					mydepartid + "%");
		} else {
			hql += " and departid!=? order by departid";
			return applicationEnumService.getApplicationEnums(false, hql,
					mydepartid + "%", mydepartid);
		}
	}

	public ApplicationEnumService getApplicationEnumService() {
		return applicationEnumService;
	}

	public void setApplicationEnumService(
			ApplicationEnumService applicationEnumService) {
		this.applicationEnumService = applicationEnumService;
	}

}
