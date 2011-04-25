package com.imchooser.infoms.service.sys.impl;

import java.util.List;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.sys.SysBizLogAction;
import com.imchooser.infoms.entity.sys.TSysBizLog;
import com.imchooser.util.StringUtil;

public class SysBizLogServiceImpl extends BaseServiceAbstractSupport {

	/**
	 * 操作日志显示
	 */

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SysBizLogAction action = (SysBizLogAction) myaction;
		TSysBizLog tsysBizLog = action.getTsysBizLog();

		String hqlcolumn = "select a.wid,(select zdmc from TSysCode where zdlb='czdx' and zdbm=a.czdx) as czdx,a.czr,a.czlx,to_char(a.czsj,'yyyy-mm-dd hh24:mi:ss'),a.czdx";
		String hql = " from  TSysBizLog a where 1=1 ";
		if (tsysBizLog != null) {
			if (tsysBizLog.getCzr() != null && !"".equals(tsysBizLog.getCzr())) {
				hql += "  and a.czr  like '%" + tsysBizLog.getCzr() + "%'";
			}
			if (tsysBizLog.getCzdx() != null && !"".equals(tsysBizLog.getCzdx())) {
				hql += "  and a.czdx  = '" + tsysBizLog.getCzdx() + "'";
			}
			if (tsysBizLog.getCzlx() != null && !"".equals(tsysBizLog.getCzlx())) {
				hql += "  and a.czlx  = '" + tsysBizLog.getCzlx() + "'";
			}
		}
		/*
		 * 操作时间查询过滤(时间段),qssj为起始时间,zzsj为终止时间
		 */
		if (StringUtil.isNotBlank(action.getParameter("qssj")) && StringUtil.isNotBlank(action.getParameter("zzsj"))) {
			action.setParameter("qssj", action.getParameter("qssj"));
			action.setParameter("zzsj", action.getParameter("zzsj"));
			hql += "  and a.czsj  between to_date('" + action.getParameter("qssj")
					+ ":00','yyyy-mm-dd HH24:mi:ss') and to_date('" + action.getParameter("zzsj")
					+ ":59','yyyy-mm-dd HH24:mi:ss')";
		}
		long c = getBaseDao().count(" select count(*) as c " + hql);
		pager.setTotalRows(c);
		hql = hqlcolumn + hql + " order by czsj desc";
		List<?> list = getBaseDao().findPageByHql(hql, pager);
		return list;
	}

	public boolean remove(Object myaction) throws Exception {
		SysBizLogAction action = (SysBizLogAction) myaction;
		boolean deleteSuccess = false;
		String ids = action.getWid();
		if (ids != null) {
			deleteSuccess = getBaseDao().deleteAll("TSysBizLog", "wid", "=", ids);
		} else {
			String czsj = action.getParameter("czsj");
			String sql = "delete from t_sys_biz_log where czsj<to_date(?,'yyyy-mm-dd')";
			deleteSuccess = DBUtil.executeSQL(sql, czsj) > 0;
		}
		return deleteSuccess;
	}

	public void load(Object arg0) throws Exception {

	}

	public void saveOrUpdate(Object arg0) throws Exception {

	}

}
