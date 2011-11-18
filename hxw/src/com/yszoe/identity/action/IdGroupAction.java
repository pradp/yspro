/***********************************************************
 * 
 * 说 明：用户组查看、保存处理
 * 作 者：yangjianliang
 * 日 期：2008-11-6
 *
 **********************************************************/
package com.yszoe.identity.action;

import java.util.List;

import com.yszoe.identity.entity.TSysGroup;
import com.yszoe.sys.action.AbstractBaseActionSupport;
import com.yszoe.sys.entity.ApplicationEnum;

public class IdGroupAction extends AbstractBaseActionSupport {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private TSysGroup tsysGroup;

	public TSysGroup getTsysGroup() {
		return tsysGroup;
	}

	public void setTsysGroup(TSysGroup tsysGroup) {
		this.tsysGroup = tsysGroup;
	}

	/**
	 * 用于页面上获取所有的角色名
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getAllRoles() {
		String hql = "select new ApplicationEnum(roleid,rolename) from TSysRole where state='1' order by roleid";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql);
		return list;
	}
}
