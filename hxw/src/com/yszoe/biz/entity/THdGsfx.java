package com.yszoe.biz.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * THdGsfx entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "t_hd_gsfx")
public class THdGsfx implements java.io.Serializable {

	// Fields

	private String wid;
	private String bmwid;
	private String fxdx;
	private String fxly;

	// Constructors

	/** default constructor */
	public THdGsfx() {
	}

	/** minimal constructor */
	public THdGsfx(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public THdGsfx(String wid, String bmwid, String fxdx, String fxly) {
		this.wid = wid;
		this.bmwid = bmwid;
		this.fxdx = fxdx;
		this.fxly = fxly;
	}

	// Property accessors
	@Id
	@Column(name = "wid", unique = true, nullable = false, length = 50)
	public String getWid() {
		return this.wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	@Column(name = "bmwid", length = 50)
	public String getBmwid() {
		return this.bmwid;
	}

	public void setBmwid(String bmwid) {
		this.bmwid = bmwid;
	}

	@Column(name = "fxdx", length = 50)
	public String getFxdx() {
		return this.fxdx;
	}

	public void setFxdx(String fxdx) {
		this.fxdx = fxdx;
	}

	@Column(name = "fxly", length = 3)
	public String getFxly() {
		return fxly;
	}

	public void setFxly(String fxly) {
		this.fxly = fxly;
	}

}