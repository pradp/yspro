package com.yszoe.biz.entity;

import java.sql.Timestamp;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 * THdNr entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_hd_nr", catalog = "hxw")
public class THdNr implements java.io.Serializable {

	// Fields

	private String wid;
	private String hdlx;
	private String bt;
	private String syydt;
	private String zzz;
	private String nr;
	private String hddd;
	private String hdsj;
	private Double jg;
	private Integer zdrs;
	private Long bmrs; //manual add 已经报名人数
	private String zbfzz;
	private String cjr;
	private Date cjrq;
	private Date zhxgrq;
	private Long djs;
	private String state;
	private Date shrq;
	private String shyj;

	// Constructors

	/** default constructor */
	public THdNr() {
	}

	/** minimal constructor */
	public THdNr(String wid) {
		this.wid = wid;
	}

	/** list constructor */
	public THdNr(String wid, String bt, String syydt, String zzz, String hddd, String hdsj, Double jg, 
			Integer zdrs, Date zhxgrq, Long djs, String hdlx, String state, Long bmrs) {
		this.wid = wid;
		this.hdlx = hdlx;
		this.bt = bt;
		this.syydt = syydt;
		this.zzz = zzz;
		this.hddd = hddd;
		this.hdsj = hdsj;
		this.jg = jg;
		this.zdrs = zdrs;
		this.zhxgrq = zhxgrq;
		this.djs = djs;
		this.state = state;
		this.bmrs = bmrs;
	}

	/** full constructor */
	public THdNr(String wid, String hdlx, String bt, String zzz, String nr, String hddd, String hdsj, Double jg, Integer zdrs, String zbfzz,
			String cjr, Timestamp cjrq, Timestamp zhxgrq, Long djs, String state, Timestamp shrq, String shyj) {
		this.wid = wid;
		this.hdlx = hdlx;
		this.bt = bt;
		this.zzz = zzz;
		this.nr = nr;
		this.hddd = hddd;
		this.hdsj = hdsj;
		this.jg = jg;
		this.zdrs = zdrs;
		this.zbfzz = zbfzz;
		this.cjr = cjr;
		this.cjrq = cjrq;
		this.zhxgrq = zhxgrq;
		this.djs = djs;
		this.state = state;
		this.shrq = shrq;
		this.shyj = shyj;
	}

	// Property accessors
	@Id
	@Column(name = "WID", unique = true, nullable = false, length = 50)
	public String getWid() {
		return this.wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	@Column(name = "HDLX", length = 50)
	public String getHdlx() {
		return this.hdlx;
	}

	public void setHdlx(String hdlx) {
		this.hdlx = hdlx;
	}

	@Column(name = "BT", length = 150)
	public String getBt() {
		return this.bt;
	}

	public void setBt(String bt) {
		this.bt = bt;
	}

	@Column(name = "SYYDT", length = 150)
	public String getSyydt() {
		return syydt;
	}

	public void setSyydt(String syydt) {
		this.syydt = syydt;
	}

	@Column(name = "ZZZ", length = 50)
	public String getZzz() {
		return this.zzz;
	}

	public void setZzz(String zzz) {
		this.zzz = zzz;
	}

	@Column(name = "NR")
	public String getNr() {
		return this.nr;
	}

	public void setNr(String nr) {
		this.nr = nr;
	}

	@Column(name = "HDDD", length = 900)
	public String getHddd() {
		return hddd;
	}

	public void setHddd(String hddd) {
		this.hddd = hddd;
	}

	@Column(name = "HDSJ", length = 600)
	public String getHdsj() {
		return hdsj;
	}

	public void setHdsj(String hdsj) {
		this.hdsj = hdsj;
	}

	@Column(name = "JG", precision = 10)
	public Double getJg() {
		return this.jg;
	}

	public void setJg(Double jg) {
		this.jg = jg;
	}

	@Column(name = "ZDRS")
	public Integer getZdrs() {
		return this.zdrs;
	}

	public void setZdrs(Integer zdrs) {
		this.zdrs = zdrs;
	}

	@Column(name = "ZBFZZ", length = 65535)
	public String getZbfzz() {
		return this.zbfzz;
	}

	public void setZbfzz(String zbfzz) {
		this.zbfzz = zbfzz;
	}

	@Column(name = "CJR", length = 50)
	public String getCjr() {
		return this.cjr;
	}

	public void setCjr(String cjr) {
		this.cjr = cjr;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "CJRQ", length = 19)
	public Date getCjrq() {
		return this.cjrq;
	}

	public void setCjrq(Date cjrq) {
		this.cjrq = cjrq;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "ZHXGRQ", length = 19)
	public Date getZhxgrq() {
		return this.zhxgrq;
	}

	public void setZhxgrq(Date zhxgrq) {
		this.zhxgrq = zhxgrq;
	}

	@Column(name = "DJS")
	public Long getDjs() {
		return this.djs;
	}

	public void setDjs(Long djs) {
		this.djs = djs;
	}

	@Column(name = "STATE", length = 2)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "SHRQ", length = 19)
	public Date getShrq() {
		return this.shrq;
	}

	public void setShrq(Date shrq) {
		this.shrq = shrq;
	}

	@Column(name = "SHYJ", length = 65535)
	public String getShyj() {
		return this.shyj;
	}

	public void setShyj(String shyj) {
		this.shyj = shyj;
	}

	@Transient
	public Long getBmrs() {
		return bmrs;
	}

	public void setBmrs(Long bmrs) {
		this.bmrs = bmrs;
	}

}