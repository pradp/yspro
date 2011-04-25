package com.imchooser.infoms.action.biz;

import com.imchooser.infoms.entity.biz.TSportCjTdMx;
import com.imchooser.infoms.entity.biz.TSportCjYdy;

/**
 * 
 * @author LiuHaiDong
 * 2010-5-25
 */
@SuppressWarnings("serial")
public class SportSjhdDbtAction  extends SportBsxmAction{
	private TSportCjTdMx tsportCjTdMx;
	private TSportCjYdy tsportCjYdy;
	public TSportCjTdMx getTsportCjTdMx() {
		return tsportCjTdMx;
	}
	public void setTsportCjTdMx(TSportCjTdMx tsportCjTdMx) {
		this.tsportCjTdMx = tsportCjTdMx;
	}
	public TSportCjYdy getTsportCjYdy() {
		return tsportCjYdy;
	}
	public void setTsportCjYdy(TSportCjYdy tsportCjYdy) {
		this.tsportCjYdy = tsportCjYdy;
	}
	
}
