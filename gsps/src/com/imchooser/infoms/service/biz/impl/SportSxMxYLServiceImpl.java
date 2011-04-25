package com.imchooser.infoms.service.biz.impl;

import java.net.URLDecoder;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportSxMxYLAction;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.util.StringUtil;

/*
 * * 运动员成绩表
 * 
 * @author WangJunjun
 * 
 * @date:2010-3-24
 */
public class SportSxMxYLServiceImpl extends BaseServiceAbstractSupport {
	@SuppressWarnings("unchecked")
	public List list(Object myaction, Pager pager) throws Exception {
		SportSxMxYLAction action = (SportSxMxYLAction) myaction;
		// 获取左边树结构传来的 姓名名称
		String bsxm = action.getParameter("bsxm");
		String type = action.getParameter("type");
		// 判断界面显示 保存 还是 审批 "dj" 登记 ---出现 保存 “sp” 审批----出现审批
		action.setParameter("type", type);
		TSportBsxm sportBsxm = action.getSportBsxm();
		action.setParameter("bsxm", bsxm);
		String sqlColumn = "";
		// 待审批 菜单 标识
		sqlColumn = " select c.wid,(select a.dxmmc from  T_Sport_Bsxm a where c.xmbm=a.wid)as dxmmc,"
				+ "(select a.xxmmc from  T_Sport_Bsxm a where c.xmbm=a.wid) as xxmmc,"
				+ "(select a.zb from  T_Sport_Bsxm a where c.xmbm=a.wid)as zb,"
				+ "(select a.xbz from  T_Sport_Bsxm a where c.xmbm=a.wid)as xbz,"
				+ "(select a.xmdj from  T_Sport_Bsxm a where c.xmbm=a.wid)as xmdj,"
				+ "c.scbm as sc,(select f.zdmc from T_Sys_Code f where f.zdlb='BSXM_ZB' and f.zdbm=(select a.zb from  T_Sport_Bsxm a where c.xmbm=a.wid) ) as zbcn,"
				+ " to_char(c.bssj,'yyyy-MM-dd HH24:mi:ss') as startTime,(select max(k.sfjtxm) from T_Sport_Bsxm k where k.wid=c.xmbm ) as sfjtxm,"
				+ "(select  e.zdmc from T_Sys_Code e where e.zdlb='SSRC_SCBM' and e.zdbm=c.scbm) as scCn,c.cjdw,"
				+ " (select (case when a.sfdzxm=1 and a.sfjtxm=1  then "
				+ "nvl( (select replace(wmsys.wm_concat(case when j.dbtmc is null then j.dbtmc else j.dbtmc end),',',':') from t_sport_cj_jt j  where  scbm = c.wid  group by scbm having count(*)=2  )  ,'---')"
				+ "when a.sfdzxm=1 then "
				+ "nvl((select replace(wmsys.wm_concat(y.ydyxm),',',':') from t_sport_cj_ydy y  where  scbm = c.wid   group by scbm having count(*)=2 ),'---')"
				+ "else '非对战' end ) as c from  T_Sport_Bsxm a where c.xmbm=a.wid)as dzr, (select t.zdmc from t_sys_code t where t.zdlb='SSRC_BPFZ' and t.zdbm=c.bpfz) as bpfz  from t_sport_ssrc c left join t_sport_cj_jt a on  a.scbm=c.wid  where c.xmbm  in (select  n.wid  from t_sport_bsxm n where n.sfjtxm='1' and n.sfdzxm='1'";
		String sql2 = " ) and c.scbm='2'  and c.fbzt='3' ";
		String sql3 = " group by a.scbm,c.bssj,c.cjdw,c.xmbm,c.scbm,c.wid,c.bpfz "
				+ "union "
				+ "  select c.wid,(select a.dxmmc from  T_Sport_Bsxm a where c.xmbm=a.wid)as dxmmc,"
				+ " (select a.xxmmc from  T_Sport_Bsxm a where c.xmbm=a.wid) as xxmmc,"
				+ " (select a.zb from  T_Sport_Bsxm a where c.xmbm=a.wid)as zb,"
				+ " (select a.xbz from  T_Sport_Bsxm a where c.xmbm=a.wid)as xbz,"
				+ "  (select a.xmdj from  T_Sport_Bsxm a where c.xmbm=a.wid)as xmdj,c.scbm as sc,"
				+ " (select f.zdmc from T_Sys_Code f where f.zdlb='BSXM_ZB' and f.zdbm=(select a.zb from  T_Sport_Bsxm a where c.xmbm=a.wid) ) as zbcn,to_char(c.bssj,'yyyy-MM-dd HH24:mi:ss')as startTime,"
				+ " (select max(k.sfjtxm) from T_Sport_Bsxm k where k.wid=c.xmbm ) as sfjtxm,"
				+ " (select  e.zdmc from T_Sys_Code e where e.zdlb='SSRC_SCBM' and e.zdbm=c.scbm) as scCn,c.cjdw, '非对战', (select t.zdmc from t_sys_code t where t.zdlb='SSRC_BPFZ' and t.zdbm=c.bpfz) as bpfz"
				+ " from t_sport_ssrc c  left join   t_sport_cj_ydy a on a.scbm=c.wid where  c.xmbm not  in (select  n.wid  from t_sport_bsxm n where n.sfjtxm='1' and n.sfdzxm='1'";

		String sql4 = " ) and c.scbm='2' and c.fbzt='3' ";
		String sql5 = "  group by a.scbm,c.bssj,c.cjdw,c.xmbm,c.scbm,c.wid,c.bpfz ";
		if (sportBsxm != null) {
			sql4 += " and c.xmbm in ( select  n.wid  from t_sport_bsxm n where 1=1 ";
			if (StringUtil.isNotBlank(sportBsxm.getDxmmc())) {
				sqlColumn += " and n.dxmmc='" + URLDecoder.decode(sportBsxm.getDxmmc(), "utf-8") + "' ";
				sql4 += " and n.dxmmc='" + URLDecoder.decode(sportBsxm.getDxmmc(), "utf-8") + "' ";
			}
			if (StringUtils.isNotBlank(sportBsxm.getXxmmc())) {
				sqlColumn += " and n.xxmmc like '%" + sportBsxm.getXxmmc() + "%'";
				sql4 += " and n.xxmmc like '%" + sportBsxm.getXxmmc() + "%'";
			}
			if (StringUtils.isNotBlank(sportBsxm.getZb())) {
				sqlColumn += " and n.zb='" + sportBsxm.getZb() + "' ";
				sql4 += " and n.zb='" + sportBsxm.getZb() + "' ";
			}
			if (StringUtils.isNotBlank(sportBsxm.getXbz())) {
				sqlColumn += " and n.xbz='" + sportBsxm.getXbz() + "' ";
				sql4 += " and n.xbz='" + sportBsxm.getXbz() + "' ";
			}
			sql4 += " ) ";
		}

		if (sportBsxm != null) {
			if (StringUtils.isNotBlank(sportBsxm.getStartTime()) || StringUtils.isNotBlank(sportBsxm.getEndTime())
					|| StringUtils.isNotBlank(sportBsxm.getSc())) {

				if (StringUtils.isNotBlank(sportBsxm.getStartTime()) && StringUtils.isNotBlank(sportBsxm.getEndTime())) {
					sql2 += " and to_char(c.bssj,'yyyy-MM-dd HH:mi') between '" + sportBsxm.getStartTime() + "' and '"
							+ sportBsxm.getEndTime() + "' ";
					sql4 += " and to_char(c.bssj,'yyyy-MM-dd HH:mi') between '" + sportBsxm.getStartTime() + "' and '"
							+ sportBsxm.getEndTime() + "' ";
				} else {
					if (StringUtils.isNotBlank(sportBsxm.getStartTime())) {
						sql2 += " and to_char(c.bssj,'yyyy-MM-dd HH:mi') >= '" + sportBsxm.getStartTime() + "' ";
						sql4 += " and to_char(c.bssj,'yyyy-MM-dd HH:mi') >= '" + sportBsxm.getStartTime() + "' ";
					} else if (StringUtils.isNotBlank(sportBsxm.getEndTime())) {
						sql2 += " and to_char(c.bssj,'yyyy-MM-dd HH:mi') <= '" + sportBsxm.getEndTime() + "' ";
						sql4 += " and to_char(c.bssj,'yyyy-MM-dd HH:mi') <= '" + sportBsxm.getEndTime() + "' ";
					}
				}
				if (StringUtils.isNotBlank(sportBsxm.getSc())) {
					sql2 += " and c.scbm='" + sportBsxm.getSc() + "' ";
					sql4 += " and c.scbm='" + sportBsxm.getSc() + "' ";
				}
			}
			if (StringUtils.isNotBlank(sportBsxm.getShzt())) {
				sql2 += " and (c.wid in(select m.scbm from t_sport_cj_jt m where m.shzt='" + sportBsxm.getShzt()
						+ "'))";
				sql4 += " and (c.wid in (select m.scbm from t_sport_cj_ydy m where m.shzt='" + sportBsxm.getShzt()
						+ "') )";
			}
		}
		sqlColumn = sqlColumn + sql2 + sql3 + sql4 + sql5;
		sqlColumn = " select * from ( " + sqlColumn + ") tt where 1=1 order by tt.startTime desc";
		long c = 0;
		List<TSportBsxm> list_sportBsxm = null;
		c = DBUtil.count("select count(*) from (" + sqlColumn + ")");
		pager.setTotalRows(c);
		list_sportBsxm = DBUtil.queryPageBeanList(pager, sqlColumn, TSportBsxm.class);
		return list_sportBsxm;
	}

