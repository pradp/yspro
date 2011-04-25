package com.imchooser.infoms.action.biz;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportCjYdy;
import com.imchooser.infoms.entity.biz.TSportCjZsMx;

/**
 * 数据核对区县
 * @author LiBing
 * DateTime 2010-6-2
 */
@SuppressWarnings("serial")
public class SportSjhdSxAction extends BaseActionAbstractSupport{

	private TSportCjYdy tsportCjYdy;
	private TSportCjZsMx tsportCjZsMx;
	
	public TSportCjYdy getTsportCjYdy() {
		return tsportCjYdy;
	}
	public void setTsportCjYdy(TSportCjYdy tsportCjYdy) {
		this.tsportCjYdy = tsportCjYdy;
	}
	public TSportCjZsMx getTsportCjZsMx() {
		return tsportCjZsMx;
	}
	public void setTsportCjZsMx(TSportCjZsMx tsportCjZsMx) {
		this.tsportCjZsMx = tsportCjZsMx;
	}

	
}
