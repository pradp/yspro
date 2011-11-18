package com.yszoe.cms.action;

import java.util.List;

import com.yszoe.cms.service.impl.CmsApproveArticleServiceImpl;
import com.yszoe.framework.util.DBUtil;
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
//		String hql = "select new ApplicationEnum(wid, lmmc) from TXxfbLm where state=1";
//		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql);
		String sql = "SELECT wid id, DECODE( NVL(LEVEL2,0),0, SUBSTR('││││││',1,LEVEL1 - 1)||'└', " +
		"DECODE(LEVEL2 - LEVEL1, 0, SUBSTR('││││││',1,LEVEL1 - 1)||'├', 1,SUBSTR('││││││',1,LEVEL1 - 1)||'├', " +
		"SUBSTR('││││││',1,LEVEL1 - 1)||'└' ) )||lmmc caption FROM (SELECT wid,lmmc,parentwid, " +
		"LEVEL LEVEL1,LEAD(LEVEL,1) OVER (ORDER BY ROWNUM) LEVEL2 FROM t_xxfb_lm where state=1 " +
		"CONNECT BY parentwid=PRIOR wid START WITH (parentwid='000' and state=1) ORDER BY wid) ";
		List<ApplicationEnum> list = DBUtil.queryAllBeanList(sql, ApplicationEnum.class);
		return list;
	}

	public void removePic(){
		CmsApproveArticleServiceImpl service = (CmsApproveArticleServiceImpl)getBaseService();
		boolean success = service.removePic(this);
		putResultStringToView(success?"ok":"删除失败！");//直接返回字符串，不需要视图了。客户端AJAX
	}
}
