package com.imchooser.infoms.entity.biz;

import java.io.Serializable;
import java.util.Date;

@SuppressWarnings("serial")
public class TSportCjYdy implements Serializable
{
  private String wid;
  private Short djjydh;
  private String scbm;
  private String ydybm;
  private String cj;
  private Double df;
  private Double jps;
  private Double yps;
  private Double tps;
  private String dbd;
  private Short mc;
  private String sfjs;
  private Double jjf;
  private String shzt;
  private Date createtime;
  private String bz;
  private String pjllx;
  private String yjlcj;
  private String sfjtxm;
  private String sfjrxyl;
  private Double jjjps;
  private Double jjyps;
  private Double jjtps;
  private String dxmmc;
  private String xxmmc;
  private String bpxh;
  private String ydyxm;
  private String pjllx1;
  private String zch;
  private String csz;
  private String sccbm;
  private String shztCn;
  private String sfbjydhcj;
  private String departid;
  private String jtwid;
  private String cjdw;
  private String bssj;
  private String zb;
  private String xbz;
  private String bsxm;
  private String ssydy;
  private int rs;

  public TSportCjYdy()
  {
  }

  public TSportCjYdy(String wid, Double jps, Double yps, Double tps, String shzt, Date createtime, String pjllx)
  {
    this.wid = wid;
    this.jps = jps;
    this.yps = yps;
    this.tps = tps;
    this.shzt = shzt;
    this.createtime = createtime;
    this.pjllx = pjllx;
  }

  public TSportCjYdy(String wid, Short djjydh, String scbm, String ydybm, String cj, Double df, Double jps, Double yps, Double tps, String dbd, Short mc, String sfjs, Double jjf, String shzt, Date createtime, String bz, String pjllx, String yjlcj, String sfjtxm, String sfjrxyl, Double jjjps, Double jjyps, Double jjtps, String dxmmc, String xxmmc, String bpxh, String ydyxm, String sfbjydhcj)
  {
    this.wid = wid;
    this.djjydh = djjydh;
    this.scbm = scbm;
    this.ydybm = ydybm;
    this.cj = cj;
    this.df = df;
    this.jps = jps;
    this.yps = yps;
    this.tps = tps;
    this.dbd = dbd;
    this.mc = mc;
    this.sfjs = sfjs;
    this.jjf = jjf;
    this.shzt = shzt;
    this.createtime = createtime;
    this.bz = bz;
    this.pjllx = pjllx;
    this.yjlcj = yjlcj;
    this.sfjtxm = sfjtxm;
    this.sfjrxyl = sfjrxyl;
    this.jjjps = jjjps;
    this.jjyps = jjyps;
    this.jjtps = jjtps;
    this.dxmmc = dxmmc;
    this.xxmmc = xxmmc;
    this.bpxh = bpxh;
    this.ydyxm = ydyxm;
    this.sfbjydhcj = sfbjydhcj;
  }

  public TSportCjYdy(String wid, Short djjydh, String scbm, String ydybm, String cj, Double df, Double jps, Double yps, Double tps, String dbd, Short mc, String sfjs, Double jjf, String shzt, Date createtime, String bz, String pjllx, String yjlcj, String sfjtxm, String sfjrxyl, Double jjjps, Double jjyps, Double jjtps, String dxmmc, String xxmmc, String bpxh, String ydyxm, String sfbjydhcj, String departid, String shztCn, String cjdw, String ssydy, String zch)
  {
    this.wid = wid;
    this.djjydh = djjydh;
    this.scbm = scbm;
    this.ydybm = ydybm;
    this.cj = cj;
    this.df = df;
    this.jps = jps;
    this.yps = yps;
    this.tps = tps;
    this.dbd = dbd;
    this.mc = mc;
    this.sfjs = sfjs;
    this.jjf = jjf;
    this.shzt = shzt;
    this.createtime = createtime;
    this.bz = bz;
    this.pjllx = pjllx;
    this.yjlcj = yjlcj;
    this.sfjtxm = sfjtxm;
    this.sfjrxyl = sfjrxyl;
    this.jjjps = jjjps;
    this.jjyps = jjyps;
    this.jjtps = jjtps;
    this.dxmmc = dxmmc;
    this.xxmmc = xxmmc;
    this.bpxh = bpxh;
    this.shztCn = shztCn;
    this.sfbjydhcj = sfbjydhcj;
    this.ydyxm = ydyxm;
    this.departid = departid;
    this.cjdw = cjdw;
    this.ssydy = ssydy;
    this.zch = zch;
  }

