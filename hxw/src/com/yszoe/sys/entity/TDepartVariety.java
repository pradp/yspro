package com.yszoe.sys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * TDepartVariety entity. @author MyEclipse Persistence Tools
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "T_DEPART_VARIETY")
public class TDepartVariety implements java.io.Serializable {

	// Fields

	private String wid;
	private String departid;
	private String pz;
	private String px;
	private Integer jcmxqcl;
	private Integer jcgxqcl;
	private Integer hbmxqcl;
	private Integer hbgxqcl;
	private String dc;
	
	private String xz;//只做查询用

	// Constructors

	/** default constructor */
	public TDepartVariety() {
	}

	/** minimal constructor */
	public TDepartVariety(String wid, String departid) {
		this.wid = wid;
		this.departid = departid;
	}

	/** full constructor */
	public TDepartVariety(String wid, String departid, String pz, String px, Integer jcmxqcl, Integer jcgxqcl,
			Integer hbmxqcl, Integer hbgxqcl, String dc) {
		this.wid = wid;
		this.departid = departid;
		this.pz = pz;
		this.px = px;
		this.jcmxqcl = jcmxqcl;
		this.jcgxqcl = jcgxqcl;
		this.hbmxqcl = hbmxqcl;
		this.hbgxqcl = hbgxqcl;
		this.dc = dc;
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

	@Column(name = "DEPARTID", nullable = false, length = 50)
	public String getDepartid() {
		return this.departid;
	}

	public void setDepartid(String departid) {
		this.departid = departid;
	}

	@Column(name = "PZ", length = 4)
	public String getPz() {
		return this.pz;
	}

	public void setPz(String pz) {
		this.pz = pz;
	}

	@Column(name = "PX", length = 4)
	public String getPx() {
		return this.px;
	}

	public void setPx(String px) {
		this.px = px;
	}

	@Column(name = "JCMXQCL", precision = 8, scale = 0)
	public Integer getJcmxqcl() {
		return this.jcmxqcl;
	}

	public void setJcmxqcl(Integer jcmxqcl) {
		this.jcmxqcl = jcmxqcl;
	}

	@Column(name = "JCGXQCL", precision = 8, scale = 0)
	public Integer getJcgxqcl() {
		return this.jcgxqcl;
	}

	public void setJcgxqcl(Integer jcgxqcl) {
		this.jcgxqcl = jcgxqcl;
	}

	@Column(name = "HBMXQCL", precision = 8, scale = 0)
	public Integer getHbmxqcl() {
		return this.hbmxqcl;
	}

	public void setHbmxqcl(Integer hbmxqcl) {
		this.hbmxqcl = hbmxqcl;
	}

	@Column(name = "HBGXQCL", precision = 8, scale = 0)
	public Integer getHbgxqcl() {
		return this.hbgxqcl;
	}

	public void setHbgxqcl(Integer hbgxqcl) {
		this.hbgxqcl = hbgxqcl;
	}

	@Column(name = "DC", length = 2)
	public String getDc() {
		return this.dc;
	}

	public void setDc(String dc) {
		this.dc = dc;
	}
	@Transient 
	public String getXz() {
		return xz;
	}

	public void setXz(String xz) {
		this.xz = xz;
	}

}