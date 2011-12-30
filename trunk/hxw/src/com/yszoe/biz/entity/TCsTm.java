package com.yszoe.biz.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TCsTm entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_CS_TM", schema = "HXW")
public class TCsTm implements java.io.Serializable {

	// Fields

	private String wid;
	private String xmid;
	private String cjr;
	private Date cjsj;
	private String state;
	private String bjxx;
	private String xsxx;
	private Short px;
	private Short fz;

	// Constructors

	/** default constructor */
	public TCsTm() {
	}

	/** minimal constructor */
	public TCsTm(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public TCsTm(String wid, String xmid, String cjr, Date cjsj, String state, String bjxx, String xsxx, Short px,
			Short fz) {
		this.wid = wid;
		this.xmid = xmid;
		this.cjr = cjr;
		this.cjsj = cjsj;
		this.state = state;
		this.bjxx = bjxx;
		this.xsxx = xsxx;
		this.px = px;
		this.fz = fz;
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

	@Column(name = "XMID", length = 50)
	public String getXmid() {
		return this.xmid;
	}

	public void setXmid(String xmid) {
		this.xmid = xmid;
	}

	@Column(name = "CJR", length = 50)
	public String getCjr() {
		return this.cjr;
	}

	public void setCjr(String cjr) {
		this.cjr = cjr;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "CJSJ", length = 7)
	public Date getCjsj() {
		return this.cjsj;
	}

	public void setCjsj(Date cjsj) {
		this.cjsj = cjsj;
	}

	@Column(name = "STATE", length = 2)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "BJXX")
	public String getBjxx() {
		return this.bjxx;
	}

	public void setBjxx(String bjxx) {
		this.bjxx = bjxx;
	}

	@Column(name = "XSXX")
	public String getXsxx() {
		return this.xsxx;
	}

	public void setXsxx(String xsxx) {
		this.xsxx = xsxx;
	}

	@Column(name = "PX", precision = 4, scale = 0)
	public Short getPx() {
		return this.px;
	}

	public void setPx(Short px) {
		this.px = px;
	}

	@Column(name = "FZ", precision = 4, scale = 0)
	public Short getFz() {
		return this.fz;
	}

	public void setFz(Short fz) {
		this.fz = fz;
	}

}