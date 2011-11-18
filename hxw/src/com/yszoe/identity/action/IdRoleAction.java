/***********************************************************
 * 
 * 说 明：角色查看、保存处理
 * 作 者：yangjianliang
 * 日 期：2007-11-1
 *
 **********************************************************/
package com.yszoe.identity.action;

import java.util.List;

import com.yszoe.identity.entity.TSysRole;
import com.yszoe.sys.action.AbstractBaseActionSupport;
import com.yszoe.sys.entity.ApplicationEnum;

public class IdRoleAction extends AbstractBaseActionSupport {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private TSysRole tsysRole;

	private List<ApplicationEnum> listMenuDepth2; // 遍历二级菜单

	public TSysRole getTsysRole() {
		return tsysRole;
	}

	public void setTsysRole(TSysRole tsysRole) {
		this.tsysRole = tsysRole;
	}

	public List<ApplicationEnum> getListMenuDepth2() {
		return listMenuDepth2;
	}

	public void setListMenuDepth2(List<ApplicationEnum> listMenuDepth2) {
		this.listMenuDepth2 = listMenuDepth2;
	}

}
