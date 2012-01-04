package com.yszoe.biz.service.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.biz.Constants;
import com.yszoe.biz.action.ConsultingTjAction;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;

/**
 * 显示咨询信息 咨询师在线人数，求助者等待人数
 * 
 * @author Linyang datetime 2011-12-8
 */
public class ConsultingTjServiceImpl extends AbstractBaseServiceSupport {
	@SuppressWarnings("unused")
	private static final Log LOG = LogFactory.getLog(ConsultingTjServiceImpl.class);

	@Override
	public List<?> list(Object myaction, Pager pager) throws Exception {
		ConsultingTjAction action = (ConsultingTjAction) myaction;
		String sql = "from t_zx_zx where zxlb=?";
		action.setParameter("zxs_gy", DBUtil.count(sql, Constants.ZXLB_GY));
		action.setParameter("zxs_sf", DBUtil.count(sql, Constants.ZXLB_SF));
		action.setParameter("zxs_jb", DBUtil.count(sql, Constants.ZXLB_JB));
		sql = "from t_zx_zt where zxlb = ? and zxzt = '0'";
		action.setParameter("zxz_gy", DBUtil.count(sql, Constants.ZXLB_GY));
		action.setParameter("zxz_sf", DBUtil.count(sql, Constants.ZXLB_SF));
		action.setParameter("zxz_jb", DBUtil.count(sql, Constants.ZXLB_JB));
		return null;
	}

	@Override
	public void load(Object myaction) throws Exception {
	}

	@Override
	public boolean remove(Object myaction) throws Exception {
		return false;
	}

	@Override
	public void saveOrUpdate(Object myaction) throws Exception {
	}
}
