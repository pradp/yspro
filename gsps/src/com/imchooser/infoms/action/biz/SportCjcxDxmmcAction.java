package com.imchooser.infoms.action.biz;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportSsrc;
/**
 * 项目成绩查询（根据大项目名称）
 * 
 * @author DaiQinggao
 * @data 2010-4-7
 */
@SuppressWarnings("serial")
public class SportCjcxDxmmcAction extends BaseActionAbstractSupport {
	private TSportSsrc tsportSsrc;

	public TSportSsrc getTsportSsrc() {
		return tsportSsrc;
	}
	public void setTsportSsrc(TSportSsrc tsportSsrc) {
		this.tsportSsrc = tsportSsrc;
	}
	


}
