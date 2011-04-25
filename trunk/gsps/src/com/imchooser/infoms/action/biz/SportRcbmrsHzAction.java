package com.imchooser.infoms.action.biz;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.entity.biz.TSportYdybmxm;
import com.imchooser.infoms.entity.biz.TSportYdybmxmCc;
import com.imchooser.infoms.entity.biz.TSportYdyxx;

/**
 * 代表团二次报名人数汇总
 * @author LiBing
 * DateTime 2010-8-27
 */
@SuppressWarnings("serial")
public class SportRcbmrsHzAction extends BaseActionAbstractSupport{

	private TSportYdybmxmCc tsportYdybmxmCc;
	private TSportBsxm tsportBsxm;
	private TSportYdybmxm tsportYdybmxm;
	private TSportYdyxx tsportYdyxx;
	
	
	public TSportYdybmxmCc getTsportYdybmxmCc() {
		return tsportYdybmxmCc;
	}
	public void setTsportYdybmxmCc(TSportYdybmxmCc tsportYdybmxmCc) {
		this.tsportYdybmxmCc = tsportYdybmxmCc;
	}
	public TSportBsxm getTsportBsxm() {
		return tsportBsxm;
	}
	public void setTsportBsxm(TSportBsxm tsportBsxm) {
		this.tsportBsxm = tsportBsxm;
	}
	public TSportYdybmxm getTsportYdybmxm() {
		return tsportYdybmxm;
	}
	public void setTsportYdybmxm(TSportYdybmxm tsportYdybmxm) {
		this.tsportYdybmxm = tsportYdybmxm;
	}
	public TSportYdyxx getTsportYdyxx() {
		return tsportYdyxx;
	}
	public void setTsportYdyxx(TSportYdyxx tsportYdyxx) {
		this.tsportYdyxx = tsportYdyxx;
	}

}
