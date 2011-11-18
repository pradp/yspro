package com.yszoe.sys.action;

import com.yszoe.sys.entity.TSysCode;


@SuppressWarnings("serial")
public class SysCodeAction extends AbstractBaseActionSupport {

	private TSysCode tsysCode;

	public TSysCode getTsysCode() {
		return tsysCode;
	}

	public void setTsysCode(TSysCode tsysCode) {
		this.tsysCode = tsysCode;
	}

}
