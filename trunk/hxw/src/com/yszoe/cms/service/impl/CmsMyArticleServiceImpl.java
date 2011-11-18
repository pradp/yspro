package com.yszoe.cms.service.impl;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.biz.Constants;
import com.yszoe.cms.action.CmsMyArticleAction;
import com.yszoe.cms.entity.TXxfbWz;
import com.yszoe.cms.util.WordFilter;
import com.yszoe.framework.jdbc.DBConn;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.support.OldOlbSupport;
import com.yszoe.sys.util.CommonQuery;
import com.yszoe.util.DateUtil;
import com.yszoe.util.FileUtil;
import com.yszoe.util.StringUtil;

/**
 * 信息发布模块 文章供稿
 * 会员或者管理员，有权限供稿的人的界面
 * @author Yangjianliang
 * datetime 2011-7-4
 */
public class CmsMyArticleServiceImpl extends AbstractBaseServiceSupport {

//	private static final Log LOG = LogFactory.getLog(CmsArticleApproveServiceImpl.class);
	
	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#list(java.lang.Object, com.yszoe.framework.util.Pager)
	 */
	@Override
	public List<?> list(Object arg0, Pager pager) throws Exception {

		return getList(arg0, pager, 1);
	}

	/**
	 * 提取此方法，为了将管理员和供稿人代码共有，便于维护
	 * @param arg0
	 * @param pager
	 * @param userType 1普通供稿人；2管理员审核别人数据； 
	 * @return
	 * @throws Exception
	 */
	List<?> getList(Object arg0, Pager pager, int userType) throws Exception {
		CmsMyArticleAction action = (CmsMyArticleAction)arg0;
		String hql = "from TXxfbWz a where ";//管理员查看所有非草稿状态的数据
		if(userType==1){
			//各种供稿人查看自己的文章（管理员管理自己编写文章）
			hql += "a.cjr = ?";
		}else if(userType==2){
			//管理员审核普通供稿人提供的所有非草稿状态的数据
			hql += "(a.cjr != ? and a.state!=0)";
		}

		List<Object> params = new LinkedList<Object>();
		params.add(action.getLoginuser().getUserid());

		TXxfbWz xxfbWz = action.getTxxfbWz();
		if(xxfbWz!=null){
			if(StringUtil.isNotBlank(xxfbWz.getBt())){
				hql += " and a.bt like ?";
				params.add("%"+xxfbWz.getBt()+"%");
			}
			if(StringUtil.isNotBlank(xxfbWz.getLmwid())){
				hql += " and a.lmwid=?";
				params.add( xxfbWz.getLmwid() );
			}
			if( null != xxfbWz.getZhxgrqStart() ){
				hql += " and a.zhxgrq >= ?";
				params.add( xxfbWz.getZhxgrqStart() );
			}
			if( null != xxfbWz.getZhxgrqEnd() ){
				hql += " and a.zhxgrq <= ?";
				params.add( xxfbWz.getZhxgrqEnd() );
			}
			if(StringUtil.isNotBlank(xxfbWz.getState())){
				hql += " and a.state=?";
				params.add( xxfbWz.getState() );
			}
		}
		long c = getBaseDao().count("select count(*) as c " + hql, params.toArray());
		pager.setTotalRows(c);

		String hqlCol = "select new TXxfbWz(wid,(select lmmc from TXxfbLm where wid=a.lmwid) as lmwid, " +
				"bt, shrq, cjr, cjrq, " +
				"(select zdmc from TSysCode where zdbm=a.sfpl and zdlb='xxfb_plqx') as sfpl, " +
//				"(select zdmc from TSysCode where zdbm=a.ordernum and zdlb='xxfb_wzzd') as wzzd, " +
				"ordernum, (select count(*) from TXxfbPl where wzwid=a.wid) as pls, djs, " +
				"(select zdmc from TSysCode where zdbm=a.state and zdlb='xxfb_wzzt') as state, " +
				"zhxgrq, shyj, (select zdmc from TSysCode where zdbm=a.wzlx and zdlb='xxfb_wzlx') as wzlx) ";
		hql = hqlCol + hql +" order by a.wid desc";
		List<TXxfbWz> list = getBaseDao().findPageByHql(hql, pager, params.toArray());
		return list;
	}
	
	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#load(java.lang.Object)
	 */
	@Override
	public void load(Object arg0) throws Exception {
		CmsMyArticleAction action = (CmsMyArticleAction)arg0;

		String wid = action.getWid();
		TXxfbWz bean = getBaseDao().findById(TXxfbWz.class, wid);
		action.setTxxfbWz(bean);

	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#remove(java.lang.Object)
	 */
	@Override
	public boolean remove(Object arg0) throws Exception {
		CmsMyArticleAction action = (CmsMyArticleAction)arg0;
		String wid = action.getWid();
		String sqlwhere = DBUtil.spellSqlWhere("wid", "=", wid.split(","));
		String sql = "select count(*) from T_Xxfb_Wz where state=2 and " + sqlwhere;
		int i;
		boolean bool;
		try {
			i = DBUtil.count(sql);
			if(i>0){
				//已发布的不能删除
				throw new Exception( "已勾选记录中有已发布内容。已发布的不能删除" );
			}
			bool = getBaseDao().deleteAll("TXxfbPl", "wzwid", "=", wid);
			if( bool ){
				bool = getBaseDao().deleteAll("TXxfbWz", "wid", "=", wid);
			}
		} catch (SQLException e) {
			throw new Exception( e.getMessage() );
		}
		return bool;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#saveOrUpdate(java.lang.Object)
	 */
	@Override
	public void saveOrUpdate(Object arg0) throws Exception {
		CmsMyArticleAction action = (CmsMyArticleAction)arg0;

		TXxfbWz txxfbWz = action.getTxxfbWz();
		//有上传图片，先保存上传的图片
		File photo = action.getSyydt();
		if (photo != null) {
			// 有文件上传
			String str_maxphotosize = CommonQuery.getSysProperty(Constants.FILE_SIZE_PHOTO);//系统参数管理里设置的图片最大大小
			long maxPhotoSize;
			if (StringUtils.isBlank(str_maxphotosize)) {
				maxPhotoSize = Constants.FILE_SIZE_1M;// 用系统默认，已经按字节计算
			} else {
				maxPhotoSize = Integer.parseInt(str_maxphotosize) * 1024;// kb转为字节
			}
			FileUtil.checkFileIsImage(action.getSyydtContentType(), action.getSyydtFileName());
			FileUtil.checkFileSize(photo.length(), maxPhotoSize);
			String relativeHttpPath = FileUtil.saveFile(photo, "cms", action.getSyydtFileName());
			txxfbWz.setSyydt(relativeHttpPath);
		}
		
		txxfbWz.setBt( WordFilter.filter(txxfbWz.getBt()) );
		txxfbWz.setZy( WordFilter.filter(txxfbWz.getZy()) );
//		txxfbWz.setNr( WordFilter.filter(txxfbWz.getNr()) );
		//TODO 如果数据库用oracle10g及以后版本，都直接用上面一句话就可以了
		/****** 针对oracle9i数据特殊处理clob类型 ****/
		String nr = WordFilter.filter(txxfbWz.getNr());
		txxfbWz.setNr(null);
		/****** 针对oracle9i数据特殊处理clob类型 ****/
		
		if(StringUtil.isBlank(txxfbWz.getWid())){
			//do insert
			txxfbWz.setWid(SeqFactory.getNewSequenceAlone());
			txxfbWz.setDjs(0);
			txxfbWz.setCjr(action.getLoginuser().getUserid());
			txxfbWz.setCjrq(DateUtil.currentTime());
			txxfbWz.setZhxgrq(DateUtil.currentTime());
			if(StringUtil.isBlank(txxfbWz.getState())){//如果管理员操作，会选择一个值。空表示供稿人界面。
				txxfbWz.setState("0");
			}
			
			if(StringUtil.isBlank(txxfbWz.getSfpl())){
				String sfpl = getBaseDao().findFieldValue("select sfpl from TXxfbLm where wid=?", txxfbWz.getLmwid());
				txxfbWz.setSfpl(sfpl);//默认继承该栏目的评论权限
			}
			if(StringUtil.isBlank(txxfbWz.getSfsyxs())){
				txxfbWz.setSfsyxs("0");//默认不作为首页头条新闻
			}
			if(StringUtil.isBlank(txxfbWz.getSftj())){
				txxfbWz.setSftj("0");//普通推荐
			}
			
			getBaseDao().save(txxfbWz);
		}else{
			//do update
			Date cjrq = txxfbWz.getCjrq();
			txxfbWz.setCjrq(null);//避免此字段被动态生成的HQL更新
			txxfbWz.setZhxgrq( DateUtil.currentTime() );
			if (photo != null) {
				//删除老的图片
				String file = getBaseDao().findFieldValue("select syydt from TXxfbWz where wid=?", txxfbWz.getWid());
				FileUtil.deleteFileByRelativePath(file);
			}
			getBaseDao().updateNotNull(txxfbWz);
			txxfbWz.setCjrq(cjrq);//恢复创建日期传到页面显示
		}
		/****** 针对oracle9i数据特殊处理clob类型 ****/
		Connection conn = DBConn.getConnection();
		OldOlbSupport.updateClob(conn , "T_Xxfb_Wz", "nr", "wid='"+txxfbWz.getWid()+"'", nr);
		DBConn.close(conn);
		txxfbWz.setNr(nr);
		/****** 针对oracle9i数据特殊处理clob类型 ****/
	}

	/**
	 * 批量提交
	 */
	@Override
	public String changeState(Object myaction) throws Exception {
		
		CmsMyArticleAction action = (CmsMyArticleAction)myaction;
		String shzt = action.getRequest().getParameter("shzt");
		String ids = action.getWid();
		if(StringUtil.isBlank(ids) || StringUtil.isBlank(shzt)){

			return "操作失败：缺少参数";
		}
		String sqlwhere = DBUtil.spellSqlWhere("wid", "=", ids.split(","));
		String sql = null;
		if(shzt.equals("1")){//要提交勾选的数据，检查此时状态是不是有非草稿和非退回的
			sql = "select count(*) from T_Xxfb_Wz where (state!=0 and state!=-1) and " + sqlwhere;
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
		sql = "update T_Xxfb_Wz set state="+shzt+" where ";
		sql = sql + sqlwhere;
		i = DBUtil.executeOneoffSQL(sql);
		if(i>0){
			return "操作成功";
		}else{

			return "操作失败";
		}
	}
}
