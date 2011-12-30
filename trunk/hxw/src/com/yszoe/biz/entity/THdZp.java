package com.yszoe.biz.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * THdZp entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_HD_ZP")
public class THdZp implements java.io.Serializable {

	// Fields

	private String wid;
	private String hdwid;
	private String zp;
	private String scr;
	private Date scsj;
	private String zpjj;

	// Constructors

	/** default constructor */
	public THdZp() {
	}

	/** minimal constructor */
	public THdZp(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public THdZp(String wid, String hdwid, String zp, String scr, Date scsj, String zpjj) {
		this.wid = wid;
		this.hdwid = hdwid;
		this.zp = zp;
		this.scr = scr;
		this.scsj = scsj;
		this.zpjj = zpjj;
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

	@Column(name = "HDWID", length = 50)
	public String getHdwid() {
		return this.hdwid;
	}

	public void setHdwid(String hdwid) {
		this.hdwid = hdwid;
	}

	@Column(name = "ZP", length = 150)
	public String getZp() {
		return this.zp;
	}

	public void setZp(String zp) {
		this.zp = zp;
	}

	@Column(name = "SCR", length = 50)
	public String getScr() {
		return this.scr;
	}

	public void setScr(String scr) {
		this.scr = scr;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "SCSJ", length = 7)
	public Date getScsj() {
		return this.scsj;
	}

	public void setScsj(Date scsj) {
		this.scsj = scsj;
	}

	@Column(name = "ZPJJ", length = 600)
	public String getZpjj() {
		return this.zpjj;
	}

	public void setZpjj(String zpjj) {
		this.zpjj = zpjj;
	}

}