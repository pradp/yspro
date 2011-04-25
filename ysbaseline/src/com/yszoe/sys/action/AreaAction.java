
package com.yszoe.sys.action;

import com.yszoe.sys.entity.TSysArea;

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
