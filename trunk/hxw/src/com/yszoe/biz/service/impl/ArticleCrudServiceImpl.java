package com.yszoe.biz.service.impl;

import java.net.URLDecoder;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.ModelMap;

import com.yszoe.cms.entity.TXxfbWz;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.util.StringUtil;

/**
 * spring crud example
 * @author Yangjianliang
 * datetime 2011-9-9
 */
public class ArticleCrudServiceImpl extends AbstractBaseServiceSupport {

	private static final Log LOG = LogFactory.getLog(ArticleCrudServiceImpl.class);

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#list(java.lang.Object, com.yszoe.framework.util.Pager)
	 */
	@Override
	public List<?> list(Object arg0, Pager pager) throws Exception {
		ModelMap model = (ModelMap)arg0;
		HttpServletRequest request = (HttpServletRequest)model.get("request");
		String bt = (String)request.getParameter("bt");

		String hql = "from TXxfbWz a where a.state=2";//状态为已发布的数据

		List<Object> params = new LinkedList<Object>();
		if(StringUtil.isNotBlank(bt)){
			bt = URLDecoder.decode(bt, "utf-8");
			
			hql += " and a.bt like ?";
			params.add("%" + bt + "%");
			
			model.put("bt", bt);
		}
		long c = getBaseDao().count("select count(*) as c " + hql, params.toArray());
		pager.setTotalRows(c);

		String hqlCol = "select new TXxfbWz(wid,(select lmmc from TXxfbLm where wid=a.lmwid) as lmwid, " +
				"bt, ly, sftj, ordernum, (select count(*) from TXxfbPl where wzwid=a.wid) as pls, " +
				"zhxgrq, djs, wzlx, bturl) ";
		hql = hqlCol + hql +" order by a.ordernum desc, a.wid desc";
		List<TXxfbWz> list = getBaseDao().findPageByHql(hql, pager, params.toArray());
		return list;
	}

	@Override
	public void openCreate(Object myaction) throws Exception {
		ModelMap model = (ModelMap)myaction;
		model.addAttribute("entityBean", new TXxfbWz());
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#load(java.lang.Object)
	 */
	@Override
	public void load(Object arg0) throws Exception {
		ModelMap model = (ModelMap)arg0;
		String wid = (String)model.get("wid");
		TXxfbWz bean = getBaseDao().findById(TXxfbWz.class, wid);
		if( bean==null ){
			bean = new TXxfbWz();
		}else{
			//更新点击量计数
			getBaseDao().executeHql("update TXxfbWz set djs=djs+1 where wid=?", wid);
		}
		model.addAttribute("entityBean", bean);

	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#remove(java.lang.Object)
	 */
	@Override
	public boolean remove(Object arg0) throws Exception {
		ModelMap model = (ModelMap)arg0;
		String wid = (String)model.get("wid");
		boolean f = getBaseDao().deleteAll("TXxfbWz", "wid", "=", wid);
		return f;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#saveOrUpdate(java.lang.Object)
	 */
	@Override
	public void saveOrUpdate(Object myaction) throws Exception {
		ModelMap model = (ModelMap)myaction;
		HttpServletRequest request = (HttpServletRequest)model.get("request");
		TXxfbWz xxfbWz = (TXxfbWz)model.get("entityBean");
//		String bt = (String)request.getParameter("bt");
//		String nr = (String)request.getParameter("nr");
		if(StringUtil.isBlank(xxfbWz.getWid())){
			xxfbWz.setWid(SeqFactory.getNewSequenceAlone());
			xxfbWz.setLmwid("2011");
			xxfbWz.setCjr("999999");
			xxfbWz.setCjrq(new Date());
			getBaseDao().save(xxfbWz);
		}else{
			getBaseDao().updateNotNull(xxfbWz);
		}
		
		request.setAttribute("entityBean", xxfbWz);
	}

}
