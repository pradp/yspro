package com.imchooser.infoms.action.sys;

import com.imchooser.infoms.entity.sys.TSysBizLog;

@SuppressWarnings("serial")
public class SysBizLogAction extends BaseActionAbstractSupport {
	private TSysBizLog tsysBizLog;

	public TSysBizLog getTsysBizLog() {
		return tsysBizLog;
	}

	public void setTsysBizLog(TSysBizLog tsysBizLog) {
		this.tsysBizLog = tsysBizLog;
	}

}
