package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.Pager;
import com.imchooser.infoms.action.biz.SportScDpHdAction;
import com.imchooser.infoms.entity.biz.TSportBsxm;

/**
 * 赛程得牌核对
 * 
 * @author Wangjunjun 2010-7-19
 */
public class SportScDpHdServiceImpl extends BaseServiceAbstractSupport {

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.imchooser.framework.service.BaseService#list(java.lang.Object,
	 * com.imchooser.framework.util.Pager)
	 */
	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportScDpHdAction action = (SportScDpHdAction) myaction;
		TSportBsxm sportBsxm = action.getSportBsxm();
		boolean isfushu = false;
		// 实际 与 赛程的差值
		String sql = "select aaa.xm,aaa.bssj,bbb.pjps,bbb.pyps,bbb.ptps,bbb.pdf,aaa.jps,aaa.yps,aaa.tps,aaa.df from "
				+ " (SELECT  c.dxmmc ||' '||(select r.zdmc from t_sys_code r where r.zdlb='BSXM_ZB' and r.zdbm=c.zb )||' '||(select r.zdmc from t_sys_code r where r.zdlb='BSXM_XBZ' and r.zdbm=c.xbz )||' '|| c.xxmmc xm,to_char(a.bssj,'yyyy-mm-dd') bssj, c.wid xmbm,"
				+ " SUM (b.jps) jps, SUM (b.yps) yps, SUM (b.tps) tps,SUM (b.df) df,c.dxmmc dxmmc, c.xxmmc xxmmc "
				+ "FROM t_sport_ssrc a INNER JOIN t_sport_cj_jt b ON a.wid = b.scbm "
				+ " LEFT JOIN t_sport_bsxm c ON c.wid = a.xmbm " + " WHERE a.fbzt = 3 AND a.scbm = 2 AND b.shzt=1 "
				+ " GROUP BY c.wid,c.dxmmc, c.xxmmc,a.bssj,c.zb,c.xbz " + " union "
				+ " SELECT  c.dxmmc ||' '||(select r.zdmc from t_sys_code r where r.zdlb='BSXM_ZB' and r.zdbm=c.zb )||' '||(select r.zdmc from t_sys_code r where r.zdlb='BSXM_XBZ' and r.zdbm=c.xbz )||' '|| c.xxmmc xm,to_char(a.bssj,'yyyy-mm-dd') bssj, c.wid xmbm, "
				+ " SUM (b.jps) jps, SUM (b.yps) yps, SUM (b.tps) tps, SUM (b.df) df ,c.dxmmc dxmmc, c.xxmmc xxmmc "
				+ " FROM t_sport_ssrc a INNER JOIN t_sport_cj_ydy b ON a.wid = b.scbm "
				+ " LEFT JOIN t_sport_bsxm c ON c.wid = a.xmbm "
				+ " WHERE a.fbzt = 3 AND a.scbm = 2 AND c.sfjtxm = 0 AND b.shzt=1 "
				+ " GROUP BY c.wid, c.dxmmc, c.xxmmc,a.bssj,c.zb,c.xbz ) aaa ";
		if (sportBsxm != null) {
			String val = sportBsxm.getVal();
			if (StringUtils.isNotBlank(val)) {
				double val_int = Double.parseDouble(val);
				if (val_int > 0) {
					sql += " ,";
				} else if (val_int < 0) {
					sql += " right join";
					isfushu=true;
				}else{
					sql += " ,";
				}
			}else{
				sql += " ,";
			}
		}else{
			sql += " ,";
		}
		if(isfushu){
			sql += "(select b.wid, SUM (g.pmjps) pjps, SUM (g.pmyps) pyps, SUM (g.pmtps) ptps, SUM (g.pmdf) pdf "
				+ " from t_sport_bsxm b , t_sport_scdfgz g where b.wid=g.xmbm GROUP BY b.wid) bbb "
				+ " on aaa.xmbm=bbb.wid where (  ";
		}else{
			sql += "(select b.wid, SUM (g.pmjps) pjps, SUM (g.pmyps) pyps, SUM (g.pmtps) ptps, SUM (g.pmdf) pdf "
				+ " from t_sport_bsxm b , t_sport_scdfgz g where b.wid=g.xmbm GROUP BY b.wid) bbb "
				+ "where aaa.xmbm=bbb.wid and (  ";
		}
		
		int i = 0;
		if (sportBsxm != null) {
			String dpType = sportBsxm.getDpType();
			if (StringUtils.isNotBlank(dpType)) {
				if ("1".equals(dpType)) {
					i++;
					sql += " aaa.jps != bbb.pjps ";
				} else if ("2".equals(dpType)) {
					i++;
					sql += " aaa.yps != bbb.pyps ";
				} else if ("3".equals(dpType)) {
					i++;
					sql += " aaa.tps != bbb.ptps ";
				} else if ("4".equals(dpType)) {
					i++;
					sql += " aaa.df != bbb.pdf ";
				}
			}
		}
		if (i == 0) {
			sql += " aaa.jps != bbb.pjps or aaa.yps != bbb.pyps or aaa.tps != bbb.ptps or aaa.df != bbb.pdf ";
		}
		sql += ") ";
		if (sportBsxm != null) {
			if (StringUtils.isNotBlank(sportBsxm.getStartTime())) {
				sql += " and aaa.bssj >= '" + sportBsxm.getStartTime() + "' ";
			}
			if (StringUtils.isNotBlank(sportBsxm.getEndTime())) {
				sql += " and aaa.bssj <= '" + sportBsxm.getEndTime() + "' ";
			}
			if (StringUtils.isNotBlank(sportBsxm.getDxmmc())) {
				sql += " and aaa.dxmmc='" + java.net.URLDecoder.decode(sportBsxm.getDxmmc(), "utf-8")+ "'";
			}
			if (StringUtils.isNotBlank(sportBsxm.getXxmmc())) {
				sql += " and aaa.xxmmc='" +java.net.URLDecoder.decode(sportBsxm.getXxmmc(), "utf-8")+ "'";
			}
		}
		long c = DBUtil.count("select count(*) from (" + sql + ")");
		pager.setTotalRows(c);
		List<?> list = DBUtil.queryPageList(pager, sql);
		return list;
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

}
