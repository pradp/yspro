package com.yszoe.sys.action;

import com.yszoe.sys.entity.TSysCodesort;


@SuppressWarnings("serial")
public class SysCodeSortAction extends AbstractBaseActionSupport {
	private TSysCodesort tsysCodesort;

	public TSysCodesort getTsysCodesort() {
		return tsysCodesort;
	}

	public void setTsysCodesort(TSysCodesort tsysCodesort) {
		this.tsysCodesort = tsysCodesort;
	}

}
