package com.yszoe.biz.service.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.biz.action.HdNrAdminAction;
import com.yszoe.biz.entity.THdNr;
import com.yszoe.cms.entity.TXxfbLm;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;

/**
 * 活动内容 管理员
 * @author Yangjianliang
 * datetime 2011-12-28
 */
public class HdNrAdminServiceImpl extends AbstractBaseServiceSupport {

	private static final Log LOG = LogFactory.getLog(HdNrAdminServiceImpl.class);

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#list(java.lang.Object, com.yszoe.framework.util.Pager)
	 */
	@Override
	public List<?> list(Object myaction, Pager pager) throws Exception {
		HdNrAdminAction action = (HdNrAdminAction)myaction;
		String hql = "from THdNr a ";
		long c = getBaseDao().count("select count(*) as c " + hql);
		pager.setTotalRows(c);
		String hqlCol = "select new THdNr(wid, bt, syydt, zzz, hddd, hdsj, jg, zdrs, zhxgrq, djs, " +
				"(select zdmc from TSysCode where zdbm=a.hdlx and zdlb='hd_hdlx') as hdlx, " +
				"(select zdmc from TSysCode where zdbm=a.state and zdlb='hd_state') as state, " +
				"(select count(*) from THdBm where state=1 and hdwid=a.wid) as bmrs) ";  
		hql = hqlCol + hql +" order by a.wid desc";
		List<TXxfbLm> list = getBaseDao().findByHql(hql);
		return list;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#load(java.lang.Object)
	 */
	@Override
	public void load(Object myaction) throws Exception {
		HdNrAdminAction action = (HdNrAdminAction)myaction;
		String wid = action.getWid();
		THdNr bean = getBaseDao().findById(THdNr.class, wid);
		if( bean==null ){
			bean = new THdNr();
		}else{
			//更新点击量计数
			getBaseDao().executeHql("update THdNr set djs=djs+1 where wid=?", wid);
		}
		action.setThdNr(bean);
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#remove(java.lang.Object)
	 */
	@Override
	public boolean remove(Object arg0) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#saveOrUpdate(java.lang.Object)
	 */
	@Override
	public void saveOrUpdate(Object arg0) throws Exception {
		// TODO Auto-generated method stub

	}

}

