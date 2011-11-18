package com.yszoe.identity.action;

import java.util.List;

import com.yszoe.identity.entity.TSysMenu;
import com.yszoe.sys.action.AbstractBaseActionSupport;

public class IdMenuAction extends AbstractBaseActionSupport {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	private TSysMenu tsysMenu;
	private List<TSysMenu> tsysMenues;
	
	public TSysMenu getTsysMenu() {
		return tsysMenu;
	}

	public void setTsysMenu(TSysMenu tsysMenu) {
		this.tsysMenu = tsysMenu;
	}

	public List<TSysMenu> getTsysMenues() {
		return tsysMenues;
	}

	public void setTsysMenues(List<TSysMenu> tsysMenues) {
		this.tsysMenues = tsysMenues;
	}

}
