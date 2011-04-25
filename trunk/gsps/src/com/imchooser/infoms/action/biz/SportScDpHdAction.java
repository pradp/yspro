package com.imchooser.infoms.action.biz;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportBsxm;

/**
 * 赛程得牌核对
 * 
 * @author Wangjunjun 2010-7-19
 */
@SuppressWarnings("serial")
public class SportScDpHdAction extends BaseActionAbstractSupport {
	private TSportBsxm sportBsxm;

	public TSportBsxm getSportBsxm() {
		return sportBsxm;
	}

	public void setSportBsxm(TSportBsxm sportBsxm) {
		this.sportBsxm = sportBsxm;
	}
}
