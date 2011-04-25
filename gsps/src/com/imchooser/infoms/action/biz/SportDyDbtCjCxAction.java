package com.imchooser.infoms.action.biz;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportCjTdMx;

/**
 * 代表团成绩查询(打印)
 * @author Wangjunjun 2010-7-21
 */
@SuppressWarnings("serial")
public class SportDyDbtCjCxAction extends BaseActionAbstractSupport  {
	private TSportCjTdMx cjTdMx;

	public TSportCjTdMx getCjTdMx() {
		return cjTdMx;
	}

	public void setCjTdMx(TSportCjTdMx cjTdMx) {
		this.cjTdMx = cjTdMx;
	}
}
