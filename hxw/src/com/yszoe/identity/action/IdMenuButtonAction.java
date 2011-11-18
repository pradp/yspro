/***********************************************************
 * 
 * 说 明：菜单按钮配置
 * 作 者：linyang
 * 日 期：2011-06-07
 *
 **********************************************************/
package com.yszoe.identity.action;

import java.util.List;

import com.yszoe.identity.entity.TSysRoleMenuButton;
import com.yszoe.sys.action.AbstractBaseActionSupport;
import com.yszoe.sys.entity.ApplicationEnum;

public class IdMenuButtonAction extends AbstractBaseActionSupport {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	private TSysRoleMenuButton tsysRoleMenuButton;
	private List<ApplicationEnum> listMenu; // 用于显示二级以下菜单
	private List<ApplicationEnum> listButton;// 用于显示按钮
	private int max_length_menuid; // 菜单id最长长度,用于页面选中上级菜单时自动选中下级菜单

	public TSysRoleMenuButton getTsysRoleMenuButton() {
		return tsysRoleMenuButton;
	}

	public void setTsysRoleMenuButton(TSysRoleMenuButton tsysRoleMenuButton) {
		this.tsysRoleMenuButton = tsysRoleMenuButton;
	}

	public List<ApplicationEnum> getListMenu() {
		return listMenu;
	}

	public void setListMenu(List<ApplicationEnum> listMenu) {
		this.listMenu = listMenu;
	}

	public List<ApplicationEnum> getListButton() {
		return listButton;
	}

	public void setListButton(List<ApplicationEnum> listButton) {
		this.listButton = listButton;
	}

	public int getMax_length_menuid() {
		return max_length_menuid;
	}

	public void setMax_length_menuid(int maxLengthMenuid) {
		max_length_menuid = maxLengthMenuid;
	}

}
