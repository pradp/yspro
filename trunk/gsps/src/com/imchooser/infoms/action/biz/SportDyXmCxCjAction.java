package com.imchooser.infoms.action.biz;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportBsxm;

/**
 * 按项目查询成绩(打印)
 * @author Wangjunjun 2010-7-19
 */
@SuppressWarnings("serial")
public class SportDyXmCxCjAction extends BaseActionAbstractSupport  {
	private TSportBsxm bsxm;

	public TSportBsxm getBsxm() {
		return bsxm;
	}

	public void setBsxm(TSportBsxm bsxm) {
		this.bsxm = bsxm;
	}
}
