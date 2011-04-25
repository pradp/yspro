package com.imchooser.infoms.service.biz.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.biz.SportCjYdyAction;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.entity.biz.TSportCjJt;
import com.imchooser.infoms.entity.biz.TSportCjYdy;
import com.imchooser.infoms.entity.biz.TSportScdfgz;
import com.imchooser.infoms.entity.biz.TSportSsrc;
import com.imchooser.infoms.util.BusinessLogUtil;
import com.imchooser.infoms.util.CommonQuery;
import com.imchooser.infoms.util.PropConfigUtil;
import com.imchooser.util.Arith;
import com.imchooser.util.DateUtil;
import com.imchooser.util.StringUtil;

/**
 * 运动员、集体 成绩登记
 * 
 * @author WangJunjun
 * @date:2010-3-24
 */
public class SportCjYdyServiceImpl extends BaseServiceAbstractSupport {

	// private static final Log LOG =
	// LogFactory.getLog(SportCjYdyServiceImpl.class);

	@SuppressWarnings("unchecked")
	public List list(Object myaction, Pager pager) throws Exception {
		SportCjYdyAction action = (SportCjYdyAction) myaction;
		// 获取左边树结构传来的 姓名名称
		String bsxm = action.getParameter("bsxm");
		String type = action.getParameter("type");
		String gqxm = action.getParameter("gqxm");
		// 判断界面显示 保存 还是 审批 "dj" 登记 ---出现 保存 “sp” 审批----出现审批
		action.setParameter("type", type);
		TSportBsxm sportBsxm = action.getSportBsxm();
		action.setParameter("bsxm", bsxm);
		action.setParameter("gqxm", gqxm);
		if (action.getSportBsxm() != null) {
			action.setParameter("fbzt", action.getSportBsxm().getShzt());
		}

		String sqlColumn = "";
		String sql = "";
		// 区别于 “赛次成绩汇总” "赛次成绩发布" <页面判断使用>
		String sccj = action.getParameter("sccj");
		action.setParameter("sccj", sccj);
		// 待审批 菜单 标识

		// list界面 默认选择 条目 （上色）
		action.setParameter("scbm_default", action.getParameter("scbm_default"));
		// cx 用来标记是 点击查询按钮触发的提交
		action.setParameter("cx", action.getParameter("cx"));
		sqlColumn = "select t.wid,(select a.dxmmc from  T_Sport_Bsxm a where t.xmbm=a.wid)as dxmmc,"
				+ " (select a.xxmmc from  T_Sport_Bsxm a where t.xmbm=a.wid) as xxmmc,"
				+ " (select a.zb from  T_Sport_Bsxm a where t.xmbm=a.wid)as zb,"
				+ " (select a.xbz from  T_Sport_Bsxm a where t.xmbm=a.wid)as xbz,"
				+ " (select a.xmdj from  T_Sport_Bsxm a where t.xmbm=a.wid)as xmdj,t.scbm as sc,"
				+ " (select f.zdmc from T_Sys_Code f where f.zdlb='BSXM_ZB' and f.zdbm=(select a.zb from  T_Sport_Bsxm a where t.xmbm=a.wid) ) as zbcn,"
				+ " to_char(t.bssj,'yyyy-MM-dd HH24:mi:ss') as startTime,(select t.zdmc from t_sys_code t where t.zdlb='XM_SFJT' and t.zdbm=(select max(k.sfjtxm) from T_Sport_Bsxm k where k.wid=t.xmbm )) as sfjtxm,"
				+ " (select  e.zdmc from T_Sys_Code e where e.zdlb='SSRC_SCBM' and e.zdbm=t.scbm) as scCn,t.cjdw,"
				+ " (select (case when a.sfdzxm=1 and (a.sfjtxm=1 or a.sfjtxm=2) then "
				+ " nvl( (select replace(wmsys.wm_concat(case when j.dbtmc is null then j.dbtmc else j.dbtmc end),',','：') from t_sport_cj_jt j  where  scbm = t.wid  group by scbm having count(*)=2  )  ,'---')"
				+ " when a.sfdzxm=1 then "
				+ " nvl((select replace(wmsys.wm_concat(y.ydyxm),',','：') from t_sport_cj_ydy y where scbm = t.wid group by scbm having count(*)=2 ),'---')"
				+ "  else '非对战' end ) as c from T_Sport_Bsxm a where t.xmbm=a.wid)as dzr, t.fbzt as fbzt, (select t.zdmc from t_sys_code t where t.zdlb='SSRC_BPFZ' and t.zdbm=t.bpfz) as bpfz,t.xmbm as xmbm,nvl(t.bscd,'无') bscd";
		sql = " from T_Sport_Ssrc t where 1=1 ";
		if (StringUtil.isNotBlank(bsxm) || sportBsxm != null) {
			sql += " and t.xmbm in (select a.wid from T_Sport_Bsxm a where 1=1 ";
		}
		if (StringUtil.isNotBlank(bsxm)) {
			sql += " and a.dxmmc='" + bsxm + "' ";
		}
		if (sportBsxm != null) {
			if (StringUtils.isNotBlank(sportBsxm.getDxmmc())) {
				sql += " and a.dxmmc='" + java.net.URLDecoder.decode(sportBsxm.getDxmmc(), "utf-8") + "'";
			}
			if (StringUtils.isNotBlank(sportBsxm.getXxmmc())) {
				sql += " and a.xxmmc='" + java.net.URLDecoder.decode(sportBsxm.getXxmmc(), "utf-8") + "'";
			}
			if (StringUtils.isNotBlank(sportBsxm.getZb())) {
				sql += " and a.zb='" + sportBsxm.getZb() + "' ";
			}
			if (StringUtils.isNotBlank(sportBsxm.getXbz())) {
				sql += " and a.xbz='" + sportBsxm.getXbz() + "' ";
			}
			sql += ") ";

			if (StringUtils.isNotBlank(sportBsxm.getCsz())) {
				sql += " and( t.wid in (select g.scbm from t_sport_cj_jt g where g.dbtmc like '%" + sportBsxm.getCsz()
						+ "%') ";
				sql += " or t.wid in (select w.scbm from t_sport_cj_ydy w where w.ydyxm like '%" + sportBsxm.getCsz()
						+ "%')) ";
			}
			if (StringUtils.isNotBlank(sportBsxm.getShzt())) {
				// 用 “+” 截取 审核状态
				String fbzt = " and (";
				String str[] = sportBsxm.getShzt().split("\\+");
				for (int i = 0; i < str.length; i++) {
					String str2 = str[i];
					if (i == 0) {
						fbzt += " t.fbzt='" + str2 + "' ";
					} else {
						fbzt += " or t.fbzt='" + str2 + "' ";
					}
				}
				fbzt += ") ";
				if (str != null && str.length > 0) {
					sql += fbzt;
				}
			}

			if (StringUtils.isNotBlank(sportBsxm.getStartTime()) || StringUtils.isNotBlank(sportBsxm.getEndTime())
					|| StringUtils.isNotBlank(sportBsxm.getSc())) {

				if (StringUtils.isNotBlank(sportBsxm.getStartTime())
						|| StringUtils.isNotBlank(sportBsxm.getEndTime())) {
					if (StringUtils.isNotBlank(sportBsxm.getStartTime())) {
						sql += " and to_char(t.bssj,'yyyy-MM-dd HH24:mi') >= '" + sportBsxm.getStartTime() + "' ";
					}
					if (StringUtils.isNotBlank(sportBsxm.getEndTime())) {
						sql += " and to_char(t.bssj,'yyyy-MM-dd HH24:mi') <= '" + sportBsxm.getEndTime() + "' ";
					}
					// 未登记模块
				} else if ("wdj".equals(action.getParameter("gqxm"))) {
					String str = DateUtil.currentDateTimeString();
					str = str.substring(0, str.length() - 3);
					sql += " and to_char(t.bssj,'yyyy-MM-dd HH24:mi') < '" + str + "' ";
				}
				if (StringUtils.isNotBlank(sportBsxm.getSc())) {
					sql += " and t.scbm='" + sportBsxm.getSc() + "' ";
				}

				// 未登记模块
			} else if ("wdj".equals(action.getParameter("gqxm"))) {
				String str = DateUtil.currentDateTimeString();
				str = str.substring(0, str.length() - 3);
				sql += " and to_char(t.bssj,'yyyy-MM-dd HH24:mi') < '" + str + "' ";
			}

		} else {
			sql += ")";
		}
		// 审批
		if (sportBsxm == null && "sp".equals(type)) {
			// 默认 待审批+退回审核中
			sql += " and (t.fbzt='1' or t.fbzt='-2' )";
			TSportBsxm ts = new TSportBsxm();
			ts.setShzt("-2+1");
			action.setSportBsxm(ts);
			// 登记
		} else if (sportBsxm == null && "dj".equals(type)) {
			// 默认 未开始+在登记中+成绩修订中
			sql += " and (t.fbzt='0' or t.fbzt='0.5' or t.fbzt='-1') ";
			TSportBsxm ts = new TSportBsxm();
			ts.setShzt("-1+0+0.5");
			action.setSportBsxm(ts);
		}
		long c = 0;
		List<TSportBsxm> list_sportBsxm = null;
		c = DBUtil.count("select count(*) " + sql);
		pager.setTotalRows(c);
		sql = sqlColumn + sql + " order by t.bssj";
		list_sportBsxm = DBUtil.queryPageBeanList(pager, sql, TSportBsxm.class);
		if (list_sportBsxm != null) {
			return list_sportBsxm;
		} else {
			return Collections.EMPTY_LIST;
		}

	}

