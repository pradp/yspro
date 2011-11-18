package com.yszoe.cms.action;

import java.util.List;

import com.yszoe.cms.service.impl.CmsApproveArticleServiceImpl;
import com.yszoe.sys.entity.ApplicationEnum;

/**
 * 信息发布文章审核
 * 管理员界面
 * @author Yangjianliang
 * datetime 2011-7-4
 */
@SuppressWarnings("serial")
public class CmsApproveArticleAction extends CmsMyArticleAction {

	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getCmsSort(){
		String hql = "select new ApplicationEnum(wid, lmmc) from TXxfbLm where state=1";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql);
		return list;
	}

	public void removePic(){
		CmsApproveArticleServiceImpl service = (CmsApproveArticleServiceImpl)getBaseService();
		boolean success = service.removePic(this);
		putResultStringToView(success?"ok":"删除失败！");//直接返回字符串，不需要视图了。客户端AJAX
	}
}
