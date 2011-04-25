package com.imchooser.infoms.entity.biz;

import java.util.Date;

/**
 * TSportSsrc entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class TSportSsrc implements java.io.Serializable {

	// Fields

	private String wid;
	private String xmbm;
	private String cjdw;
	private Date bssj;
	private String bpfz;
	private String scbm;
	private String scbmQuery;//虚拟字段,批量修改赛程界面用
	private String bscd;
	private String cdzy;
	private String sysc;
	private String xysc;
	private Byte djjd;
	private String xmmc;//手工添加 项目名称
	private String startTime;  //
	private String endTime; //
	private String count; //项目场数    手工添加  非持久化
	private String dxmmc;
	private String xxmmc;
	private String zb;
	private String xbz;
	private String xmdj;
	private String fbzt;
	private String sfxnsc;
	private String bssj1;//手动添加 非持久化
	private Date fbsj;
	private String shyj;
	// Constructors

	
	/** default constructor */
	public TSportSsrc() {
	}

	/** minimal constructor */
	public TSportSsrc(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public TSportSsrc(String wid, String xmbm, String cjdw, Date bssj, String bpfz, String scbm, String bscd,
			String cdzy, String sysc, String xysc, Byte djjd) {
		this.wid = wid;
		this.xmbm = xmbm;
		this.cjdw = cjdw;
		this.bssj = bssj;
		this.bpfz = bpfz;
		this.scbm = scbm;
		this.bscd = bscd;
		this.cdzy = cdzy;
		this.sysc = sysc;
		this.xysc = xysc;
		this.djjd = djjd;
	}

//首页面快速导航栏  （今日赛程）
	public TSportSsrc(String dxmmc,  String count) {
		this.dxmmc = dxmmc;
		this.count = count;
	}

	public TSportSsrc(String wid, String xmbm, String cjdw, Date bssj, String bpfz, String scbm, String bscd,String cdzy) {
		this.wid = wid;
		this.xmbm = xmbm;
		this.cjdw = cjdw;
		this.bssj = bssj;
		this.bpfz = bpfz;
		this.scbm = scbm;
		this.bscd = bscd;
		this.cdzy = cdzy;

	}
   //SsrcServiceImpl 中的List()
	public TSportSsrc(String wid, String xmbm, String dxmmc, String xxmmc, String zb, String xbz, String xmdj,
			String cjdw, Date bssj, String bpfz, String scbm, String bscd, String cdzy,String fbzt) {
		this.wid = wid;
		this.xmbm = xmbm;
		this.cjdw = cjdw;
		this.bssj = bssj;
		this.bpfz = bpfz;
		this.scbm = scbm;
		this.bscd = bscd;
		this.cdzy = cdzy;
		this.dxmmc = dxmmc;
		this.xxmmc = xxmmc;
		this.zb = zb;
		this.xbz = xbz;
		this.xmdj = xmdj;
		this.fbzt = fbzt;
	}

   //SsrcServiceImpl 中的load()
	public TSportSsrc(String wid, String xmbm, String dxmmc, String xxmmc, String zb, String xbz, String xmdj,
			String cjdw, Date bssj, String bpfz, String scbm, String bscd, String cdzy,
			String sysc,String xysc,Byte djjd,String sfxnsc) {
		this.wid = wid;
		this.xmbm = xmbm;
		this.cjdw = cjdw;
		this.bssj = bssj;
		this.bpfz = bpfz;
		this.scbm = scbm;
		this.bscd = bscd;
		this.cdzy = cdzy;
		this.dxmmc = dxmmc;
		this.xxmmc = xxmmc;
		this.zb = zb;
		this.xbz = xbz;
		this.xmdj = xmdj;
		this.sysc = sysc;
		this.xysc = xysc;
		this.djjd = djjd;
		this.sfxnsc = sfxnsc;
	}
	// Property accessors

	public String getWid() {
		return this.wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	public String getXmbm() {
		return this.xmbm;
	}

	public void setXmbm(String xmbm) {
		this.xmbm = xmbm;
	}

	public String getCjdw() {
		return this.cjdw;
	}

	public void setCjdw(String cjdw) {
		this.cjdw = cjdw;
	}

	public Date getBssj() {
		return this.bssj;
	}

	public void setBssj(Date bssj) {
		this.bssj = bssj;
	}

	public String getBpfz() {
		return this.bpfz;
	}

	public void setBpfz(String bpfz) {
		this.bpfz = bpfz;
	}

	public String getScbm() {
		return this.scbm;
	}

	public void setScbm(String scbm) {
		this.scbm = scbm;
	}

	public String getBscd() {
		return this.bscd;
	}

	public void setBscd(String bscd) {
		this.bscd = bscd;
	}

	public String getCdzy() {
		return this.cdzy;
	}

	public void setCdzy(String cdzy) {
		this.cdzy = cdzy;
	}

	public String getSysc() {
		return this.sysc;
	}

	public void setSysc(String sysc) {
		this.sysc = sysc;
	}

	public String getXysc() {
		return this.xysc;
	}

	public void setXysc(String xysc) {
		this.xysc = xysc;
	}

	public Byte getDjjd() {
		return this.djjd;
	}

	public void setDjjd(Byte djjd) {
		this.djjd = djjd;
	}

	public String getXmmc() {
		return xmmc;
	}

	public void setXmmc(String xmmc) {
		this.xmmc = xmmc;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getDxmmc() {
		return dxmmc;
	}

	public void setDxmmc(String dxmmc) {
		this.dxmmc = dxmmc;
	}

	public String getXxmmc() {
		return xxmmc;
	}

	public void setXxmmc(String xxmmc) {
		this.xxmmc = xxmmc;
	}

	public String getZb() {
		return zb;
	}

	public void setZb(String zb) {
		this.zb = zb;
	}

	public String getXbz() {
		return xbz;
	}

	public void setXbz(String xbz) {
		this.xbz = xbz;
	}

	public String getXmdj() {
		return xmdj;
	}

	public void setXmdj(String xmdj) {
		this.xmdj = xmdj;
	}

	public String getFbzt() {
		return fbzt;
	}

	public void setFbzt(String fbzt) {
		this.fbzt = fbzt;
	}

	public String getSfxnsc() {
		return sfxnsc;
	}

	public void setSfxnsc(String sfxnsc) {
		this.sfxnsc = sfxnsc;
	}

	public String getBssj1() {
		return bssj1;
	}

	public void setBssj1(String bssj1) {
		this.bssj1 = bssj1;
	}

	public Date getFbsj() {
		return fbsj;
	}

	public void setFbsj(Date fbsj) {
		this.fbsj = fbsj;
	}

	public String getShyj() {
		return shyj;
	}

	public void setShyj(String shyj) {
		this.shyj = shyj;
	}

	public String getScbmQuery() {
		return scbmQuery;
	}

	public void setScbmQuery(String scbmQuery) {
		this.scbmQuery = scbmQuery;
	}
	
	
}