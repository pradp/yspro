package com.imchooser.infoms.action.biz;

import java.io.UnsupportedEncodingException;
import java.util.List;

import com.imchooser.framework.util.DBUtil;
import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.entity.biz.TSportCjJt;
import com.imchooser.infoms.entity.biz.TSportCjYdy;
import com.imchooser.infoms.entity.sys.ApplicationEnum;

/*
 **比赛项目
 * 
 * @author DaiQinggao
 * @date 2010-03-22
 */
@SuppressWarnings("serial")
public class SportSxMxYLAction extends BaseActionAbstractSupport {


	private TSportCjYdy sportCjYdy;
	private List<TSportCjYdy> listSportCjYdy;
	private TSportBsxm sportBsxm;
	private List<TSportCjJt> jts;
	private List<Object[]> objsTd;
	private List<Object[]> objsSx;
	public TSportCjYdy getSportCjYdy() {
		return sportCjYdy;
	}

	public void setSportCjYdy(TSportCjYdy sportCjYdy) {
		this.sportCjYdy = sportCjYdy;
	}

	public List<TSportCjYdy> getListSportCjYdy() {
		return listSportCjYdy;
	}

	public void setListSportCjYdy(List<TSportCjYdy> listSportCjYdy) {
		this.listSportCjYdy = listSportCjYdy;
	}

	public TSportBsxm getSportBsxm() {
		return sportBsxm;
	}

	public void setSportBsxm(TSportBsxm sportBsxm) {
		this.sportBsxm = sportBsxm;
	}
	
	

	public List<TSportCjJt> getJts() {
		return jts;
	}

	public void setJts(List<TSportCjJt> jts) {
		this.jts = jts;
	}


	public List<Object[]> getObjsTd() {
		return objsTd;
	}

	public void setObjsTd(List<Object[]> objsTd) {
		this.objsTd = objsTd;
	}

	public List<Object[]> getObjsSx() {
		return objsSx;
	}

	public void setObjsSx(List<Object[]> objsSx) {
		this.objsSx = objsSx;
	}

	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getBsxmZb() throws UnsupportedEncodingException{
		String bsxm = this.getParameter("bsxm");
		String hql = "select new ApplicationEnum(t.zdbm,t.zdmc) from TSysCode t where t.zdlb='BSXM_ZB'  and t.zdbm in (select a.zb from TSportBsxm a where a.dxmmc='"+bsxm+"' ) group by t.zdmc,t.zdbm ";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql);
		return list;
	}
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getBsxmXbz() throws UnsupportedEncodingException{
		String bsxm = this.getParameter("bsxm");
		String hql = "select new ApplicationEnum(t.zdbm,t.zdmc) from TSysCode t where t.zdlb='BSXM_XBZ' and t.zdbm in (select a.xbz from TSportBsxm a where a.dxmmc='"+bsxm+"' ) group by t.zdmc,t.zdbm ";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql);
		return list;
	}
	
	/**
	 * 获得小项目
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getBsxmByName() throws UnsupportedEncodingException{
		String bsxm = this.getParameter("bsxm");
		String sql = "select xxmmc as id,xxmmc as caption from T_Sport_Bsxm a where a.dxmmc=? group by a.xxmmc order by  f_pinyin(xxmmc),xxmmc";
		List<ApplicationEnum> list = (List<ApplicationEnum>)DBUtil.queryAllBeanList(sql, ApplicationEnum.class, bsxm);
		return list;
	}
	/**
	 * 获得赛次
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	@SuppressWarnings("unchecked")
	public List<ApplicationEnum> getBsxmSc() throws UnsupportedEncodingException{
		String hql = "select new ApplicationEnum(a.zdbm,a.zdmc) from TSysCode a where a.zdlb='SSRC_SCBM' ";
		List<ApplicationEnum> list = applicationEnumService.getApplicationEnums(true, hql);
		return list;
	}
	
	public String  xzcsz(){
		this.setParameter("type", this.getParameter("type"));
		this.setParameter("scbm", this.getParameter("scbm"));
		this.setParameter("djjydh", this.getParameter("djjydh"));
		this.setParameter("departid", this.getParameter("departid"));
		return "xzcsz";
	}
}
