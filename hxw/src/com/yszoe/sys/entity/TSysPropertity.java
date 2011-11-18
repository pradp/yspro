package com.yszoe.sys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TSysPropertity entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_PROPERTITY")
public class TSysPropertity implements java.io.Serializable {

	// Fields

	private String wid;
	private String csmc;
	private String cs;
	private String csfl;
	private String cslx;
	private String cssm;

	// Constructors

	/** default constructor */
	public TSysPropertity() {
	}

	/** minimal constructor */
	public TSysPropertity(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public TSysPropertity(String wid, String csmc, String cs, String csfl, String cslx, String cssm) {
		this.wid = wid;
		this.csmc = csmc;
		this.cs = cs;
		this.csfl = csfl;
		this.cslx = cslx;
		this.cssm = cssm;
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

	@Column(name = "CSMC", length = 50)
	public String getCsmc() {
		return this.csmc;
	}

	public void setCsmc(String csmc) {
		this.csmc = csmc;
	}

	@Column(name = "CS", length = 300)
	public String getCs() {
		return this.cs;
	}

	public void setCs(String cs) {
		this.cs = cs;
	}

	@Column(name = "CSFL", length = 50)
	public String getCsfl() {
		return this.csfl;
	}

	public void setCsfl(String csfl) {
		this.csfl = csfl;
	}

	@Column(name = "CSLX", length = 30)
	public String getCslx() {
		return this.cslx;
	}

	public void setCslx(String cslx) {
		this.cslx = cslx;
	}

	@Column(name = "CSSM", length = 90)
	public String getCssm() {
		return this.cssm;
	}

	public void setCssm(String cssm) {
		this.cssm = cssm;
	}

}