package com.yszoe.cms.service.impl;

import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.rsslibj.elements.Channel;
import com.rsslibj.elements.Item;
import com.yszoe.cms.entity.TXxfbLm;
import com.yszoe.cms.entity.TXxfbWz;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;

/**
 * 展示某栏目下的文章
 * 前台的频道页面
 * @author Yangjianliang
 * datetime 2011-7-27
 */
public class CmsPublicChannelRSSServiceImpl extends AbstractBaseServiceSupport {

	private static final Log LOG = LogFactory.getLog(CmsPublicChannelRSSServiceImpl.class);
	
	private CmsPublicArticleServiceImpl cmsPublicArticleService;

	public CmsPublicArticleServiceImpl getCmsPublicArticleService() {
		return cmsPublicArticleService;
	}

	public void setCmsPublicArticleService(CmsPublicArticleServiceImpl cmsPublicArticleService) {
		this.cmsPublicArticleService = cmsPublicArticleService;
	}

	/**
	 * 获取某个栏目的最新RSS源
	 * @param channelid
	 * @param model
	 * @return
	 */
	public String getRSS(String channelid){
		
		TXxfbLm lm = getBaseDao().findById(TXxfbLm.class, channelid);
		Channel channel = new Channel();
		channel.setDescription( "" + lm.getMemo());
		channel.setLink("../channel/" + lm.getWid() + ".jhtm");
		channel.setTitle(lm.getLmmc() + "最新源");
		List<TXxfbWz> articles = cmsPublicArticleService.getRSSData(channelid);
		Iterator<TXxfbWz> it = articles.iterator();
		while(it.hasNext()) {
			TXxfbWz wz = it.next();
		    Item item = new Item();
		    item.setDescription(wz.getZy());
		    item.setTitle( wz.getBt() );
		    item.setLink("../html/" + wz.getWid() + ".jhtm");
		    item.addCategory(lm.getLmmc());
		    channel.addItem( item );
		}
		String rss = null;
		try {
			rss = channel.getFeed("2.0");
		} catch (InstantiationException e) {
			LOG.error(e);
		} catch (IllegalAccessException e) {
			LOG.error(e);
		} catch (ClassNotFoundException e) {
			LOG.error(e);
		}
		return rss;
	}
	
	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#list(java.lang.Object, com.yszoe.framework.util.Pager)
	 */
	public List<?> list(Object arg0, Pager pager) throws Exception {

		return null;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#load(java.lang.Object)
	 */
	public void load(Object arg0) throws Exception {
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#remove(java.lang.Object)
	 */
	public boolean remove(Object arg0) throws Exception {
		return false;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#saveOrUpdate(java.lang.Object)
	 */
	public void saveOrUpdate(Object arg0) throws Exception {
		
	}

}
