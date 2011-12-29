package com.yszoe.biz.entity;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * THdBm entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_hd_bm", catalog = "hxw")
public class THdBm implements java.io.Serializable {

	// Fields

	private String wid;
	private String hdwid;
	private String bmr;
	private String bmrip;
	private Timestamp bmsj;
	private String state;
	private String hdgs;
	private String fxjb;

	// Constructors

	/** default constructor */
	public THdBm() {
	}

	/** minimal constructor */
	public THdBm(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public THdBm(String wid, String hdwid, String bmr, String bmrip, Timestamp bmsj, String state, String hdgs,
			String fxjb) {
		this.wid = wid;
		this.hdwid = hdwid;
		this.bmr = bmr;
		this.bmrip = bmrip;
		this.bmsj = bmsj;
		this.state = state;
		this.hdgs = hdgs;
		this.fxjb = fxjb;
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

	@Column(name = "BMR", length = 50)
	public String getBmr() {
		return this.bmr;
	}

	public void setBmr(String bmr) {
		this.bmr = bmr;
	}

	@Column(name = "BMRIP", length = 30)
	public String getBmrip() {
		return this.bmrip;
	}

	public void setBmrip(String bmrip) {
		this.bmrip = bmrip;
	}

	@Column(name = "BMSJ", length = 19)
	public Timestamp getBmsj() {
		return this.bmsj;
	}

	public void setBmsj(Timestamp bmsj) {
		this.bmsj = bmsj;
	}

	@Column(name = "STATE", length = 2)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "HDGS", length = 65535)
	public String getHdgs() {
		return this.hdgs;
	}

	public void setHdgs(String hdgs) {
		this.hdgs = hdgs;
	}

	@Column(name = "FXJB", length = 3)
	public String getFxjb() {
		return this.fxjb;
	}

	public void setFxjb(String fxjb) {
		this.fxjb = fxjb;
	}

}