package com.imchooser.infoms.service.biz.impl;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.imchooser.framework.service.impl.BaseServiceAbstractSupport;
import com.imchooser.framework.util.Pager;
import com.imchooser.framework.util.SeqFactory;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.action.biz.SportBsxmAction;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.util.BusinessLogUtil;

/**
 * 比赛项目
 * 
 * @author LiBing
 * @date 2010-3-22
 */

public class SportBsxmServiceImpl extends BaseServiceAbstractSupport {

	public List<?> list(Object myaction, Pager pager) throws Exception {
		SportBsxmAction action = (SportBsxmAction) myaction;
		TSportBsxm tsportBsxm = action.getTsportBsxm();
		String hqlcolumn = "select new TSportBsxm(a.wid,a.dxmmc, a.xxmmc,"
				+ "(select c.zdmc from TSysCode c where c.zdbm=a.zb and c.zdlb='BSXM_ZB' ) as zb,"
				+ "(select c.zdmc from TSysCode c where c.zdbm=a.xbz and c.zdlb='BSXM_XBZ' ) as xbz,"
				+ "(select c.zdmc from TSysCode c where c.zdbm=a.xmdj and c.zdlb='BSXM_XMDJ' ) as xmdj,"
				+ "(select c.zdmc from TSysCode c where c.zdbm=a.sfjtxm and c.zdlb='XM_SFJT')as sfjtxm,"
				+ "(select c.zdmc from TSysCode c where c.zdbm=a.sfdzxm and c.zdlb='BOOLEAN')as sfdzxm,a.pxh)";
		String hql = " from TSportBsxm a where 1=1 ";

		if (tsportBsxm != null) {
			// if (StringUtils.isNotBlank(tsportBsxm.getXmdj())) {
			// hql += " and a.xmdj='" + tsportBsxm.getXmdj().trim() + "' ";
			// }
			if (StringUtils.isNotBlank(tsportBsxm.getDxmmc())) {
				hql += " and a.dxmmc='" + tsportBsxm.getDxmmc().trim() + "' ";
			}
			if (StringUtils.isNotBlank(tsportBsxm.getXxmmc())) {
				hql += " and a.xxmmc='" + java.net.URLDecoder.decode(tsportBsxm.getXxmmc().trim(), "utf-8") + "' ";
			}
			if (StringUtils.isNotBlank(tsportBsxm.getZb())) {
				hql += " and a.zb='" + tsportBsxm.getZb().trim() + "' ";
			}
			if (StringUtils.isNotBlank(tsportBsxm.getXbz())) {
				hql += " and a.xbz='" + tsportBsxm.getXbz().trim() + "' ";
			}
		}
		long c = getBaseDao().count("select count(*) as c " + hql);
		hql = hqlcolumn + hql + " order by a.wid desc ";
		pager.setTotalRows(c);
		List<?> list = getBaseDao().findPageByHql(hql, pager);
		return list;
	}

	public void load(Object myaction) throws Exception {
		SportBsxmAction action = (SportBsxmAction) myaction;
		String wid = action.getWid();
		TSportBsxm bean = getBaseDao().findById(TSportBsxm.class, wid);
		action.setTsportBsxm(bean);
	}

	public boolean remove(Object myaction) throws Exception {
		SportBsxmAction action = (SportBsxmAction) myaction;
		String ids = action.getWid();
		boolean deleteSuccess = getBaseDao().deleteAll("TSportBsxm", "wid", "=", ids);
		if (deleteSuccess) {
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_BSXM,
					Constants.LOG_ACTION_DEL);
		}
		return deleteSuccess;
	}

	public void saveOrUpdate(Object myaction) throws Exception {
		SportBsxmAction action = (SportBsxmAction) myaction;
		TSportBsxm object = action.getTsportBsxm();
		if (StringUtils.isBlank(object.getWid())) {
			object.setWid(SeqFactory.getNewSequenceAlone());
			getBaseDao().save(object);
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_BSXM,
					Constants.LOG_ACTION_SAVE);
		} else {
			getBaseDao().updateNotNull(object);
			BusinessLogUtil.log(action.getLoginUser().getUserLoginId(), Constants.CZDX_T_SPORT_BSXM,
					Constants.LOG_ACTION_UPDATE);
		}
		String syxz = action.getParameter("sfxz");// 保存并新增按钮
		if ("1".equals(syxz)) {
			action.setTsportBsxm(null);
			openCreate(myaction);
		}

	}

}
