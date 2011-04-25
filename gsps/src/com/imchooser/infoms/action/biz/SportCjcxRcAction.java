package com.imchooser.infoms.action.biz;

import java.util.List;

import com.imchooser.infoms.action.sys.BaseActionAbstractSupport;
import com.imchooser.infoms.entity.biz.TSportCjTdHz;
import com.imchooser.infoms.entity.biz.TSportSsrc;
import com.imchooser.infoms.service.biz.impl.SportCjcxRcServiceImpl;

@SuppressWarnings("serial")
public class SportCjcxRcAction extends BaseActionAbstractSupport {

	private TSportCjTdHz sportCjTdHz;
	private List<TSportCjTdHz> listSportCjTdHz;
	private String dxmmc;
	private String bssj;
	private TSportSsrc sportSsrc;
	private String sfjsbs;
	private String paixu; //排序类别 0:时间排序 ； 1:小项目排序
	public TSportCjTdHz getSportCjTdHz() {
		return sportCjTdHz;
	}
	public void setSportCjTdHz(TSportCjTdHz sportCjTdHz) {
		this.sportCjTdHz = sportCjTdHz;
	}
	public List<TSportCjTdHz> getListSportCjTdHz() {
		return listSportCjTdHz;
	}
	public void setListSportCjTdHz(List<TSportCjTdHz> listSportCjTdHz) {
		this.listSportCjTdHz = listSportCjTdHz;
	}
	public String getDxmmc() {
		return dxmmc;
	}
	public void setDxmmc(String dxmmc) {
		this.dxmmc = dxmmc;
	}
	public String getBssj() {
		return bssj;
	}
	public void setBssj(String bssj) {
		this.bssj = bssj;
	}
	public TSportSsrc getSportSsrc() {
		return sportSsrc;
	}
	public void setSportSsrc(TSportSsrc sportSsrc) {
		this.sportSsrc = sportSsrc;
	}
	public String getSfjsbs() {
		return sfjsbs;
	}
	public void setSfjsbs(String sfjsbs) {
		this.sfjsbs = sfjsbs;
	}
	public String getPaixu() {
		return paixu;
	}
	public void setPaixu(String paixu) {
		this.paixu = paixu;
	}
	/*
	 * 查看团队人员
	 */
	public String  tdry(){
		SportCjcxRcServiceImpl service = (SportCjcxRcServiceImpl) getBaseService();
/*		this.setParameter("shzt", this.getParameter("shzt"));
		this.setParameter("scbm", this.getParameter("scbm"));
		this.setParameter("isjtxm", this.getParameter("isjtxm"));*/
		try {
			service.tdry(this);
		} catch (Exception e) {
			addActionError(e.getMessage());
		}
		return "tdry";
	}
}
