package com.imchooser.infoms.entity.biz;

import java.util.Date;

/**
 * TSportCjSxMx entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class TSportCjSxMx implements java.io.Serializable {

	// Fields

	private String wid;
	private Short djjydh;
	private String dxmmc;
	private String xxmmc;
	private String scbm;
	private String dbtmc;
	private String yddmc;
	private String departid;
	private Double df;
	private Double jps;
	private Double yps;
	private Double tps;
	private String dbd;
	private Short mc;
	private Double jjf;
	private Double jjjps;
	private Double jjyps;
	private Double jjtps;
	private String shzt;
	private Date createtime;
	private String bz;
	private String dflx;
	private String dfly;
	private String sfjrzcj;
	private String xm;//姓名手动添加
	private String ydybm;//运动员编码手动添加
	private String createtime1;//手动添加 非持久化

	// Constructors

	/** default constructor */
	public TSportCjSxMx() {
	}

	/** minimal constructor */
	public TSportCjSxMx(String wid, Short djjydh) {
		this.wid = wid;
		this.djjydh = djjydh;
	}

	/** full constructor */
	public TSportCjSxMx(String wid, Short djjydh, String dxmmc, String xxmmc, String scbm, String dbtmc, String yddmc,
			String departid, Double df, Double jps, Double yps, Double tps, String dbd, Short mc, Double jjf,
			Double jjjps, Double jjyps, Double jjtps, String shzt, Date createtime, String bz, String dflx,
			String dfly, String sfjrzcj) {
		this.wid = wid;
		this.djjydh = djjydh;
		this.dxmmc = dxmmc;
		this.xxmmc = xxmmc;
		this.scbm = scbm;
		this.dbtmc = dbtmc;
		this.yddmc = yddmc;
		this.departid = departid;
		this.df = df;
		this.jps = jps;
		this.yps = yps;
		this.tps = tps;
		this.dbd = dbd;
		this.mc = mc;
		this.jjf = jjf;
		this.jjjps = jjjps;
		this.jjyps = jjyps;
		this.jjtps = jjtps;
		this.shzt = shzt;
		this.createtime = createtime;
		this.bz = bz;
		this.dflx = dflx;
		this.dfly = dfly;
		this.sfjrzcj = sfjrzcj;
	}

	//TSportCjSxMxServiceImpl中的list使用
    public TSportCjSxMx(String wid, String dbtmc,String dxmmc, String xxmmc, String createtime1,Double jjf, Double jjjps,Double jjyps,Double jjtps) {
        this.wid = wid;
        this.dbtmc = dbtmc;
        this.dxmmc = dxmmc;
        this.xxmmc = xxmmc;
        this.createtime1 = createtime1;
        this.jjf = jjf;
        this.jjjps = jjjps;
        this.jjyps = jjyps;
        this.jjtps = jjtps;
    }
    
    
    //TSportCjSxMxServiceImpl中的load使用
      public TSportCjSxMx(String wid,Double jjf, Double jjjps,Double jjyps,Double jjtps) {
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

	public String getDxmmc() {
		return this.dxmmc;
	}

	public void setDxmmc(String dxmmc) {
		this.dxmmc = dxmmc;
	}

	public String getXxmmc() {
		return this.xxmmc;
	}

	public void setXxmmc(String xxmmc) {
		this.xxmmc = xxmmc;
	}

	public String getScbm() {
		return this.scbm;
	}

	public void setScbm(String scbm) {
		this.scbm = scbm;
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

	public String getDepartid() {
		return this.departid;
	}

	public void setDepartid(String departid) {
		this.departid = departid;
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

	public String getDflx() {
		return this.dflx;
	}

	public void setDflx(String dflx) {
		this.dflx = dflx;
	}

	public String getDfly() {
		return this.dfly;
	}

	public void setDfly(String dfly) {
		this.dfly = dfly;
	}

	public String getSfjrzcj() {
		return this.sfjrzcj;
	}

	public void setSfjrzcj(String sfjrzcj) {
		this.sfjrzcj = sfjrzcj;
	}

	public String getXm() {
		return xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}

	public String getYdybm() {
		return ydybm;
	}

	public void setYdybm(String ydybm) {
		this.ydybm = ydybm;
	}

	public String getCreatetime1() {
		return createtime1;
	}

	public void setCreatetime1(String createtime1) {
		this.createtime1 = createtime1;
	}

}