package com.yszoe.cms.service.impl;

import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.cms.action.CmsMyCommentAction;
import com.yszoe.cms.entity.TXxfbPl;
import com.yszoe.cms.entity.TXxfbWz;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;

/**
 * 信息发布模块 会员查看自己的评论管理
 * @author Yangjianliang
 * datetime 2011-7-4
 */
public class CmsMyCommentServiceImpl extends AbstractBaseServiceSupport {

//	private static final Log LOG = LogFactory.getLog(CmsArticleServiceImpl.class);

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#list(java.lang.Object, com.yszoe.framework.util.Pager)
	 */
	@Override
	public List<?> list(Object arg0, Pager pager) throws Exception {
		
		return getListData(arg0, pager, false);
	}

	protected List<?> getListData(Object arg0, Pager pager, boolean isAdmin) throws Exception {
		CmsMyCommentAction action = (CmsMyCommentAction)arg0;
		TXxfbPl pl = action.getTxxfbPl();
		String hql = " from TXxfbWz a, TXxfbPl b, TXxfbLm c where a.wid=b.wzwid and a.lmwid=c.wid";
		List<Object> params = new LinkedList<Object>();
		if(isAdmin==false){
			hql += " and b.plr=?";
			params.add(action.getLoginuser().getUserid());
		}
		if(pl!=null){
			if(StringUtils.isNotBlank(pl.getLmmc())){
				hql += " and a.lmwid=?";
				params.add(pl.getLmmc());
			}
			if(StringUtils.isNotBlank(pl.getWzbt())){
				hql += " and a.bt like ?";
				params.add( "%" + pl.getWzbt() + "%");
			}
			if( null != pl.getPlsjStart() ){
				hql += " and b.plsj >= ?";
				params.add( pl.getPlsjStart() );
			}
			if( null != pl.getPlsjEnd() ){
				hql += " and b.plsj <= ?";
				params.add( pl.getPlsjEnd() );
			}
			if(StringUtils.isNotBlank(pl.getState())){
				hql += " and b.state=?";
				params.add(pl.getState());
			}
		}
		long c = getBaseDao().count("select count(*) as c " + hql, params.toArray());
		pager.setTotalRows(c);
		
		String hqlcol = "select new TXxfbPl(b.wid, b.wzwid, a.bt, c.lmmc, b.plr, (select u.username from TSysUser u where b.plr=u.userid) as plrName, b.plnr, b.plrip, b.plsj, " +
				"(select zdmc from TSysCode where zdbm=b.state and zdlb='xxfb_plzt') as state)";
		hql = hqlcol + hql + " order by a.wid desc";
		List<TXxfbWz> list = getBaseDao().findPageByHql(hql, pager, params.toArray());
		return list;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#load(java.lang.Object)
	 */
	@Override
	public void load(Object arg0) throws Exception {
		CmsMyCommentAction action = (CmsMyCommentAction)arg0;

		String wid = action.getWid();
		TXxfbPl bean = getBaseDao().findById(TXxfbPl.class, wid);
		action.setTxxfbPl(bean);

	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#remove(java.lang.Object)
	 */
	@Override
	public boolean remove(Object arg0) throws Exception {

		return false;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#saveOrUpdate(java.lang.Object)
	 */
	@Override
	public void saveOrUpdate(Object arg0) throws Exception {

	}

}
