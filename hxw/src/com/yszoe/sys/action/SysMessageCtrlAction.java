package com.yszoe.sys.action;

import com.yszoe.sys.entity.TSysMessageCtrl;
import com.yszoe.sys.servlets.SysInitAutoLoad;

/**
 * 登录时提示消息管理
 * 
 * @author Linyang datetime 2011-7-27
 */
@SuppressWarnings("serial")
public class SysMessageCtrlAction extends AbstractBaseActionSupport {
	private TSysMessageCtrl tsysMessageCtrl;

	public TSysMessageCtrl getTsysMessageCtrl() {
		return tsysMessageCtrl;
	}

	public void setTsysMessageCtrl(TSysMessageCtrl tsysMessageCtrl) {
		this.tsysMessageCtrl = tsysMessageCtrl;
	}

	/**
	 * 刷新内存
	 */
	public String refreshSysProp() throws Exception {
		try {
			SysInitAutoLoad.refreshListMessageCtrl();
		} catch (Exception e) {
			throw new Exception(e.getMessage());
		}
		return toView("list.jsp");
	}
}
