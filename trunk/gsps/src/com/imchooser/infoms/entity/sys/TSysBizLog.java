package com.imchooser.infoms.entity.sys;

import java.util.Date;

/**
 * TSysBizLog generated by MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class TSysBizLog implements java.io.Serializable {

	// Fields

	private String wid;

	private Date czsj;

	private String czdx;

	private String czr;

	private String czlx;

	// Constructors

	/** default constructor */
	public TSysBizLog() {
	}

	/** full constructor */
	public TSysBizLog(String wid, Date czsj, String czdx, String czr,
			String czlx) {
		this.wid = wid;
		this.czsj = czsj;
		this.czdx = czdx;
		this.czr = czr;
		this.czlx = czlx;
	}

	// Property accessors

	public String getWid() {
		return this.wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	public Date getCzsj() {
		return this.czsj;
	}

	public void setCzsj(Date czsj) {
		this.czsj = czsj;
	}

	public String getCzdx() {
		return this.czdx;
	}

	public void setCzdx(String czdx) {
		this.czdx = czdx;
	}

	public String getCzr() {
		return this.czr;
	}

	public void setCzr(String czr) {
		this.czr = czr;
	}

	public String getCzlx() {
		return this.czlx;
	}

	public void setCzlx(String czlx) {
		this.czlx = czlx;
	}

}