package com.yszoe.sys.action;

import com.yszoe.sys.entity.TSysCode;

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
