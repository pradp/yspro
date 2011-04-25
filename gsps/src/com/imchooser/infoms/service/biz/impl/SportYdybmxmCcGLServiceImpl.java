package com.imchooser.infoms.service.biz.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.biz.SportYdybmxmCcGLAction;
import com.imchooser.infoms.entity.biz.TSportYdybmxmCc;
import com.imchooser.infoms.entity.biz.TSportYdyxx;
import com.imchooser.infoms.entity.sys.ApplicationEnum;
import com.imchooser.infoms.util.BusinessLogUtil;

/**
 * 运动员一次报名信息维护
 * 
 * @author WangJunjun DateTime 2010-7-30
 */
public class SportYdybmxmCcGLServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		return null;
	}

	@SuppressWarnings("unchecked")
	public void load(Object myaction) throws Exception {
		SportYdybmxmCcGLAction action = (SportYdybmxmCcGLAction) myaction;
		TSportYdybmxmCc tsportYdybmxmCc = action.getTsportYdybmxmCc();
//		String xm = action.getXm();
		String ydybm = action.getWid();
		String dxmmc = "";
		if (tsportYdybmxmCc != null) {
			dxmmc = tsportYdybmxmCc.getDxmmc();
		}else{
			tsportYdybmxmCc = new TSportYdybmxmCc();
			action.setTsportYdybmxmCc(tsportYdybmxmCc);
		}
		tsportYdybmxmCc.setYdywid(ydybm);
		// String sql = " from  TSportYdybmxmCc c where c.ydywid=?";
		// List<TSportYdybmxmCc> list = this.getBaseDao().findByHql(sql, ydybm);
		// 查询大项目
		String sqldxm = " select distinct(c.dxmmc) from  T_Sport_Ydybmxm_Cc c where c.ydywid=? and c.dxmmc is not null";
		List<Object[]> listdxm = DBUtil.queryAllList(sqldxm, ydybm);
		List<ApplicationEnum> list_dxmmc = new ArrayList<ApplicationEnum>();
		if (!listdxm.isEmpty()) {
			if (StringUtils.isBlank(dxmmc)) {
				dxmmc = String.valueOf(listdxm.get(0)[0]);
			}
			for (Object[] cc : listdxm) {
				ApplicationEnum applicationEnum = new ApplicationEnum();
				applicationEnum.setId(String.valueOf(cc[0]));
				applicationEnum.setCaption(java.net.URLDecoder.decode(String.valueOf(cc[0]), "utf-8"));
				list_dxmmc.add(applicationEnum);
			}
		}
		action.setParameter("dxmlist", list_dxmmc);
		// 查询小项目
		String sqlxxm = "select (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid1) as xxmmc1,a.bsxmwid1,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid2) as xxmmc2,a.bsxmwid2,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid3) as xxmmc3,a.bsxmwid3,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid4) as xxmmc4,a.bsxmwid4,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid5) as xxmmc5,a.bsxmwid5,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid6) as xxmmc6,a.bsxmwid6,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid7) as xxmmc7,a.bsxmwid7,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid8) as xxmmc8,a.bsxmwid8,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid9) as xxmmc9,a.bsxmwid9,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid10) as xxmmc10,a.bsxmwid10,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid11) as xxmmc11,a.bsxmwid11,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid12) as xxmmc12,a.bsxmwid12,"
				+ " (select f.xxmmc from T_Sport_Bsxm f  where f.wid=a.bsxmwid13) as xxmmc13,a.bsxmwid13"
				+ " from  T_Sport_Ydybmxm_Cc a left join t_sport_bsxm b on a.dxmmc=b.dxmmc and " 
				+ " (a.bsxmwid1=b.wid or a.bsxmwid2=b.wid or a.bsxmwid3=b.wid or a.bsxmwid4=b.wid or a.bsxmwid5=b.wid " 
				+ " or a.bsxmwid6=b.wid or a.bsxmwid7=b.wid or a.bsxmwid8=b.wid or a.bsxmwid9=b.wid or a.bsxmwid10=b.wid or " 
				+ " a.bsxmwid11=b.wid or a.bsxmwid12=b.wid or a.bsxmwid13=b.wid)"
				+ " where a.ydywid=? and a.dxmmc=?";
		List<TSportYdybmxmCc> listxxm = null;
		if (StringUtils.isNotBlank(dxmmc)) {
			listxxm = DBUtil.queryAllBeanList(sqlxxm, TSportYdybmxmCc.class, ydybm, dxmmc);
//			action.setParameter("dxmmc", dxmmc);
			tsportYdybmxmCc.setDxmmc(dxmmc);
			List<String> strlist = new ArrayList<String>();
			if (!listxxm.isEmpty()) {
				String bsxmwid = String.valueOf(listxxm.get(0).getBsxmwid1());
//				action.setParameter("bsxmwid", bsxmwid);
				tsportYdybmxmCc.setBsxmwid1(bsxmwid);
				if(StringUtils.isNotBlank(bsxmwid)&& "".equals(bsxmwid)){
					String sqlzb = " select (select t.zdmc from t_sys_code t where t.zdbm=a.zb and t.zdlb='BSXM_ZB')as zb  "
							+ " from t_sport_bsxm a where a.wid=?";
					tsportYdybmxmCc.setZb((String)DBUtil.queryFieldValue(sqlzb, bsxmwid));
				}else{
					String sqlzzb = "select (select t.zdmc from t_sys_code t where t.zdbm=a.zb and t.zdlb='BSXM_ZB')as zb " 
						+" from t_sport_ydybmxm_cc a where a.ydywid=?";
					tsportYdybmxmCc.setZb((String)DBUtil.queryFieldValue(sqlzzb, ydybm));
				}

				String sqlzzb = "select t.zb from t_sport_ydybmxm_cc t where t.ydywid=?";
				tsportYdybmxmCc.setZbbm((String)DBUtil.queryFieldValue(sqlzzb, ydybm));
				String sqlxxb = "select a.xb from t_sport_ydyxx a where a.wid=?";
				tsportYdybmxmCc.setXbbm((String)DBUtil.queryFieldValue(sqlxxb, ydybm));
				
				String sqlxb = " select (select t.zdmc from t_sys_code t where t.zdbm=a.xb and t.zdlb='XB')as xb  "
						+ " from t_sport_ydyxx a where a.wid=?";
				Object xbs = DBUtil.queryFieldValue(sqlxb, ydybm);
				tsportYdybmxmCc.setXb((String)xbs);
				for (TSportYdybmxmCc cc : listxxm) {
					strlist.add(cc.getXxmmc1());
					strlist.add(cc.getXxmmc2());
					strlist.add(cc.getXxmmc3());
					strlist.add(cc.getXxmmc4());
					strlist.add(cc.getXxmmc5());
					strlist.add(cc.getXxmmc6());
					strlist.add(cc.getXxmmc7());
					strlist.add(cc.getXxmmc8());
					strlist.add(cc.getXxmmc9());
					strlist.add(cc.getXxmmc10());
					strlist.add(cc.getXxmmc11());
					strlist.add(cc.getXxmmc12());
					strlist.add(cc.getXxmmc13());
					strlist.add(cc.getBsxmwid1());
					strlist.add(cc.getBsxmwid2());
					strlist.add(cc.getBsxmwid3());
					strlist.add(cc.getBsxmwid4());
					strlist.add(cc.getBsxmwid5());
					strlist.add(cc.getBsxmwid6());
					strlist.add(cc.getBsxmwid7());
					strlist.add(cc.getBsxmwid8());
					strlist.add(cc.getBsxmwid9());
					strlist.add(cc.getBsxmwid10());
					strlist.add(cc.getBsxmwid11());
					strlist.add(cc.getBsxmwid12());
					strlist.add(cc.getBsxmwid13());
					strlist.add(cc.getDxmmc());
				}
			}
			action.setParameter("vallist", strlist);
		}
	}

	public boolean remove(Object myaction) throws Exception {
		return true;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		SportYdybmxmCcGLAction action = (SportYdybmxmCcGLAction) myaction;
		// 运动员编码
		String ydybm = action.getWid();
		// 登记人所报的一次项目列表
//		String dxmmc = action.getParameter("dxmmcse");
		String dxmmc = action.getTsportYdybmxmCc().getDxmmc();
		String zb = action.getTsportYdybmxmCc().getZbbm();
		Object[] xxmmcs = action.getParameters("se");
		action.setParameter("vallist", xxmmcs);
		if (xxmmcs != null && xxmmcs.length > 0 && StringUtils.isNotBlank(ydybm)) {
			// 获取当前登记人的 详细信息
			TSportYdyxx sportYdyxx = this.getBaseDao().findById(TSportYdyxx.class, ydybm);
			if (sportYdyxx != null) {
				List<TSportYdybmxmCc> cc = new ArrayList<TSportYdybmxmCc>();
				TSportYdybmxmCc tempCc = new TSportYdybmxmCc();
				if (StringUtils.isNotBlank(dxmmc)) {
					tempCc.setWid(SeqFactory.getNewSequenceAlone());
					tempCc.setYdywid(ydybm);
					tempCc.setDxmmc(dxmmc);
					tempCc.setZb(zb);
					tempCc.setZczh(sportYdyxx.getZch());
					tempCc.setXm(sportYdyxx.getXm());
					tempCc.setSfzh(sportYdyxx.getSfzh());
					if (xxmmcs.length > 0) {
						// 设置小项目wid
						for (int i = 0; i < xxmmcs.length; i++) {
							if (i == 0) {
								tempCc.setBsxmwid1(xxmmcs[0] == null ? "" : String.valueOf(xxmmcs[0]));
							}
							if (i == 1) {
								tempCc.setBsxmwid2(xxmmcs[1] == null ? "" : String.valueOf(xxmmcs[1]));
							}
							if (i == 2) {
								tempCc.setBsxmwid3(xxmmcs[2] == null ? "" : String.valueOf(xxmmcs[2]));
							}
							if (i == 3) {
								tempCc.setBsxmwid4(xxmmcs[3] == null ? "" : String.valueOf(xxmmcs[3]));
							}
							if (i == 4) {
								tempCc.setBsxmwid5(xxmmcs[4] == null ? "" : String.valueOf(xxmmcs[4]));
							}
							if (i == 5) {
								tempCc.setBsxmwid6(xxmmcs[5] == null ? "" : String.valueOf(xxmmcs[5]));
							}
							if (i == 6) {
								tempCc.setBsxmwid7(xxmmcs[6] == null ? "" : String.valueOf(xxmmcs[6]));
							}
							if (i == 7) {
								tempCc.setBsxmwid8(xxmmcs[7] == null ? "" : String.valueOf(xxmmcs[7]));
							}
							if (i == 8) {
								tempCc.setBsxmwid9(xxmmcs[8] == null ? "" : String.valueOf(xxmmcs[8]));
							}
							if (i == 9) {
								tempCc.setBsxmwid10(xxmmcs[9] == null ? "" : String.valueOf(xxmmcs[9]));
							}
							if (i == 10) {
								tempCc.setBsxmwid11(xxmmcs[10] == null ? "" : String.valueOf(xxmmcs[10]));
							}
							if (i == 11) {
								tempCc.setBsxmwid12(xxmmcs[11] == null ? "" : String.valueOf(xxmmcs[11]));
							}
							if (i == 12) {
								tempCc.setBsxmwid13(xxmmcs[12] == null ? "" : String.valueOf(xxmmcs[12]));
							}
						}
						cc.add(tempCc);
					}
				}
				// 保存
				String deleteSQL = "delete  from t_sport_ydybmxm_cc t where t.ydywid=? ";
				int i = DBUtil.executeSQL(deleteSQL, ydybm);
				if (i != -1) {
					if (!cc.isEmpty()) {
						this.getBaseDao().saveAll(cc);
						BusinessLogUtil.log(action.getLoginUser().getUserLoginId(),
								Constants.CZDX_T_SPORT_YDYBMXM_CC, Constants.LOG_ACTION_UPDATE);
					}
				}
			}

		}
	}

}
