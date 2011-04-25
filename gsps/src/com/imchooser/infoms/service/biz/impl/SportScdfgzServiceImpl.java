package com.imchooser.infoms.service.biz.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.Pager;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.biz.SportScdfgzAction;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.entity.biz.TSportScdfgz;
import com.imchooser.infoms.util.BusinessLogUtil;

/**
 * 赛次得分规则
 * 
 * @author DaiQinggao
 * @date 2010-03-30
 */
public class SportScdfgzServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportScdfgzAction action = (SportScdfgzAction) myaction;
		TSportBsxm tsportBsxm = action.getTsportBsxm();
		String hqlcolumn = "select new TSportBsxm(a.wid,a.dxmmc, a.xxmmc,"
				+ "(select c.zdmc from TSysCode c where c.zdbm=a.zb and c.zdlb='BSXM_ZB' ) as zb,"
				+ "(select c.zdmc from TSysCode c where c.zdbm=a.xbz and c.zdlb='BSXM_XBZ' ) as xbz,"
				+ "(select c.zdmc from TSysCode c where c.zdbm=a.xmdj and c.zdlb='BSXM_XMDJ' ) as xmdj)";
		String hql = " from TSportBsxm a where 1=1 ";

		if (tsportBsxm != null) {
//			if (StringUtils.isNotBlank(tsportBsxm.getXmdj())) {
//				hql += " and a.xmdj like '%" + tsportBsxm.getXmdj().trim() + "%' ";
//			}
			if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
				hql += " and a.dxmmc='" + tsportBsxm.getDxmmc().trim() + "' ";
			}
			if (StringUtils.isNotBlank(tsportBsxm.getXxmmc())) {
				hql += " and a.xxmmc= '" + java.net.URLDecoder.decode(tsportBsxm.getXxmmc().trim(),"utf-8") + "' ";
			}
			if (StringUtils.isNotBlank(tsportBsxm.getZb())) {
				hql += " and a.zb='" + tsportBsxm.getZb().trim() + "' ";
			}
			if (StringUtils.isNotBlank(tsportBsxm.getXbz())) {
				hql += " and a.xbz= '" + tsportBsxm.getXbz().trim() + "' ";
			}
		}
		long c = getBaseDao().count("select count(*) as c " + hql);
		hql = hqlcolumn + hql + " order by a.wid desc ";
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findPageByHql(hql, pager);
		return list;
	}

	public void load(Object myaction) throws Exception {
		SportScdfgzAction action = (SportScdfgzAction) myaction;
		String xmbm = action.getParameter("xmbm");
		List<TSportScdfgz> list_sportScdfgz = null;
		list_sportScdfgz = getBaseDao().findByHql("from TSportScdfgz a where a.xmbm = ? order by a.pmjb asc", xmbm);
		if (list_sportScdfgz == null || list_sportScdfgz.size() == 0) {
			list_sportScdfgz = new ArrayList<TSportScdfgz>();
			for (int i = 1; i <= 8; i++) {
				TSportScdfgz tsportScdfgz = new TSportScdfgz();
				tsportScdfgz.setWid(SeqFactory.getNewSequenceAlone());
				tsportScdfgz.setXmbm(xmbm);
				tsportScdfgz.setPmdf(Double.valueOf(0));
				tsportScdfgz.setPmtps(Double.valueOf(0));
				tsportScdfgz.setPmjps(Double.valueOf(0));
				tsportScdfgz.setPmyps(Double.valueOf(0));
				tsportScdfgz.setPmjb(Short.valueOf(Integer.toString(i)));
				tsportScdfgz.setSfdjgz("0");
				getBaseDao().save(tsportScdfgz);
				list_sportScdfgz.add(tsportScdfgz);
			}
		}
		action.setListSportScdfgz(list_sportScdfgz);
	}

	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		SportScdfgzAction action = (SportScdfgzAction) myaction;
		List<TSportScdfgz> list_sportScdfg = action.getListSportScdfgz();
		if (list_sportScdfg != null && list_sportScdfg.size() > 0) {
			this.getBaseDao().saveOrUpdateAll(list_sportScdfg);
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_SCDFGZ,
					Constants.LOG_ACTION_UPDATE);
		}

	}

}
