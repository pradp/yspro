package com.yszoe.cms.action;

import java.io.File;
import java.util.List;

import com.yszoe.cms.entity.TXxfbWz;
import com.yszoe.framework.util.DBUtil;
import com.yszoe.sys.action.AbstractBaseActionSupport;
import com.yszoe.sys.entity.ApplicationEnum;

/**
 * 信息发布文章管理
 * @author Yangjianliang
 * datetime 2011-7-4
 */
@SuppressWarnings("serial")
public class CmsMyArticleAction extends AbstractBaseActionSupport {

	private TXxfbWz txxfbWz;
	private File syydt;
	private String syydtContentType;
	private String syydtFileName;

	public TXxfbWz getTxxfbWz() {
		return txxfbWz;
	}

	public void setTxxfbWz(TXxfbWz txxfbWz) {
		this.txxfbWz = txxfbWz;
	}

	public File getSyydt() {
		return syydt;
	}

	public void setSyydt(File syydt) {
		this.syydt = syydt;
	}

	public String getSyydtContentType() {
		return syydtContentType;
	}

	public void setSyydtContentType(String syydtContentType) {
		this.syydtContentType = syydtContentType;
	}

	public String getSyydtFileName() {
		return syydtFileName;
	}

	public void setSyydtFileName(String syydtFileName) {
		this.syydtFileName = syydtFileName;
	}

	/**
	 * 允许网友供稿的栏目
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getCmsSortAllowFeeds(){
		
//		String hql = "select new ApplicationEnum(wid, lmmc) from TXxfbLm where state=1 and yxwygg=1";
//		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql);
		String sql = "SELECT wid id, DECODE( NVL(LEVEL2,0),0, SUBSTR('││││││',1,LEVEL1 - 1)||'└', " +
				"DECODE(LEVEL2 - LEVEL1, 0, SUBSTR('││││││',1,LEVEL1 - 1)||'├', 1,SUBSTR('││││││',1,LEVEL1 - 1)||'├', " +
				"SUBSTR('││││││',1,LEVEL1 - 1)||'└' ) )||lmmc caption FROM (SELECT wid,lmmc,parentwid, " +
				"LEVEL LEVEL1,LEAD(LEVEL,1) OVER (ORDER BY ROWNUM) LEVEL2 FROM t_xxfb_lm where state=1 and yxwygg=1 " +
				"CONNECT BY parentwid=PRIOR wid START WITH (parentwid='000' and state=1 and yxwygg=1) ORDER BY wid) ";
		List<ApplicationEnum> list = DBUtil.queryAllBeanList(sql, ApplicationEnum.class);
		return list;
	}

}
