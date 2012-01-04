package com.yszoe.sys.entity;

/**
 * TSysPropertity generated by MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
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
	public TSysPropertity(String wid, String csmc, String cs, String csfl,
			String cslx, String cssm) {
		this.wid = wid;
		this.csmc = csmc;
		this.cs = cs;
		this.csfl = csfl;
		this.cslx = cslx;
		this.cssm = cssm;
	}

	// Property accessors

	public String getWid() {
		return this.wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	public String getCsmc() {
		return this.csmc;
	}

	public void setCsmc(String csmc) {
		this.csmc = csmc;
	}

	public String getCs() {
		return this.cs;
	}

	public void setCs(String cs) {
		this.cs = cs;
	}

	public String getCsfl() {
		return this.csfl;
	}

	public void setCsfl(String csfl) {
		this.csfl = csfl;
	}

	public String getCslx() {
		return this.cslx;
	}

	public void setCslx(String cslx) {
		this.cslx = cslx;
	}

	public String getCssm() {
		return this.cssm;
	}

	public void setCssm(String cssm) {
		this.cssm = cssm;
	}

}