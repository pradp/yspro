package com.yszoe.sys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * TSysCode entity. @author MyEclipse Persistence Tools
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "T_SYS_CODE")
public class TSysCode implements java.io.Serializable {

	// Fields

	private String wid;
	private String zdbm;
	private String zdmc;
	private String zdcc;
	private String sjdm;
	private String sfsy;
	private String zdlb;
	private String zs;

	private String lbmc;

	// Constructors

	/** default constructor */
	public TSysCode() {
	}

	/** minimal constructor */
	public TSysCode(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public TSysCode(String wid, String zdbm, String zdmc, String zdcc, String sjdm, String sfsy, String zdlb,
			String zs, String lbmc) {
		this.wid = wid;
		this.zdbm = zdbm;
		this.zdmc = zdmc;
		this.zdcc = zdcc;
		this.sjdm = sjdm;
		this.sfsy = sfsy;
		this.zdlb = zdlb;
		this.zs = zs;
		this.lbmc = lbmc;
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

	@Column(name = "ZDBM", length = 50)
	public String getZdbm() {
		return this.zdbm;
	}

	public void setZdbm(String zdbm) {
		this.zdbm = zdbm;
	}

	@Column(name = "ZDMC", length = 300)
	public String getZdmc() {
		return this.zdmc;
	}

	public void setZdmc(String zdmc) {
		this.zdmc = zdmc;
	}

	@Column(name = "ZDCC", length = 2)
	public String getZdcc() {
		return this.zdcc;
	}

	public void setZdcc(String zdcc) {
		this.zdcc = zdcc;
	}

	@Column(name = "SJDM", length = 50)
	public String getSjdm() {
		return this.sjdm;
	}

	public void setSjdm(String sjdm) {
		this.sjdm = sjdm;
	}

	@Column(name = "SFSY", length = 1)
	public String getSfsy() {
		return this.sfsy;
	}

	public void setSfsy(String sfsy) {
		this.sfsy = sfsy;
	}

	@Column(name = "ZDLB", length = 50)
	public String getZdlb() {
		return this.zdlb;
	}

	public void setZdlb(String zdlb) {
		this.zdlb = zdlb;
	}

	@Column(name = "ZS", length = 150)
	public String getZs() {
		return zs;
	}

	public void setZs(String zs) {
		this.zs = zs;
	}

	@Transient
	public String getLbmc() {
		return lbmc;
	}

	public void setLbmc(String lbmc) {
		this.lbmc = lbmc;
	}

}