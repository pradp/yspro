
package com.imchooser.infoms.action.sys;

import com.imchooser.infoms.entity.sys.TSysArea;

@SuppressWarnings("serial")
public class AreaAction extends BaseActionAbstractSupport {

	private TSysArea tsysArea;
	
	public String areaTree(){
		return SUCCESS;
	}

	public String listArea(){
		return SUCCESS;
	}

	public TSysArea getTsysArea() {
		return tsysArea;
	}

	public void setTsysArea(TSysArea tsysArea) {
		this.tsysArea = tsysArea;
	}

}
