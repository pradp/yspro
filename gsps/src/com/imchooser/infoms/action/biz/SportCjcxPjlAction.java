package com.imchooser.infoms.action.biz;

import java.util.List;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.entity.biz.TSportCjYdy;

@SuppressWarnings("serial")
public class SportCjcxPjlAction  extends BaseActionAbstractSupport {

	List<TSportCjYdy> listCj = null;
	
	private TSportBsxm tsportBsxm;

	public TSportBsxm getTsportBsxm() {
		return tsportBsxm;
	}

	public void setTsportBsxm(TSportBsxm tsportBsxm) {
		this.tsportBsxm = tsportBsxm;
	}

	public List<TSportCjYdy> getListCj() {
		return listCj;
	}

	public void setListCj(List<TSportCjYdy> listCj) {
		this.listCj = listCj;
	}
	
}
