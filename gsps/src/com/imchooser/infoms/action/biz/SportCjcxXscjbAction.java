package com.imchooser.infoms.action.biz;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportCjTdHz;
/**
 * 区县成绩榜
 * @author DaiQinggao
 * @date 2010-4-8
 *
 */
@SuppressWarnings("serial")
public class SportCjcxXscjbAction extends BaseActionAbstractSupport {

	private TSportCjTdHz tsportCjTdHz;
	public TSportCjTdHz getTsportCjTdHz() {
		return tsportCjTdHz;
	}

	public void setTsportCjTdHz(TSportCjTdHz tsportCjTdHz) {
		this.tsportCjTdHz = tsportCjTdHz;
	}
}
