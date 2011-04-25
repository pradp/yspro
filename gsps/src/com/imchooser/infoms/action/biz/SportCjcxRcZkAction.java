package com.imchooser.infoms.action.biz;

import java.util.List;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.entity.biz.TSportCjTdHz;

/*
 **比赛项目
 * 
 * @author DaiQinggao
 * @date 2010-03-22
 */
@SuppressWarnings("serial")
public class SportCjcxRcZkAction extends BaseActionAbstractSupport {

	private TSportBsxm tsportBsxm;
	private List<TSportBsxm> listSportBsxm;
	private List<TSportCjTdHz> listSportCjTdHzs1;
	private List<TSportCjTdHz> listSportCjTdHzs2;
	private List<TSportCjTdHz> listSportCjTdHzs3;
	private List<String> listString;
	public TSportBsxm getTsportBsxm() {
		return tsportBsxm;
	}
	public void setTsportBsxm(TSportBsxm tsportBsxm) {
		this.tsportBsxm = tsportBsxm;
	}
	public List<TSportBsxm> getListSportBsxm() {
		return listSportBsxm;
	}
	public void setListSportBsxm(List<TSportBsxm> listSportBsxm) {
		this.listSportBsxm = listSportBsxm;
	}
	
	public List<TSportCjTdHz> getListSportCjTdHzs1() {
		return listSportCjTdHzs1;
	}
	public void setListSportCjTdHzs1(List<TSportCjTdHz> listSportCjTdHzs1) {
		this.listSportCjTdHzs1 = listSportCjTdHzs1;
	}
	public List<TSportCjTdHz> getListSportCjTdHzs2() {
		return listSportCjTdHzs2;
	}
	public void setListSportCjTdHzs2(List<TSportCjTdHz> listSportCjTdHzs2) {
		this.listSportCjTdHzs2 = listSportCjTdHzs2;
	}
	public List<TSportCjTdHz> getListSportCjTdHzs3() {
		return listSportCjTdHzs3;
	}
	public void setListSportCjTdHzs3(List<TSportCjTdHz> listSportCjTdHzs3) {
		this.listSportCjTdHzs3 = listSportCjTdHzs3;
	}
	public List<String> getListString() {
		return listString;
	}
	public void setListString(List<String> listString) {
		this.listString = listString;
	}
}
