package com.yszoe.cms.service.impl;

import java.sql.SQLException;
import java.util.List;

import com.yszoe.cms.action.CmsApproveArticleAction;
import com.yszoe.cms.entity.TXxfbWz;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.util.DateUtil;
import com.yszoe.util.FileUtil;
import com.yszoe.util.StringUtil;

/**
 * 信息发布模块  -- 管理员审核文章
 * 继承于供稿人java类
 * @author Yangjianliang
 * datetime 2011-7-4
 */
public class CmsApproveArticleServiceImpl extends CmsMyArticleServiceImpl {

//	private static final Log LOG = LogFactory.getLog(CmsArticleApproveServiceImpl.class);

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#list(java.lang.Object, com.yszoe.framework.util.Pager)
	 */
	@Override
	public List<?> list(Object arg0, Pager pager) throws Exception {
		
		return getList(arg0, pager, 2);//2是管理员审核
	}
	
	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#load(java.lang.Object)
	 */
	@Override
	public void load(Object arg0) throws Exception {
		CmsApproveArticleAction action = (CmsApproveArticleAction)arg0;

		String wid = action.getWid();
		TXxfbWz bean = getBaseDao().findById(TXxfbWz.class, wid);
		String uname = (String)DBUtil.queryFieldValue("select username from t_sys_user where userid=?", bean.getCjr());
		bean.setCjrName(uname);
		action.setTxxfbWz(bean);
	}

	/**
	 * 批量审核 ；shlx 2通过 -2撤销 -1退回
	 */
	@Override
	public String changeState(Object myaction) throws Exception {
		
		CmsApproveArticleAction action = (CmsApproveArticleAction)myaction;
		String shzt = action.getRequest().getParameter("shzt");
		String ids = action.getWid();
		if(StringUtil.isBlank(ids) || StringUtil.isBlank(shzt)){

			return "操作失败：缺少参数";
		}
		String sqlwhere = DBUtil.spellSqlWhere("wid", "=", ids.split(","));
		String sql = null;
		if(shzt.equals("2")){//要审核通过勾选的数据，检查此时状态是不是有非待审核和非撤销的
			sql = "select count(*) from T_Xxfb_Wz where (state!=1 and state!=-2) and " + sqlwhere;
		}else if(shzt.equals("-2")){//要撤销发布勾选的数据，检查此时状态是不是有非已审核通过的
			sql = "select count(*) from T_Xxfb_Wz where state!=2 and " + sqlwhere;
		}else if(shzt.equals("-1")){//要退回勾选的数据，检查此时状态是不是待审核，或者已撤销
			sql = "select count(*) from T_Xxfb_Wz where (state!=1 and state!=-2) and " + sqlwhere;
		}
		int i;
		try {
			i = DBUtil.count(sql);
		} catch (SQLException e) {
			return "操作失败："+e.getMessage();
		}
		if(i>0){//有非安全状态的数据，不能执行批量更新
			
			return "操作失败：已勾选记录的状态不能执行此操作";
		}
		String hql = "update TXxfbWz set shrq=?, state=? where ";
		hql = hql + sqlwhere;
		i = getBaseDao().executeHql(hql, DateUtil.currentTime(), shzt);
		if(i>0){
			return "操作成功";
		}else{

			return "操作失败";
		}
	}
	
	public boolean removePic(Object myaction){

		CmsApproveArticleAction action = (CmsApproveArticleAction)myaction;
		String wid = action.getWid();
		String pic = getBaseDao().findFieldValue("select syydt from TXxfbWz where wid=?", wid);
		FileUtil.deleteFileByRelativePath( pic );
		int i = getBaseDao().executeHql("update TXxfbWz set syydt=null where wid=? ", wid);
		if(i>0){
			return true;
		}
		return false;
	}
}