	public void load(Object myaction) throws Exception {
		SportSxMxYLAction action = (SportSxMxYLAction) myaction;
		// 赛程编码
		String scbm = action.getParameter("scbm");
		String type = action.getParameter("fbzt");
		action.setParameter("type", type);
		String sql_td = "select t.dxmmc,t.xxmmc,t.dbtmc,t.yddmc,t.jps,t.yps,t.tps,t.jjjps,t.jjyps,t.jjtps,t.jjf,t.df,(select t.zdmc from t_sys_code t where t.zdlb='CJ_SHZT' and t.zdbm=t.shzt),t.bz,(select t.zdmc from t_sys_code t where t.zdlb='MX_DFLX' and t.zdbm=t.dflx), (select wmsys.wm_concat(m.xm) from T_Sport_Ydyxx m where t.dfly like '%'||m.wid||'%'),t.mc from t_sport_cj_td_mx_yl t where  t.scbm=? order by t.df desc";
		String sql_sx = "select t.dxmmc,t.xxmmc,t.dbtmc,t.yddmc,t.jps,t.yps,t.tps,t.jjjps,t.jjyps,t.jjtps,t.jjf,t.df,(select t.zdmc from t_sys_code t where t.zdlb='CJ_SHZT' and t.zdbm=t.shzt),t.bz,(select t.zdmc from t_sys_code t where t.zdlb='MX_DFLX' and t.zdbm=t.dflx),(select wmsys.wm_concat(m.xm) from T_Sport_Ydyxx m where t.dfly like '%'||m.wid||'%') ,t.mc from t_sport_cj_sx_mx_yl t where  t.scbm=? order by t.df desc";
		if (StringUtils.isNotBlank(scbm)) {
			List<Object[]> obj_list_td = DBUtil.queryAllList(sql_td, scbm);
			List<Object[]> obj_list_sx = DBUtil.queryAllList(sql_sx, scbm);
			action.setObjsTd(obj_list_td);
			action.setObjsSx(obj_list_sx);
		}
	}

	public boolean remove(Object myaction) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
	}

}
