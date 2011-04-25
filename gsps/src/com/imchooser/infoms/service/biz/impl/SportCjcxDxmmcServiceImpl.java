package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportCjcxDxmmcAction;

/**
 * 项目成绩查询（根据大项目名称）
 * 
 * @author DaiQinggao
 * @data 2010-4-7
 */
public class SportCjcxDxmmcServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportCjcxDxmmcAction action = (SportCjcxDxmmcAction) myaction;
		String dxmmc = action.getParameter("dxmmc");
		action.setParameter("dxmmc", dxmmc);
		String sqlDxmmc = "select max(a.dxmmc),max(a.dxmtb) from T_Sport_Bsxm a where a.dxmmc = ? group by a.dxmmc";
		String sqlColumn = "select to_char(t.bssj,'MM-dd HH24:mm'), "
				+ "(select c.zdmc from T_Sys_Code c where c.zdbm=(select b.xbz from T_Sport_Bsxm b where b.wid=t.xmbm )and c.zdlb='BSXM_XBZ'),"
				+ "(select c.xxmmc from T_Sport_Bsxm c where c.wid=t.xmbm ), "
				+ "(select sum(a.jps +a.jjjps) from  t_sport_cj_td_mx a  "
				+ " where a.scbm=t.wid and a.shzt='1' and length(a.departid)=6 ),"
				+ " (select c.zdmc from T_Sys_Code c where c.zdbm=t.scbm and c.zdlb='SSRC_SCBM' ),t.bscd,t.wid ";
		String sql = " from t_sport_ssrc t where t.xmbm = (select b.wid from T_Sport_Bsxm b where b.dxmmc = ? and b.wid = t.xmbm)";
		if (StringUtils.isNotBlank(action.getParameter("bssj"))) {
			sql += "and to_char(t.bssj,'dd')= " + action.getParameter("bssj");
		}
		long c = DBUtil.count("select count(*) as cc " + sql, dxmmc);
		pager.setTotalRows(c);
		sql = sqlColumn + sql + "order by t.bssj asc";
		List<Object[]> list_dxmmc = DBUtil.queryPageList(pager, sql, dxmmc);
		List<Object[]> dxmmctb = DBUtil.queryAllList(sqlDxmmc, dxmmc);
		action.setParameter("dxmmctb", dxmmctb);
		return list_dxmmc;
	}

	public void load(Object myaction) throws Exception {

	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object arg0) throws Exception {

	}

}
