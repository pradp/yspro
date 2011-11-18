package com.yszoe.cms.service.impl;

import java.util.List;

import com.yszoe.framework.util.Pager;

/**
 * 信息发布模块  -- 管理员编写的文章
 * 继承于供稿人java类
 * @author Yangjianliang
 * datetime 2011-7-4
 */
public class CmsAdminArticleServiceImpl extends CmsApproveArticleServiceImpl {

//	private static final Log LOG = LogFactory.getLog(CmsArticleApproveServiceImpl.class);

	/* (non-Javadoc)
	 * @see com.yszoe.framework.service.BaseService#list(java.lang.Object, com.yszoe.framework.util.Pager)
	 */
	@Override
	public List<?> list(Object arg0, Pager pager) throws Exception {
		
		return getList(arg0, pager, 1);//1是维护自己的文章
	}
	
}
