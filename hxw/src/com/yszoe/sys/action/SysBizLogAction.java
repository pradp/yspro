package com.yszoe.sys.action;

import com.yszoe.sys.entity.TSysBizLog;

@SuppressWarnings("serial")
public class SysBizLogAction extends AbstractBaseActionSupport {
	private TSysBizLog tsysBizLog;

	public TSysBizLog getTsysBizLog() {
		return tsysBizLog;
	}

	public void setTsysBizLog(TSysBizLog tsysBizLog) {
		this.tsysBizLog = tsysBizLog;
	}

}
