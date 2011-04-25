package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportSjhdXydAction;
import com.imchooser.infoms.entity.biz.TSportCjYdy;

/**
 * 数据核对协议地(协议地成绩分布)
 * @author LiBing
 * DateTime 2010-5-27
 */
public class SportSjhdXydServiceImpl extends BaseServiceAbstractSupport{


	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportSjhdXydAction action =(SportSjhdXydAction) myaction;
		TSportCjYdy tsportCjYdy =action.getTsportCjYdy();

		String sqlcolumn =" select to_char(e.bssj, 'yyyy-MM-dd')  AS bssj, (t.dxmmc || '，' || t.xxmmc) , x.xm, t.dbd, " +
				" (t.jps+t.jjjps),(t.yps+t.jjyps),(t.tps+t.jjtps),(t.df+t.jjf), " +
				" replace(wmsys.wm_concat( (select c.departname from T_Sys_Depart c where c.departid=x.xyjfdq3)" +
				" ||'_'|| (select c.departname from T_Sys_Depart c where c.departid=x.xyjfdq7)" +
				" ||'_'|| (select c.departname from T_Sys_Depart c where c.departid=x.xyjfdq2)" +
				" ||'_'||(select c.departname from T_Sys_Depart c where c.departid=x.xyjfdq4)),',','_')as ydyxxb," +
				" replace(wmsys.wm_concat( (select e.zdmc from t_sys_code e where e.zdlb='MX_DFLX' and e.zdbm=b.dflx)||'_'|| b.dbtmc " +
				" ||'_'||(b.jps+b.jjjps+1)||'_'||(b.yps+b.jjyps+1)||'_'||(b.tps+b.jjtps+1)||'_'||(b.df+b.jjf+1)),',','_') as zsb, b.mc ";
		String sql = "  from t_sport_cj_zs_mx b left join t_sport_ssrc e on b.scbm=e.wid left join t_sport_bsxm f on f.wid=e.xmbm left join t_sport_cj_ydy t on t.ydybm=b.dfly and b.scbm=t.scbm left join t_sport_ydyxx x on t.ydybm=x.wid where b.dflx!=1 ";
		if (tsportCjYdy != null) {
			if (StringUtils.isNotBlank(tsportCjYdy.getDxmmc())) {
				sql += "  and b.dxmmc like '%" + tsportCjYdy.getDxmmc() + "%' ";
			}
			if (StringUtils.isNotBlank(tsportCjYdy.getXxmmc())) {
				sql += " and b.xxmmc like '%" +java.net.URLDecoder.decode( tsportCjYdy.getXxmmc(),"utf-8") + "%' ";
			}
			if (StringUtils.isNotBlank(tsportCjYdy.getYdyxm())) {
				sql += " and t.ydyxm like '%" + tsportCjYdy.getYdyxm() + "%' ";
			}
			if (StringUtils.isNotBlank(tsportCjYdy.getZb())) {
				sql += " and f.zb='" + tsportCjYdy.getZb() + "' ";
			}
			if (StringUtils.isNotBlank(tsportCjYdy.getXbz())) {
				sql += " and f.xbz='" + tsportCjYdy.getXbz() + "' ";
			}
			if (StringUtils.isNotBlank(tsportCjYdy.getDbd())) {
				sql += " and x.yddbm like (select g.departid from  t_sys_depart g where g.departname='" + tsportCjYdy.getDbd() + "')||'%' ";
			}
		}
		if (StringUtils.isNotBlank(action.getParameter("bssj"))) {
			sql += " and to_char((select b.bssj from t_sport_ssrc b where b.wid=t.scbm),'yyyy-MM-dd')= '" + action.getParameter("bssj")+"'" ;
		}
		action.setParameter("bssj", action.getParameter("bssj"));
		sql += " group by e.bssj, t.scbm,t.dxmmc,t.xxmmc,  x.xm,t.dbd, (t.jps + t.jjjps), (t.yps + t.jjyps),  (t.tps + t.jjtps), (t.df + t.jjf) ,b.mc order by bssj desc ";
		 long c = DBUtil.count("select count(count(*)) as c " + sql);//分页
         sql = sqlcolumn + sql;
         pager.setTotalRows(c);
         pager.setEachPageRows(8);
         List<?> resultData =DBUtil.queryPageList(pager, sql);
         return resultData;
	}

	
	public void load(Object arg0) throws Exception {
		
	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object arg0) throws Exception {
		
	}


}