	public void load(Object myaction) throws Exception {
		SportCjYdyAction action = (SportCjYdyAction) myaction;
		String reportServer = PropConfigUtil.get("reportServer");
		action.setParameter("reportServer", reportServer);
		// 赛程编码
		String bsxm = action.getParameter("bsxm");
		// 赛程编码
		String scbm = null;
		if (StringUtils.isBlank(action.getParameter("jtscbm"))) {
			scbm = action.getParameter("scbm");
		}
		// 集体项目wid
		String jtwid = action.getParameter("jtwid");
		action.setParameter("jtwid", jtwid);

		String importTempID = getImportTempID(bsxm, scbm);// 找到此项目对应的导入配置模板
		action.setParameter("importTempID", importTempID);
		// 赛次编码 1:预赛、2:决赛
		String sc = action.getParameter("sc");
		// 是否是 人员登记 1： 是 null: 不是
		String rydj = action.getParameter("rydj");
		// 区别于 “赛次成绩汇总” "赛次成绩发布" <页面判断使用>
		String sccj = action.getParameter("sccj");
		action.setParameter("sccj", sccj);
		// 判断界面显示 保存 还是 审批 "dj" 登记 ---出现 保存 “sp” 审批----出现审批
		String type = action.getParameter("type");
		// 确定 审批页面 的 ”预览赛次成绩“ 按钮是否禁用
		String isdisable = "true";
		action.setParameter("sc", sc);
		action.setParameter("scbm", scbm);
		action.setParameter("type", type);

		action.setParameter("model", action.getParameter("model"));
		action.setParameter("isjtdj", action.getParameter("isjtdj"));
		action.setParameter("xsshzt", action.getParameter("xsshzt"));
		action.setParameter("url", action.getParameter("url"));
		action.setParameter("xmbm", action.getParameter("xmbm"));
		List<TSportCjYdy> list_sportYdydf = new ArrayList<TSportCjYdy>();
		// select 是否集体项目 ， 项目编码， 发布状态
		String sql = "  select t.sfjtxm,t.wid,a.fbzt,t.sfdzxm from T_Sport_bsxm t,t_sport_ssrc a where t.wid=a.xmbm and a.wid=? ";
		String hql = "";
		List<Object[]> obj_list = null;
		// 用于判断 数 据 是否审核 通过 按钮是否变灰
		int count = 0;
		// 用于判断 数 据 是否待审核 保存 按钮是否变灰
		int saveStyle = 0;

		if (StringUtils.isNotBlank(scbm)) {
			obj_list = DBUtil.queryAllList(sql, scbm);
		}

		String obj = "";

		List<TSportCjJt> jts = new ArrayList<TSportCjJt>();
		if (obj_list != null && obj_list.size() > 0) {
			obj = String.valueOf(obj_list.get(0)[0]);
			// 项目编码 用于 项目的发布
			action.setParameter("xmbm", String.valueOf(obj_list.get(0)[1]));
			// 赛程的发布状态
			action.setParameter("fbzt", String.valueOf(obj_list.get(0)[2]));
			// 是否对仗项目
			action.setParameter("sfdzxm", String.valueOf(obj_list.get(0)[3]));
		}
		action.setParameter("isjtxm", obj);
		// 1 集体项目 2： 多人项目 <多人项目和集体项目相同的处理>
		if ("1".equals(String.valueOf(obj)) || "2".equals(String.valueOf(obj))) {
			hql = " select new TSportCjJt(t.wid,t.djjydh,t.dxmmc,t.xxmmc,t.scbm, t.dbtmc,t.yddmc,t.departid,t.bpxh,t.cj, t.df, t.jps, t.yps, t.tps, t.dbd,t.mc, t.sfjs,t.sfjrxyl, t.jjf, t.jjjps,t.jjyps, t.jjtps, t.shzt,t.createtime,t.bz,t.pjllx, t.yjlcj, t.sfbjydhcj,(select b.zdmc from TSysCode b where b.zdlb='CJ_SHZT' and b.zdbm=t.shzt),(select cjdw from TSportSsrc where wid = t.scbm)) from TSportCjJt t where t.scbm=? order by t.mc,t.wid";
			jts = getBaseDao().findByHql(hql, scbm);
			if (jts != null) {
				for (TSportCjJt jt : jts) {
					if ("1".equals(jt.getShzt())) {
						isdisable = "false";
						count++;
					}
					if ("2".equals(jt.getShzt())) {
						saveStyle++;
					}
				}
			}
			// 全部数据中 审核状态 全部 为“审核通过” 状态 <界面显示用>
			if (jts == null || count == jts.size()) {
				action.setParameter("isdisabledTg", "true");
			}
			// 全部数据中 审核状态 全部 为“待审核” 状态 <界面显示用>
			if (jts == null || saveStyle == jts.size()) {
				action.setParameter("isdisabledSave", "true");
			}

			// 数据中 审核状态 包含 审核通过的<界面显示用的>
			action.setParameter("isdisabled", isdisable);
			// 非集体项目 || 人员登记
		} else if ("0".equals(String.valueOf(obj)) || "1".equals(rydj)) {
			if (StringUtils.isBlank(scbm)) {
				// 此赛程编码是 集体项目点击“登记” 是传来的“jtscbm”
				scbm = action.getParameter("jtscbm");
				action.setParameter("scbm", scbm);
				action.setParameter("jtscbm", action.getParameter("jtscbm"));
			}
			String departid = action.getParameter("departid");
			action.setParameter("departid", departid);
			
			//departid 判断是否是 点击代表团登记 或者是 点击查看 进来 查询 所属的 人员成绩
			if (StringUtil.isNotBlank(departid)) {
				//集体项目点击 查看 或者 点击 登记 进来
				hql = " select new TSportCjYdy(t.wid, t.djjydh, t.scbm, t.ydybm, t.cj,t.df, t.jps,t.yps, t.tps, t.dbd, t.mc, t.sfjs,t.jjf, t.shzt, t.createtime,t.bz, t.pjllx, t.yjlcj,t.sfjtxm, t.sfjrxyl, t.jjjps, t.jjyps,t.jjtps, t.dxmmc, t.xxmmc, t.bpxh, t.ydyxm,t.sfbjydhcj,t.departid,(select b.zdmc from TSysCode b where b.zdlb='CJ_SHZT' and b.zdbm=t.shzt),(select cjdw from TSportSsrc where wid = t.scbm),(select e.departname from TSysDepart e where e.departid=c.yddbm ),c.zch) from TSportCjYdy t , TSportYdyxx c  where c.wid=t.ydybm  and t.scbm=? ";
				hql += " and t.departid='" + departid + "'  ";
				if (StringUtils.isNotBlank(jtwid)) {
					hql += " and t.jtwid='" + jtwid + "' ";
				}
			}else{
				// 非集体项目  加 sfjtxm =0 约束
				hql = " select new TSportCjYdy(t.wid, t.djjydh, t.scbm, t.ydybm, t.cj,t.df, t.jps,t.yps, t.tps, t.dbd, t.mc, t.sfjs,t.jjf, t.shzt, t.createtime,t.bz, t.pjllx, t.yjlcj,t.sfjtxm, t.sfjrxyl, t.jjjps, t.jjyps,t.jjtps, t.dxmmc, t.xxmmc, t.bpxh, t.ydyxm,t.sfbjydhcj,t.departid,(select b.zdmc from TSysCode b where b.zdlb='CJ_SHZT' and b.zdbm=t.shzt),(select cjdw from TSportSsrc where wid = t.scbm),(select e.departname from TSysDepart e where e.departid=c.yddbm ),c.zch) from TSportCjYdy t , TSportYdyxx c  where c.wid=t.ydybm and t.sfjtxm='0'  and t.scbm=? ";
			}
			hql += " order by t.mc,t.wid ";
			list_sportYdydf = getBaseDao().findByHql(hql, scbm);
			if (list_sportYdydf != null) {
				for (TSportCjYdy ydy : list_sportYdydf) {
					if ("1".equals(ydy.getShzt())) {
						isdisable = "false";
						count++;
					}
					if ("2".equals(ydy.getShzt())) {
						saveStyle++;
					}
				}
			}
			// 全部数据中 审核状态 全部 为“审核通过” 状态 <界面显示用>
			if (list_sportYdydf == null || count == list_sportYdydf.size()) {
				action.setParameter("isdisabledTg", "true");
			}
			// 全部数据中 审核状态 全部 为“待审核” 状态 <界面显示用>
			if (list_sportYdydf == null || saveStyle == list_sportYdydf.size()) {
				action.setParameter("isdisabledSave", "true");
			}
			// 数据中 审核状态 包含 审核通过的<界面显示用的>
			action.setParameter("isdisabled", isdisable);
		}

		action.setJts(jts);
		action.setListSportCjYdy(list_sportYdydf);
	}

