package com.yszoe.biz.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TCsXm entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_CS_XM", schema = "HXW")
public class TCsXm implements java.io.Serializable {

	// Fields

	private String wid;
	private String name;
	private String jj;
	private String lx;
	private Double jg;
	private Long sycs;
	private String cjr;
	private Date cjsj;
	private String state;
	private Integer cssj;
	private Short ts;
	private String xxxx;

	// Constructors

	/** default constructor */
	public TCsXm() {
	}

	/** minimal constructor */
	public TCsXm(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public TCsXm(String wid, String name, String jj, String lx, Double jg, Long sycs, String cjr, Date cjsj,
			String state, Integer cssj, Short ts, String xxxx) {
		this.wid = wid;
		this.name = name;
		this.jj = jj;
		this.lx = lx;
		this.jg = jg;
		this.sycs = sycs;
		this.cjr = cjr;
		this.cjsj = cjsj;
		this.state = state;
		this.cssj = cssj;
		this.ts = ts;
		this.xxxx = xxxx;
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

	@Column(name = "NAME", length = 50)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "JJ", length = 600)
	public String getJj() {
		return this.jj;
	}

	public void setJj(String jj) {
		this.jj = jj;
	}

	@Column(name = "LX", length = 50)
	public String getLx() {
		return this.lx;
	}

	public void setLx(String lx) {
		this.lx = lx;
	}

	@Column(name = "JG", precision = 8)
	public Double getJg() {
		return this.jg;
	}

	public void setJg(Double jg) {
		this.jg = jg;
	}

	@Column(name = "SYCS", precision = 12, scale = 0)
	public Long getSycs() {
		return this.sycs;
	}

	public void setSycs(Long sycs) {
		this.sycs = sycs;
	}

	@Column(name = "CJR", length = 50)
	public String getCjr() {
		return this.cjr;
	}

	public void setCjr(String cjr) {
		this.cjr = cjr;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "CJSJ", length = 7)
	public Date getCjsj() {
		return this.cjsj;
	}

	public void setCjsj(Date cjsj) {
		this.cjsj = cjsj;
	}

	@Column(name = "STATE", length = 2)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "CSSJ", precision = 5, scale = 0)
	public Integer getCssj() {
		return this.cssj;
	}

	public void setCssj(Integer cssj) {
		this.cssj = cssj;
	}

	@Column(name = "TS", precision = 4, scale = 0)
	public Short getTs() {
		return this.ts;
	}

	public void setTs(Short ts) {
		this.ts = ts;
	}

	@Column(name = "XXXX")
	public String getXxxx() {
		return this.xxxx;
	}

	public void setXxxx(String xxxx) {
		this.xxxx = xxxx;
	}

}