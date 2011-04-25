package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;

/**
 * 项目成绩查询（按大项目名称）
 * 被 SportCjcxRcServiceImpl类代替
 * @author DaiQinggao
 * @date 2010-03-25
 */
@Deprecated
public class SportDxmmcServiceImpl extends BaseServiceAbstractSupport {

	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(SportDxmmcServiceImpl.class);

	public List<?> list(Object myaction, Pager pager) throws Exception {
		//String hqlcolumn = "select new TSportBsxm(max(a.wid),max(a.dxmmc), max(a.dxmtb) )";
		//String hql = " from TSportBsxm a where 1=1 ";
		String sqlColumn = " select cc.dxmmc,cc.dxmtb,(select count(*) from t_sport_ssrc ccc where exists "
				+ " (select null from t_sport_bsxm where dxmmc=cc.dxmmc and ccc.xmbm=wid) ) as c,cc.pxh ";
		String sql = " from (select  max(a.dxmmc) as dxmmc,max(a.dxmtb) as dxmtb,a.pxh as pxh"
				+ " from T_Sport_Bsxm a group by a.pxh) cc";
		sql = sqlColumn + sql + " order by cc.pxh";
		List<?> list = DBUtil.queryAllList(sql);
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
