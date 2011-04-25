package com.imchooser.infoms.entity.sys;

/**
 * TSysDepart entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class TSysDepart implements java.io.Serializable {

	// Fields

	private String departid;
	private String updepartid;
	private String departname;
	private String departnamePy;
	private String description;
	private String departtype;
	private String city;
	private String departcode;
	private String cc;
	private String linkname;
	private String linktel;
	private String state;
	private String sfsn;

	// Constructors

	/** default constructor */
	public TSysDepart() {
	}

	/** minimal constructor */
	public TSysDepart(String departid) {
		this.departid = departid;
	}

	/** full constructor */
	public TSysDepart(String departid, String updepartid, String departname,
			String departnamePy, String description, String departtype,
			String city, String departcode, String cc, String linkname,
			String linktel, String state, String sfsn) {
		this.departid = departid;
		this.updepartid = updepartid;
		this.departname = departname;
		this.departnamePy = departnamePy;
		this.description = description;
		this.departtype = departtype;
		this.city = city;
		this.departcode = departcode;
		this.cc = cc;
		this.linkname = linkname;
		this.linktel = linktel;
		this.state = state;
		this.sfsn = sfsn;
	}

	// Property accessors

	public String getDepartid() {
		return this.departid;
	}

	public void setDepartid(String departid) {
		this.departid = departid;
	}

	public String getUpdepartid() {
		return this.updepartid;
	}

	public void setUpdepartid(String updepartid) {
		this.updepartid = updepartid;
	}

	public String getDepartname() {
		return this.departname;
	}

	public void setDepartname(String departname) {
		this.departname = departname;
	}

	public String getDepartnamePy() {
		return this.departnamePy;
	}

	public void setDepartnamePy(String departnamePy) {
		this.departnamePy = departnamePy;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDeparttype() {
		return this.departtype;
	}

	public void setDeparttype(String departtype) {
		this.departtype = departtype;
	}

	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDepartcode() {
		return this.departcode;
	}

	public void setDepartcode(String departcode) {
		this.departcode = departcode;
	}

	public String getCc() {
		return this.cc;
	}

	public void setCc(String cc) {
		this.cc = cc;
	}

	public String getLinkname() {
		return this.linkname;
	}

	public void setLinkname(String linkname) {
		this.linkname = linkname;
	}

	public String getLinktel() {
		return this.linktel;
	}

	public void setLinktel(String linktel) {
		this.linktel = linktel;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getSfsn() {
		return this.sfsn;
	}

	public void setSfsn(String sfsn) {
		this.sfsn = sfsn;
	}

}