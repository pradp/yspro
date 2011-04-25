package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportRcbmrsHzAction;
import com.imchooser.infoms.entity.biz.TSportBsxm;

/**
 * 代表团二次报名人数汇总
 * 
 * @author LiBing DateTime 2010-8-27
 */
public class SportRcbmrsHzServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportRcbmrsHzAction action = (SportRcbmrsHzAction) myaction;
		TSportBsxm tsportBsxm = action.getTsportBsxm();
		String depart = action.getDepartID();
		if(tsportBsxm!=null){
			String dxmmc = java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8");
			action.setParameter("dxmmc", dxmmc);
			String dbd = tsportBsxm.getDbd();
			if(StringUtils.isNotBlank(dbd)){
				depart = dbd;
			}
		}
		if(tsportBsxm!=null&&StringUtils.isNotBlank(tsportBsxm.getDxmmc())){  //小项目报名情况汇总
			String sql1 = "select * from(select s.dxmmc||'，'||(select f.zdmc from t_sys_code f where f.zdbm=s.zb and f.zdlb='BSXM_ZB')" 
				+ " ||'，'||(select f.zdmc from t_sys_code f where f.zdbm=s.xbz and f.zdlb='BSXM_XBZ')||'，'||s.xxmmc," 
				+ " case when (select  count(*) from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid where b.yddbm like ? and" 
				+ " (a.bsxmwid1=s.wid or a.bsxmwid2=s.wid or a.bsxmwid3=s.wid or a.bsxmwid4=s.wid or a.bsxmwid5=s.wid or a.bsxmwid6=s.wid or a.bsxmwid7=s.wid or a.bsxmwid8=s.wid or a.bsxmwid9=s.wid or a.bsxmwid10=s.wid or a.bsxmwid11=s.wid or a.bsxmwid12=s.wid or a.bsxmwid13=s.wid) and b.state='1')=0" 
				+ " then '未开始'" 
				+ " when (select count(*)  from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid where b.yddbm like ? and " 
				+ " (a.bsxmwid1=s.wid or a.bsxmwid2=s.wid or a.bsxmwid3=s.wid or a.bsxmwid4=s.wid or a.bsxmwid5=s.wid or a.bsxmwid6=s.wid or a.bsxmwid7=s.wid or a.bsxmwid8=s.wid or a.bsxmwid9=s.wid or a.bsxmwid10=s.wid or a.bsxmwid11=s.wid or a.bsxmwid12=s.wid or a.bsxmwid13=s.wid) and b.state='0')=0" 
				+ " then '报名结束' else '在报名中'end st," 
				+ " (select count(*) from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid where b.yddbm like ? and " 
				+ " (a.bsxmwid1=s.wid or a.bsxmwid2=s.wid or a.bsxmwid3=s.wid or a.bsxmwid4=s.wid or a.bsxmwid5=s.wid or a.bsxmwid6=s.wid or a.bsxmwid7=s.wid or a.bsxmwid8=s.wid or a.bsxmwid9=s.wid or a.bsxmwid10=s.wid or a.bsxmwid11=s.wid or a.bsxmwid12=s.wid or a.bsxmwid13=s.wid))as ycbmrs," 
				+ " (select count(count(a.wid)) from t_sport_ydybmxm a left join  t_sport_ydyxx b on a.ydywid = b.wid where b.yddbm like ? and a.bsxmwid=s.wid group by a.ydywid)as rcbmrs,s.dxmmc" 
				+ " from t_sport_bsxm s group by s.dxmmc,s.xxmmc,s.wid,s.zb,s.xbz)aa where 1=1";
				if (tsportBsxm != null) {
					if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
						sql1+=" and aa.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
					}
					if (StringUtils.isNotBlank(tsportBsxm.getBmstate())) {
						sql1+=" and aa.st = '" + tsportBsxm.getBmstate() + "' ";
					}
				}
				long c = DBUtil.count("select count(*) as c from (" + sql1+")", depart+"%",depart+"%",depart+"%",depart+"%");
				pager.setTotalRows(c);
				List<?> list = DBUtil.queryPageList(pager, sql1, depart+"%",depart+"%",depart+"%",depart+"%");
				//统计一次已报小项目个数
				String sqlycbmxx = "select a.bsxmwid1 ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? ";
					if (tsportBsxm != null) {
						if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
							sqlycbmxx+=" and a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
						}
					}
					sqlycbmxx+=" union select a.bsxmwid2 ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? ";
					if (tsportBsxm != null) {
						if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
							sqlycbmxx+=" and a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
						}
					}
					sqlycbmxx+=" union select a.bsxmwid3 ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? ";
					if (tsportBsxm != null) {
						if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
							sqlycbmxx+=" and a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
						}
					}
					sqlycbmxx+=" union select a.bsxmwid4 ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ?";
					if (tsportBsxm != null) {
						if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
							sqlycbmxx+=" and a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
						}
					}
					sqlycbmxx+=" union select a.bsxmwid5 ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ?";
					if (tsportBsxm != null) {
						if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
							sqlycbmxx+=" and a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
						}
					}
					sqlycbmxx+=" union select a.bsxmwid6 ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ?";
					if (tsportBsxm != null) {
						if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
							sqlycbmxx+=" and a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
						}
					}
					sqlycbmxx+=" union select a.bsxmwid7 ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ?";
					if (tsportBsxm != null) {
						if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
							sqlycbmxx+=" and a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
						}
					}
					sqlycbmxx+=" union select a.bsxmwid8 ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ?";
					if (tsportBsxm != null) {
						if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
							sqlycbmxx+=" and a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
						}
					}
					sqlycbmxx+=" union select a.bsxmwid9 ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ?";
					if (tsportBsxm != null) {
						if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
							sqlycbmxx+=" and a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
						}
					}
					sqlycbmxx+=" union select a.bsxmwid10 ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ?";
					if (tsportBsxm != null) {
						if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
							sqlycbmxx+=" and a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
						}
					}
					sqlycbmxx+=" union select a.bsxmwid11 ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ?";
					if (tsportBsxm != null) {
						if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
							sqlycbmxx+=" and a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
						}
					}
					sqlycbmxx+=" union select a.bsxmwid12 ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ?";
					if (tsportBsxm != null) {
						if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
							sqlycbmxx+=" and a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
						}
					}
					sqlycbmxx+=" union select a.bsxmwid13 ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ?";
					if (tsportBsxm != null) {
						if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
							sqlycbmxx+=" and a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
						}
					}
				long count_sqlycbmxx = DBUtil.count("select count(aa.ss) from ("+sqlycbmxx+")aa",depart+"%",depart+"%",depart+"%",depart+"%",depart+"%",depart+"%",depart+"%",depart+"%",depart+"%",depart+"%",depart+"%",depart+"%",depart+"%");
				action.setParameter("countYcbmxx", String.valueOf(count_sqlycbmxx));
				//统计二次已报小项目个数
				String sqlrcbmxx = "select distinct(a.bsxmwid) from t_sport_ydybmxm a left join  t_sport_ydyxx b on a.ydywid = b.wid "; 
				if (tsportBsxm != null) {
					if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
						sqlrcbmxx+=" where a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
					}
				}
				sqlrcbmxx +=" and b.yddbm like ?";
				long count_sqlrcbmxx = DBUtil.count("select count(*) from ("+sqlrcbmxx+")",depart+"%");
				action.setParameter("countRcbmxx", String.valueOf(count_sqlrcbmxx));
				return list;
		}else{   //大项目报名情况汇总
			/*String sql = "select * from(select s.dxmmc,case "
					+ " when (select  count(*)  from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid " 
					+ " where b.yddbm like ? and a.dxmmc = s.dxmmc and b.state='1')=0 "
					+ " then '未开始' "
					+ " when (select  count(*)  from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid " 
					+ " where b.yddbm like ? and a.dxmmc = s.dxmmc and b.state='0')=0 "
					+ " then '报名结束' else '在报名中' end st,"
					+ " (select count(*) from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid " 
					+ " where b.yddbm like ? and a.dxmmc = s.dxmmc )as ycbm," 
					+ " (select count(count(a.wid)) from t_sport_ydybmxm a left join  t_sport_ydyxx b on a.ydywid = b.wid " 
					+ " where b.yddbm like ? and a.dxmmc = s.dxmmc group by a.ydywid)as rcbm ," 
					+ " (select count(aa.ss) from(select a.bsxmwid1,a.dxmmc ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? and a.bsxmwid1 is not null " 
					+ " union select a.bsxmwid2,a.dxmmc ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? and a.bsxmwid2 is not null" 
					+ " union select a.bsxmwid3,a.dxmmc ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? and a.bsxmwid3 is not null" 
					+ " union select a.bsxmwid4,a.dxmmc ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? and a.bsxmwid4 is not null" 
					+ " union select a.bsxmwid5,a.dxmmc ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? and a.bsxmwid5 is not null" 
					+ " union select a.bsxmwid6,a.dxmmc ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? and a.bsxmwid6 is not null" 
					+ " union select a.bsxmwid7,a.dxmmc ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? and a.bsxmwid7 is not null" 
					+ " union select a.bsxmwid8,a.dxmmc ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? and a.bsxmwid8 is not null" 
					+ " union select a.bsxmwid9,a.dxmmc ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? and a.bsxmwid9 is not null" 
					+ " union select a.bsxmwid10,a.dxmmc ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? and a.bsxmwid10 is not null" 
					+ " union select a.bsxmwid11,a.dxmmc ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? and a.bsxmwid11 is not null" 
					+ " union select a.bsxmwid12,a.dxmmc ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? and a.bsxmwid12 is not null" 
					+ " union select a.bsxmwid13,a.dxmmc ss from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ? and a.bsxmwid13 is not null) aa where aa.ss=s.dxmmc)as ycbmdxm," 
					+ "(select count( distinct aa.bsxmwid) from (select a.bsxmwid bsxmwid,a.dxmmc dxmmc from t_sport_ydybmxm a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ?) aa where aa.dxmmc=s.dxmmc)as rcbmxxm" 
					+ " from t_sport_bsxm s group by s.dxmmc)aa where 1=1";*/
			 String sql = "select * from(select t.departname,case  when " +
			 		" (select  count(*)  from t_sport_ydybmxm_cc a left join  t_sport_ydyxx f on a.ydywid = f.wid  where t.departid=substr(f.yddbm,0,6) and f.state='1'and f.yddbm like ?)=0  " +
			 		" then '未开始'  when " +
			 		" (select  count(*)  from t_sport_ydybmxm_cc a left join  t_sport_ydyxx f on a.ydywid = f.wid  where  t.departid=substr(f.yddbm,0,6) and f.state='0'and f.yddbm like ?)=0  " +
			 		" then '报名结束' else '在报名中' end st, " +
			 		" (select count(*) from t_sport_ydybmxm_cc a left join t_sport_ydyxx f on a.ydywid=f.wid where t.departid=substr(f.yddbm,0,6) and f.yddbm like ?)as ycbmrs," +
			 		" (select count(distinct(c.ydywid)) from t_sport_ydybmxm c left join t_sport_ydyxx f on c.ydywid = f.wid where t.departid=substr(f.yddbm,0,6)and f.yddbm like ?)as rcbmrs," +
			 		" (select count(distinct(a.dxmmc)) from t_sport_ydybmxm_cc a left join t_sport_ydyxx f on a.ydywid=f.wid left join t_sport_bsxm e on a.dxmmc = e.dxmmc where t.departid=substr(f.yddbm,0,6)and f.yddbm like ?)as ycbmdxm," +
			 		" (select count(distinct(a.dxmmc)) from t_sport_ydybmxm a left join t_sport_ydyxx f on a.ydywid=f.wid left join t_sport_bsxm e on a.dxmmc = e.dxmmc where t.departid=substr(f.yddbm,0,6)and f.yddbm like ?)as rcbmdxm" +
			 		" from t_sys_depart t left join t_sport_ydyxx s on t.departid=substr(s.yddbm,0,6) " +
			 		" where length(t.departid)=6 and s.yddbm like ? group by t.departname,t.departid)aa where 1=1";
					if (tsportBsxm != null) {
						if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
							sql+=" and aa.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "utf-8") + "' ";
						}
						if (StringUtils.isNotBlank(tsportBsxm.getBmstate())) {
							sql+=" and aa.st = '" + tsportBsxm.getBmstate() + "' ";
						}
					}
			long c = DBUtil.count("select count(*) as c from (" + sql+")", depart+"%",depart+"%",depart+"%",depart+"%",depart+"%",depart+"%",depart+"%");
			pager.setTotalRows(c);
			List<?> list = DBUtil.queryPageList(pager, sql, depart+"%",depart+"%",depart+"%",depart+"%",depart+"%",depart+"%",depart+"%");
			//统计一次已报大项目个数
			String sqlycbm = "select distinct(a.dxmmc) from t_sport_ydybmxm_cc a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ?";
			long count_sqlycbm = DBUtil.count("select count(*) from ("+sqlycbm+")",depart+"%");
			action.setParameter("countYcbm", String.valueOf(count_sqlycbm));
			//统计二次已报大项目个数
			String sqlrcbm = "select distinct(a.dxmmc) from t_sport_ydybmxm a left join  t_sport_ydyxx b on a.ydywid = b.wid  where b.yddbm like ?";
			long count_sqlrcbm = DBUtil.count("select count(*) from ("+sqlrcbm+")",depart+"%");
			action.setParameter("countRcbm", String.valueOf(count_sqlrcbm));
			//统计 已报的代表团个数(二次报名)
			String sqllcbmdbrs = "select count(distinct substr(b.yddbm,0,6)) from t_sport_ydybmxm g left join t_sport_ydyxx b on g.ydywid=b.wid";
			long count_dbts = DBUtil.count(sqllcbmdbrs);
			action.setParameter("countDbts", String.valueOf(count_dbts));
			//统计未报名的代表团个数(二次报名)
			long count_wbms = 13 - count_dbts;
			action.setParameter("countDbts_wb", String.valueOf(count_wbms));
			return list;
		}
	}

	public void load(Object arg0) throws Exception {

	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object arg0) throws Exception {

	}

}
