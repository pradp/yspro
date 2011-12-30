package com.yszoe.biz.service.impl;

import java.io.File;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.yszoe.biz.Constants;
import com.yszoe.biz.action.HdNrAction;
import com.yszoe.biz.entity.THdNr;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.sys.util.CommonQuery;
import com.yszoe.util.DateUtil;
import com.yszoe.util.FileUtil;
import com.yszoe.util.StringUtil;

/**
 * 活动内容
 * @author Yangjianliang
 * datetime 2011-12-28
 */
public class HdNrServiceImpl extends AbstractBaseServiceSupport {

	/**
	 * 前台列表索引
	 * @param arg0
	 * @param pager
	 * @return
	 * @throws Exception
	 */
	public List<?> index(Object arg0, Pager pager) throws Exception {
		String hql = "from THdNr a ";
		long c = getBaseDao().count("select count(*) as c " + hql);
		pager.setTotalRows(c);
		String hqlCol = "select new THdNr(wid, bt, syydt, zzz, hddd, hdsj, jg, zdrs, zbfzz, " +
		"(select username from TSysUser where userid=a.cjr) as cjr, zhxgrq, djs, " +
				"(select zdmc from TSysCode where zdbm=a.hdlx and zdlb='hd_hdlx') as hdlx, " +
				"(select zdmc from TSysCode where zdbm=a.state and zdlb='hd_state') as state, shrq, " +
				"(select count(*) from THdBm where state=1 and hdwid=a.wid) as bmrs) ";  
		hql = hqlCol + hql +" order by a.wid desc";
		List<THdNr> list = getBaseDao().findByHql(hql);
		return list;
	}

	/**
	 * springmvc获取活动详情
	 * @param wid 活动主键
	 * @return
	 */
	public THdNr load(String wid) {

		THdNr bean = getBaseDao().findById(THdNr.class, wid);
		if( bean==null ){
			bean = new THdNr();
		}else{
			//更新点击量计数
			getBaseDao().executeHql("update THdNr set djs=djs+1 where wid=?", wid);
		}
		return bean;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#list(java.lang.Object, com.yszoe.framework.util.Pager)
	 */
	@Override
	public List<?> list(Object myaction, Pager pager) throws Exception {
		HdNrAction action = (HdNrAction)myaction;
		String hql = "from THdNr a ";
		long c = getBaseDao().count("select count(*) as c " + hql);
		pager.setTotalRows(c);
		String hqlCol = "select new THdNr(wid, bt, syydt, zzz, hddd, hdsj, jg, zdrs, zbfzz, " +
		"(select username from TSysUser where userid=a.cjr) as cjr, zhxgrq, djs, " +
				"(select zdmc from TSysCode where zdbm=a.hdlx and zdlb='hd_hdlx') as hdlx, " +
				"(select zdmc from TSysCode where zdbm=a.state and zdlb='hd_state') as state, shrq, " +
				"(select count(*) from THdBm where state=1 and hdwid=a.wid) as bmrs) ";  
		hql = hqlCol + hql +" order by a.wid desc";
		List<THdNr> list = getBaseDao().findByHql(hql);
		return list;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#load(java.lang.Object)
	 */
	@Override
	public void load(Object myaction) throws Exception {
		HdNrAction action = (HdNrAction)myaction;
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
	public boolean remove(Object myaction) throws Exception {
		HdNrAction action = (HdNrAction)myaction;
		String wid = action.getWid();
		getBaseDao().deleteAll("THdGsfx", "bmwid", "=", wid);//活动感受分享
		getBaseDao().deleteAll("THdZp", "hdwid", "=", wid);//活动照片
		getBaseDao().deleteAll("THdBm", "hdwid", "=", wid);//活动报名人员
		getBaseDao().deleteAll("THdNr", "wid", "=", wid);//活动内容
		return true;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#saveOrUpdate(java.lang.Object)
	 */
	@Override
	public void saveOrUpdate(Object myaction) throws Exception {
		HdNrAction action = (HdNrAction)myaction;
		THdNr thdNr = action.getThdNr();
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
			String relativeHttpPath = FileUtil.saveFile(photo, "activity", action.getSyydtFileName());
			thdNr.setSyydt(relativeHttpPath);
		}
		if(StringUtil.isBlank(thdNr.getWid())){
			thdNr.setWid(SeqFactory.getNewSequenceAlone());
			thdNr.setCjr(action.getLoginuser().getUserid());
			thdNr.setCjrq(new Date());
			thdNr.setZhxgrq(new Date());
			thdNr.setDjs( new Long(0) );
			getBaseDao().save(thdNr);
		}else{

			thdNr.setZhxgrq(new Date());
			getBaseDao().updateNotNull(thdNr);
		}
	}

	/**
	 * 批量审核 ；shlx 2通过 -2撤销 -1退回
	 */
	@Override
	public String changeState(Object myaction) throws Exception {
		
		HdNrAction action = (HdNrAction)myaction;
		String shzt = action.getRequest().getParameter("shzt");
		String ids = action.getWid();
		if(StringUtil.isBlank(ids) || StringUtil.isBlank(shzt)){

			return "操作失败：缺少参数";
		}
		String sqlwhere = DBUtil.spellSqlWhere("wid", "=", ids.split(","));
		String sql = null;
		if(shzt.equals("2")){//要审核通过勾选的数据，检查此时状态是不是有非待审核和非撤销的
			sql = "select count(*) from THdNr where (state!=1 and state!=-2) and " + sqlwhere;
		}else if(shzt.equals("-2")){//要撤销发布勾选的数据，检查此时状态是不是有非已审核通过的
			sql = "select count(*) from THdNr where state!=2 and " + sqlwhere;
		}else if(shzt.equals("-1")){//要退回勾选的数据，检查此时状态是不是待审核，或者已撤销
			sql = "select count(*) from THdNr where (state!=1 and state!=-2) and " + sqlwhere;
		}
		long i = getBaseDao().count(sql);
		if(i>0){//有非安全状态的数据，不能执行批量更新
			
			return "操作失败：已勾选记录的状态不能执行此操作";
		}
		String hql = "update THdNr set shrq=?, state=? where ";
		hql = hql + sqlwhere;
		i = getBaseDao().executeHql(hql, DateUtil.currentTime(), shzt);
		if(i>0){
			return "操作成功";
		}else{

			return "操作失败";
		}
	}
	
	public boolean removePic(Object myaction){

		HdNrAction action = (HdNrAction)myaction;
		String wid = action.getWid();
		String pic = getBaseDao().findFieldValue("select syydt from THdNr where wid=?", wid);
		FileUtil.deleteFileByRelativePath( pic );
		int i = getBaseDao().executeHql("update THdNr set syydt=null where wid=? ", wid);
		if(i>0){
			return true;
		}
		return false;
	}
}

