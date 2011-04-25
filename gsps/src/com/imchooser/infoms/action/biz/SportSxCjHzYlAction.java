package com.imchooser.infoms.action.biz;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportCjSxHzYl;
import com.imchooser.infoms.entity.biz.TSportCjTdHzYl;

/**
 * 成绩市县(代表团)汇总预览信息
 * @author LiBing
 * DateTime 2010-4-26
 */
@SuppressWarnings("serial")
public class SportSxCjHzYlAction extends BaseActionAbstractSupport{

	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(SportSxCjHzYlAction.class);
	
	private TSportCjSxHzYl tsportCjSxHzYl;
	private TSportCjTdHzYl tsportCjTdHzYl;

	public TSportCjSxHzYl getTsportCjSxHzYl() {
		return tsportCjSxHzYl;
	}

	public void setTsportCjSxHzYl(TSportCjSxHzYl tsportCjSxHzYl) {
		this.tsportCjSxHzYl = tsportCjSxHzYl;
	}
	
	
	public TSportCjTdHzYl getTsportCjTdHzYl() {
		return tsportCjTdHzYl;
	}
	public void setTsportCjTdHzYl(TSportCjTdHzYl tsportCjTdHzYl) {
		this.tsportCjTdHzYl = tsportCjTdHzYl;
	}

}
