package com.yszoe.cms.service.impl;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.ModelMap;

import com.yszoe.cms.entity.TXxfbPl;
import com.yszoe.cms.util.WordFilter;
import com.yszoe.framework.service.impl.AbstractBaseServiceSupport;
import com.yszoe.framework.util.Pager;
import com.yszoe.framework.util.SeqFactory;
import com.yszoe.identity.entity.TSysUser;

/**
 * 用户发表评论处理类
 * @author Yangjianliang
 * datetime 2011-7-27
 */
public class CmsPublicCommentServiceImpl extends AbstractBaseServiceSupport {

	private static final Log LOG = LogFactory.getLog(CmsPublicCommentServiceImpl.class);

	public void saveComment(String wzwid, String plnr, String plrip, TSysUser user, ModelMap modelMap) throws Exception {
		String sfpl = (String)getBaseDao().findFieldValue("select sfpl from TXxfbWz where wid=?", wzwid);
		if("2".equals(sfpl) && user == null){
			modelMap.put("msg", "请先登录");
		}else if("0".equals(sfpl)){
			modelMap.put("msg", "此文章禁用评论");
		}else {
			try {
				plnr = URLDecoder.decode(plnr, "utf-8");
			} catch (UnsupportedEncodingException e1) {
				LOG.error(e1);
			}
			TXxfbPl pl = new TXxfbPl();
			if(user!=null){//会员评论
				String plr = user.getUserid();
				pl.setPlr(plr);
			}else{
				//游客评论
			}
			plnr = WordFilter.filter( plnr );//过滤敏感词
			pl.setPlnr(plnr);
			pl.setPlrip(plrip);
			pl.setWzwid(wzwid);
			pl.setPlsj(new Date());
			pl.setState("1");
			pl.setWid(SeqFactory.getNewSequenceAlone());
			getBaseDao().save(pl);
			modelMap.put("msg", "ok");
		}
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#saveOrUpdate(java.lang.Object)
	 */
	@Override
	public void saveOrUpdate(Object myaction) throws Exception {
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#load(java.lang.Object)
	 */
	@Override
	public void load(Object myaction) throws Exception {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#list(java.lang.Object, com.yszoe.framework.util.Pager)
	 */
	@Override
	public List<?> list(Object myaction, Pager pager) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#remove(java.lang.Object)
	 */
	@Override
	public boolean remove(Object myaction) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

}
