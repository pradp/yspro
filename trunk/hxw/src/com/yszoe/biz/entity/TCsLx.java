package com.yszoe.biz.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TCsLx entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_CS_LX", schema = "HXW")
public class TCsLx implements java.io.Serializable {

	// Fields

	private String wid;
	private String lx;
	private String jj;
	private String state;
	private String cjr;
	private Date cjsj;

	// Constructors

	/** default constructor */
	public TCsLx() {
	}

	/** minimal constructor */
	public TCsLx(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public TCsLx(String wid, String lx, String jj, String state, String cjr, Date cjsj) {
		this.wid = wid;
		this.lx = lx;
		this.jj = jj;
		this.state = state;
		this.cjr = cjr;
		this.cjsj = cjsj;
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

	@Column(name = "LX", length = 20)
	public String getLx() {
		return this.lx;
	}

	public void setLx(String lx) {
		this.lx = lx;
	}

	@Column(name = "JJ", length = 200)
	public String getJj() {
		return this.jj;
	}

	public void setJj(String jj) {
		this.jj = jj;
	}

	@Column(name = "STATE", length = 2)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "CJR", length = 50)
	public String getCjr() {
		return this.cjr;
	}

	public void setCjr(String cjr) {
		this.cjr = cjr;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "CJSJ")
	public Date getCjsj() {
		return this.cjsj;
	}

	public void setCjsj(Date cjsj) {
		this.cjsj = cjsj;
	}

}