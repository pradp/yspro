package com.imchooser.infoms.action.biz;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.entity.biz.TSportCjYdy;
import com.imchooser.infoms.entity.biz.TSportYdybmxm;
import com.imchooser.infoms.entity.biz.TSportYdyxx;
import com.imchooser.infoms.service.biz.impl.SportYdyxxServiceImpl;

/*
 **运动员信息
 * 
 * 
 */
@SuppressWarnings("serial")
public class SportYdyxxAction extends BaseActionAbstractSupport {
	private TSportYdyxx tsportYdyxx;
	private TSportBsxm tsportBsxm;
	private TSportYdybmxm tsportYdybmxm;
	private TSportCjYdy tsportCjYdy;

	public TSportYdyxx getTsportYdyxx() {
		return tsportYdyxx;
	}

	public void setTsportYdyxx(TSportYdyxx tsportYdyxx) {
		this.tsportYdyxx = tsportYdyxx;
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

	public TSportCjYdy getTsportCjYdy() {
		return tsportCjYdy;
	}

	public void setTsportCjYdy(TSportCjYdy tsportCjYdy) {
		this.tsportCjYdy = tsportCjYdy;
	}

	/**
	 * 确认参赛项目
	 * 
	 * @return
	 * @throws Exception
	 */
	public String qrbsxm() throws Exception {
		SportYdyxxServiceImpl service = (SportYdyxxServiceImpl) getBaseService();
		try {
			service.submitQrbsxm(this, this.getPager());
		} catch (Exception e) {
			addActionError(e.getMessage());
		}
		return "qrbsxm";
	}

	/**
	 * 查看成绩分布
	 * 
	 * @return
	 * @throws Exception
	 */
	public String ckcjfb() throws Exception {
		SportYdyxxServiceImpl service = (SportYdyxxServiceImpl) getBaseService();
		try {
			service.submitCkcjfb(this);
		} catch (Exception e) {
			addActionError(e.getMessage());
		}
		return "ckcjfb";
	}
}
