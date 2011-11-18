package com.yszoe.sys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TSysCodesort entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_CODESORT")
public class TSysCodesort implements java.io.Serializable {

	// Fields

	private String zdlb;
	private String lbmc;

	// Constructors

	/** default constructor */
	public TSysCodesort() {
	}

	/** minimal constructor */
	public TSysCodesort(String zdlb) {
		this.zdlb = zdlb;
	}

	/** full constructor */
	public TSysCodesort(String zdlb, String lbmc) {
		this.zdlb = zdlb;
		this.lbmc = lbmc;
	}

	// Property accessors
	@Id
	@Column(name = "ZDLB", unique = true, nullable = false, length = 50)
	public String getZdlb() {
		return this.zdlb;
	}

	public void setZdlb(String zdlb) {
		this.zdlb = zdlb;
	}

	@Column(name = "LBMC", length = 50)
	public String getLbmc() {
		return this.lbmc;
	}

	public void setLbmc(String lbmc) {
		this.lbmc = lbmc;
	}

}