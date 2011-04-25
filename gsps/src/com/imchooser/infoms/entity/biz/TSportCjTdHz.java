package com.imchooser.infoms.entity.biz;

import java.util.Date;

/**
 * TSportCjTdHz entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class TSportCjTdHz implements java.io.Serializable {

	// Fields

	private String wid;
	private Short djjydh;
	private String dbtmc;
	private String yddmc;
	private String departid;
	private Double df;
	private Double jps;
	private Double yps;
	private Double tps;
	private Double hjjps;
	private String dbd;
	private Short mc;
	private Double jjf;//加减分,手动添加
	private Double jjjps;//加减金牌数,手动添加
	private Double jjyps;//加减银牌数,手动添加
	private Double jjtps;//加减铜牌数,手动添加
	private String shzt;
	private Date createtime;
	private String bz;
	private String hzlx;
	private String cj; //成绩,手动添加
	private String scbm; //赛程编码,手动添加
	private String bscd; //比赛场地，手工添加非持久化
	private String bssj; //用于页面显示的  比赛时间 ，手工添加非持久化
	private String ydybm; //运动员编码 ，手工添加非持久化
	private String ydymc; //运动员姓名，手工添加非持久化
	private String bpxh; //编排序号，手工添加非持久化
	private String zch;  //注册号， 手工添加非持久化
	private String rctime;  //日程时间 ，手工添加非持久化
	private String xmbm;   //项目编码，手工添加非持久化
	private String sfjtxm;  //是否集体项目，  手工添加非持久化
	private String zb;   //组别，  手工添加非持久化
	private String xbz;  // 性别组，手工添加非持久化
	private String sfdzxm; // 是否对战项目，手工添加非持久化
	private String xmjd;  //项目阶段，手工添加非持久化
	private String dxmmc;
	private String xxmmc;
	private String sfbjydhcj; //是否本届运动会成绩， 手工添加非持久化
	// Constructors

	/** default constructor */
	public TSportCjTdHz() {
	}

	/** minimal constructor */
	public TSportCjTdHz(String wid, Short djjydh) {
		this.wid = wid;
		this.djjydh = djjydh;
	}

	/** full constructor */
	public TSportCjTdHz(String wid, Short djjydh, String dbtmc, String yddmc, String departid, Double df, Double jps,
			Double yps, Double tps, Double hjjps, String dbd, Short mc, Double jjf, Double jjjps, Double jjyps,
			Double jjtps, String shzt, Date createtime, String bz, String hzlx) {
		this.wid = wid;
		this.djjydh = djjydh;
		this.dbtmc = dbtmc;
		this.yddmc = yddmc;
		this.departid = departid;
		this.df = df;
		this.jps = jps;
		this.yps = yps;
		this.tps = tps;
		this.hjjps = hjjps;
		this.dbd = dbd;
		this.mc = mc;
		this.jjf = jjf;
		this.jjjps = jjjps;
		this.jjyps = jjyps;
		this.jjtps = jjtps;
		this.shzt = shzt;
		this.createtime = createtime;
		this.bz = bz;
		this.hzlx = hzlx;
	}

	//TSportCjTdHzServiceImpl中的list使用
    public TSportCjTdHz(String wid, String dbd, String dbtmc,String yddmc,Double jjf,Double jjjps,Double jjyps,Double jjtps) {
        this.wid = wid;
        this.dbd = dbd;
        this.dbtmc = dbtmc;
        this.yddmc = yddmc;
        this.jjf = jjf;
        this.jjjps = jjjps;
        this.jjyps = jjyps;
        this.jjtps = jjtps;
    }
  //TSportCjTdHzServiceImpl中的load使用
    public TSportCjTdHz(String wid, Double jjf,Double jjjps,Double jjyps,Double jjtps) {
    	this.wid = wid;
    	this.jjf = jjf;
        this.jjjps = jjjps;
        this.jjyps = jjyps;
        this.jjtps = jjtps;
    }
	
	// Property accessors

	public String getWid() {
		return this.wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	public Short getDjjydh() {
		return this.djjydh;
	}

	public void setDjjydh(Short djjydh) {
		this.djjydh = djjydh;
	}

	public String getDbtmc() {
		return this.dbtmc;
	}

	public void setDbtmc(String dbtmc) {
		this.dbtmc = dbtmc;
	}

	public String getYddmc() {
		return this.yddmc;
	}

	public void setYddmc(String yddmc) {
		this.yddmc = yddmc;
	}



	public Double getDf() {
		return this.df;
	}

	public void setDf(Double df) {
		this.df = df;
	}

	public Double getJps() {
		return this.jps;
	}

	public void setJps(Double jps) {
		this.jps = jps;
	}

	public Double getYps() {
		return this.yps;
	}

	public void setYps(Double yps) {
		this.yps = yps;
	}

	public Double getTps() {
		return this.tps;
	}

	public void setTps(Double tps) {
		this.tps = tps;
	}

	public Double getHjjps() {
		return this.hjjps;
	}

	public void setHjjps(Double hjjps) {
		this.hjjps = hjjps;
	}

	public String getDbd() {
		return this.dbd;
	}

	public void setDbd(String dbd) {
		this.dbd = dbd;
	}

	public Short getMc() {
		return this.mc;
	}

	public void setMc(Short mc) {
		this.mc = mc;
	}

	public Double getJjf() {
		return this.jjf;
	}

	public void setJjf(Double jjf) {
		this.jjf = jjf;
	}

	public Double getJjjps() {
		return this.jjjps;
	}

	public void setJjjps(Double jjjps) {
		this.jjjps = jjjps;
	}

	public Double getJjyps() {
		return this.jjyps;
	}

	public void setJjyps(Double jjyps) {
		this.jjyps = jjyps;
	}

	public Double getJjtps() {
		return this.jjtps;
	}

	public void setJjtps(Double jjtps) {
		this.jjtps = jjtps;
	}

	public String getShzt() {
		return this.shzt;
	}

	public void setShzt(String shzt) {
		this.shzt = shzt;
	}

	public Date getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getBz() {
		return this.bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

	public String getHzlx() {
		return this.hzlx;
	}

	public void setHzlx(String hzlx) {
		this.hzlx = hzlx;
	}

	public String getDepartid() {
		return departid;
	}

	public void setDepartid(String departid) {
		this.departid = departid;
	}

	public String getCj() {
		return cj;
	}

	public void setCj(String cj) {
		this.cj = cj;
	}

	public String getScbm() {
		return scbm;
	}

	public void setScbm(String scbm) {
		this.scbm = scbm;
	}

	public String getBscd() {
		return bscd;
	}

	public void setBscd(String bscd) {
		this.bscd = bscd;
	}

	public String getBssj() {
		return bssj;
	}

	public void setBssj(String bssj) {
		this.bssj = bssj;
	}

	public String getYdybm() {
		return ydybm;
	}

	public void setYdybm(String ydybm) {
		this.ydybm = ydybm;
	}

	public String getYdymc() {
		return ydymc;
	}

	public void setYdymc(String ydymc) {
		this.ydymc = ydymc;
	}

	public String getBpxh() {
		return bpxh;
	}

	public void setBpxh(String bpxh) {
		this.bpxh = bpxh;
	}

	public String getZch() {
		return zch;
	}

	public void setZch(String zch) {
		this.zch = zch;
	}

	public String getRctime() {
		return rctime;
	}

	public void setRctime(String rctime) {
		this.rctime = rctime;
	}

	public String getXmbm() {
		return xmbm;
	}

	public void setXmbm(String xmbm) {
		this.xmbm = xmbm;
	}

	public String getSfjtxm() {
		return sfjtxm;
	}

	public void setSfjtxm(String sfjtxm) {
		this.sfjtxm = sfjtxm;
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

	public String getSfdzxm() {
		return sfdzxm;
	}

	public void setSfdzxm(String sfdzxm) {
		this.sfdzxm = sfdzxm;
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

	public String getXmjd() {
		return xmjd;
	}

	public void setXmjd(String xmjd) {
		this.xmjd = xmjd;
	}

	public String getSfbjydhcj() {
		return sfbjydhcj;
	}

	public void setSfbjydhcj(String sfbjydhcj) {
		this.sfbjydhcj = sfbjydhcj;
	}
}