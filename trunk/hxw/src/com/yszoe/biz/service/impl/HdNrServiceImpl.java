package com.yszoe.biz.service.impl;

import java.util.Collections;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.yszoe.biz.Constants;
import com.yszoe.biz.action.HdNrAction;
import com.yszoe.biz.entity.THdNr;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.sys.util.CommonQuery;
import com.yszoe.util.ControllerUtil;
import com.yszoe.util.DateUtil;
import com.yszoe.util.FileUtil;
import com.yszoe.util.StringUtil;

/**
 * 活动内容 spring mvc的业务类
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
	public THdNr detail(String wid) {

		THdNr bean = getBaseDao().findById(THdNr.class, wid);
		if( bean==null ){
			bean = new THdNr();
		}else{
			//更新点击量计数
			getBaseDao().executeHql("update THdNr set djs=djs+1 where wid=?", wid);
		}
		return bean;
	}

	/**
	 * 用户管理自己发布的活动信息
	 * @param model
	 * @param request
	 * @param pager
	 * @return
	 */
	public List<?> list(ModelMap model, HttpServletRequest request, Pager pager){

		StringBuilder hql = new StringBuilder("from THdNr a where cjr=?");
		List<Object> params = new LinkedList<Object>();
		params.add( ControllerUtil.getLoginUserid(request) );
		
		THdNr thdNr = (THdNr) model.get("thdNr");
		if(thdNr!=null){
			if( StringUtils.isNotBlank(thdNr.getBt()) ){
				hql.append(" and a.bt like ?");
				params.add("%"+thdNr.getBt()+"%");
			}
			if( null != thdNr.getZhxgrqStart() ){
				hql.append(" and a.zhxgrq >= ?");
				params.add( thdNr.getZhxgrqStart() );
			}
			if( null != thdNr.getZhxgrqEnd() ){
				hql.append(" and a.zhxgrq <= ?");
				params.add( thdNr.getZhxgrqEnd() );
			}
			if(StringUtil.isNotBlank(thdNr.getState())){
				hql.append(" and a.state=?");
				params.add( thdNr.getState() );
			}
		}
		long c = getBaseDao().count("select count(*) as c " + hql, params.toArray());
		pager.setTotalRows(c);
		String hqlCol = "select new THdNr(wid, bt, syydt, zzz, hddd, hdsj, jg, zdrs, zbfzz, " +
		"(select username from TSysUser where userid=a.cjr) as cjr, zhxgrq, djs, " +
				"(select zdmc from TSysCode where zdbm=a.hdlx and zdlb='hd_hdlx') as hdlx, " +
				"(select zdmc from TSysCode where zdbm=a.state and zdlb='hd_state') as state, shrq, " +
				"(select count(*) from THdBm where state=1 and hdwid=a.wid) as bmrs) ";

		hql.insert(0, hqlCol ).append(" order by a.wid desc");
		List<THdNr> list = getBaseDao().findPageByHql(hql.toString(), pager, params.toArray());
		return list;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#list(java.lang.Object, com.yszoe.framework.util.Pager)
	 */
	@Override
	@Deprecated
	public List<?> list(Object arg0, Pager pager) throws Exception {
		return Collections.EMPTY_LIST;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#load(java.lang.Object)
	 */
	@Override
	public void load(Object arg) throws Exception {
		ModelMap model = (ModelMap)arg;
		String wid = (String)model.get("wid");
		THdNr bean = getBaseDao().findById(THdNr.class, wid);
		model.put("bean", bean);
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#remove(java.lang.Object)
	 */
	@Override
	public boolean remove(Object arg) throws Exception {
		ModelMap model = (ModelMap)arg;
		String wid = (String)model.get("wid");
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
	public void saveOrUpdate(Object arg) throws Exception {
		ModelMap model = (ModelMap)arg;
		THdNr thdNr = (THdNr) model.get("bean");
		//有上传图片，先保存上传的图片
		MultipartHttpServletRequest request = (MultipartHttpServletRequest) model.get("request");
//		File photo = action.getSyydt();
		List<MultipartFile> files = request.getFiles("file");
		for (int i = 0; i < files.size(); i++) {
			if (!files.get(i).isEmpty()) {
				// 有文件上传
				MultipartFile file = files.get(i);
				String str_maxphotosize = CommonQuery.getSysProperty(Constants.FILE_SIZE_PHOTO);//系统参数管理里设置的图片最大大小
				long maxPhotoSize;
				if (StringUtils.isBlank(str_maxphotosize)) {
					maxPhotoSize = Constants.FILE_SIZE_1M;// 用系统默认，已经按字节计算
				} else {
					maxPhotoSize = Integer.parseInt(str_maxphotosize) * 1024;// kb转为字节
				}
				FileUtil.checkFileIsImage(file.getContentType(), file.getOriginalFilename());
				FileUtil.checkFileSize(file.getSize(), maxPhotoSize);
				String relativeHttpPath = FileUtil.saveFile(file.getInputStream(), "activity", file.getOriginalFilename());
				thdNr.setSyydt(relativeHttpPath);
			}
		}
		
		if(StringUtil.isBlank(thdNr.getWid())){
			thdNr.setWid(SeqFactory.getNewSequenceAlone());
			thdNr.setCjr(ControllerUtil.getLoginUserid(request));
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
	public String changeState(Object arg) throws Exception {

		ModelMap model = (ModelMap)arg;
		HttpServletRequest request = (HttpServletRequest)model.get("request");
		String shzt = request.getParameter("shzt");
		String ids = request.getParameter("wid");
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