  public TSportCjYdy(String wid, String pjllx, String pjllx1, String ydybm, String dxmmc, String xxmmc, String bz, String dbd, Date createtime, String yjlcj, String cj)
  {
    this.wid = wid;
    this.pjllx = pjllx;
    this.pjllx1 = pjllx1;
    this.ydybm = ydybm;
    this.dxmmc = dxmmc;
    this.xxmmc = xxmmc;
    this.bz = bz;
    this.dbd = dbd;
    this.createtime = createtime;
    this.yjlcj = yjlcj;
    this.cj = cj;
  }

  public TSportCjYdy(String bsxm, String cj, Short mc, String sfjtxm, Double df)
  {
    this.bsxm = bsxm;
    this.cj = cj;
    this.mc = mc;
    this.sfjtxm = sfjtxm;
    this.df = df;
  }

  public String getWid()
  {
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

  public String getScbm() {
    return this.scbm;
  }

  public void setScbm(String scbm) {
    this.scbm = scbm;
  }

  public String getYdybm() {
    return this.ydybm;
  }

  public void setYdybm(String ydybm) {
    this.ydybm = ydybm;
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

  public Double getJjf() {
    return this.jjf;
  }

  public void setJjf(Double jjf) {
    this.jjf = jjf;
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
    return this.yjlcj;
  }

  public void setYjlcj(String yjlcj) {
    this.yjlcj = yjlcj;
  }

  public String getSfjtxm() {
    return this.sfjtxm;
  }

  public void setSfjtxm(String sfjtxm) {
    this.sfjtxm = sfjtxm;
  }

  public String getSfjrxyl() {
    return this.sfjrxyl;
  }

  public void setSfjrxyl(String sfjrxyl) {
    this.sfjrxyl = sfjrxyl;
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

  public String getBpxh() {
    return this.bpxh;
  }

  public void setBpxh(String bpxh) {
    this.bpxh = bpxh;
  }

  public String getYdyxm() {
    return this.ydyxm;
  }

  public void setYdyxm(String ydyxm) {
    this.ydyxm = ydyxm;
  }

  public String getPjllx1() {
    return this.pjllx1;
  }

  public void setPjllx1(String pjllx1) {
    this.pjllx1 = pjllx1;
  }

  public String getZch() {
    return this.zch;
  }

  public void setZch(String zch) {
    this.zch = zch;
  }

  public String getCsz() {
    return this.csz;
  }

  public void setCsz(String csz) {
    this.csz = csz;
  }

  public String getSccbm() {
    return this.sccbm;
  }

  public void setSccbm(String sccbm) {
    this.sccbm = sccbm;
  }

  public String getShztCn() {
    return this.shztCn;
  }

  public void setShztCn(String shztCn) {
    this.shztCn = shztCn;
  }

  public String getSfbjydhcj() {
    return this.sfbjydhcj;
  }

  public void setSfbjydhcj(String sfbjydhcj) {
    this.sfbjydhcj = sfbjydhcj;
  }

  public String getDepartid() {
    return this.departid;
  }

  public void setDepartid(String departid) {
    this.departid = departid;
  }

  public String getCjdw() {
    return this.cjdw;
  }

  public void setCjdw(String cjdw) {
    this.cjdw = cjdw;
  }

  public String getBssj() {
    return this.bssj;
  }

  public void setBssj(String bssj) {
    this.bssj = bssj;
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

  public String getBsxm() {
    return this.bsxm;
  }

  public void setBsxm(String bsxm) {
    this.bsxm = bsxm;
  }

  public String getSsydy() {
    return this.ssydy;
  }

  public void setSsydy(String ssydy) {
    this.ssydy = ssydy;
  }

  public String getJtwid() {
    return this.jtwid;
  }

  public void setJtwid(String jtwid) {
    this.jtwid = jtwid;
  }

  public int getRs() {
    return this.rs;
  }

  public void setRs(int rs) {
    this.rs = rs;
  }
}