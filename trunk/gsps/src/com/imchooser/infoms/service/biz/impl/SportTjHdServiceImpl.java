package com.imchooser.infoms.service.biz.impl;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportTjHdAction;
import com.imchooser.infoms.entity.biz.TSportCjTdMx;
import com.imchooser.util.DateUtil;

/**
 * 统计核对
 * 
 * @author Wangjunjun 2010-7-19
 */
public class SportTjHdServiceImpl extends BaseServiceAbstractSupport {

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.imchooser.framework.service.BaseService#list(java.lang.Object,
	 * com.imchooser.framework.util.Pager)
	 */
	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportTjHdAction action = (SportTjHdAction) myaction;
		TSportCjTdMx cjtdmx = action.getCjTdMx();
		if (cjtdmx == null) {
			cjtdmx = new TSportCjTdMx();
		}
		action.setCjTdMx(cjtdmx);
		// 集体项目
		String jtxm = "select  nvl(sum(t.jps+t.jjjps),0) jps, nvl(sum(t.yps+t.jjyps),0) yps,nvl(sum(t.tps+t.jjtps),0) tps,nvl(sum(t.df+t.jjf),0)df "
				+ "from t_sport_cj_jt t left join  t_sport_ssrc a on t.scbm=a.wid "
				+ "left join  t_sport_bsxm c on  c.wid=a.xmbm where a.fbzt=3 and a.scbm='2' and t.shzt=1 ";

		// 非集体项目
		String fjtxm = "select  nvl(sum(t.jps+t.jjjps),0) jps, nvl(sum(t.yps+t.jjyps),0) yps,nvl(sum(t.tps+t.jjtps),0) tps,nvl(sum(t.df+t.jjf),0)df "
				+ " from t_sport_cj_ydy t left join t_sport_ssrc a on t.scbm=a.wid left join t_sport_bsxm c on c.wid=a.xmbm where a.fbzt=3 and t.sfjtxm=0 and a.scbm='2' and t.shzt=1 ";

		// 折算的 金银铜
		String zs = " select  nvl(sum(t.jps+t.jjjps),0) jps, nvl(sum(t.yps+t.jjyps),0) yps,nvl(sum(t.tps+t.jjtps),0) tps,nvl(sum(t.df+t.jjf),0)df from t_sport_cj_td_mx t left join t_sport_ssrc a on a.wid=t.scbm  left join  t_sport_bsxm c on  c.wid=a.xmbm   where 1=1 ";
		// 理论折算次数
		String ll_cs = "select  sum(case when b.xyjfdq2 is not null and d.sfjtxm=0 and (a.df+a.jjf)>0 then 1 else 0 end )+"
				+ "sum(case when b.xyjfdq3 is not null and (a.df+a.jjf)>0 then 1 else 0 end )+"
				+ "sum(case when b.xyjfdq4 is not null and (a.jps+a.jjjps)>0 then 1 else 0 end ) cs "
				+ "from t_sport_cj_ydy a left join t_sport_ydyxx b on a.ydybm=b.wid "
				+ "left join t_sport_ssrc c on c.wid=a.scbm  and c.scbm=2 left join t_sport_bsxm d on c.xmbm=d.wid where  a.shzt=1 and c.fbzt=3 ";
		// 实际折算次数
		String sj_cs = "select count(*) from t_sport_cj_zs_mx e where e.dflx!=1 and length(e.departid)=6";

		// 用于显示打印时间
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
		String dateF = sdf.format(date);
		action.setParameter("printDate", dateF);

		// 折算
		List<?> zsData = DBUtil.queryAllList(zs);
		action.setParameter("zsData", zsData);
		// 折算前（ 实际产生数据）
		String sjSql = "select sum(aa.jps+bb.jps) jps, sum(aa.yps+bb.yps) yps,sum(aa.tps+bb.tps)tps,sum(aa.df+bb.df)df  from ("
				+ jtxm + ")aa,(" + fjtxm + " )bb";
		List<?> sjData = DBUtil.queryAllList(sjSql);
		action.setParameter("sjData", sjData);
		// 赛程 产生数据
		String ssrcSql = " SELECT NVL (SUM (g.pmjps), 0) jps, NVL (SUM (g.pmyps), 0) yps, NVL (SUM (g.pmtps), 0) tps, NVL (SUM (g.pmdf), 0) dfs "
				+ " FROM t_sport_scdfgz g  where  exists( select 1 from t_sport_ssrc a ,t_sport_bsxm c where a.xmbm=c.wid and a.fbzt=3 and a.scbm=2 and g.xmbm=c.wid )";
		List<?> ssrcData = DBUtil.queryAllList(ssrcSql);
		action.setParameter("ssrcData", ssrcData);
		// 实际得牌得分人数
		List<?> ll_cs_data = DBUtil.queryAllList(ll_cs);
		action.setParameter("ll_cs_data", ll_cs_data);
		// 折算得牌 得分人数
		List<?> sj_cs_data = DBUtil.queryAllList(sj_cs);
		action.setParameter("sj_cs_data", sj_cs_data);
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.imchooser.framework.service.BaseService#load(java.lang.Object)
	 */
	public void load(Object arg0) throws Exception {
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.imchooser.framework.service.BaseService#remove(java.lang.Object)
	 */
	public boolean remove(Object arg0) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.imchooser.framework.service.BaseService#saveOrUpdate(java.lang.Object
	 * )
	 */
	public void saveOrUpdate(Object arg0) throws Exception {
		// TODO Auto-generated method stub

	}

	/**
	 * 实际跟折算的出入查询
	 * 
	 * @param arg0
	 * @throws SQLException
	 */
	public void sjZs(Object arg0, Pager pager) throws SQLException {
		SportTjHdAction action = (SportTjHdAction) arg0;
		/*
		 * String sql = " select aa.scbm,aa.sfjtxm from "+
		 * "(select  nvl(sum(t.jps+t.jjjps),0) jps, nvl(sum(t.yps+t.jjyps),0) yps,nvl(sum(t.tps+t.jjtps),0) tps,nvl(sum(t.df+t.jjf),0)df,t.scbm scbm ,c.sfjtxm sfjtxm "
		 * +
		 * "from t_sport_cj_td_mx t left join t_sport_ssrc a on a.wid=t.scbm  left join  t_sport_bsxm c on  c.wid=a.xmbm where 1=1  group by t.scbm ,c.sfjtxm ) aa, "
		 * +
		 * "(select  nvl(sum(t.jps+t.jjjps),0) jps, nvl(sum(t.yps+t.jjyps),0) yps,nvl(sum(t.tps+t.jjtps),0) tps,nvl(sum(t.df+t.jjf),0)df ,t.scbm scbm "
		 * +
		 * "	from t_sport_cj_jt t left join  t_sport_ssrc a on t.scbm=a.wid  left join  t_sport_bsxm c on  c.wid=a.xmbm where a.fbzt=3 and a.scbm='2' and t.shzt=1 group by t.scbm) bb "
		 * +
		 * " where aa.scbm=bb.scbm  and( (aa.jps!=0   and bb.jps!=0 and aa.jps!=bb.jps )   or (aa.tps!=0   and bb.tps!=0 and aa.tps!=bb.tps ) or (aa.yps!=0   and bb.yps!=0 and aa.yps!=bb.yps ) ) "
		 * + "  union "+ "  select aa.scbm,aa.sfjtxm from "+
		 * "(select  nvl(sum(t.jps+t.jjjps),0) jps, nvl(sum(t.yps+t.jjyps),0) yps,nvl(sum(t.tps+t.jjtps),0) tps,nvl(sum(t.df+t.jjf),0)df,t.scbm scbm,c.sfjtxm sfjtxm "
		 * +
		 * " from t_sport_cj_td_mx t left join t_sport_ssrc a on a.wid=t.scbm  left join  t_sport_bsxm c on  c.wid=a.xmbm where 1=1  group by t.scbm,c.sfjtxm ) aa, "
		 * +
		 * " (select  nvl(sum(t.jps+t.jjjps),0) jps, nvl(sum(t.yps+t.jjyps),0) yps,nvl(sum(t.tps+t.jjtps),0) tps,nvl(sum(t.df+t.jjf),0)df ,t.scbm scbm "
		 * +
		 * " from t_sport_cj_ydy t left join t_sport_ssrc a on t.scbm=a.wid left join t_sport_bsxm c on c.wid=a.xmbm where a.fbzt=3 and t.sfjtxm=0 and a.scbm='2' and t.shzt=1 "
		 * +
		 * " group by t.scbm  )cc   where aa.scbm=cc.scbm  and( (aa.jps!=0   and cc.jps!=0 and aa.jps!=cc.jps ) "
		 * +
		 * " or (aa.tps!=0   and cc.tps!=0 and aa.tps!=cc.tps ) or (aa.yps!=0   and cc.yps!=0 and aa.yps!=cc.yps )   )"
		 * ; List<Object[]> list = DBUtil.queryAllList(sql); StringBuilder sb =
		 * new StringBuilder(); if(list!=null && list.size()>0){ for(int
		 * i=0;i<list.size();i++){ Object [] obj = list.get(i); if(obj!=null){
		 * if(i==0){ sb.append("'"+obj[0]+"'"); }else{
		 * sb.append(",'"+obj[0]+"'"); } } } }
		 */

		String sqlcolumn = " select to_char(e.bssj, 'yyyy-MM-dd')  AS bssj, (t.dxmmc || '，' || t.xxmmc) , x.xm, t.dbd, "
				+ " (t.jps+t.jjjps),(t.yps+t.jjyps),(t.tps+t.jjtps),(t.df+t.jjf), "
				+ " replace(wmsys.wm_concat( (select c.departname from T_Sys_Depart c where c.departid=x.xyjfdq3)"
				+ " ||'_'|| (select c.departname from T_Sys_Depart c where c.departid=x.xyjfdq7)"
				+ " ||'_'|| (select c.departname from T_Sys_Depart c where c.departid=x.xyjfdq2)"
				+ " ||'_'||(select c.departname from T_Sys_Depart c where c.departid=x.xyjfdq4)),',','_')as ydyxxb,"
				+ " replace(wmsys.wm_concat( (select e.zdmc from t_sys_code e where e.zdlb='MX_DFLX' and e.zdbm=b.dflx)||'_'|| b.dbtmc "
				+ " ||'_'||(b.jps+b.jjjps+1)||'_'||(b.yps+b.jjyps+1)||'_'||(b.tps+b.jjtps+1)||'_'||(b.df+b.jjf+1)),',','_') as zsb, b.mc ";
		String sql_ydy = "  from t_sport_cj_zs_mx b left join t_sport_ssrc e on b.scbm=e.wid left join t_sport_bsxm f on f.wid=e.xmbm"
				+ " left join t_sport_cj_ydy t on t.ydybm=b.dfly and b.scbm=t.scbm left join t_sport_ydyxx x on t.ydybm=x.wid where b.dflx!=1 ";
		/*
		 * if(sb.length()>0){ sql_ydy+=" and e.wid in("+sb.toString()+") "; }
		 */
		String departid = action.getParameter("departid");
		if (StringUtils.isNotBlank(departid)) {
			sql_ydy += " and b.departid='" + departid + "' ";
		}
		String talSql = sqlcolumn
				+ sql_ydy
				+ "  group by e.bssj, t.scbm,t.dxmmc,t.xxmmc,  x.xm,t.dbd, (t.jps + t.jjjps), (t.yps + t.jjyps),  (t.tps + t.jjtps), (t.df + t.jjf) ,b.mc order by bssj desc ";
		long c = DBUtil.count("select count(*) as c " + sql_ydy);// 分页
		pager.setTotalRows(c);
		List<?> resultData = DBUtil.queryPageList(pager, talSql);
		action.setResultData(resultData);
	}

	/**
	 * 获取距离今天最近的比赛时间
	 * 
	 * @param action
	 * @return
	 * @throws Exception
	 */
	public String getRecentDate(TSportCjTdMx cjtdmx) throws Exception {
		String sql = " select ss.times from  (select distinct to_char(a.bssj,'yyyy-MM-dd') times from t_sport_cj_td_mx t,t_sport_ssrc a  where t.scbm=a.wid and  t.departid=? ) ss order by ss.times";
		List<Object[]> listapp = DBUtil.queryAllList(sql, cjtdmx.getDepartid());
		int index = 0;
		if (!listapp.isEmpty()) {
			long min = DateUtil.dateDayInteval(DateUtil.currentDateString(), listapp.get(0)[0].toString());
			for (int i = 0; i < listapp.size(); i++) {
				long c = DateUtil.dateDayInteval(DateUtil.currentDateString(), listapp.get(i)[0].toString());
				if (!(c > Math.abs(min))) {
					index = i;
					min = c;
				}
			}
		}
		return String.valueOf(listapp.get(index)[0]);
	}

	/**
	 * 实际得牌跟折算得牌人数的出入查询
	 * 
	 * @param arg0
	 * @throws SQLException
	 */
	public void rsZs(Object arg0, Pager pager) throws SQLException {
		SportTjHdAction action = (SportTjHdAction) arg0;
		String sql = " select   to_char(c.bssj, 'yyyy-MM-dd')  bssj, (a.dxmmc || '，' || a.xxmmc) , v.xm, a.dbd,   (a.jps+a.jjjps),(a.yps+a.jjyps),(a.tps+a.jjtps),(a.df+a.jjf),  '--'  zsb, a.mc "
				+ " from t_sport_cj_ydy a left join t_sport_ydyxx  v on a.ydybm=v.wid "
				+ " left join t_sport_ssrc c on c.wid=a.scbm  and c.scbm=2 "
				+ " left join t_sport_bsxm d on c.xmbm=d.wid "
				+ " where  a.shzt=1 and c.fbzt=3 and "
				+ " (((v.xyjfdq2 IS NOT NULL AND d.sfjtxm = 0 AND (a.df + a.jjf) > 0)  AND a.ydybm NOT IN (SELECT e.dfly  FROM t_sport_cj_zs_mx e  WHERE e.dflx = 2 AND LENGTH (e.departid) = 6)) "
				+ " OR ((v.xyjfdq3 IS NOT NULL AND (a.df + a.jjf) > 0) AND a.ydybm NOT IN (SELECT e.dfly  FROM t_sport_cj_zs_mx e  WHERE e.dflx = 3 AND LENGTH (e.departid) = 6)) "
				+ " OR ((v.xyjfdq4 IS NOT NULL AND (a.jps + a.jjjps) > 0) AND a.ydybm NOT IN (SELECT e.dfly  FROM t_sport_cj_zs_mx e  WHERE e.dflx = 4 AND LENGTH (e.departid) = 6))) ";
		// +
		// " ( (v.xyjfdq2 is not null and d.sfjtxm=0 and (a.df+a.jjf)>0) or (v.xyjfdq3 is not null and (a.df+a.jjf)>0) or (v.xyjfdq4 is not null and (a.jps+a.jjjps)>0)) "
		// +
		// " and a.ydybm not in (select e.dfly from t_sport_cj_zs_mx e where e.dflx!=1 and length(e.departid)=6 ) ";

		long c = DBUtil.count("select count(*) as c from( " + sql + ") ");// 分页
		pager.setTotalRows(c);
		pager.setEachPageRows(8);
		List<?> resultData = DBUtil.queryPageList(pager, sql);
		action.setResultData(resultData);
	}
}
