package com.imchooser.infoms.action.biz;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportBsxm;

/*
 **项目成绩查询（按大项目名称）
 * 
 * @author DaiQinggao
 * @date 2010-03-25
 */
@SuppressWarnings("serial")
public class SportDxmmcAction extends BaseActionAbstractSupport {
	
	private TSportBsxm tsportBsxm;

	public TSportBsxm getTsportBsxm() {
		return tsportBsxm;
	}

	public void setTsportBsxm(TSportBsxm tsportBsxm) {
		this.tsportBsxm = tsportBsxm;
	}
	

}
