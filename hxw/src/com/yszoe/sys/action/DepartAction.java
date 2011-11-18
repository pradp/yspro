
package com.yszoe.sys.action;

import com.yszoe.identity.entity.TSysDepart;

@SuppressWarnings("serial")
public class DepartAction extends AbstractBaseActionSupport {

	private TSysDepart tsysDepart;
	private String updepartid;
	private String updepartname;
	private String todepartid;
	private String fromdepartid;
	private String successFlag;

	/**
	 * action method
	 * @return
	 */
	public String treeFrame(){
		return toView("treeFrame.jsp");
	}

	/**
	 * action method
	 * 供以树形式维护部门信息调用
	 * @return
	 */
	public String departTree(){
		return toView("departTree.jsp");
	}

	public String getSuccessFlag() {
		return successFlag;
	}

	public void setSuccessFlag(String successFlag) {
		this.successFlag = successFlag;
	}

	public TSysDepart getTsysDepart() {
		return tsysDepart;
	}

	public void setTsysDepart(TSysDepart tsysDepart) {
		this.tsysDepart = tsysDepart;
	}

	public String getUpdepartname() {
		return updepartname;
	}

	public void setUpdepartname(String updepartname) {
		this.updepartname = updepartname;
	}

	public String getUpdepartid() {
		return updepartid;
	}

	public void setUpdepartid(String updepartid) {
		this.updepartid = updepartid;
	}

	public String getTodepartid() {
		return todepartid;
	}

	public void setTodepartid(String todepartid) {
		this.todepartid = todepartid;
	}

	public String getFromdepartid() {
		return fromdepartid;
	}

	public void setFromdepartid(String fromdepartid) {
		this.fromdepartid = fromdepartid;
	}
}
