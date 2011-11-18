package com.yszoe.cms.action;

import java.util.List;

import com.yszoe.cms.entity.TXxfbPl;
import com.yszoe.sys.action.AbstractBaseActionSupport;
import com.yszoe.sys.entity.ApplicationEnum;

/**
 * 信息发布 评论管理
 * @author Yangjianliang
 * datetime 2011-7-4
 */
public class CmsMyCommentAction extends AbstractBaseActionSupport {

	private TXxfbPl txxfbPl;

	public TXxfbPl getTxxfbPl() {
		return txxfbPl;
	}

	public void setTxxfbPl(TXxfbPl txxfbPl) {
		this.txxfbPl = txxfbPl;
	}

	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getCmsSort(){
		String hql = "select new ApplicationEnum(wid, lmmc) from TXxfbLm where state=1";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql);
		return list;
	}

}
