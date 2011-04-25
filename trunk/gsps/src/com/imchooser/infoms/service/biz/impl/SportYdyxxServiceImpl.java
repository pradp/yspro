package com.imchooser.infoms.service.biz.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.biz.SportYdyxxAction;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.entity.biz.TSportCjYdy;
import com.imchooser.infoms.entity.biz.TSportYdyxx;
import com.imchooser.infoms.util.BusinessLogUtil;

/**
 * 运动员基本信息维护
 * @author Liuhaidong 
 * datetime 2010-3-27
 */
public class SportYdyxxServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportYdyxxAction action = (SportYdyxxAction) myaction;
		TSportYdyxx tsportYdyxx = action.getTsportYdyxx();
		String hqlcolumn = " select new TSportYdyxx(a.wid,(select c.departname from TSysDepart c where c.departid=a.yddbm ) as yddbm,"
				+ " a.xm,a.sfzh,a.zch,"
				+ " (select replace(t.departname,'市','') from TSysDepart t  where t.departid =a.xyjfdq1) as xyjfdqName1,"
				+ " (select replace(t.departname,'市','') from TSysDepart t  where t.departid =a.xyjfdq3) as xyjfdqName3,"
				+ " (select replace(t.departname,'市','') from TSysDepart t  where t.departid =a.xyjfdq7) as xyjfdqName7,"
				+ " (select replace(t.departname,'市','') from TSysDepart t  where t.departid =a.xyjfdq2) as xyjfdqName2,"
				+ " (select t.departname from TSysDepart t  where t.departid =a.xyjfdq5) as xyjfdqName5,"
				+ " (select t.departname from TSysDepart t  where t.departid =a.xyjfdq4) as xyjfdqName4 ) ";

		String hql = " from TSportYdyxx a where 1=1 ";
		if(StringUtils.isNotBlank(action.getDepartID())){
			hql += " and a.yddbm like '%"+action.getDepartID()+"%' ";
		}
		if (tsportYdyxx != null) {
			if (StringUtils.isNotBlank(tsportYdyxx.getXm())) {
				hql += (" and a.xm like '%" + tsportYdyxx.getXm() + "%' ");
			}
			if (StringUtils.isNotBlank(tsportYdyxx.getSfzh())) {
				hql += " and a.sfzh like '%" + tsportYdyxx.getSfzh() + "%' ";
			}
			if (StringUtils.isNotBlank(tsportYdyxx.getYddbm())) {
				hql += "  and a.yddbm in (select s.departid from TSysDepart s where s.departname like '%"
						+ tsportYdyxx.getYddbm() + "%') ";
			}
			if (StringUtils.isNotBlank(tsportYdyxx.getZch())) {
				hql += (" and a.zch like '%" + tsportYdyxx.getZch() + "%' ");
			}
			if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName1())) {
				hql += "  and a.xyjfdq1 in (select s.departid from TSysDepart s where s.departname like '%"
						+ tsportYdyxx.getXyjfdqName1() + "%') ";
			}
			if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdq2isorno())) {
				if ("0".equals(tsportYdyxx.getXyjfdq2isorno())) {
					hql += "  and a.xyjfdq2 in (select s.departid from TSysDepart s where s.departname is null) ";
				} else if ("1".equals(tsportYdyxx.getXyjfdq2isorno())) {
					if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName2())) {
						hql += "  and a.xyjfdq2 in (select s.departid from TSysDepart s where s.departname like '%"
								+ tsportYdyxx.getXyjfdqName2() + "%' and s.departname is not null) ";
					} else {
						hql += "  and a.xyjfdq2 in (select s.departid from TSysDepart s where s.departname is not null) ";
					}
				}
				
			}else{
				if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName2())) {
					hql += "  and a.xyjfdq2 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName2() + "%') ";
				}
			}
			if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdq7isorno())) {
				if ("0".equals(tsportYdyxx.getXyjfdq7isorno())) {
					hql += "  and a.xyjfdq7 in (select s.departid from TSysDepart s where s.departname is null) ";
				} else if ("1".equals(tsportYdyxx.getXyjfdq7isorno())) {
					if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName7())) {
						hql += "  and a.xyjfdq7 in (select s.departid from TSysDepart s where s.departname like '%"
								+ tsportYdyxx.getXyjfdqName7() + "%' and s.departname is not null) ";
					} else {
						hql += "  and a.xyjfdq7 in (select s.departid from TSysDepart s where s.departname is not null) ";
					}
				}
				
			}else{
				if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName7())) {
					hql += "  and a.xyjfdq7 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName7() + "%') ";
				}
			}
			if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdq4isorno())) {
				if ("0".equals(tsportYdyxx.getXyjfdq4isorno())) {
					hql += "  and a.xyjfdq4 in (select s.departid from TSysDepart s where s.departname is null) ";
				} else if ("1".equals(tsportYdyxx.getXyjfdq4isorno())) {
					if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName4())) {
						hql += "  and a.xyjfdq4 in (select s.departid from TSysDepart s where s.departname like '%"
								+ tsportYdyxx.getXyjfdqName4() + "%' and s.departname is not null) ";
					} else {
						hql += "  and a.xyjfdq4 in (select s.departid from TSysDepart s where s.departname is not null) ";
					}
				}
				
			}else{
				if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName4())) {
					hql += "  and a.xyjfdq4 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName4() + "%') ";
				}
			}
			if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdq3isorno())) {
				if ("0".equals(tsportYdyxx.getXyjfdq3isorno())) {
					hql += "  and a.xyjfdq3 in (select s.departid from TSysDepart s where s.departname is null) ";
				} else if ("1".equals(tsportYdyxx.getXyjfdq3isorno())) {
					if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName3())) {
						hql += "  and a.xyjfdq3 in (select s.departid from TSysDepart s where s.departname like '%"
								+ tsportYdyxx.getXyjfdqName3() + "%' and s.departname is not null) ";
					} else {
						hql += "  and a.xyjfdq3 in (select s.departid from TSysDepart s where s.departname is not null) ";
					}
				}
			} else {
				if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName3())) {
					hql += "  and a.xyjfdq3 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName3() + "%') ";
				}
			}
			if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdq5isorno())) {
				if ("0".equals(tsportYdyxx.getXyjfdq5isorno())) {
					hql += "  and a.xyjfdq5 in (select s.departid from TSysDepart s where s.departname is null) ";
				} else if ("1".equals(tsportYdyxx.getXyjfdq5isorno())) {
					if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName5())) {
						hql += "  and a.xyjfdq5 in (select s.departid from TSysDepart s where s.departname like '%"
								+ tsportYdyxx.getXyjfdqName5() + "%' and s.departname is not null) ";
					} else {
						hql += "  and a.xyjfdq5 in (select s.departid from TSysDepart s where s.departname is not null) ";
					}
				}
				
			}else{
				if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdqName5())) {
					hql += "  and a.xyjfdq5 in (select s.departid from TSysDepart s where s.departname like '%"
							+ tsportYdyxx.getXyjfdqName5() + "%') ";
				}
			}
		}
		
		long c = getBaseDao().count("select count(*) as c " + hql);
		hql = hqlcolumn + hql + " order by a.wid desc ";
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findPageByHql(hql, pager);
		return list;
	}

	public void load(Object myaction) throws Exception {
		SportYdyxxAction action = (SportYdyxxAction) myaction;
		String wid = action.getWid();
		String hql = " select new TSportYdyxx( a.wid,a.yddbm,(select c.departname from TSysDepart c where c.departid=a.yddbm) as yddbmName,"
				+ " a.xm,a.csrq,a.xb,a.sg,a.tz,a.sfzh,a.zch,a.state,a.xyjfdq1,(select c.departname from TSysDepart c where c.departid=a.xyjfdq1) as xyjfdqName1,"
				+ " a.xyjfbl1,a.xydpbl1,a.xyjfdq2,(select c.departname from TSysDepart c where c.departid=a.xyjfdq2) as xyjfdqName2,"
				+ " a.xyjfbl2,a.xydpbl2,a.xyjfdq3,(select c.departname from TSysDepart c where c.departid=a.xyjfdq3) as xyjfdqName3,"
				+ " a.xyjfbl3,a.xydpbl3,a.xyjfdq4,(select c.departname from TSysDepart c where c.departid=a.xyjfdq4) as xyjfdqName4,"
				+ " a.xyjfbl4,a.xydpbl4,a.xyjfdq5,(select c.departname from TSysDepart c where c.departid=a.xyjfdq5) as xyjfdqName5,"
				+ " a.xyjfbl5,a.xydpbl5,a.xyjfdq6,(select c.departname from TSysDepart c where c.departid=a.xyjfdq6) as xyjfdqName6,"
				+ " a.xyjfbl6,a.xydpbl6,a.xyjfdq7,(select c.departname from TSysDepart c where c.departid=a.xyjfdq7) as xyjfdqName7,"
				+ " a.xyjfbl7,a.xydpbl7,a.createtime )  from TSportYdyxx a where a.wid=? ";
		TSportYdyxx tsportYdyxx = (TSportYdyxx) getBaseDao().findFieldValue(hql, wid);
		if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdq1()) && StringUtils.isBlank(tsportYdyxx.getXyjfdq3())
				&& StringUtils.isNotBlank(tsportYdyxx.getXyjfdq7())) {
			tsportYdyxx.setXyjfdq3(tsportYdyxx.getXyjfdq1());
			tsportYdyxx.setXyjfdqName3(tsportYdyxx.getXyjfdqName1());
			tsportYdyxx.setXyjfbl3(tsportYdyxx.getXyjfbl1());
			tsportYdyxx.setXydpbl3(tsportYdyxx.getXydpbl1());
		} else if (StringUtils.isNotBlank(tsportYdyxx.getXyjfdq1()) && StringUtils.isNotBlank(tsportYdyxx.getXyjfdq3())
				&& StringUtils.isBlank(tsportYdyxx.getXyjfdq7())) {
			tsportYdyxx.setXyjfdq7(tsportYdyxx.getXyjfdq1());
			tsportYdyxx.setXyjfdqName7(tsportYdyxx.getXyjfdqName1());
			tsportYdyxx.setXyjfbl7(tsportYdyxx.getXyjfbl1());
			tsportYdyxx.setXydpbl7(tsportYdyxx.getXydpbl1());
		}
		action.setTsportYdyxx(tsportYdyxx);

	}

	public boolean remove(Object myaction) throws Exception {
		SportYdyxxAction action = (SportYdyxxAction) myaction;
		String wid = action.getWid();
		boolean deleteSuccess = getBaseDao().deleteAll("TSportYdyxx", "wid", "=", wid);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_YDYXX,
					Constants.LOG_ACTION_DEL);
		}
		return deleteSuccess;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		SportYdyxxAction action = (SportYdyxxAction) myaction;
		TSportYdyxx tsportYdyxx = action.getTsportYdyxx();
		String ydd = tsportYdyxx.getYddbm();
		ydd = ydd.substring(0, 6);
		String sql_yddmc = "select t.departname from t_sys_depart t where t.departid=?";
		String ssd = tsportYdyxx.getXyjfdq7();
		String cxd = tsportYdyxx.getXyjfdq3();
		Double ssddfbl = tsportYdyxx.getXyjfbl7();
		Double ssddpbl = tsportYdyxx.getXydpbl7();
		Double cxddfbl = tsportYdyxx.getXyjfbl3();
		Double cxddpbl = tsportYdyxx.getXydpbl3();
		Double a = Double.parseDouble("0.0");
		String b = "";
		String yddmc = (String) DBUtil.queryFieldValue(sql_yddmc, ydd);
		if (StringUtils.isNotBlank(ydd)){
			tsportYdyxx.setXyjfdqName1(yddmc);
			tsportYdyxx.setXyjfdq1(ydd);
			tsportYdyxx.setXyjfbl1(Double.parseDouble("1"));
			tsportYdyxx.setXydpbl1(Double.parseDouble("1"));
		}
		if (StringUtils.isNotBlank(ydd) && StringUtils.isNotBlank(ssd) && StringUtils.isNotBlank(cxd)) {
			if (ydd.equals(ssd)) {
				tsportYdyxx.setXyjfdq7(b);
				tsportYdyxx.setXyjfbl7(a);
				tsportYdyxx.setXydpbl7(a);
			} else if (ydd.equals(cxd)) {
				tsportYdyxx.setXyjfdq3(b);
				tsportYdyxx.setXyjfbl3(a);
				tsportYdyxx.setXydpbl3(a);
			}
		}
		if (StringUtils.isBlank(tsportYdyxx.getWid())) {
			Date date = new Date();
			tsportYdyxx.setWid(SeqFactory.getNewSequenceAlone());
			tsportYdyxx.setCreatetime(date);
			tsportYdyxx.setShzt("0");
			getBaseDao().save(tsportYdyxx);
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_YDYXX,
					Constants.LOG_ACTION_SAVE);
		} else {
			getBaseDao().updateNotNull(tsportYdyxx);
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_YDYXX,
					Constants.LOG_ACTION_UPDATE);
		}
		if (StringUtils.isNotBlank(ydd) && StringUtils.isBlank(tsportYdyxx.getXyjfdq7()) && StringUtils.isNotBlank(cxd)) {
			tsportYdyxx.setXyjfdq7(ssd);
			tsportYdyxx.setXyjfbl7(ssddfbl);
			tsportYdyxx.setXydpbl7(ssddpbl);
		} else if (StringUtils.isNotBlank(ydd) && StringUtils.isNotBlank(ssd)
				&& StringUtils.isBlank(tsportYdyxx.getXyjfdq3())) {
			tsportYdyxx.setXyjfdq3(cxd);
			tsportYdyxx.setXyjfbl3(cxddfbl);
			tsportYdyxx.setXydpbl3(cxddpbl);
		}
		String syxz = action.getParameter("sfxz");// 保存并新增按钮
		if ("1".equals(syxz)) {
			action.setTsportYdyxx(null);
			openCreate(myaction);
		}

	}

	// 用于确认参赛项目
	@SuppressWarnings("unchecked")
	public List<?> submitQrbsxm(Object myaction, Pager pager) throws Exception {
		SportYdyxxAction action = (SportYdyxxAction) myaction;
		String shzt = action.getParameter("shzt");
		if("-1".equals(shzt)||"0".equals(shzt)||"".equals(shzt)){
			action.setParameter("shzt", shzt);
		}
		String ydybm = action.getWid();
		String bsxm = " select wmsys.wm_concat(t.dxmmc) from t_sport_ydybmxm_cc t where t.ydywid=? group by t.dxmmc ";
		String ydyxx = " from TSportYdyxx t where t.wid=? ";
		Object obj_ydyxx = this.getBaseDao().findFieldValue(ydyxx, ydybm);
		TSportYdyxx tsy = null;
		if(obj_ydyxx!=null){
			tsy = (TSportYdyxx) obj_ydyxx;
		}
		
		String ydybsxm = "";
		Object obj = DBUtil.queryFieldValue(bsxm, ydybm);
		if(obj!=null){
			ydybsxm = String.valueOf(obj);
		}
		ydybsxm = ydybsxm.replaceAll(",", "','"); //将wid间的, 取代为','
		String hqlcolumn = "select new TSportBsxm(a.wid,a.dxmmc, a.xxmmc,"
				+ " (select c.zdmc from TSysCode c where c.zdbm=a.zb and c.zdlb='BSXM_ZB' ) as zb,"
				+ " (select c.zdmc from TSysCode c where c.zdbm=a.xbz and c.zdlb='BSXM_XBZ' ) as xbz)";
		String hql = " from TSportBsxm a where 1=1 ";
		if(tsy!=null){
			if("1".equals(tsy.getXb())){
				hql+=" and a.xbz != '2' ";
			}else if("2".equals(tsy.getXb())){
				hql+=" and a.xbz != '1' ";
			}
			
		}
		
		if(StringUtils.isNotBlank(ydybsxm)){
			hql += " and a.dxmmc in ('"+ydybsxm+"')";
		}
		@SuppressWarnings("unused")
		long c = getBaseDao().count("select count(*) as c " + hql);
		hql = hqlcolumn + hql + " order by a.wid desc ";
		
		//已确定项目
		List<Object[]> objects = (List<Object[]>) submitOrSave(action);
		
		List<TSportBsxm> submitQrbsxm = getBaseDao().findByHql(hql);
		//submitQrbsxm 的 副本
		List<TSportBsxm> submitQrbsxmsbak = new ArrayList<TSportBsxm>();
		if(submitQrbsxm!=null && submitQrbsxm.size()>0){
			submitQrbsxmsbak.addAll(submitQrbsxm);
		}
		//用于存放已经选择报名的项目
		List<TSportBsxm> bsxmEd = new ArrayList<TSportBsxm>();
		//提取已报名的项目
		if(submitQrbsxm!=null && submitQrbsxm.size()>0 && objects!=null && objects.size()>0){
			for(TSportBsxm app : submitQrbsxm ){
				for(Object[] temp : objects){
					if(temp!=null){
						String str = String.valueOf(temp[3]);
						if(app.getWid().equals(str)){
							//添加 已报项目 list
							bsxmEd.add(app);
							//吧 已报项目从 副本中 移除
							submitQrbsxmsbak.remove(app);
						}
					}
				}
				
			}
		}
		//吧 已报名的项目 和未报名的姓名 重新 整合  已报名的 排在前列
		for(TSportBsxm bsxm2 : bsxmEd){
			submitQrbsxmsbak.add(0,bsxm2);
		}
		
		action.setParameter("lists", submitQrbsxmsbak); // "lists" 用于在页面上取值
		return bsxmEd;
	}

	// 用于显示已确定项目和运动员人
	public List<?> submitOrSave(SportYdyxxAction action) throws Exception {
		String wid = action.getWid();
		String sqlcolumn = "select (select b.xm from T_Sport_Ydyxx b where b.wid=t.ydywid)as xm, "
				+ " (select  a.dxmmc||'，'||(select c.zdmc from T_Sys_Code c where c.zdbm=a.zb and c.zdlb='BSXM_ZB' ) "
				+ " ||'，'||(select c.zdmc from T_Sys_Code c where c.zdbm=a.xbz and c.zdlb='BSXM_XBZ')||'，'||a.xxmmc from T_Sport_Bsxm a where a.wid=t.bsxmwid)as bsxm,t.wid,t.bsxmwid";
		String sql = " from T_Sport_Ydybmxm t where t.ydywid=?";
		sql = sqlcolumn + sql + " order by t.wid desc ";
		List<?> submitOrSave = DBUtil.queryAllList(sql, wid);// getBaseDao().findByHql(sql,wid);
		action.setParameter("lists1", submitOrSave); // "lists1" 用于在页面上取值
		return submitOrSave;
	}

	//用于查看成绩分布页面
	public void submitCkcjfb(Object myaction) throws Exception {
		SportYdyxxAction action = (SportYdyxxAction) myaction;
		String wid = action.getWid();
		// String ydybm = action.getParameter("ydybm");
		String depardid = action.getUserLoginId();
		if (StringUtils.isNotBlank(depardid)) {
			action.setParameter("departid", "1");
		}
		//是否打印（页面打印按钮）
		action.setParameter("isprint", action.getParameter("isprint"));
		String hql = " select new TSportYdyxx (a.xm,a.zp,a.xb,a.sg,a.tz,a.zch,"
				+ "( select b.departname from TSysDepart b where b.departid = substr(a.yddbm,0,6) ) as yddbm)"
				+ " from TSportYdyxx a where a.wid=? ";// 个人信息
		String hql1 = "  select  distinct(c.dxmmc|| "+
        " case when b.zb is not null then "+
       " '，'||(select a.zdmc from t_sys_code a where a.zdbm=b.zb and  a.zdlb='BSXM_ZB') end "+
       " ||case when b.xbz is not null then "+
       " '，'|| (select a.zdmc from t_sys_code a where a.zdbm=b.xbz  and  a.zdlb='BSXM_XBZ') end "+   
       " ||case when b.xbz is not null then "+
       " '，'|| (select a.zdmc from t_sys_code a where a.zdbm=b.xbz  and  a.zdlb='BSXM_XBZ') end  "+
       "  || case when b.xxmmc is not null then "+
       " '，'||b.xxmmc end  ) "+
		"	 from T_Sport_Cj_Ydy c,T_Sport_Ydyxx t,t_sport_bsxm b,t_sport_ssrc x where  b.wid=x.xmbm and x.wid=c.scbm  and c.ydybm=t.wid and t.wid=?";// 赛前报名项目
		String hql2 = "select (a.dxmmc||'，'||a.xxmmc)as bsxm,a.cj as cj,a.mc as mc,(a.jps+a.jjjps)as jps,(a.yps+a.jjyps)as yps,(a.tps+a.jjtps)as tps,(a.df+a.jjf)as df  "
				+ " from T_Sport_Cj_Ydy a  where a.ydybm= ? and ((a.df+a.jjf)is not null and (a.df+a.jjf)!=0)";// 本届赛会得牌得分
		String hql3 = "select (select m.zdmc from t_sys_code m where m.zdlb='MX_DFLX'and m.zdbm=t.dflx)as dflx, "
				+ " t.dbtmc,t.yddmc,t.dxmmc,t.xxmmc,t.mc,(t.jps+t.jjjps)as jps,(t.yps+t.jjyps)as yps,(t.tps+t.jjtps)as tps,(t.df+t.jjf)as df "
				+ " from  t_sport_cj_zs_mx t where t.shzt='1'and t.dfly like ? and((t.df+t.jjf)is not null and (t.df+t.jjf)!=0)";
		// 登录后可见，计入输送单位（代表团和区县）得分得牌

		TSportYdyxx tsportYdyxx = (TSportYdyxx) getBaseDao().findFieldValue(hql, wid);// 个人信息
		action.setTsportYdyxx(tsportYdyxx);

		List<?> list = DBUtil.queryAllList(hql1, wid); // 赛前报名项目
		if(list==null || list.size()==0){
			 hql1 = "select   distinct(c.dxmmc||"+
        " case when c.bsxmwid is not null then "+
        " '，'|| (select a.zdmc from t_sys_code a,t_sport_bsxm b  where a.zdbm=b.zb and b.wid=c.bsxmwid and  a.zdlb='BSXM_ZB')"+
         "   end "+
        " ||case when c.bsxmwid is not null then "+
        " '，' ||(select a.zdmc from t_sys_code a,t_sport_bsxm b  where a.zdbm=b.xbz and b.wid=c.bsxmwid and  a.zdlb='BSXM_XBZ') "+
         "   end "+
       " || case when c.bsxmwid is not null then "+
       " '，'|| (select a.xxmmc from t_sport_bsxm a where a.wid=c.bsxmwid) "+
       "end)"
		+ " from T_Sport_Ydybmxm c,T_Sport_Ydyxx t where c.ydywid=t.wid and t.wid= ? ";
			 list = DBUtil.queryAllList(hql1, wid);
		}
		action.setParameter("result", list);

		List<TSportCjYdy> list1 = DBUtil.queryAllBeanList(hql2, TSportCjYdy.class, wid);// 本届赛会得牌得分
		action.setParameter("result1", list1);

		if (StringUtils.isNotBlank(action.getUserLoginId())) {// 登录后可见，计入输送单位（代表团和区县）得分得牌
			List<?> list2 = DBUtil.queryAllList(hql3, "%" + wid + "%");
			action.setParameter("result2", list2);
		}

	}
}
