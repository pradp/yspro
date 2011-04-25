package com.imchooser.infoms.action.biz;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportDrcjb;

/*
 * * 带入成绩
 * 
 * @author ChenLihong
 * 
 * @date:2010-3-18
 */
@SuppressWarnings("serial")
public class SportDrcjbAction extends BaseActionAbstractSupport {

	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(SportDrcjbAction.class);
	private TSportDrcjb tsportDrcjb;

	public TSportDrcjb getTsportDrcjb() {
		return tsportDrcjb;
	}

	public void setTsportDrcjb(TSportDrcjb tsportDrcjb) {
		this.tsportDrcjb = tsportDrcjb;
	}

}
