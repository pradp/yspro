package com.imchooser.infoms.action.biz;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportCjYdy;
import com.imchooser.infoms.entity.biz.TSportYdyxx;


@SuppressWarnings("serial")
public class SportCjcxYdyxxAction extends BaseActionAbstractSupport{

	private TSportYdyxx tsportYdyxx;
	private TSportCjYdy tsportCjYdy; 

	public TSportCjYdy getTsportCjYdy() {
		return tsportCjYdy;
	}

	public void setTsportCjYdy(TSportCjYdy tsportCjYdy) {
		this.tsportCjYdy = tsportCjYdy;
	}

	public TSportYdyxx getTsportYdyxx() {
		return tsportYdyxx;
	}

	public void setTsportYdyxx(TSportYdyxx tsportYdyxx) {
		this.tsportYdyxx = tsportYdyxx;
	}
	
	
}
