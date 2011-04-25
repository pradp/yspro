package com.imchooser.infoms.action.biz;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportCjTdHz;

/**
 * 团队成绩汇总表(网站首页显示)
 * @author DaiQinggao
 * @date 2010-4-2
 *
 */
@SuppressWarnings("serial")
public class SportCjTdHzAction extends BaseActionAbstractSupport {
	private TSportCjTdHz tsportCjTdHz;
	public TSportCjTdHz getTsportCjTdHz() {
		return tsportCjTdHz;
	}

	public void setTsportCjTdHz(TSportCjTdHz tsportCjTdHz) {
		this.tsportCjTdHz = tsportCjTdHz;
	}
}
