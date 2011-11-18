package com.yszoe.sys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * TSysArea entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_AREA")
public class TSysArea implements java.io.Serializable {

	// Fields

	private String areaid;
	private String areaname;
	private String upareaid;
	private String upareaname;// 手工添加
	private String state;
	private String arealevel;
	private String gbm; // 新增字段,国标码
	private Integer ordernum; // 排序号,从大到小排

	// Constructors

	/** default constructor */
	public TSysArea() {
	}

	/** minimal constructor */
	public TSysArea(String areaid, String areaname, String upareaid, String state) {
		this.areaid = areaid;
		this.areaname = areaname;
		this.upareaid = upareaid;
		this.state = state;
	}

	public TSysArea(String areaid, String areaname, String upareaid, String state, String arealevel) {
		this.areaid = areaid;
		this.areaname = areaname;
		this.upareaid = upareaid;
		this.state = state;
		this.arealevel = arealevel;
	}

	public TSysArea(String areaid, String areaname, String upareaid, String upareaname, String state, String arealevel,
			String gbm) {
		super();
		this.areaid = areaid;
		this.areaname = areaname;
		this.upareaid = upareaid;
		this.upareaname = upareaname;
		this.state = state;
		this.arealevel = arealevel;
		this.gbm = gbm;
	}

	/** full constructor */
	public TSysArea(String areaid, String areaname, String upareaid, String upareaname, String state, String arealevel,
			String gbm, Integer ordernum) {
		this.areaid = areaid;
		this.areaname = areaname;
		this.upareaid = upareaid;
		this.upareaname = upareaname;
		this.state = state;
		this.arealevel = arealevel;
		this.gbm = gbm;
		this.ordernum = ordernum;
	}

	// Property accessors
	@Id
	@Column(name = "AREAID", unique = true, nullable = false, length = 50)
	public String getAreaid() {
		return this.areaid;
	}

	public void setAreaid(String areaid) {
		this.areaid = areaid;
	}

	@Column(name = "AREANAME", nullable = false, length = 300)
	public String getAreaname() {
		return this.areaname;
	}

	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}

	@Column(name = "UPAREAID", nullable = false, length = 50)
	public String getUpareaid() {
		return this.upareaid;
	}

	public void setUpareaid(String upareaid) {
		this.upareaid = upareaid;
	}

	@Column(name = "STATE", nullable = false, length = 1)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "AREALEVEL", length = 50)
	public String getArealevel() {
		return this.arealevel;
	}

	public void setArealevel(String arealevel) {
		this.arealevel = arealevel;
	}

	@Column(name = "GBM", length = 50)
	public String getGbm() {
		return gbm;
	}

	public void setGbm(String gbm) {
		this.gbm = gbm;
	}

	@Transient
	public String getUpareaname() {
		return upareaname;
	}

	public void setUpareaname(String upareaname) {
		this.upareaname = upareaname;
	}

	@Column(name = "ORDERNUM", length = 6)
	public Integer getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(Integer ordernum) {
		this.ordernum = ordernum;
	}

}