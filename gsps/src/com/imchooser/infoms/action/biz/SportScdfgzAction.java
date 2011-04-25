package com.imchooser.infoms.action.biz;

import java.util.List;

import com.imchooser.infoms.entity.biz.TSportScdfgz;

/*
 **赛次得分规则
 * 
 * @author DaiQinggao
 * @date 2010-03-30
 */
@SuppressWarnings("serial")
public class SportScdfgzAction extends SportBsxmAction {
	private TSportScdfgz tsportScdfgz;
	private List<TSportScdfgz> listSportScdfgz;

	public List<TSportScdfgz> getListSportScdfgz() {
		return listSportScdfgz;
	}

	public void setListSportScdfgz(List<TSportScdfgz> listSportScdfgz) {
		this.listSportScdfgz = listSportScdfgz;
	}

	public TSportScdfgz getTsportScdfgz() {
		return tsportScdfgz;
	}

	public void setTsportScdfgz(TSportScdfgz tsportScdfgz) {
		this.tsportScdfgz = tsportScdfgz;
	}
	

}
