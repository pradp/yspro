package com.yszoe.cms.service.impl;

import java.util.List;

import com.yszoe.cms.action.CmsApproveCommentAction;
import com.yszoe.cms.entity.TXxfbPl;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.util.StringUtil;

/**
 * 信息发布模块 管理员管理评论
 * @author Yangjianliang
 * datetime 2011-7-4
 */
public class CmsApproveCommentServiceImpl extends CmsMyCommentServiceImpl {

//	private static final Log LOG = LogFactory.getLog(CmsArticleServiceImpl.class);

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#list(java.lang.Object, com.yszoe.framework.util.Pager)
	 */
	@Override
	public List<?> list(Object arg0, Pager pager) throws Exception {
		
		return getListData(arg0, pager, true);
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#remove(java.lang.Object)
	 */
	@Override
	public boolean remove(Object arg0) throws Exception {
		CmsApproveCommentAction action = (CmsApproveCommentAction)arg0;
		String wid = action.getWid();
		boolean hql = getBaseDao().deleteAll("TXxfbPl", "wid", "=", wid);
		return hql;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#saveOrUpdate(java.lang.Object)
	 */
	@Override
	public void saveOrUpdate(Object arg0) throws Exception {
		CmsApproveCommentAction action = (CmsApproveCommentAction)arg0;

		TXxfbPl pl = action.getTxxfbPl();
		
		if(StringUtil.isBlank(pl.getWid())){
			//do insert
			pl.setWid(SeqFactory.getNewSequenceAlone());
			getBaseDao().save(pl);
		}else{
			//do update
			getBaseDao().updateNotNull(pl);
		}

	}

	/**
	 * 批量变更状态
	 */
	@Override
	public String changeState(Object myaction) throws Exception {
		
		CmsApproveCommentAction action = (CmsApproveCommentAction)myaction;
		String shzt = action.getRequest().getParameter("shzt");
		String ids = action.getWid();
		if(StringUtil.isBlank(ids) || StringUtil.isBlank(shzt)){

			return "操作失败：缺少参数";
		}
		String sqlwhere = DBUtil.spellSqlWhere("wid", "=", ids.split(","));
		String sql = null;

		sql = "update t_xxfb_pl set state="+shzt+" where ";
		sql = sql + sqlwhere;
		int i = DBUtil.executeOneoffSQL(sql);
		if(i>0){
			return "操作成功";
		}else{

			return "操作失败";
		}
	}
}
