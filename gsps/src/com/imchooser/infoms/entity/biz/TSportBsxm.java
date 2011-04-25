package com.imchooser.infoms.entity.biz;

import java.util.Date;

/**
 * TSportBsxm entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class TSportBsxm implements java.io.Serializable {

	// Fields

	private String wid;
	private String dxmmc;
	private String xxmmc;
	private String zb;
	private String xbz;
	private String xmdj;
	private String dxmtb;
	private Byte pxh;
	private String sfjtxm;
	private String sfdzxm;
	private String cjdw;

	private String sc; // 赛次 手工添加 非持久化 wangjunjun
	private String scCn; // 赛次 中文手工添加 非持久化 wangjunjun
	private String zbcn; // 组别中文名称 wangjunjun
	private Date bssj; // 比赛时间
	private String startTime; // 起始时间 界面搜索穿值
	private String endTime; // 起始时间 界面搜索穿值
	private String dzr; //赛此 对战人
	private String shzt; //审核状态，  手动添加
	private long c;//手动添加
	private String fbzt; //赛程的发布状态
	private String bpfz; //编排分组
	private String csz;
	private String xbzCn; // 性别组 中文手工添加 非持久化 wangjunjun
	private String xmbm; //wangjunjun 项目编码  成绩运动员 中用
	private String dbd; //手工添加 代表地名称
	private String bmstate; //手工添加  判断报名状态
	private String dpType; //手工添加  查询得牌类型
	private String val; //手工添加  金银铜 得分值 （数据核对用）
	private String bscd; //手工添加  比赛场地
	// Constructors

	/** default constructor */
	public TSportBsxm() {
	}

	/** minimal constructor */
	public TSportBsxm(String wid, String dxmmc) {
		this.wid = wid;
		this.dxmmc = dxmmc;
	}

	public TSportBsxm(String wid, String dxmmc, String xxmmc, String zb, String xbz, String xmdj, String sc,
			String zbcn, Date bssj, String sfjtxm,String scCn,String cjdw,String dzr) {
		this.wid = wid;
		this.dxmmc = dxmmc;
		this.xxmmc = xxmmc;
		this.zb = zb;
		this.xbz = xbz;
		this.xmdj = xmdj;
		this.sc = sc;
		this.zbcn = zbcn;
		this.bssj = bssj;
		this.sfjtxm = sfjtxm;
		this.scCn = scCn;
		this.cjdw = cjdw;
		this.dzr = dzr;
	}
	//junjun 用 
	public TSportBsxm( String dxmmc, String xxmmc,String zbcn, String xbzCn) {
		this.dxmmc = dxmmc;
		this.xxmmc = xxmmc;
		this.zbcn = zbcn;
		this.xbzCn = xbzCn;
	}
	//未解决 时间显示不了 hh:mm:ss 格式而定义的  ------junjunWang
	public TSportBsxm(String wid, String dxmmc, String xxmmc, String zb, String xbz, String xmdj, String sc,
			String zbcn, String startTime, String sfjtxm,String scCn,String cjdw,String dzr,String fbzt,String bpfz) {
		this.wid = wid;
		this.dxmmc = dxmmc;
		this.xxmmc = xxmmc;
		this.zb = zb;
		this.xbz = xbz;
		this.xmdj = xmdj;
		this.sc = sc;
		this.zbcn = zbcn;
		this.startTime = startTime;
		this.sfjtxm = sfjtxm;
		this.scCn = scCn;
		this.cjdw = cjdw;
		this.dzr = dzr;
		this.fbzt = fbzt;
		this.bpfz = bpfz;
	}
	// xmbm wangjunjun  ---cjYdy
	public TSportBsxm(String wid, String dxmmc, String xxmmc, String zb, String xbz, String xmdj, String sc,
			String zbcn, String startTime, String sfjtxm,String scCn,String cjdw,String dzr,String fbzt,String bpfz,String xmbm) {
		this.wid = wid;
		this.dxmmc = dxmmc;
		this.xxmmc = xxmmc;
		this.zb = zb;
		this.xbz = xbz;
		this.xmdj = xmdj;
		this.sc = sc;
		this.zbcn = zbcn;
		this.startTime = startTime;
		this.sfjtxm = sfjtxm;
		this.scCn = scCn;
		this.cjdw = cjdw;
		this.dzr = dzr;
		this.fbzt = fbzt;
		this.bpfz = bpfz;
		this.xmbm = xmbm;
	}

	/** full constructor */
	public TSportBsxm(String wid, String dxmmc, String xxmmc, String zb, String xbz, String xmdj, String dxmtb,
			Byte pxh, String sfjtxm, String sfdzxm) {
		this.wid = wid;
		this.dxmmc = dxmmc;
		this.xxmmc = xxmmc;
		this.zb = zb;
		this.xbz = xbz;
		this.xmdj = xmdj;
		this.dxmtb = dxmtb;
		this.pxh = pxh;
		this.sfjtxm = sfjtxm;
		this.sfdzxm = sfdzxm;
	}
	
	
	//TSportBsxmServiceImpl中的list使用
	public TSportBsxm(String wid, String dxmmc, String xxmmc, String zb, String xbz, String xmdj,String sfjtxm,String sfdzxm,Byte pxh) {
		this.wid=wid;
		this.dxmmc=dxmmc;
		this.xxmmc=xxmmc;
		this.zb=zb;
		this.xbz=xbz;
		this.xmdj=xmdj;
		this.sfjtxm=sfjtxm;
		this.sfdzxm=sfdzxm;
		this.pxh=pxh;
	}
	
	//SportYdyxxServiceImpl中的submitQrbsxm使用
	public TSportBsxm(String wid, String dxmmc, String xxmmc, String zb, String xbz) {
		this.wid=wid;
		this.dxmmc=dxmmc;
		this.xxmmc=xxmmc;
		this.zb=zb;
		this.xbz=xbz;
	}
	
	//SportScdfgzServiceImpl中list使用
	public TSportBsxm(String wid, String dxmmc, String xxmmc, String zb, String xbz, String xmdj) {
		this.wid=wid;
		this.dxmmc=dxmmc;
		this.xxmmc=xxmmc;
		this.zb=zb;
		this.xbz=xbz;
		this.xmdj=xmdj;
	}
	
	
	public TSportBsxm(String wid, String dxmmc, String dxmtb, long c) {
		this.wid = wid;
		this.dxmmc = dxmmc;
		this.dxmtb = dxmtb;
		this.c = c;
	}

	public TSportBsxm(String wid, String dxmmc, String dxmtb) {
		this.wid = wid;
		this.dxmmc = dxmmc;
		this.dxmtb = dxmtb;
	}

	// Property accessors

	public String getWid() {
		return this.wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
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

	public String getZb() {
		return this.zb;
	}

	public void setZb(String zb) {
		this.zb = zb;
	}

	public String getXbz() {
		return this.xbz;
	}

	public void setXbz(String xbz) {
		this.xbz = xbz;
	}

	public String getXmdj() {
		return this.xmdj;
	}

	public void setXmdj(String xmdj) {
		this.xmdj = xmdj;
	}

	public String getDxmtb() {
		return this.dxmtb;
	}

	public void setDxmtb(String dxmtb) {
		this.dxmtb = dxmtb;
	}

	public Byte getPxh() {
		return this.pxh;
	}

	public void setPxh(Byte pxh) {
		this.pxh = pxh;
	}

	public String getSfjtxm() {
		return this.sfjtxm;
	}

	public void setSfjtxm(String sfjtxm) {
		this.sfjtxm = sfjtxm;
	}

	public String getSfdzxm() {
		return this.sfdzxm;
	}

	public void setSfdzxm(String sfdzxm) {
		this.sfdzxm = sfdzxm;
	}

	public String getSc() {
		return sc;
	}

	public void setSc(String sc) {
		this.sc = sc;
	}

	public String getZbcn() {
		return zbcn;
	}

	public void setZbcn(String zbcn) {
		this.zbcn = zbcn;
	}

	public Date getBssj() {
		return bssj;
	}

	public void setBssj(Date bssj) {
		this.bssj = bssj;
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

	public long getC() {
		return c;
	}

	public void setC(long c) {
		this.c = c;
	}

	public String getScCn() {
		return scCn;
	}

	public void setScCn(String scCn) {
		this.scCn = scCn;
	}

	public String getCjdw() {
		return cjdw;
	}

	public void setCjdw(String cjdw) {
		this.cjdw = cjdw;
	}

	public String getDzr() {
		return dzr;
	}

	public void setDzr(String dzr) {
		this.dzr = dzr;
	}

	public String getShzt() {
		return shzt;
	}

	public void setShzt(String shzt) {
		this.shzt = shzt;
	}

	public String getFbzt() {
		return fbzt;
	}

	public void setFbzt(String fbzt) {
		this.fbzt = fbzt;
	}

	public String getBpfz() {
		return bpfz;
	}

	public void setBpfz(String bpfz) {
		this.bpfz = bpfz;
	}

	public String getCsz() {
		return csz;
	}

	public void setCsz(String csz) {
		this.csz = csz;
	}

	public String getXbzCn() {
		return xbzCn;
	}

	public void setXbzCn(String xbzCn) {
		this.xbzCn = xbzCn;
	}

	public String getXmbm() {
		return xmbm;
	}

	public void setXmbm(String xmbm) {
		this.xmbm = xmbm;
	}

	public String getDbd() {
		return dbd;
	}

	public void setDbd(String dbd) {
		this.dbd = dbd;
	}

	public String getBmstate() {
		return bmstate;
	}

	public void setBmstate(String bmstate) {
		this.bmstate = bmstate;
	}

	public String getDpType() {
		return dpType;
	}

	public void setDpType(String dpType) {
		this.dpType = dpType;
	}

	public String getVal() {
		return val;
	}

	public void setVal(String val) {
		this.val = val;
	}

	public String getBscd() {
		return bscd;
	}

	public void setBscd(String bscd) {
		this.bscd = bscd;
	}

}