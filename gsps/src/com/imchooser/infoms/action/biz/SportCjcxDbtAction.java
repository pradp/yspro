package com.imchooser.infoms.action.biz;

import java.util.List;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.sys.TSysArea;

@SuppressWarnings("serial")
public class SportCjcxDbtAction  extends BaseActionAbstractSupport {
	List<Object[]> listCj = null;
	
	private TSysArea tsysArea;

	public TSysArea getTsysArea() {
		return tsysArea;
	}

	public void setTsysArea(TSysArea tsysArea) {
		this.tsysArea = tsysArea;
	}

	public List<Object[]> getListCj() {
		return listCj;
	}

	public void setListCj(List<Object[]> listCj) {
		this.listCj = listCj;
	}

	
	
}
