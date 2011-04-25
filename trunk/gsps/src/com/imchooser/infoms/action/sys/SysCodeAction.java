package com.imchooser.infoms.action.sys;

import com.imchooser.infoms.entity.sys.TSysCode;

@SuppressWarnings("serial")
public class SysCodeAction extends BaseActionAbstractSupport {

	private TSysCode tsysCode;

	public String getEntityBean() {

		return "tsysCode";
	}

	public TSysCode getTsysCode() {
		return tsysCode;
	}

	public void setTsysCode(TSysCode tsysCode) {
		this.tsysCode = tsysCode;
	}

}
