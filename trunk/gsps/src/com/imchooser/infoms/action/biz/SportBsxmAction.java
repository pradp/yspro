package com.imchooser.infoms.action.biz;

import java.util.List;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.entity.sys.ApplicationEnum;

/*
 **比赛项目
 * 
 * @author DaiQinggao
 * @date 2010-03-22
 */
@SuppressWarnings("serial")
public class SportBsxmAction extends BaseActionAbstractSupport {

	private TSportBsxm tsportBsxm;
	public TSportBsxm getTsportBsxm() {
		return tsportBsxm;
	}
	public void setTsportBsxm(TSportBsxm tsportBsxm) {
		this.tsportBsxm = tsportBsxm;
	}
	
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getDxmmcList() throws Exception {
		String hql = "select new ApplicationEnum(max(a.wid),max(a.dxmmc))"
		    + " from TSportBsxm a where 1=1 group by a.dxmmc order by max(a.wid) desc ";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql); 
		return list;
	}
	
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getXxmmcList() throws Exception {
		String hql = "select new ApplicationEnum(max(a.wid),max(a.xxmmc))"
		    + " from TSportBsxm a where 1=1 group by a.xxmmc order by max(a.wid) desc ";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql); 
		return list;
	}
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getXmdjList() throws Exception {
		String hql = "select new ApplicationEnum(a.xmdj,(select c.zdmc from TSysCode c where c.zdbm=a.xmdj and c.zdlb='BSXM_XMDJ'))"
		    + " from TSportBsxm a where 1=1 group by a.xmdj order by a.xmdj asc ";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql); 
		return list;
	}
}
