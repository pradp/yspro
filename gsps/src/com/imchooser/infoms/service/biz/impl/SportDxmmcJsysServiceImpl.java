package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.Pager;

/**
 * 项目成绩查询（按大项目名称-->>江苏优势项目）
 * 
 * @author DaiQinggao
 * @date 2010-03-26
 */
public class SportDxmmcJsysServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		String hqlcolumn = "select new TSportBsxm(max(a.wid),max(a.dxmmc), max(a.dxmtb) )";
		String hql = " from TSportBsxm a where 1=1 and a.xmdj='1' ";
		hql = hqlcolumn + hql + "group by a.dxmmc order by max(a.wid) desc ";
		List<?> list = getBaseDao().findByHql(hql);
		return list;
	}

	public void load(Object arg0) throws Exception {
	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object arg0) throws Exception {

	}

}
