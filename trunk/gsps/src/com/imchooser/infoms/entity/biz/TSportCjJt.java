package com.imchooser.infoms.entity.biz;

import java.util.Date;

/**
 * TSportCjJt entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class TSportCjJt implements java.io.Serializable {

	// Fields

	private String wid;
	private Short djjydh;
	private String dxmmc;
	private String xxmmc;
	private String scbm;
	private String dbtmc;
	private String yddmc;
	private String departid;
	private String bpxh;
	private String cj;
	private Double df;
	private Double jps;
	private Double yps;
	private Double tps;
	private String dbd;
	private Short mc;
	private String sfjs;
	private String sfjrxyl;
	private Double jjf;
	private Double jjjps;
	private Double jjyps;
	private Double jjtps;
	private String shzt;
	private Date createtime;
	private String bz;
	private String pjllx;
	private String yjlcj;
	private String sfbjydhcj;
	private String shztCn; //审核状态中文     手工添加 非持久化
	private String cjdw;//成绩单位
	// Constructors

	/** default constructor */
	public TSportCjJt() {
	}

	/** minimal constructor */
	public TSportCjJt(String wid, Short djjydh, String dxmmc, String xxmmc, String sfjs, String sfjrxyl, String shzt) {
		this.wid = wid;
		this.djjydh = djjydh;
		this.dxmmc = dxmmc;
		this.xxmmc = xxmmc;
		this.sfjs = sfjs;
		this.sfjrxyl = sfjrxyl;
		this.shzt = shzt;
	}

	/** full constructor */
	public TSportCjJt(String wid, Short djjydh, String dxmmc, String xxmmc, String scbm, String dbtmc, String yddmc,
			String departid, String bpxh, String cj, Double df, Double jps, Double yps, Double tps, String dbd,
			Short mc, String sfjs, String sfjrxyl, Double jjf, Double jjjps, Double jjyps, Double jjtps, String shzt,
			Date createtime, String bz, String pjllx, String yjlcj, String sfbjydhcj) {
		this.wid = wid;
		this.djjydh = djjydh;
		this.dxmmc = dxmmc;
		this.xxmmc = xxmmc;
		this.scbm = scbm;
		this.dbtmc = dbtmc;
		this.yddmc = yddmc;
		this.departid = departid;
		this.bpxh = bpxh;
		this.cj = cj;
		this.df = df;
		this.jps = jps;
		this.yps = yps;
		this.tps = tps;
		this.dbd = dbd;
		this.mc = mc;
		this.sfjs = sfjs;
		this.sfjrxyl = sfjrxyl;
		this.jjf = jjf;
		this.jjjps = jjjps;
		this.jjyps = jjyps;
		this.jjtps = jjtps;
		this.shzt = shzt;
		this.createtime = createtime;
		this.bz = bz;
		this.pjllx = pjllx;
		this.yjlcj = yjlcj;
		this.sfbjydhcj = sfbjydhcj;
	}
	//成绩登记 审核使用
	public TSportCjJt(String wid, Short djjydh, String dxmmc, String xxmmc, String scbm, String dbtmc, String yddmc,
			String departid, String bpxh, String cj, Double df, Double jps, Double yps, Double tps, String dbd,
			Short mc, String sfjs, String sfjrxyl, Double jjf, Double jjjps, Double jjyps, Double jjtps, String shzt,
			Date createtime, String bz, String pjllx, String yjlcj, String sfbjydhcj,String shztCn) {
		this.wid = wid;
		this.djjydh = djjydh;
		this.dxmmc = dxmmc;
		this.xxmmc = xxmmc;
		this.scbm = scbm;
		this.dbtmc = dbtmc;
		this.yddmc = yddmc;
		this.departid = departid;
		this.bpxh = bpxh;
		this.cj = cj;
		this.df = df;
		this.jps = jps;
		this.yps = yps;
		this.tps = tps;
		this.dbd = dbd;
		this.mc = mc;
		this.sfjs = sfjs;
		this.sfjrxyl = sfjrxyl;
		this.jjf = jjf;
		this.jjjps = jjjps;
		this.jjyps = jjyps;
		this.jjtps = jjtps;
		this.shzt = shzt;
		this.createtime = createtime;
		this.bz = bz;
		this.pjllx = pjllx;
		this.yjlcj = yjlcj;
		this.sfbjydhcj = sfbjydhcj;
		this.shztCn = shztCn;
	}
	public TSportCjJt(String wid, Short djjydh, String dxmmc, String xxmmc, String scbm, String dbtmc, String yddmc,
			String departid, String bpxh, String cj, Double df, Double jps, Double yps, Double tps, String dbd,
			Short mc, String sfjs, String sfjrxyl, Double jjf, Double jjjps, Double jjyps, Double jjtps, String shzt,
			Date createtime, String bz, String pjllx, String yjlcj, String sfbjydhcj,String shztCn,String cjdw) {
		this.wid = wid;
		this.djjydh = djjydh;
		this.dxmmc = dxmmc;
		this.xxmmc = xxmmc;
		this.scbm = scbm;
		this.dbtmc = dbtmc;
		this.yddmc = yddmc;
		this.departid = departid;
		this.bpxh = bpxh;
		this.cj = cj;
		this.df = df;
		this.jps = jps;
		this.yps = yps;
		this.tps = tps;
		this.dbd = dbd;
		this.mc = mc;
		this.sfjs = sfjs;
		this.sfjrxyl = sfjrxyl;
		this.jjf = jjf;
		this.jjjps = jjjps;
		this.jjyps = jjyps;
		this.jjtps = jjtps;
		this.shzt = shzt;
		this.createtime = createtime;
		this.bz = bz;
		this.pjllx = pjllx;
		this.yjlcj = yjlcj;
		this.sfbjydhcj = sfbjydhcj;
		this.shztCn = shztCn;
		this.cjdw = cjdw;
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

	public String getBpxh() {
		return this.bpxh;
	}

	public void setBpxh(String bpxh) {
		this.bpxh = bpxh;
	}

	public String getCj() {
		return this.cj;
	}

	public void setCj(String cj) {
		this.cj = cj;
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

	public String getSfjs() {
		return this.sfjs;
	}

	public void setSfjs(String sfjs) {
		this.sfjs = sfjs;
	}

	public String getSfjrxyl() {
		return this.sfjrxyl;
	}

	public void setSfjrxyl(String sfjrxyl) {
		this.sfjrxyl = sfjrxyl;
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

	public String getPjllx() {
		return this.pjllx;
	}

	public void setPjllx(String pjllx) {
		this.pjllx = pjllx;
	}

	public String getYjlcj() {
		return yjlcj;
	}

	public void setYjlcj(String yjlcj) {
		this.yjlcj = yjlcj;
	}

	public String getSfbjydhcj() {
		return this.sfbjydhcj;
	}

	public void setSfbjydhcj(String sfbjydhcj) {
		this.sfbjydhcj = sfbjydhcj;
	}

	public String getShztCn() {
		return shztCn;
	}

	public void setShztCn(String shztCn) {
		this.shztCn = shztCn;
	}

	public String getCjdw() {
		return cjdw;
	}

	public void setCjdw(String cjdw) {
		this.cjdw = cjdw;
	}

}