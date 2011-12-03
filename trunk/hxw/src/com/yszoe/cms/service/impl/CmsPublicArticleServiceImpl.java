package com.yszoe.cms.service.impl;

import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.ui.ModelMap;

import com.yszoe.cms.entity.TXxfbLm;
import com.yszoe.cms.entity.TXxfbPl;
import com.yszoe.cms.entity.TXxfbWz;
import com.yszoe.cms.util.CachedQuery;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.Pager;
import com.yszoe.util.StringUtil;

/**
 * 网站前台查询文章 和spring rest mvc结合使用
 * 
 * @author Yangjianliang datetime 2011-7-8
 */
public class CmsPublicArticleServiceImpl extends AbstractBaseServiceSupport {
    
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yszoe.framework.service.BaseService#list(java.lang.Object,
	 * com.yszoe.framework.util.Pager)
	 */

	@Override
	public List<?> list(Object arg0, Pager pager) throws Exception {
		ModelMap model = (ModelMap) arg0;
		String channelpinyin = (String) model.get("channelpinyin");
		if (StringUtil.isBlank(channelpinyin)) {
			return Collections.EMPTY_LIST;
		}
		String channelid = CachedQuery.getCmsChannelIdByLmbm(channelpinyin);
		if(StringUtil.isBlank(channelid) && "search".equals(channelpinyin)){
			throw new RuntimeException("request channelid is blank.");
		}
		model.put("channelid", channelid);

		String hql = "from TXxfbWz a where a.state=2";// 状态为已发布的数据

		List<Object> params = new LinkedList<Object>();

		if ("search".equals(channelpinyin)) {
			// 执行全频道搜索
			TXxfbLm lm = new TXxfbLm();
			lm.setLmmc("搜索结果");
			model.put("lmbean", lm);
		} else {
			// 查询某频道数据
			hql += " and a.lmwid like ?";
			params.add(channelid + "%");
			String hql_lmmc = "from TXxfbLm where wid=?";
			List<TXxfbLm> lmmcs = getBaseDao().findByHqlWithSecondCache(true, hql_lmmc, channelid);
			if (lmmcs.isEmpty() == false) {
				TXxfbLm lm = lmmcs.get(0);
				model.put("lmbean", lm);
			}
		}

		if (StringUtil.isNotBlank((String) model.get("bt"))) {
			hql += " and a.bt like ?";
			params.add("%" + (String) model.get("bt") + "%");
		}
		long c = getBaseDao().count("select count(*) as c " + hql, params.toArray());
		pager.setTotalRows(c);

		String hqlCol = "select new TXxfbWz(wid,(select lmmc from TXxfbLm where wid=a.lmwid) as lmwid, "
				+ "bt, ly, sftj, ordernum, (select count(*) from TXxfbPl where wzwid=a.wid) as pls, "
				+ "zhxgrq, djs, wzlx, bturl) ";
		hql = hqlCol + hql + " order by a.ordernum desc, a.wid desc";
		List<TXxfbWz> list = getBaseDao().findPageByHql(hql, pager, params.toArray());
		return list;
	}

	/**
	 * 首页portlet展示用的数据 取某栏目下最新的10条新闻
	 * 
	 * @param channelid
	 * @return
	 */
	public List<TXxfbWz> listTop(String channelid) {
		if (StringUtil.isBlank(channelid)) {
			return Collections.emptyList();
		}
		String hql = "from TXxfbWz a where a.state=2 and a.lmwid=?";// 状态为已发布的数据
		List<Object> params = new LinkedList<Object>();
		params.add(channelid);
		Pager pager = new Pager();
		pager.setCurrentPageno(1);// 返回前10条

		String hqlCol = "select new TXxfbWz(wid,(select lmmc from TXxfbLm where wid=a.lmwid) as lmwid, "
				+ "bt, ly, sftj, (select count(*) from TXxfbPl where wzwid=a.wid) as pls, "
				+ "zhxgrq, djs, wzlx, bturl) ";
		hql = hqlCol + hql + " order by a.wid desc";
		List<TXxfbWz> list = getBaseDao().findPageByHql(hql, pager, params.toArray());
		return list;
	}

	/**
	 * 取某栏目下最新的10条新闻
	 * 
	 * @param channelid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<TXxfbWz> getRSSData(String channelid) {
		if (StringUtil.isBlank(channelid)) {
			return Collections.emptyList();
		}
		Pager pager = new Pager();
		pager.setCurrentPageno(1);// 返回前10条

		String sql = "select wid, bt, ly, zhxgrq, djs, zy from T_XXFB_WZ a where a.state=2 and a.lmwid=? order by a.wid desc";// 状态为已发布的数据
		List<TXxfbWz> list = (List<TXxfbWz>) DBUtil.queryPageBeanList(pager, sql, TXxfbWz.class, channelid);
		return list;
	}

	/**
	 * 提供给spring mvc使用。前台页面查看文章内容
	 * 
	 * @param model
	 * @throws Exception
	 */
	// @SuppressWarnings("unchecked")
	@Override
	public void load(Object arg0) throws Exception {
		ModelMap model = (ModelMap) arg0;
		String wid = (String) model.get("wid");
		TXxfbWz bean = getBaseDao().findById(TXxfbWz.class, wid);
		if (bean == null) {
			bean = new TXxfbWz();
		} else {
			// 更新点击量计数
			getBaseDao().executeHql("update TXxfbWz set djs=djs+1 where wid=?", wid);
		}
		model.addAttribute("entityBean", bean);
		/********************* 相关新闻 *****************************/
		if (StringUtil.isNotBlank(bean.getGjz())) {
			String[] gjz = bean.getGjz().split(" ");
			for (int i = 0; i < gjz.length; i++) {
				String string = gjz[i];
				string = "%" + string;
				gjz[i] = string;
			}
			Pager pager_tmp = new Pager();
			pager_tmp.setCurrentPageno(1);
			pager_tmp.setEachPageRows(5);// 设置查最新的前5条记录
			String hql = "from TXxfbWz where wid!=? and " + DBUtil.spellSqlWhere("gjz", "like", gjz)
					+ " order by wid desc";
			List<TXxfbWz> relationNews = getBaseDao().findPageByHql(hql, pager_tmp, wid);
			model.addAttribute("relationNews", relationNews);
		}
		/********************* 评论信息 *****************************/
		Pager pager = (Pager) model.get("pager");
		long pls = getBaseDao().count("select count(*) from TXxfbPl where wzwid=? and state=1", wid);
		bean.setPls(pls);
		pager.setTotalRows(bean.getPls());
		if (bean.getPls() > 0) {
			if (pager.getEachPageRows() == 0) {
				pager.setEachPageRows(1);
			}
			// pager.setCurrentPageno(currentPageno);
			String hql = "select new TXxfbPl(wid, plr, (select username from TSysUser u where u.userid=plr) as plrName, plnr, plsj) from TXxfbPl where wzwid=? and state=1";

			List<TXxfbPl> comments = getBaseDao().findPageByHql(hql, pager, wid);
			model.addAttribute("comments", comments);
		}
		// 查看文章分类
		String wzfl = "select a.lmmc from TXxfbLm a,TXxfbWz b where a.wid = b.lmwid and b.wid = ?";
		String lmmc = (String) getBaseDao().findFieldValue(wzfl, wid);
		if (StringUtils.isNotBlank(lmmc)) {
			TXxfbLm txxfblm = (TXxfbLm) getBaseDao().findFieldValue("from TXxfbLm where lmmc = ?", lmmc);
			model.addAttribute("wzEntityBean", txxfblm);
		}
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.yszoe.framework.service.BaseService#remove(java.lang.Object)
	 */
	@Override
	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.yszoe.framework.service.BaseService#saveOrUpdate(java.lang.Object)
	 */
	@Override
	public void saveOrUpdate(Object arg0) throws Exception {
		// TODO Auto-generated method stub

	}

}
