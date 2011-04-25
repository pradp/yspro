package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportSxCjHzYlAction;
import com.imchooser.infoms.entity.biz.TSportCjSxHzYl;
import com.imchooser.infoms.entity.biz.TSportCjTdHzYl;

/**
 * 
 * @author LiBing
 * DateTime 2010-4-26
 */
public class SportSxCjHzYlServiceImpl extends BaseServiceAbstractSupport{

	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(SportSxCjHzYlServiceImpl.class);

	
	public List<?> list(Object myaction, Pager pager) throws Exception {
	
		SportSxCjHzYlAction action =(SportSxCjHzYlAction) myaction;
	
		TSportCjSxHzYl tsportCjSxHzYl=action.getTsportCjSxHzYl();
		TSportCjTdHzYl tsportCjTdHzYl=action.getTsportCjTdHzYl();
		String type = action.getParameter("type");
		action.setParameter("type", type);
		String hqlcolumn ="";
		String hql = "";
		if ("sx".equals(type)){
			 hqlcolumn = " select new TSportCjSxHzYl(a.wid,a.dbtmc,a.yddmc,a.df,a.jps,a.yps,a.tps,a.hjjps,a.mc," +
					          " (select b.jjf  from TSportCjTdSxJjf b where a.departid=b.departid)as jjf ," +
					          " (select b.jjjps from TSportCjTdSxJjf b where a.departid=b.departid)as jjjps," +
					          " (select b.jjyps from TSportCjTdSxJjf b where a.departid=b.departid)as jjyps," +
					          " (select b.jjtps from TSportCjTdSxJjf b where a.departid=b.departid)as jjtps," +
					          " (select c.zdmc from TSysCode c where c.zdbm=a.hzlx and c.zdlb='CJ_HZLX')as hzlx)";
			hql = " from TSportCjSxHzYl a where 1=1 ";
			if (tsportCjSxHzYl != null) {
				if (StringUtils.isNotBlank(tsportCjSxHzYl.getDbtmc())) {
					hql += " and a.dbtmc like '%" + tsportCjSxHzYl.getDbtmc() + "%' ";
				}
				if (StringUtils.isNotBlank(tsportCjSxHzYl.getYddmc())) {
					hql += " and a.yddmc like '%" + tsportCjSxHzYl.getYddmc() + "%' ";
				}
			}
		}else if ("td".equals(type)){
			hqlcolumn = " select new TSportCjTdHzYl(a.wid,a.dbtmc,a.yddmc,a.df,a.jps,a.yps,a.tps,a.hjjps,a.mc," +
					          " (select b.jjf  from TSportCjTdSxJjf b where a.departid=b.departid)as jjf ," +
					          " (select b.jjjps from TSportCjTdSxJjf b where a.departid=b.departid)as jjjps," +
					          " (select b.jjyps from TSportCjTdSxJjf b where a.departid=b.departid)as jjyps," +
					          " (select b.jjtps from TSportCjTdSxJjf b where a.departid=b.departid)as jjtps," +
					          " (select c.zdmc from TSysCode c where c.zdbm=a.hzlx and c.zdlb='CJ_HZLX')as hzlx)";
			hql = " from TSportCjTdHzYl a where 1=1 ";
			if (tsportCjTdHzYl != null) {
			if (StringUtils.isNotBlank(tsportCjTdHzYl.getDbtmc())) {
				hql += " and a.dbtmc like '%" + tsportCjTdHzYl.getDbtmc() + "%' ";
			}
			if (StringUtils.isNotBlank(tsportCjTdHzYl.getHzlx())) {
				hql += " and a.hzlx='" + tsportCjTdHzYl.getHzlx().trim() + "' ";
			}
			}
		}
		long c = getBaseDao().count("select count(*) as c " + hql);
		hql = hqlcolumn + hql + " order by a.mc asc ";
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findPageByHql(hql, pager);
		return list;
		
	}

	
	public void load(Object myaction) throws Exception {
		SportSxCjHzYlAction action =(SportSxCjHzYlAction) myaction;
		String wid = action.getWid();
		String hql = " from TSportCjSxHzYl a where a.wid=? ";
		TSportCjSxHzYl tsportCjSxHzYl = (TSportCjSxHzYl) getBaseDao().findFieldValue(hql, wid);
		action.setTsportCjSxHzYl(tsportCjSxHzYl);
	}

	
	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		SportSxCjHzYlAction action=(SportSxCjHzYlAction)myaction;
		TSportCjSxHzYl tsportCjSxHzYl=action.getTsportCjSxHzYl();
		getBaseDao().updateNotNull(tsportCjSxHzYl);
	}

}
