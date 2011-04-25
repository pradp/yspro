package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportSjhdSxAction;
import com.imchooser.infoms.entity.biz.TSportCjYdy;

/**
 * 数据核对区县(区县成绩分布)
 * @author LiBing
 * DateTime 2010-6-2
 */
public class SportSjhdSxServiceImpl extends BaseServiceAbstractSupport{

	
	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportSjhdSxAction action =(SportSjhdSxAction) myaction;
		TSportCjYdy tsportCjYdy =action.getTsportCjYdy();
		
		String sqlcolumn ="select (select to_char(b.bssj,'yyyy-MM-dd') from t_sport_ssrc b where b.wid=t.scbm) as bssj,(t.dxmmc||'，'||t.xxmmc),t.ydyxm," +
				" (select b.departname  from t_sys_depart b where a.yddbm=b.departid )as dbd,(t.jps+t.jjjps),(t.df+t.jjf)," +
				" replace(wmsys.wm_concat((select c.departname from T_Sys_Depart c where c.departid=a.xyjfdq6) ||'_'||" +
				" (select c.departname from T_Sys_Depart c where c.departid=a.xyjfdq5)),',','_')as ydyxxb," +
				" replace(wmsys.wm_concat((select e.zdmc from t_sys_code e where e.zdlb='MX_DFLX' and e.zdbm=m.dflx) ||'_'||m.yddmc ||'_'||" +
				" (m.jps+m.jjjps+1)||'_'||(m.df+m.jjf+1)),',','_')as zsb";

		String sqlcolumn2 ="select (select to_char(b.bssj,'yyyy-MM-dd') from t_sport_ssrc b where b.wid=t.scbm) as bssj,(t.dxmmc||'，'||t.xxmmc),t.ydyxm," +
				" (select b.departname  from t_sys_depart b where a.yddbm=b.departid )as dbd,(t.jps+t.jjjps),(t.df+t.jjf)," +
				" replace(wmsys.wm_concat((select c.departname from T_Sys_Depart c where c.departid=a.xyjfdq6) ||'_'||" +
				" (select c.departname from T_Sys_Depart c where c.departid=a.xyjfdq5)),',','_')as ydyxxb," +
				" (m.jps+m.jjjps) as zsb";
		String sql = " from  t_sport_cj_ydy t left join  t_sport_ydyxx a on a.wid=t.ydybm left join t_sport_cj_zs_mx m " +
				    " on t.ydybm like '%'||m.dfly||'%' and t.scbm=m.scbm left join t_sport_ssrc e " +
				    " on t.scbm=e.wid left join t_sport_bsxm f on e.xmbm=f.wid where t.sfjtxm='0' and (length(m.departid)=9 or m.departid is null)" +
				    " and ((select c.departname from T_Sys_Depart c where c.departid=a.xyjfdq6)is not null or" +
				    " (select c.departname from T_Sys_Depart c where c.departid=a.xyjfdq5)is not null )" +
				    " and ((t.jps+t.jjjps) is not null and (t.jps+t.jjjps)!=0)"+
				    " and (((t.jps+t.jjjps) is not null and (t.jps+t.jjjps)!=0) or ((t.df+t.jjf) is not null and (t.df+t.jjf)!=0))";
		
		if (tsportCjYdy != null) {
			if (StringUtils.isNotBlank(tsportCjYdy.getDxmmc())) {
				sql += " and t.dxmmc like '%" + tsportCjYdy.getDxmmc() + "%' ";
			}
			if (StringUtils.isNotBlank(tsportCjYdy.getXxmmc())) {
				sql += " and t.xxmmc like '%" + tsportCjYdy.getXxmmc() + "%' ";
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
				sql += " and t.dbd = '" + tsportCjYdy.getDbd() + "' ";
			}
		}
		if (StringUtils.isNotBlank(action.getParameter("bssj"))) {
			sql += " and to_char((select b.bssj from t_sport_ssrc b where b.wid=t.scbm),'yyyy-MM-dd')= '" + action.getParameter("bssj")+"'" ;
		}
		action.setParameter("bssj", action.getParameter("bssj"));
		String sql2 = sql;
		sql += " group by t.scbm,(t.dxmmc||'，'||t.xxmmc),t.ydyxm,a.yddbm,(t.jps+t.jjjps),(t.df+t.jjf) order by bssj desc";
		sql2 += " group by t.scbm,(t.dxmmc||'，'||t.xxmmc),t.ydyxm,a.yddbm,(t.jps+t.jjjps),(t.df+t.jjf),(m.jps+m.jjjps) order by bssj desc";
		
		long c = DBUtil.count("select count(count(*)) as c " + sql);//分页
        sql = sqlcolumn + sql;
        pager.setTotalRows(c);
        List<?> resultData =DBUtil.queryPageList(pager, sql);
        String hz_jp = "select sum(k.zsb) from ("+sqlcolumn2+sql2+") k";
        Object hz_jps =   DBUtil.queryFieldValue(hz_jp);
        //实际折算汇总值
        action.setParameter("hz_jps", String.valueOf(hz_jps));
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
