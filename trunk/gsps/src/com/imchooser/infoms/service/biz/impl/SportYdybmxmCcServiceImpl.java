package com.imchooser.infoms.service.biz.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.biz.SportYdybmxmCcAction;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.entity.biz.TSportYdybmxm;
import com.imchooser.infoms.entity.biz.TSportYdybmxmCc;
import com.imchooser.infoms.util.BusinessLogUtil;
import com.imchooser.infoms.util.PropConfigUtil;
import com.imchooser.util.StringUtil;

/**
 * 运动员二次报名(按人)
 * 
 * @author LiBing DateTime 2010-7-4
 */
public class SportYdybmxmCcServiceImpl extends BaseServiceAbstractSupport {

	@SuppressWarnings("unchecked")
	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportYdybmxmCcAction action = (SportYdybmxmCcAction) myaction;
		TSportYdybmxmCc tsportYdybmxmCc = action.getTsportYdybmxmCc();
		String reportServer = PropConfigUtil.get("reportServer");
		action.setParameter("reportServer", reportServer);
		String hqlcolumn = " select a.dxmmc dxmmc,b.xm,b.zch,b.sfzh,a.ydywid,"
				+ " (select t.zdmc from T_Sys_Code t where t.zdbm=b.xb  and t.zdlb='XB')as xb,"
				+ " (select k.departname from T_Sys_Depart k where k.departid = substr(b.yddbm,0,6))as dbd,"
				+ " (select t.zdmc from T_Sys_Code t where t.zdbm=b.state  and t.zdlb='STATE')as state,"
				+ " (select t.zdmc from T_Sys_Code t where t.zdbm=b.shzt and t.zdlb='YDY_SHZT')as shzt,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid1) as xxmmc1,a.bsxmwid1 as bsxmwid1,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid2) as xxmmc2,a.bsxmwid2 as bsxmwid2,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid3) as xxmmc3,a.bsxmwid3 as bsxmwid3,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid4) as xxmmc4,a.bsxmwid4 as bsxmwid4,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid5) as xxmmc5,a.bsxmwid5 as bsxmwid5,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid6) as xxmmc6,a.bsxmwid6 as bsxmwid6,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid7) as xxmmc7,a.bsxmwid7 as bsxmwid7,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid8) as xxmmc8,a.bsxmwid8 as bsxmwid8,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid9) as xxmmc9,a.bsxmwid9 as bsxmwid9, "
				+ " (select wmsys.wm_concat(f.bsxmwid||'_'||f.fenzu) from T_Sport_Ydybmxm f  where f.ydywid=a.ydywid and f.dxmmc=a.dxmmc  and f.bsxmwid is not null ) as selectedinfo,"
				+ " (select t.zdmc from T_Sys_Code t where t.zdbm=a.zb and t.zdlb='BSXM_ZB') as zb_cn,b.state as st,"
				+ " '','' as xbz,b.shzt shzt2, "
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid10) as xxmmc10,a.bsxmwid10 as bsxmwid10, "
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid11) as xxmmc11,a.bsxmwid11 as bsxmwid11, "
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid12) as xxmmc12,a.bsxmwid12 as bsxmwid12, "
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid13) as xxmmc13,a.bsxmwid13 as bsxmwid13,a.zb zb,a.wid awid ";
		String hql = " from T_Sport_Ydyxx b inner join T_Sport_Ydybmxm_Cc a on a.ydywid = b.wid "
				+ " left join t_sport_bsxm c on c.dxmmc =a.dxmmc "
				+ " and(( c.wid = a.bsxmwid1 or c.wid = a.bsxmwid2 or "
				+ " c.wid = a.bsxmwid3 or c.wid = a.bsxmwid4 or c.wid = a.bsxmwid5 or c.wid = a.bsxmwid6 or c.wid = a.bsxmwid7 or c.wid = a.bsxmwid8 or c.wid = a.bsxmwid9 "
				+ " or c.wid = a.bsxmwid10 or c.wid = a.bsxmwid11 or c.wid = a.bsxmwid12  or c.wid = a.bsxmwid13) and (c.wid is not null))"
				+ " where b.yddbm like '" + action.getDepartID() + "%'";

		if (tsportYdybmxmCc != null) {
			if (StringUtils.isNotBlank(tsportYdybmxmCc.getDxmmc())) {
				hql += (" and a.dxmmc = '" + tsportYdybmxmCc.getDxmmc() + "' ");
			}
			if (StringUtils.isNotBlank(tsportYdybmxmCc.getXxmmc())) {
				hql += (" and c.xxmmc = '" + tsportYdybmxmCc.getXxmmc() + "' ");
			}
			if (StringUtils.isNotBlank(tsportYdybmxmCc.getZb())) {
				hql += (" and a.zb = '" + tsportYdybmxmCc.getZb() + "' ");
			}
			if (StringUtils.isNotBlank(tsportYdybmxmCc.getXm())) {
				hql += (" and b.xm like '%" + tsportYdybmxmCc.getXm() + "%' ");
			}
			if (StringUtils.isNotBlank(tsportYdybmxmCc.getXb())) {
				hql += (" and b.xb = '" + tsportYdybmxmCc.getXb() + "' ");
			}
			String depart = tsportYdybmxmCc.getDbd();
			if (action.getDepartID().length() > 3) {
				depart = action.getDepartID();
				tsportYdybmxmCc.setDbd(depart);
			}
			if (StringUtils.isNotBlank(depart)) {
				hql += (" and b.yddbm like '" + depart + "%' ");
				String dbt = "  select a.departname from t_sys_depart a where a.departid=? ";
				Object departname = DBUtil.queryFieldValue(dbt, depart);
				if (departname != null && StringUtil.isNotBlank(String.valueOf(departname))) {
					// 报表标题 编码
					String title = java.net.URLEncoder.encode(departname + "代表团第三阶段网上报名明细", "UTF-8");
					String title2 = java.net.URLEncoder.encode(departname + "代表团第三阶段网上报名明细（草稿）", "UTF-8");
					action.setParameter("reqTitle1", title);
					action.setParameter("reqTitle2", title2);
				} else {
					action.setParameter("reqTitle1", java.net.URLEncoder.encode("第三阶段网上报名明细", "UTF-8"));
					action.setParameter("reqTitle2", java.net.URLEncoder.encode("第三阶段网上报名明细（草稿）", "UTF-8"));
				}

			} else {
				action.setParameter("reqTitle1", java.net.URLEncoder.encode("第三阶段网上报名明细", "UTF-8"));
				action.setParameter("reqTitle2", java.net.URLEncoder.encode("第三阶段网上报名明细（草稿）", "UTF-8"));
			}
			if (StringUtils.isNotBlank(tsportYdybmxmCc.getState())) {
				if ("1".equals(tsportYdybmxmCc.getState())) {
					hql += (" and b.state = '1' ");
				} else {
					hql += (" and (b.state != '1' or b.state is null) ");
				}
			}
			if (StringUtils.isNotBlank(tsportYdybmxmCc.getShzt())) {
				hql += (" and b.shzt = '" + tsportYdybmxmCc.getShzt() + "' ");
			}
		} else {
			String depart = action.getDepartID();
			if (StringUtil.isNotBlank(depart) && depart.length() > 3) {
				tsportYdybmxmCc = new TSportYdybmxmCc();
				tsportYdybmxmCc.setDbd(depart);
				action.setTsportYdybmxmCc(tsportYdybmxmCc);
				String dbt = "  select a.departname from t_sys_depart a where a.departid=? ";
				Object departname = DBUtil.queryFieldValue(dbt, depart);
				if (departname != null && StringUtil.isNotBlank(String.valueOf(departname))) {
					// 报表标题 编码
					String title = java.net.URLEncoder.encode(departname + "代表团第三阶段网上报名明细", "UTF-8");
					String title2 = java.net.URLEncoder.encode(departname + "代表团第三阶段网上报名明细（草稿）", "UTF-8");
					action.setParameter("reqTitle1", title);
					action.setParameter("reqTitle2", title2);
				} else {
					action.setParameter("reqTitle1", java.net.URLEncoder.encode("第三阶段网上报名明细", "UTF-8"));
					action.setParameter("reqTitle2", java.net.URLEncoder.encode("第三阶段网上报名明细（草稿）", "UTF-8"));
				}
			} else {
				action.setParameter("reqTitle1", java.net.URLEncoder.encode("第三阶段网上报名明细", "UTF-8"));
				action.setParameter("reqTitle2", java.net.URLEncoder.encode("第三阶段网上报名明细（草稿）", "UTF-8"));
			}
		}
		// String tj =
		// "&filter=d.areaid='"+departid+"' and e.dxmmc='"+dxmmc+"' and e.xxmmc='"+xxmmc+"' and e.zb='"+zb+"' and e.xbz='"+xbz+"' and b.xm='"+xm+"' and b.xb='"+xb+"'"
		// if('0'==state){
		// url = url+" and (b.state != '1' or b.state is null) ";
		// }else{
		// url = url+ " and b.state = '"+state+"' ";
		// }
		// url = url+" and b.shzt='"+shzt+"'";

		String yd_ydy = hql;
		String hql2 = hql + " and b.state='1' ";
		hql = hqlcolumn
				+ hql
				+ " GROUP BY a.dxmmc, b.xm,b.zch,b.sfzh,a.ydywid, b.xb,b.yddbm,b.state,b.shzt,a.bsxmwid1, a.bsxmwid2,a.bsxmwid3,a.bsxmwid4,a.bsxmwid5, "
				+ "  a.bsxmwid6,a.bsxmwid7,a.bsxmwid8,a.bsxmwid9, a.bsxmwid10, a.bsxmwid11, a.bsxmwid12,a.bsxmwid13, a.zb,a.wid ";
		hql2 = hqlcolumn
				+ hql2
				+ " GROUP BY a.dxmmc, b.xm,b.zch,b.sfzh,a.ydywid, b.xb,b.yddbm,b.state,b.shzt,a.bsxmwid1, a.bsxmwid2,a.bsxmwid3,a.bsxmwid4,a.bsxmwid5, "
				+ "  a.bsxmwid6,a.bsxmwid7,a.bsxmwid8,a.bsxmwid9, a.bsxmwid10, a.bsxmwid11, a.bsxmwid12,a.bsxmwid13, a.zb,a.wid ";
		String total_select = "select "
				+ " aa.dxmmc dxmmc,aa.xm xm ,aa.zch zch,aa.sfzh sfzh,aa.ydywid ydywid,aa.xb xb,aa.dbd dbd,aa.state state,shzt shzt,aa.xxmmc1 xxmmc1,aa.bsxmwid1 bsxmwid1"
				+ " ,aa.xxmmc2 xxmmc2,aa.bsxmwid2 bsxmwid2,aa.xxmmc3 xxmmc3,aa.bsxmwid3 bsxmwid3,aa.xxmmc4 xxmmc4,aa.bsxmwid4 bsxmwid4,aa.xxmmc5 xxmmc5,aa.bsxmwid5 bsxmwid5"
				+ " ,aa.xxmmc6 xxmmc6,aa.bsxmwid6 bsxmwid6,aa.xxmmc7 xxmmc7,aa.bsxmwid7 bsxmwid7,aa.xxmmc8 xxmmc8,aa.bsxmwid8 bsxmwid8,aa.xxmmc9 xxmmc9,aa.bsxmwid9 bsxmwid9"
				+ ",aa.selectedinfo selectedinfo,aa.zb_cn zb_cn,aa.st st,aa.xbz xbz,aa.shzt2 shzt2,aa.xxmmc10 xxmmc10,aa.bsxmwid10 bsxmwid10,aa.xxmmc11 xxmmc11,aa.bsxmwid11 bsxmwid11,aa.xxmmc12 xxmmc12,aa.bsxmwid12 bsxmwid12,aa.xxmmc13 xxmmc13,aa.bsxmwid13 bsxmwid13,aa.zb zb,  aa.awid awid"
				+ " from ( ";
		String total_group = " )aa  ORDER BY aa.dxmmc, CASE WHEN aa.zb = NULL THEN '100' ELSE aa.zb END,aa.xb,NLSSORT(aa.xm,'NLS_SORT = SCHINESE_PINYIN_M') ";
				

		String total = total_select + hql + total_group;
		long c = DBUtil.count("select count(*) as c from( select a.wid " + yd_ydy + " group by a.wid )");
		pager.setTotalRows(c);
		List<TSportYdybmxmCc> list = DBUtil.queryPageBeanList(pager, total, TSportYdybmxmCc.class);

		// List<?> list2 = getBaseDao().findByHql(hqlcolumn+hql2);
		// String sql = "select count(shzt) from T_Sport_Ydyxx where shzt='-1'";

		String yb_ydy = "select count(*) from ( select a.wid " +  yd_ydy  + " and b.state='1' group by a.wid)";// 统计已报名人数
		long count_yb_ydy = DBUtil.count(yb_ydy);
		String xm = "select count(c.bsxmwid) from  T_Sport_Ydybmxm c  where  c.ydywid in (select a.ydywid " + yd_ydy
				+ " and b.state='1' ) ";// 统计报名项目的个数
		long count_xm = DBUtil.count(xm);
		action.setParameter("countYdy", String.valueOf(c));
		action.setParameter("countYbYdy", String.valueOf(count_yb_ydy));
		action.setParameter("countXm", String.valueOf(count_xm));
		if (action.getDepartID().length() != 3) {
			// 用于确定页面“数据上报”按钮的状态
			String count_sql = " select count(*) from t_sport_ydybmxm_cc a , t_sport_ydyxx b where a.ydywid=b.wid  and (b.shzt='0' or b.shzt='-1' or b.shzt is null ) and b.yddbm like '"
					+ action.getDepartID() + "%' ";
			int count = DBUtil.count(count_sql);
			if (count > 0) {
			} else {
				action.setParameter("shzt", "1");
			}
		}

		return list;
	}

	@SuppressWarnings("unchecked")
	public void load(Object myaction) throws Exception {
		SportYdybmxmCcAction action = (SportYdybmxmCcAction) myaction;
		TSportBsxm tsportBsxm = action.getTsportBsxm();
		String xm = action.getParameter("xm");
		action.setParameter("xm", xm);
		String dxmmc = action.getParameter("dxmmc");
		action.setParameter("dxmmc", dxmmc);
		String shzt = action.getParameter("shzt");
		if ("-1".equals(shzt) || "0".equals(shzt) || "".equals(shzt)) {
			action.setParameter("shzt", shzt);
		}
		String ydybm = action.getWid();
		String hqlcolumn = "select new TSportBsxm(a.wid,a.dxmmc, a.xxmmc,"
				+ " (select c.zdmc from TSysCode c where c.zdbm=a.zb and c.zdlb='BSXM_ZB' ) as zb,"
				+ " (select c.zdmc from TSysCode c where c.zdbm=a.xbz and c.zdlb='BSXM_XBZ' ) as xbz)";
		String hql = " from TSportBsxm a,TSportYdybmxmCc b where  a.dxmmc = b.dxmmc ";
		String sql = "select distinct s.xbz from t_sport_bsxm s where s.dxmmc =?";
		Object obj = DBUtil.queryFieldValue(sql, dxmmc);
		if (obj != null && !"".equals(obj)) {
			hql += " and a.xbz = (select t.xb from TSportYdyxx t where t.wid = b.ydywid)";
		}
		if (tsportBsxm != null) {
			if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
				hql += (" and a.dxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getDxmmc(), "UTF-8") + "' ");
			}
			if (StringUtils.isNotBlank(tsportBsxm.getXxmmc())) {
				hql += (" and a.xxmmc = '" + java.net.URLDecoder.decode(tsportBsxm.getXxmmc(), "UTF-8") + "' ");
			}
		}
		if (StringUtils.isNotBlank(ydybm)) {
			hql += " and b.ydywid='" + ydybm + "'";
		}
		hql = hqlcolumn + hql + " order by a.wid desc ";

		// 已确定项目
		List<Object[]> objects = (List<Object[]>) submitOrSave(action);

		List<TSportBsxm> submitQrbsxm = getBaseDao().findByHql(hql);
		// submitQrbsxm 的 副本
		List<TSportBsxm> submitQrbsxmsbak = new ArrayList<TSportBsxm>();
		if (submitQrbsxm != null && submitQrbsxm.size() > 0) {
			submitQrbsxmsbak.addAll(submitQrbsxm);
		}
		// 用于存放已经选择报名的项目
		List<TSportBsxm> bsxmEd = new ArrayList<TSportBsxm>();
		// 提取已报名的项目
		if (submitQrbsxm != null && submitQrbsxm.size() > 0 && objects != null && objects.size() > 0) {
			for (TSportBsxm app : submitQrbsxm) {
				for (Object[] temp : objects) {
					if (temp != null) {
						String str = String.valueOf(temp[3]);
						if (app.getWid().equals(str)) {
							// 添加 已报项目 list
							bsxmEd.add(app);
							// 把 已报项目从 副本中 移除
							submitQrbsxmsbak.remove(app);
						}
					}
				}

			}
		}
		// 把 已报名的项目 和未报名的项目 重新 整合 已报名的 排在前列
		for (TSportBsxm bsxm2 : bsxmEd) {
			submitQrbsxmsbak.add(0, bsxm2);
		}
		action.setParameter("lists", submitQrbsxmsbak); // "lists" 用于在页面上取值
	}

	// 用于显示已确定项目和运动员人
	public List<?> submitOrSave(SportYdybmxmCcAction action) throws Exception {
		String wid = action.getWid();
		String sqlcolumn = "select (select b.xm from T_Sport_Ydyxx b where b.wid=t.ydywid)as xm, "
				+ " (select  a.dxmmc||'，'||(select c.zdmc from T_Sys_Code c where c.zdbm=a.zb and c.zdlb='BSXM_ZB' ) "
				+ " ||'，'||(select c.zdmc from T_Sys_Code c where c.zdbm=a.xbz and c.zdlb='BSXM_XBZ')||'，'||a.xxmmc from T_Sport_Bsxm a where a.wid=t.bsxmwid)as bsxm,t.wid,t.bsxmwid";
		String sql = " from T_Sport_Ydybmxm t where t.ydywid=?";
		sql = sqlcolumn + sql + " order by t.wid desc ";
		List<?> submitOrSave = DBUtil.queryAllList(sql, wid);// getBaseDao().findByHql(sql,wid);
		action.setParameter("lists1", submitOrSave); // "lists1" 用于在页面上取值
		if ("1".equals(action.getParameter("detile"))) {
			action.addActionError("添加成功");
		}
		return submitOrSave;
	}

	// 打印二次报名信息
	@SuppressWarnings("unchecked")
	public void printRcbm(Object myaction) throws Exception {
		SportYdybmxmCcAction action = (SportYdybmxmCcAction) myaction;
		String xm = action.getParameter("xm");
		action.setParameter("xm", xm);
		String ydybm = action.getWid();
		String hqlcolumn = "select new TSportBsxm(a.wid,a.dxmmc, a.xxmmc,"
				+ " (select c.zdmc from TSysCode c where c.zdbm=a.zb and c.zdlb='BSXM_ZB' ) as zb,"
				+ " (select c.zdmc from TSysCode c where c.zdbm=a.xbz and c.zdlb='BSXM_XBZ' ) as xbz)";
		String hql = " from TSportBsxm a,TSportYdybmxmCc b where  a.dxmmc = b.dxmmc and "
				+ " a.xbz = (select t.xb from TSportYdyxx t where t.wid = b.ydywid)";
		if (StringUtils.isNotBlank(ydybm)) {
			hql += " and b.ydywid='" + ydybm + "'";
		}
		hql = hqlcolumn + hql + " order by a.wid desc ";

		// 已确定项目
		List<Object[]> objects = (List<Object[]>) submitOrSave(action);

		List<TSportBsxm> submitQrbsxm = getBaseDao().findByHql(hql);
		// submitQrbsxm 的 副本
		List<TSportBsxm> submitQrbsxmsbak = new ArrayList<TSportBsxm>();
		if (submitQrbsxm != null && submitQrbsxm.size() > 0) {
			submitQrbsxmsbak.addAll(submitQrbsxm);
		}
		// 用于存放已经选择报名的项目
		List<TSportBsxm> bsxmEd = new ArrayList<TSportBsxm>();
		// 提取已报名的项目
		if (submitQrbsxm != null && submitQrbsxm.size() > 0 && objects != null && objects.size() > 0) {
			for (TSportBsxm app : submitQrbsxm) {
				for (Object[] temp : objects) {
					if (temp != null) {
						String str = String.valueOf(temp[3]);
						if (app.getWid().equals(str)) {
							// 添加 已报项目 list
							bsxmEd.add(app);
							// 把 已报项目从 副本中 移除
							submitQrbsxmsbak.remove(app);
						}
					}
				}

			}
		}
		// 把 已报名的项目 和未报名的姓名 重新 整合 已报名的 排在前列
		for (TSportBsxm bsxm2 : bsxmEd) {
			submitQrbsxmsbak.add(0, bsxm2);
		}
		action.setParameter("lists", submitQrbsxmsbak); // "lists" 用于在页面上取值
	}

	public boolean remove(Object myaction) throws Exception {
		SportYdybmxmCcAction action = (SportYdybmxmCcAction) myaction;
		String wid = action.getWid();
		boolean deleteSuccess = getBaseDao().deleteAll("TSportYdybmxmCc", "wid", "=", wid);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_YDYBMXM_CC,
					Constants.LOG_ACTION_DEL);
		}
		return deleteSuccess;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		List<TSportYdybmxm> list = new ArrayList<TSportYdybmxm>(); // 用来添加列表信息
		List<TSportYdybmxm> listdel = new ArrayList<TSportYdybmxm>(); // 用来删除列表信息
		SportYdybmxmCcAction action = (SportYdybmxmCcAction) myaction;
		TSportYdybmxmCc tsc = action.getTsportYdybmxmCc();
		if(tsc==null){
			tsc = new TSportYdybmxmCc();
		}
		// 更新为 未确认的集合
		List<String> mylist = new ArrayList<String>();
		// 更新为已确认的集合
		List<String> mylist2 = new ArrayList<String>();
		Object[] str = action.getParameters("ydywid"); // 运动员WID 集合
		if (str != null && str.length > 0) {
			for (Object obj : str) {
				if (obj != null && StringUtils.isNotBlank(String.valueOf(obj))) {
					// ydywid_index 2323232_1
					String[] strydywid_index = String.valueOf(obj).split("_");
					String dxmmc = action.getParameter(String.valueOf(obj) + "_dxmmc"); // 大项目名称
					if (StringUtil.isNotBlank(dxmmc)) {
						String zb = action.getParameter(String.valueOf(obj) + "_zb");// 组别
						String shzt = action.getParameter(String.valueOf(obj) + "_shzt");// 审核状态
						Object[] xxmmc = action.getParameters(String.valueOf(obj)); // 小项目编码集合
						int m = 0;
						// tsc.getIsEdit()==1 说明是管理员 更该数据  ——无论什么状态都允许修改
						if ((!("1".equals(shzt) || "2".equals(shzt)))||"1".equals(tsc.getIsEdit())) {
							if (xxmmc != null && xxmmc.length > 0 && StringUtil.isNotBlank(dxmmc)) {
								m++;
								for (Object objxmmc : xxmmc) {
									if (objxmmc != null && StringUtils.isNotBlank(String.valueOf(objxmmc))) {
										String fenzu = action.getParameter(String.valueOf(obj) + "_fenzu_"
												+ String.valueOf(objxmmc));
										TSportYdybmxm tsportYdybmxm = new TSportYdybmxm();
										tsportYdybmxm.setWid(SeqFactory.getNewSequenceAlone());
										tsportYdybmxm.setYdywid(strydywid_index[0]);
										tsportYdybmxm.setBsxmwid(String.valueOf(objxmmc));
										tsportYdybmxm.setDxmmc(dxmmc);
										if (StringUtil.isNotBlank(fenzu)) {
											tsportYdybmxm.setFenzu(fenzu);
										}
										if (StringUtil.isNotBlank(zb)) {
											tsportYdybmxm.setZb(zb);
										}
										list.add(tsportYdybmxm);
									}
								}
							}
							if (StringUtil.isNotBlank(dxmmc)) {
								// 判断是否有勾选确定
								String hasxxm = action.getParameter(String.valueOf(obj) + "_hasxxm");
								if (StringUtil.isBlank(hasxxm)) {
									mylist.add(strydywid_index[0]);
								} else {
									mylist2.add(strydywid_index[0]);
									if (m == 0) {
										TSportYdybmxm tsportYdybmxm = new TSportYdybmxm();
										tsportYdybmxm.setWid(SeqFactory.getNewSequenceAlone());
										tsportYdybmxm.setYdywid(strydywid_index[0]);
										tsportYdybmxm.setDxmmc(dxmmc);
										if (StringUtil.isNotBlank(zb)) {
											tsportYdybmxm.setZb(zb);
										}
										list.add(tsportYdybmxm);
									}

								}
								TSportYdybmxm tsportYdybmxm = new TSportYdybmxm();
								tsportYdybmxm.setYdywid(strydywid_index[0]);
								tsportYdybmxm.setDxmmc(dxmmc);
								listdel.add(tsportYdybmxm);
							}
						}
					}
				}
			}
			if (listdel.size() > 0) {
				int delNum = deleteRcbm(listdel); // 删除TSportYdybmxm表中保存人员项目相应记录
				if(delNum>0){
					BusinessLogUtil.log(action.getLoginUser().getUserLoginId(),
							Constants.CZDX_T_SPORT_YDYBMXM, Constants.LOG_ACTION_UPDATE);
				}
				if (list.size() > 0) {
					getBaseDao().saveAll(list); // 保存二次报名项目
				}
				// 更新状态值为 未确认
				StringBuilder sb = new StringBuilder();
				if (mylist.size() > 0) {
					for (int i = 0; i < mylist.size(); i++) {
						if (i == 0) {
							sb.append("'" + mylist.get(i) + "'");
						} else {
							sb.append(",'" + mylist.get(i) + "'");
						}
					}
					String sql = " update t_sport_ydyxx t set t.state ='0' where wid in (" + sb.toString() + ")";
					int cgNum = DBUtil.executeSQL(sql);
					if(cgNum>0){
						BusinessLogUtil.log(action.getLoginUser().getUserLoginId(),
								Constants.CZDX_T_SPORT_YDYXX, Constants.LOG_ACTION_UPDATE);
					}
				}
				if (mylist2.size() > 0) {
					sb.delete(0, sb.length());
					for (int i = 0; i < mylist2.size(); i++) {
						if (i == 0) {
							sb.append("'" + mylist2.get(i) + "'");
						} else {
							sb.append(",'" + mylist2.get(i) + "'");
						}
					}
					String sql = " update t_sport_ydyxx t set t.state ='1' where wid in (" + sb.toString() + ")";
					int cgNum = DBUtil.executeSQL(sql);
					if(cgNum>0){
						BusinessLogUtil.log(action.getLoginUser().getUserLoginId(),
								Constants.CZDX_T_SPORT_YDYXX, Constants.LOG_ACTION_UPDATE);
					}
				}
			}
		}
	}

	public int deleteRcbm(List<TSportYdybmxm> list) { // 删除TSportYdybmxm表中保存人员项目相应记录
		StringBuilder sb = new StringBuilder();
		int delNum = 0;
		for (int i = 0; i < list.size(); i++) {
			TSportYdybmxm tsportYdybmxm = list.get(i);
			if (i == 0) {
				if (tsportYdybmxm != null && StringUtils.isNotBlank(tsportYdybmxm.getYdywid())
						&& StringUtils.isNotBlank(tsportYdybmxm.getDxmmc())) {
					sb.append(" (a.ydywid='");
					sb.append(String.valueOf(tsportYdybmxm.getYdywid()));
					sb.append("' and a.dxmmc='");
					sb.append(String.valueOf(tsportYdybmxm.getDxmmc()));
					sb.append("') ");
				}
			} else {
				if (tsportYdybmxm != null && StringUtils.isNotBlank(tsportYdybmxm.getYdywid())
						&& StringUtils.isNotBlank(tsportYdybmxm.getDxmmc())) {
					sb.append(" or (a.ydywid='");
					sb.append(String.valueOf(tsportYdybmxm.getYdywid()));
					sb.append("' and a.dxmmc='");
					sb.append(String.valueOf(tsportYdybmxm.getDxmmc()));
					sb.append("') ");
				}
			}
		}
		if (sb.length() > 0) {
			String sql = "delete from t_sport_ydybmxm a where " + sb.toString();
			delNum = DBUtil.executeSQL(sql);
		}
		return delNum;
	}

}
