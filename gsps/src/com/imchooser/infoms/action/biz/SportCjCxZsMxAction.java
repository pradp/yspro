package com.imchooser.infoms.action.biz;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportCjYdy;
import com.imchooser.infoms.entity.biz.TSportCjZsMx;

/**
 * 数据核对协议地
 * 
 * @author LiBing DateTime 2010-5-27
 */
@SuppressWarnings("serial")
public class SportCjCxZsMxAction extends BaseActionAbstractSupport {

	private TSportCjYdy tsportCjYdy;
	private TSportCjZsMx tsportCjZsMx;
	private String iscxd;
	private String isyzcd;
	private String isyj;
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

	public String getIscxd() {
		return iscxd;
	}

	public void setIscxd(String iscxd) {
		this.iscxd = iscxd;
	}

	public String getIsyzcd() {
		return isyzcd;
	}

	public void setIsyzcd(String isyzcd) {
		this.isyzcd = isyzcd;
	}

	public String getIsyj() {
		return isyj;
	}

	public void setIsyj(String isyj) {
		this.isyj = isyj;
	}
}
