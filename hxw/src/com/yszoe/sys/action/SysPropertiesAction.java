package com.yszoe.sys.action;

import com.yszoe.sys.entity.TSysPropertity;
import com.yszoe.sys.util.SysPropertiesUtil;

@SuppressWarnings("serial")
public class SysPropertiesAction extends AbstractBaseActionSupport {

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

	/**
	 * 刷新内存
	 */
	public String refreshSysProp() throws Exception {
		try {
			SysPropertiesUtil.loadSysProps();
		} catch (Exception e) {
			throw new Exception(e.getMessage());
		}
		return toView("list.jsp");
	}
}