	public boolean remove(Object myaction) throws Exception {
		SportCjYdyAction action = (SportCjYdyAction) myaction;
		String wid = action.getWid();
		String isjtxm = action.getParameter("types");
		String scbm = action.getParameter("scbm");
		String str[] = wid.split(",");

		StringBuilder sb = new StringBuilder();
		// 拼接 删除 条件 格式 in ('','',''...)
		for (int m = 0; m < str.length; m++) {
			String st = str[m];
			if (m == 0) {
				sb.append("'" + st + "'");
			} else {
				sb.append(",'" + st + "'");
			}
		}
		boolean deleteSuccess = false;
		// 判断是否集体项目 1 集体项目 2 多人项目
		if ("1".equals(isjtxm) || "2".equals(isjtxm)) {
			String del = "delete from  t_sport_cj_ydy t where t.wid in (select a.wid from t_sport_cj_ydy a, t_sport_cj_jt b where a.scbm=b.scbm and a.departid=b.departid and b.wid in("
					+ sb.toString() + ") )";
			DBUtil.executeSQL(del);
			deleteSuccess = getBaseDao().deleteAll("TSportCjJt", "wid", "=", wid);
			long count = DBUtil.count(" select count(*) from t_sport_cj_jt t where  t.scbm=?", scbm);
			if (count == 0) {
				DBUtil.executeSQL(" update t_sport_ssrc t set t.fbzt='0' where t.wid=?", scbm);
			}
			if (deleteSuccess) {
				BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_CJ_YDY,
						Constants.LOG_ACTION_DEL);
			}
			// 非集体项目
		} else if ("0".equals(isjtxm) || StringUtil.isBlank(isjtxm)) {
			deleteSuccess = getBaseDao().deleteAll("TSportCjYdy", "wid", "=", wid);
			// isjtxm 为空 时 是多人项目 或 集体项目 点击登记时 登记 团队 人员页面 执行的删除
			if (StringUtil.isNotBlank(isjtxm)) {
				long count = DBUtil.count(" select count(*) from t_sport_cj_ydy t where  t.scbm=?", scbm);
				if (count == 0) {
					DBUtil.executeSQL(" update t_sport_ssrc t set t.fbzt='0' where t.wid=?", scbm);
				}
			}
			if (deleteSuccess) {
				BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_CJ_YDY,
						Constants.LOG_ACTION_DEL);
			}
		}
		return deleteSuccess;
	}

	@SuppressWarnings("unchecked")
	public void saveOrUpdate(Object myaction) throws Exception {

		SportCjYdyAction action = (SportCjYdyAction) myaction;
		String type = action.getParameter("type");
		// 赛次编码 1:预赛、2:决赛
		String sc = action.getParameter("sc");
		// 判断界面显示 保存 还是 审批 "dj" 登记 ---出现 保存 “sp” 审批----出现审批
		action.setParameter("type", type);// 用于判断是集体还是个人
		action.setParameter("sc", sc);
		String isjtxm = action.getParameter("isjtxm");
		action.setParameter("isjtxm", isjtxm);
		action.setParameter("jtscbm", action.getParameter("jtscbm"));
		action.setParameter("departid", action.getParameter("departid"));
		action.setParameter("url", action.getParameter("url"));
		action.setParameter("xmbm", action.getParameter("xmbm"));
		action.setParameter("jtwid", action.getParameter("jtwid"));
		String dd = action.getParameter("bm");
		// 用于 新增人员 界面判断 是否是 集体项目 或 是 多人项目 的“新增并保存”-----多人项目 或 集体项目 登记人员的保存时 他的
		// saveModel 为 jtxm 同时isjtdj 为 1 是 人员添加入 cj_ydy 表
		String isjtdj = action.getParameter("isjtdj");
		action.setParameter("isjtdj", isjtdj);
		List<TSportCjYdy> list_sportYdydf = action.getListSportCjYdy();
		List<TSportCjJt> jts = action.getJts();
		// 赛程编码
		String scbm = action.getParameter("scbm");
		action.setParameter("scbm", scbm);
		// 判断是否是新增人员
		String saveModel = action.getParameter("saveModel");
		action.setParameter("saveModel", saveModel);
		if (StringUtils.isNotBlank(saveModel)) {
			// 新增人员操作
			saveNewPerson(saveModel, scbm, action);

		} else {
			// 非集体项目正常保存成绩操作
			String hqlxxm = " select new TSportBsxm(t.dxmmc, t.xxmmc, (select g.zdmc from TSysCode g where g.zdlb='BSXM_ZB' and g.zdbm=t.zb),(select g.zdmc from TSysCode g where g.zdlb='BSXM_XBZ' and g.zdbm=t.xbz) ) from TSportBsxm t,TSportSsrc a where a.xmbm=t.wid and a.wid=? ";
			List<TSportBsxm> list = getBaseDao().getHibernateTemplate().find(hqlxxm, scbm);
			// 比赛项目
			TSportBsxm tbxmmc = list.get(0);

			// 非集体项目正常保存成绩操作
			if (list_sportYdydf != null && list_sportYdydf.size() > 0) {
				savefjtxm(sc, list_sportYdydf, isjtxm, tbxmmc, scbm, action);
			}
			// 集体项目成绩保存
			if (jts != null && jts.size() > 0) {
				savejtxm(sc, jts, isjtxm, tbxmmc, scbm, action);
			}

		}

	}

	/**
	 * 新增人员操作
	 * 
	 * @param saveModel 判断是否新增人员
	 * @param scbm 赛程编码
	 * @param action
	 * @throws SQLException
	 */
	public void saveNewPerson(String saveModel, String scbm, SportCjYdyAction action) throws SQLException {
		String bsxm = "select  t.dxmmc,t.xxmmc,( select  b.zdmc from t_sys_code b where b.zdbm= t.xbz and b.zdlb='BSXM_XBZ' ),( select  b.zdmc from t_sys_code b where b.zdbm= t.zb and b.zdlb='BSXM_ZB' ),t.sfjtxm, a.scbm from T_Sport_Bsxm t,T_Sport_Ssrc a where t.wid=a.xmbm  and a.wid=?";
		// 第几届运动会
		String djjydh = CommonQuery.getSysProperty("Sports_JS");
		List<Object[]> sportBsxm = DBUtil.queryAllList(bsxm, scbm);
		String dbt = action.getParameter("dbt");
		// 集体项目
		if ("jtxm".equals(saveModel)) {
			String isjtdj = action.getParameter("isjtdj");
			if ("1".equals(isjtdj)) {
				// 集体项目 或多人项目 代表团 添加参赛人员
				addToCjYdy(action, scbm, djjydh, sportBsxm, "1");
			} else if (StringUtils.isNotBlank(dbt)) {
				if (dbt != null) {
					String[] dbts = dbt.split(",");
					if (dbts != null && dbts.length > 0) {
						for (String depart : dbts) {
							String[] id_name = depart.split("_");
							TSportCjJt cjJt = new TSportCjJt();
							cjJt.setWid(SeqFactory.getNewSequenceAlone());
							cjJt.setScbm(scbm);
							cjJt.setDepartid(id_name[0]);
							String departname = String.valueOf(id_name[1]);
							int i = -1;
							if (StringUtil.isNotBlank(departname)) {
								i = departname.indexOf("市");
							}
							if (i == -1) {
								departname += "市";
							}
							cjJt.setDbtmc(departname);
							cjJt.setDjjydh(Short.parseShort(djjydh));
							cjJt.setDxmmc(String.valueOf(sportBsxm.get(0)[0]));
							// 组别 + 性别 + 小项目 + 全角的“，”
							cjJt.setXxmmc(getXxmmc2(sportBsxm.get(0)));
							cjJt.setSfjrxyl("0");
							cjJt.setJjjps(0.00);
							cjJt.setJjyps(0.00);
							cjJt.setJjtps(0.00);
							cjJt.setJps(0.00);
							cjJt.setTps(0.00);
							cjJt.setYps(0.00);
							cjJt.setJjf(0.00);
							cjJt.setDf(0.00);
							cjJt.setCreatetime(new Date());
							if ("2".equals(String.valueOf(sportBsxm.get(0)[5]))) {
								cjJt.setSfjs("1");
							} else {
								cjJt.setSfjs("0");
							}
							cjJt.setShzt("0");
							cjJt.setSfbjydhcj("1");
							getBaseDao().saveOrUpdate(cjJt);
						}

					}

				}

			}
			// 非集体项目
		} else if ("fjtxm".equals(saveModel)) {
			addToCjYdy(action, scbm, djjydh, sportBsxm, "0");
		}

	}

	/**
	 * 登记到 运动员成绩表
	 * 
	 * @param action
	 * @param temp
	 * @param scbm
	 * @param djjydh
	 * @param sportBsxm
	 * @param obj
	 * @throws SQLException
	 */
	public void addToCjYdy(SportCjYdyAction action, String scbm, String djjydh, List<Object[]> sportBsxm, String type)
			throws SQLException {

		// String ydy = action.getParameter("ydy");
		String bm = action.getParameter("bmlast");
		/*
		 * List<Object[]> obj2 = null; if (StringUtils.isBlank(ydy) &&
		 * StringUtils.isNotBlank(bm) && StringUtils.isBlank(temp)) { // 根据
		 * 运动员编码查询 代表团 String sql =
		 * " select substr(a.departid,0,6),(select b.departname from t_sys_depart b where b.departid=substr(a.departid,0,6))    from t_sys_depart a where a.departid=( select t.yddbm from t_sport_ydyxx t where t.wid=?) "
		 * ; obj2 = DBUtil.queryAllList(sql, bm); if (obj2 != null) { temp =
		 * String.valueOf(obj2.get(0)[0]); } ydy = bm; } else {
		 */
		// bm = ydy;
		// }
		String departid = action.getParameter("departid");

		String[] bms = bm.split(",");
		List<String> bmslist = new ArrayList<String>();
		List<String> bmslist2 = new ArrayList<String>();
		if (bms != null) {
			for (String stg : bms) {
				bmslist.add(stg);
				bmslist2.add(stg);
			}
		}
		// bm :
		// 运动员wid_运动员姓名_代表地_departid,运动员wid_运动员姓名_代表地_departid,运动员wid_运动员姓名_代表地_departid
		String hql = " from TSportCjYdy t where t.scbm=? ";
		List<TSportCjYdy> cjydyData = this.getBaseDao().findByHql(hql, scbm);
		if (cjydyData != null) {
			for (String gte : bmslist) {
				for (TSportCjYdy tep : cjydyData) {
					String[] str_temp = gte.split("_");
					if (tep.getYdybm().equals(str_temp[0])) {
						bmslist2.remove(gte);
					}
				}
			}
		}
		TSportCjJt tsc = null;
		if (StringUtils.isNotBlank(departid)) {
			String departCj = " from TSportCjJt t where t.scbm=? and t.departid=?";
			List<TSportCjJt> tscs = this.getBaseDao().findByHql(departCj, scbm, departid);
			if (tscs != null) {
				tsc = tscs.get(0);
			}
		}
		List<TSportCjYdy> cjydys = new ArrayList<TSportCjYdy>();
		if (bmslist2 != null) {
			for (String str : bmslist2) {
				TSportCjYdy cjYdy = new TSportCjYdy();
				String[] str_temp = str.split("_");
				cjYdy.setWid(SeqFactory.getNewSequenceAlone());
				cjYdy.setYdybm(str_temp[0]);
				cjYdy.setScbm(scbm);
				cjYdy.setCreatetime(new Date());
				cjYdy.setYdyxm(str_temp[1]);
				cjYdy.setDjjydh(Short.parseShort(djjydh));
				cjYdy.setDxmmc(String.valueOf(sportBsxm.get(0)[0]));
				// 组别 + 性别 + 小项目 + 全角的“，”
				cjYdy.setXxmmc(getXxmmc2(sportBsxm.get(0)));
				if (StringUtils.isNotBlank(departid) && tsc != null) {
					cjYdy.setDepartid(departid);
					cjYdy.setCj(tsc.getCj());
					if ("2".equals(String.valueOf(sportBsxm.get(0)[5]))) {
						cjYdy.setMc(tsc.getMc());
					}
					cjYdy.setSfbjydhcj(tsc.getSfbjydhcj());
					cjYdy.setJjjps(tsc.getJjjps());
					cjYdy.setJjyps(tsc.getJjyps());
					cjYdy.setJjtps(tsc.getJjtps());
					cjYdy.setJps(tsc.getJps());
					cjYdy.setTps(tsc.getTps());
					cjYdy.setYps(tsc.getYps());
					cjYdy.setJjf(tsc.getJjf());
					cjYdy.setDf(tsc.getDf());
					cjYdy.setSfjrxyl(tsc.getSfjrxyl());
					cjYdy.setPjllx(tsc.getPjllx());
					cjYdy.setYjlcj(tsc.getYjlcj());
					String jtwid = action.getParameter("jtwid");
					if (StringUtils.isNotBlank(jtwid)) {
						cjYdy.setJtwid(jtwid);
					}
				} else {
					cjYdy.setDepartid(str_temp[3].substring(0, 6));
					cjYdy.setSfbjydhcj("1");
					cjYdy.setJjjps(0.00);
					cjYdy.setJjyps(0.00);
					cjYdy.setJjtps(0.00);
					cjYdy.setJps(0.00);
					cjYdy.setTps(0.00);
					cjYdy.setYps(0.00);
					cjYdy.setJjf(0.00);
					cjYdy.setDf(0.00);
					cjYdy.setSfjrxyl("0");
				}

				// 判断是否决赛
				if ("2".equals(String.valueOf(sportBsxm.get(0)[5]))) {
					cjYdy.setSfjs("1");
				} else {
					cjYdy.setSfjs("0");
				}
				cjYdy.setDbd(str_temp[2]);
				cjYdy.setSfjtxm(String.valueOf(sportBsxm.get(0)[4]));
				cjYdy.setShzt("0");
				cjydys.add(cjYdy);
			}
			action.addActionError("添加成功");
			getBaseDao().saveOrUpdateAll(cjydys);
		}
	}

	/**
	 * 根据比赛项目查询导入模板的模板名称
	 * 
	 * @param bsxm 比赛项目(大项目)
	 * @param scbm 赛程编码(大项目)
	 * @return 模板名称
	 * @throws Exception
	 */
	public static String getImportTempID(String bsxm, String scbm) throws Exception {
		String importTempID = null;
		if (StringUtils.isNotBlank(bsxm)) {// 按大项目名称查
			String sql = "select wid from t_import_temp t where t.tempname like ?";
			importTempID = (String) DBUtil.queryFieldValue(sql, bsxm + "%");
		} else if (StringUtils.isNotBlank(scbm)) {// 按赛程编码查
			String sql = "select wid from t_import_temp t where t.tempname like (select m.dxmmc||'%' from T_Sport_bsxm m,t_sport_ssrc a where m.wid=a.xmbm and a.wid=?)";
			importTempID = (String) DBUtil.queryFieldValue(sql, scbm);
		}
		return importTempID;
	}

	/**
	 * // 组别 + 性别 + 小项目 + 全角的“，”
	 * 
	 * @param scbm
	 * @return
	 */
	public String getXxmmc(TSportBsxm tbxmmc) {

		String str = "";
		int i = 0;
		if (StringUtil.isNotBlank(tbxmmc.getZbcn())) {
			str += tbxmmc.getZbcn();
			i++;
		}
		if (StringUtil.isNotBlank(tbxmmc.getXbzCn())) {
			if (i > 0) {
				str += "，" + tbxmmc.getXbzCn();
			} else {
				str += tbxmmc.getXbzCn();
			}
			i++;
		}
		if (StringUtil.isNotBlank(tbxmmc.getXxmmc())) {
			if (i > 0) {
				str += "，" + tbxmmc.getXxmmc();
			} else {
				str += tbxmmc.getXxmmc();
			}
			i++;
		}
		return str;
	}

	/**
	 * // 组别 + 性别 + 小项目 + 全角的“，”
	 * 
	 * @param scbm
	 * @return
	 */
	public String getXxmmc2(Object[] strs) {
		String str = "";
		int i = 0;
		if (strs[3] != null && StringUtil.isNotBlank(strs[3].toString())) {
			str += strs[3].toString();
			i++;
		}
		if (strs[2] != null && StringUtil.isNotBlank(strs[2].toString())) {
			if (i > 0) {
				str += "，" + strs[2].toString();
			} else {
				str += strs[2].toString();
			}
			i++;
		}
		if (strs[1] != null && StringUtil.isNotBlank(strs[1].toString())) {
			if (i > 0) {
				str += "，" + strs[1].toString();
			} else {
				str += strs[1].toString();
			}
			i++;
		}
		return str;
	}

	/**
	 * 非集体项目正常保存成绩操作
	 * 
	 * @param sc 赛次
	 * @param list_sportYdydf 运动员 保存数据集合
	 * @param isjtxm 是否集体项目
	 * @param tbxmmc 比赛项目<bean>
	 * @param scbm 赛程编码
	 * @param action
	 */
	public void savefjtxm(String sc, List<TSportCjYdy> list_sportYdydf, String isjtxm, TSportBsxm tbxmmc, String scbm,
			SportCjYdyAction action) {

		if ("2".equals(sc)) {// 是决赛
			// 获取项目所对应得 金、银、铜 牌数（赛次得分规则）
			String hql_ps = " select t from TSportScdfgz t,TSportSsrc a where a.xmbm=t.xmbm and a.wid=? order by t.pmjb";

			List<TSportScdfgz> sportScdfgz_list = getBaseDao().findByHql(hql_ps, list_sportYdydf.get(0).getScbm());
			if (sportScdfgz_list != null && sportScdfgz_list.size() > 0) {
				for (TSportCjYdy sportYdydf : list_sportYdydf) {
					// mc_count 并列名次的个数
					int mc_count = 0;
					//大于此名次的个数
					int mc_better = 0;
					for (TSportCjYdy sportYdydfTemp : list_sportYdydf) {
						if(sportYdydf.getMc()!= null){
							if ( sportYdydf.getMc().equals(sportYdydfTemp.getMc())) {
								mc_count++;
							}
							//大于
							if(sportYdydf.getMc()<sportYdydfTemp.getMc() && sportYdydfTemp.getMc()>0){
								mc_better++;
							}
						}
					}
					int i = 0;
					for (TSportScdfgz scdfgz : sportScdfgz_list) {
						// 获得 名次 对应的 规则
						if (scdfgz.getPmjb().equals(sportYdydf.getMc())) {
							i = 1;
							sportYdydf.setJps(scdfgz.getPmjps());
							sportYdydf.setYps(scdfgz.getPmyps());
							sportYdydf.setTps(scdfgz.getPmtps());
							sportYdydf.setDf(getDf(mc_count, scdfgz, sportScdfgz_list, sportYdydf.getMc(),mc_better,sportYdydf.getDxmmc(),sportYdydf.getXxmmc()));

						}
					}
					// 没有匹配上得分规则的 默认 为 0.00
					if (i == 0) {
						sportYdydf.setJps(0.00);
						sportYdydf.setYps(0.00);
						sportYdydf.setTps(0.00);
						sportYdydf.setDf(0.00);
					}
					// 把初始状态的值改成草稿
					if ("csh".equalsIgnoreCase(sportYdydf.getShzt())) {
						sportYdydf.setShzt("0");
					}
					// 是否决赛
					sportYdydf.setSfjs("1");
					if (StringUtils.isBlank(sportYdydf.getWid())) {
						sportYdydf.setWid(SeqFactory.getNewSequenceAlone());
					}
					//格式化成绩
					sportYdydf.setCj(formatCJ(sportYdydf.getCj()));
					// 组别 + 性别 + 小项目 + 全角的“，”
					sportYdydf.setXxmmc(getXxmmc(tbxmmc));
				}
			}

		} else {// 非决赛
			for (TSportCjYdy sportYdydf : list_sportYdydf) {

				sportYdydf.setJps(0.00);
				sportYdydf.setYps(0.00);
				sportYdydf.setTps(0.00);
				sportYdydf.setDf(0.00);
				// 是否决赛 0
				sportYdydf.setSfjs("0");
				// 把初始状态的值改成草稿
				if (StringUtil.isBlank(sportYdydf.getShzt())) {
					sportYdydf.setShzt("0");
				}
				if (StringUtils.isBlank(sportYdydf.getWid())) {
					sportYdydf.setWid(SeqFactory.getNewSequenceAlone());
				}
				//格式化成绩
				sportYdydf.setCj(formatCJ(sportYdydf.getCj()));
				// 组别 + 性别 + 小项目 + 全角的“，”
				sportYdydf.setXxmmc(getXxmmc(tbxmmc));
			}
		}
		String fbzt = action.getParameter("fbzt");
		if (StringUtil.isNotBlank(isjtxm) && StringUtil.isNotBlank(fbzt) && "0".equals(fbzt)) {
			// 把赛程的发布状态 改为 在登记成绩
			String sql = "update t_sport_ssrc t set t.fbzt='0.5' where t.wid=? ";
			DBUtil.executeSQL(sql, scbm);
		}
		// TODO--------
		/*
		 * if( list_sportYdydf==null || list_sportYdydf.size()>50){ throw new
		 * RuntimeException("不能执行此操作：集合为空或者待更新的EntityBean数量大于50个！"); }
		 * 
		 * for(int i=0,k=list_sportYdydf.size();i<k;i++){ TSportCjYdy entity =
		 * list_sportYdydf.get(i); this.getBaseDao().updateNotNull(entity); }
		 */
		// TODO--------
		this.getBaseDao().updateNotNullAll(list_sportYdydf);
		BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_CJ_YDY,
				Constants.LOG_ACTION_UPDATE);
	}

	/**
	 * 集体项目成绩保存
	 * 
	 * @param sc 赛次
	 * @param jts 集体项目 保存数据 集合
	 * @param isjtxm 是否集体项目
	 * @param tbxmmc 比赛项目<bean>
	 * @param scbm 赛程编码
	 * @param action
	 */
	public void savejtxm(String sc, List<TSportCjJt> jts, String isjtxm, TSportBsxm tbxmmc, String scbm,
			SportCjYdyAction action) {
		if ("2".equals(sc)) {
			// 获取项目所对应得 金、银、铜 牌数（赛次得分规则）
			String hql_ps = "select t from TSportScdfgz t,TSportSsrc a where t.xmbm=a.xmbm and a.wid=? order by t.pmjb";
			List<TSportScdfgz> sportScdfgz_list = getBaseDao().findByHql(hql_ps, jts.get(0).getScbm());
			if (sportScdfgz_list != null && sportScdfgz_list.size() > 0) {
				for (TSportCjJt jt : jts) {
					int mc_count = 0;
					//大于此名次的个数
					int mc_better = 0;
					for (TSportCjJt jtTemp : jts) {
						if(jtTemp.getMc()!=null){
							if (jt.getMc().equals(jtTemp.getMc())) {
								mc_count++;
							}
							//大于
							if(jt.getMc()<jtTemp.getMc() && jtTemp.getMc()>0){
								mc_better++;
							}
						}
					}
					int i = 0;

					for (TSportScdfgz scdfgz : sportScdfgz_list) {
						// 获得 名次 对应的 规则
						if (scdfgz.getPmjb().equals(jt.getMc())) {
							i = 1;
							jt.setJps(scdfgz.getPmjps());
							jt.setYps(scdfgz.getPmyps());
							jt.setTps(scdfgz.getPmtps());
							jt.setDf(getDf(mc_count, scdfgz, sportScdfgz_list, jt.getMc(),mc_better,jt.getDxmmc(),jt.getXxmmc()));

						}
					}
					if (i == 0) {
						jt.setJps(0.00);
						jt.setYps(0.00);
						jt.setTps(0.00);
						jt.setDf(0.00);
					}
					// 把初始状态的值改成草稿
					if ("csh".equalsIgnoreCase(jt.getShzt())) {
						jt.setShzt("0");
					}
					// 是否决赛
					jt.setSfjs("1");
					if (StringUtils.isBlank(jt.getWid())) {
						jt.setWid(SeqFactory.getNewSequenceAlone());
					}
					//格式化成绩
					jt.setCj(formatCJ(jt.getCj()));
					// 组别 + 性别 + 小项目 + 全角的“，”
					jt.setXxmmc(getXxmmc(tbxmmc));
				}
			}

		} else {// 非决赛
			for (TSportCjJt jt : jts) {
				jt.setJps(0.00);
				jt.setYps(0.00);
				jt.setTps(0.00);
				jt.setDf(0.00);
				// 是否决赛 0
				jt.setSfjs("0");
				// 把初始状态的值改成草稿
				if (StringUtils.isBlank(jt.getShzt())) {
					jt.setShzt("0");
				}
				if (StringUtils.isBlank(jt.getWid())) {
					jt.setWid(SeqFactory.getNewSequenceAlone());
				}
				//格式化成绩
				jt.setCj(formatCJ(jt.getCj()));
				// 组别 + 性别 + 小项目 + 全角的“，”
				jt.setXxmmc(getXxmmc(tbxmmc));
			}
		}
		String fbzt = action.getParameter("fbzt");
		if (StringUtil.isNotBlank(isjtxm) && StringUtil.isNotBlank(fbzt) && "0".equals(fbzt)) {
			// 把赛程的发布状态 改为 在登记成绩
			String sql = "update t_sport_ssrc t set t.fbzt='0.5' where t.wid=? ";
			DBUtil.executeSQL(sql, scbm);
		}

		// TODO -----------
		/*
		 * if( jts==null || jts.size()>50){ throw new
		 * RuntimeException("不能执行此操作：集合为空或者待更新的EntityBean数量大于50个！"); }
		 * 
		 * for(int i=0,k=jts.size();i<k;i++){ TSportCjJt entity = jts.get(i);
		 * this.getBaseDao().updateNotNull(entity); }
		 */
		// TODO -----------
		this.getBaseDao().updateNotNullAll(jts);

		// 集体、多人项目 代表团下的 运动员 成绩信息批量更新
		String sql = "update t_sport_cj_ydy g "
				+ "set "
				+ " (g.df,g.jps,g.yps,g.tps,g.jjjps,g.jjyps,g.jjtps,g.jjf, g.cj,g.sfjrxyl,g.sfbjydhcj,g.pjllx,g.yjlcj,g.mc,g.shzt)= "
				+ "(select j.df,j.jps,j.yps,j.tps,j.jjjps,j.jjyps,j.jjtps,j.jjf, j.cj,j.sfjrxyl,j.sfbjydhcj,j.pjllx,j.yjlcj,j.mc,j.shzt from t_sport_cj_jt j where j.scbm=? and j.scbm=g.scbm and g.departid=j.departid  and j.wid=g.jtwid )"
				+ " where g.departid=(select j.departid from t_sport_cj_jt j where j.departid=g.departid and j.scbm=? and j.scbm=g.scbm and j.wid=g.jtwid ) "
				+ " and g.scbm=? ";
		DBUtil.executeSQL(sql, scbm, scbm, scbm);

		BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_CJ_YDY,
				Constants.LOG_ACTION_UPDATE);
	}

	/**
	 * 成绩格式化（去多余的0）
	 * @param cj
	 * @return
	 */
	public String formatCJ(String cj){
		if(StringUtil.isNotBlank(cj)){
			int dian = cj.indexOf(".");//'.'的判断
			int maohao = cj.indexOf(":");//':'冒号判断
			if(dian!=-1 && maohao==-1){
				try {
					String before  = cj.substring(0,dian);//点号之前
					String after = cj.substring(dian);//点号之后（包括点号）
					int temp = Integer.parseInt(before);
					cj = String.valueOf(temp)+after;
				} catch (NumberFormatException e) {
				}
			}else if(dian==-1 && maohao==-1) {
				try {
					int temp = Integer.parseInt(cj);
					cj = String.valueOf(temp);
				} catch (NumberFormatException e) {
				}
			}
		}
		return cj;
	}
	
	/**
	 * 获取得分
	 * 
	 * @param mc_count 名次并列个数
	 * @param scdfgz 赛程得分规则bean
	 * @param sportScdfgz_list 所有赛程得分规则
	 * @param mc 名次
	 * @return
	 */
	public double getDf(int mc_count, TSportScdfgz scdfgz, List<TSportScdfgz> sportScdfgz_list, short mc, int mc_better,String dxmmc,String xxmmc) {
		if("摔跤".equals(dxmmc)){
		// 摔跤的计分规则  格式： 1 2 33 55 77
			if (3==mc || 5==mc || 7==mc) {
				Double df = 0.00;
					for (TSportScdfgz scdfgzTemp : sportScdfgz_list) {
						if (scdfgzTemp.getPmjb() == (mc + 1) || scdfgzTemp.getPmjb() ==mc ) {
							df += scdfgzTemp.getPmdf();
						}
					}
				return Arith.round(df / 2, 2);
			} else {
				return scdfgz.getPmdf();
			}
		}else if("跆拳道".equals(dxmmc)||"拳击".equals(dxmmc)){
		// 摔跤、拳击的计分规则 格式： 1 2 33 5555
			if (3==mc || 5==mc) {
				Double df = 0.00;
					if(3==mc){
						for (TSportScdfgz scdfgzTemp : sportScdfgz_list) {
							if (scdfgzTemp.getPmjb() == 3 || scdfgzTemp.getPmjb() ==4 ) {
								df += scdfgzTemp.getPmdf();
							}
						}
						return Arith.round(df / 2, 2);
					}else if (5==mc){
						for (TSportScdfgz scdfgzTemp : sportScdfgz_list) {
							if (scdfgzTemp.getPmjb() == 5 || scdfgzTemp.getPmjb() ==6 || scdfgzTemp.getPmjb() ==7  || scdfgzTemp.getPmjb() ==8 ) {
								df += scdfgzTemp.getPmdf();
							}
						}
						return Arith.round(df / 4, 2);
					}
					
					return 0.00;
				
			} else {
				return scdfgz.getPmdf();
			}
		}else if("武术".equals(dxmmc)){
		// 散打的计分规则 格式： 12345555
			if(StringUtils.isNotBlank(xxmmc)){
				//小项目名称 包含“散打”字样
				int i = xxmmc.indexOf("散打");
				if(i!=-1){
					if (5==mc) {
						Double df = 0.00;
								for (TSportScdfgz scdfgzTemp : sportScdfgz_list) {
									if (scdfgzTemp.getPmjb() == 5 || scdfgzTemp.getPmjb() ==6 || scdfgzTemp.getPmjb() ==7  || scdfgzTemp.getPmjb() ==8 ) {
										df += scdfgzTemp.getPmdf();
									}
								}
								return Arith.round(df / 4, 2);
					} else {
						return scdfgz.getPmdf();
					}
				}
			}
			
			if (mc_count > 1) {
				// 占了几个名次，就把这些名次分相加，然后除以并列的个数。
				Double df = 0.00;
				for (int k = 0; k < mc_count; k++) {
					for (TSportScdfgz scdfgzTemp : sportScdfgz_list) {
						if (scdfgzTemp.getPmjb() == (mc + k)) {
							df += scdfgzTemp.getPmdf();
							break;
						}
					}
				}
				return Arith.round(df / mc_count, 2);
			} else {
				return scdfgz.getPmdf();
			}
			
		}else{
			if (mc_count > 1) {
				// 占了几个名次，就把这些名次分相加，然后除以并列的个数。
				Double df = 0.00;
				for (int k = 0; k < mc_count; k++) {
					for (TSportScdfgz scdfgzTemp : sportScdfgz_list) {
						if (scdfgzTemp.getPmjb() == (mc + k)) {
							df += scdfgzTemp.getPmdf();
							break;
						}
					}
				}
				return Arith.round(df / mc_count, 2);
			} else {
				return scdfgz.getPmdf();
			}
		}
	}

	public void xzcsz(Object myaction, Pager pager) throws SQLException {
		SportCjYdyAction action = (SportCjYdyAction) myaction;
		action.setParameter("type", action.getParameter("type"));
		action.setParameter("scbm", action.getParameter("scbm"));
		action.setParameter("djjydh", action.getParameter("djjydh"));
		action.setParameter("departid", action.getParameter("departid"));
		action.setParameter("isjtdj", action.getParameter("isjtdj"));
		action.setParameter("xmbm", action.getParameter("xmbm"));
		action.setParameter("jtwid", action.getParameter("jtwid"));
		String xmbm = action.getParameter("xmbm");
		String scbm = action.getParameter("scbm");
		String departid = action.getParameter("departid");
		String sqlxxmmc = " select a.xxmmc ,a.dxmmc from t_sport_bsxm a where a.wid=? ";
		List<Object[]> obj = DBUtil.queryAllList(sqlxxmmc, xmbm);
		String dbtcode = action.getParameter("selectDbt");
		action.setSelectDbt(dbtcode);
		if (StringUtils.isNotBlank(dbtcode)) {
			departid = dbtcode;
		}
		action.setParameter("xxmmc", String.valueOf(obj.get(0)[0]));
		action.setParameter("dxmmc", String.valueOf(obj.get(0)[1]));
		String sql = "select a.wid as wid ,(select c.departname from T_Sys_Depart c where c.departid=a.yddbm ) as yddmc ,"
				+ " a.xm as xm ,a.sfzh as sfzh ,a.zch as zch,a.yddbm as  from T_Sport_Ydyxx a , T_Sport_Ydybmxm b where a.wid=b.ydywid and b.bsxmwid='"
				+ xmbm + "'  and a.shzt='2'";
		if (StringUtils.isNotBlank(departid)) {
			sql += " and a.yddbm like '" + departid + "%'";
		}
		/*
		 * String hql =" from TSportCjYdy t where t.scbm='"+scbm+"' ";
		 * if(StringUtils.isNotBlank(departid)){ hql
		 * +=" and t.departid='"+departid+"' "; } List<TSportCjYdy> tsc =
		 * this.getBaseDao().findByHql(hql); action.setParameter("cjydylist",
		 * tsc);
		 */
		// long c = DBUtil.count("select count(*) from ("+sql+")");
		// pager.setTotalRows(c);
		// List <Object[]> list = DBUtil.queryPageList(pager,sql);
		List<Object[]> list = DBUtil.queryAllList(sql);
		action.setParameter("ydylist", list);
	}

	// 用于审核意见备注信息
	public void shyj(Object myaction) throws Exception {
		SportCjYdyAction action = (SportCjYdyAction) myaction;
		String wid = action.getWid();
		String hql = " from TSportSsrc a where a.wid =?";
		TSportSsrc tsportSsrc = (TSportSsrc) getBaseDao().findFieldValue(hql, wid);
		action.setSportSsrc(tsportSsrc);
	}

	@Override
	public void openCreate(Object myaction) throws Exception {
		SportCjYdyAction action = (SportCjYdyAction) myaction;
		String reportServer = PropConfigUtil.get("reportServer");
		action.setParameter("reportServer", reportServer);
		action.setParameter("type", action.getParameter("type"));
		action.setParameter("scbm", action.getParameter("scbm"));
		action.setParameter("djjydh", action.getParameter("djjydh"));
		action.setParameter("departid", action.getParameter("departid"));
		action.setParameter("isjtdj", action.getParameter("isjtdj"));
		action.setParameter("xmbm", action.getParameter("xmbm"));
		action.setParameter("model", action.getParameter("model"));
		action.setParameter("sccj", action.getParameter("sccj"));
		action.setParameter("url", action.getParameter("url"));
		action.setParameter("fbzt", action.getParameter("fbzt"));
		action.setParameter("isjtxm", action.getParameter("isjtxm"));
		action.setParameter("jtscbm", action.getParameter("jtscbm"));
		action.setParameter("isjtxm", action.getParameter("isjtxm"));
		// load(action);
	}

}
