package com.yszoe.identity.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * TSysDepart entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_DEPART")
public class TSysDepart implements java.io.Serializable {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private String departid;
	private String updepartid;
	private String departname;
	private String departnamePy;
	private String description;
	private String departtype;
	private String city;
	private String departcode;
	private String depth;
	private String linkname;
	private String linktel;
	private String state;
	private String linkfax;
	private String linkemail;
	private String linkaddress;
	private String linkpostcode;
	private String email;

	private String updepartname; // 用于显示上级用户名,非持久化
	private String cityname; // 用于显示城市名,非持久化

	// Constructors

	/** default constructor */
	public TSysDepart() {
	}

	/** minimal constructor */
	public TSysDepart(String departid) {
		this.departid = departid;
	}

	public TSysDepart(String departid, String updepartid, String departname, String departtype, String city,
			String departcode, String state) {
		this.departid = departid;
		this.updepartid = updepartid;
		this.departname = departname;
		this.departtype = departtype;
		this.city = city;
		this.departcode = departcode;
		this.state = state;
	}

	public TSysDepart(String departid, String updepartid, String departname, String departnamePy, String description,
			String departtype, String city, String departcode, String depth, String linkname, String linktel,
			String state, String linkfax, String linkemail, String linkaddress, String linkpostcode) {
		super();
		this.departid = departid;
		this.updepartid = updepartid;
		this.departname = departname;
		this.departnamePy = departnamePy;
		this.description = description;
		this.departtype = departtype;
		this.city = city;
		this.departcode = departcode;
		this.depth = depth;
		this.linkname = linkname;
		this.linktel = linktel;
		this.state = state;
		this.linkfax = linkfax;
		this.linkemail = linkemail;
		this.linkaddress = linkaddress;
		this.linkpostcode = linkpostcode;
	}

	/** full constructor */
	public TSysDepart(String departid, String updepartid, String departname, String departnamePy, String description,
			String departtype, String city, String departcode, String depth, String linkname, String linktel,
			String state, String linkfax, String linkemail, String linkaddress, String linkpostcode, String email) {
		super();
		this.departid = departid;
		this.updepartid = updepartid;
		this.departname = departname;
		this.departnamePy = departnamePy;
		this.description = description;
		this.departtype = departtype;
		this.city = city;
		this.departcode = departcode;
		this.depth = depth;
		this.linkname = linkname;
		this.linktel = linktel;
		this.state = state;
		this.linkfax = linkfax;
		this.linkemail = linkemail;
		this.linkaddress = linkaddress;
		this.linkpostcode = linkpostcode;
		this.email = email;
	}

	// Property accessors
	@Id
	@Column(name = "DEPARTID", unique = true, nullable = false, length = 50)
	public String getDepartid() {
		return this.departid;
	}

	public void setDepartid(String departid) {
		this.departid = departid;
	}

	@Column(name = "UPDEPARTID", length = 50)
	public String getUpdepartid() {
		return this.updepartid;
	}

	public void setUpdepartid(String updepartid) {
		this.updepartid = updepartid;
	}

	@Column(name = "DEPARTNAME", length = 100)
	public String getDepartname() {
		return this.departname;
	}

	public void setDepartname(String departname) {
		this.departname = departname;
	}

	@Column(name = "DEPARTNAME_PY", length = 50)
	public String getDepartnamePy() {
		return this.departnamePy;
	}

	public void setDepartnamePy(String departnamePy) {
		this.departnamePy = departnamePy;
	}

	@Column(name = "DESCRIPTION", length = 2000)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "DEPARTTYPE", length = 3)
	public String getDeparttype() {
		return this.departtype;
	}

	public void setDeparttype(String departtype) {
		this.departtype = departtype;
	}

	@Column(name = "CITY", length = 50)
	public String getCity() {
		return this.city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	@Column(name = "DEPARTCODE", length = 30)
	public String getDepartcode() {
		return this.departcode;
	}

	public void setDepartcode(String departcode) {
		this.departcode = departcode;
	}

	@Column(name = "DEPTH", length = 10)
	public String getDepth() {
		return depth;
	}

	public void setDepth(String depth) {
		this.depth = depth;
	}

	@Column(name = "LINKNAME", length = 20)
	public String getLinkname() {
		return this.linkname;
	}

	public void setLinkname(String linkname) {
		this.linkname = linkname;
	}

	@Column(name = "LINKTEL", length = 50)
	public String getLinktel() {
		return this.linktel;
	}

	public void setLinktel(String linktel) {
		this.linktel = linktel;
	}

	@Column(name = "STATE", length = 1)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "LINKFAX", length = 50)
	public String getLinkfax() {
		return linkfax;
	}

	public void setLinkfax(String linkfax) {
		this.linkfax = linkfax;
	}

	@Column(name = "LINKEMAIL", length = 50)
	public String getLinkemail() {
		return linkemail;
	}

	public void setLinkemail(String linkemail) {
		this.linkemail = linkemail;
	}

	@Column(name = "LINKADDRESS", length = 120)
	public String getLinkaddress() {
		return linkaddress;
	}

	public void setLinkaddress(String linkaddress) {
		this.linkaddress = linkaddress;
	}

	@Column(name = "LINKPOSTCODE", length = 8)
	public String getLinkpostcode() {
		return linkpostcode;
	}

	public void setLinkpostcode(String linkpostcode) {
		this.linkpostcode = linkpostcode;
	}
	@Column(name = "EMAIL", length = 50)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Transient
	public String getUpdepartname() {
		return updepartname;
	}

	public void setUpdepartname(String updepartname) {
		this.updepartname = updepartname;
	}

	@Transient
	public String getCityname() {
		return cityname;
	}

	public void setCityname(String cityname) {
		this.cityname = cityname;
	}

}