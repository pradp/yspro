package com.yszoe.sys.action;

import com.yszoe.framework.identity.entity.TSysDepart;
import com.yszoe.framework.identity.entity.TSysUser;

@SuppressWarnings("serial")
public class userExtAction extends BaseActionAbstractSupport{

	private String usertype;
	private TSysDepart tsysDeaprt;
	private TSysUser tsysUser;
	

	public String getUsertype() {
		return usertype;
	}

	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}

	public TSysDepart getTsysDeaprt() {
		return tsysDeaprt;
	}

	public void setTsysDeaprt(TSysDepart tsysDeaprt) {
		this.tsysDeaprt = tsysDeaprt;
	}

	public TSysUser getTsysUser() {
		return tsysUser;
	}

	public void setTsysUser(TSysUser tsysUser) {
		this.tsysUser = tsysUser;
	}

	
}
