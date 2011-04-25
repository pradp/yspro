package com.imchooser.infoms.action.biz;

import java.util.List;

import com.imchooser.framework.identity.entity.TSysDepart;
import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportCjSxHz;
import com.imchooser.infoms.entity.biz.TSportCjTdSxJjf;
import com.imchooser.infoms.entity.biz.TSportCjTdSxJjfMx;

/**
 * 
 * @author LiuHaiDong
 * 2010-5-4
 */
@SuppressWarnings("serial")
public class SportTdHzCjJjfAction extends BaseActionAbstractSupport {

	private TSportCjTdSxJjf tsportCjTdSxJjf;
	private TSportCjSxHz tsportCjSxHz;
	private TSysDepart tsysDepart;
	private List<TSportCjTdSxJjfMx> tsportCjJjfMx;
	private TSportCjTdSxJjfMx tsportCjTdSxJjfMx;
	
	public TSportCjTdSxJjf getTsportCjTdSxJjf() {
		return tsportCjTdSxJjf;
	}

	public void setTsportCjTdSxJjf(TSportCjTdSxJjf tsportCjTdSxJjf) {
		this.tsportCjTdSxJjf = tsportCjTdSxJjf;
	}

	public TSportCjSxHz getTsportCjSxHz() {
		return tsportCjSxHz;
	}

	public void setTsportCjSxHz(TSportCjSxHz tsportCjSxHz) {
		this.tsportCjSxHz = tsportCjSxHz;
	}

	public TSysDepart getTsysDepart() {
		return tsysDepart;
	}

	public void setTsysDepart(TSysDepart tsysDepart) {
		this.tsysDepart = tsysDepart;
	}

	public List<TSportCjTdSxJjfMx> getTsportCjJjfMx() {
		return tsportCjJjfMx;
	}

	public void setTsportCjJjfMx(List<TSportCjTdSxJjfMx> tsportCjJjfMx) {
		this.tsportCjJjfMx = tsportCjJjfMx;
	}

	public TSportCjTdSxJjfMx getTsportCjTdSxJjfMx() {
		return tsportCjTdSxJjfMx;
	}

	public void setTsportCjTdSxJjfMx(TSportCjTdSxJjfMx tsportCjTdSxJjfMx) {
		this.tsportCjTdSxJjfMx = tsportCjTdSxJjfMx;
	}
	
}
