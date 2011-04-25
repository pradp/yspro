package com.yszoe.sys.action;

import com.yszoe.sys.entity.TSysPropertity;

@SuppressWarnings("serial")
public class PropertityAction extends BaseActionAbstractSupport {

	private TSysPropertity tsysPropertity;

	public TSysPropertity getTsysPropertity() {
		return tsysPropertity;
	}

	public void setTsysPropertity(TSysPropertity tsysPropertity) {
		this.tsysPropertity = tsysPropertity;
	}

	public String getEntityBean() {
		return "tsyspropertity";
	}
}
