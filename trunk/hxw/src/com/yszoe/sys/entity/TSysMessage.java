package com.yszoe.sys.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TSysMessage entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_MESSAGE")
public class TSysMessage implements java.io.Serializable {

	// Fields

	private String wid;
	private String xxly;
	private String xxfsr;
	private Date xxfssj;
	private String xxnr;
	private String xxbt;
	private String fxxsc;
	private String fszt;
	private String fj;
	private String fjm;

	// Constructors

	/** default constructor */
	public TSysMessage() {
	}

	/** minimal constructor */
	public TSysMessage(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public TSysMessage(String wid, String xxly, String xxfsr, Date xxfssj, String xxnr, String xxbt, String fxxsc,
			String fszt, String fj, String fjm) {
		this.wid = wid;
		this.xxly = xxly;
		this.xxfsr = xxfsr;
		this.xxfssj = xxfssj;
		this.xxnr = xxnr;
		this.xxbt = xxbt;
		this.fxxsc = fxxsc;
		this.fszt = fszt;
		this.fj = fj;
		this.fjm = fjm;
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

	@Column(name = "XXLY", length = 50)
	public String getXxly() {
		return this.xxly;
	}

	public void setXxly(String xxly) {
		this.xxly = xxly;
	}

	@Column(name = "XXFSR", length = 50)
	public String getXxfsr() {
		return this.xxfsr;
	}

	public void setXxfsr(String xxfsr) {
		this.xxfsr = xxfsr;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "XXFSSJ", length = 7)
	public Date getXxfssj() {
		return this.xxfssj;
	}

	public void setXxfssj(Date xxfssj) {
		this.xxfssj = xxfssj;
	}

	@Column(name = "XXNR", length = 1200)
	public String getXxnr() {
		return this.xxnr;
	}

	public void setXxnr(String xxnr) {
		this.xxnr = xxnr;
	}

	@Column(name = "XXBT", length = 50)
	public String getXxbt() {
		return this.xxbt;
	}

	public void setXxbt(String xxbt) {
		this.xxbt = xxbt;
	}

	@Column(name = "FXXSC", length = 50)
	public String getFxxsc() {
		return this.fxxsc;
	}

	public void setFxxsc(String fxxsc) {
		this.fxxsc = fxxsc;
	}

	@Column(name = "FSZT", length = 2)
	public String getFszt() {
		return this.fszt;
	}

	public void setFszt(String fszt) {
		this.fszt = fszt;
	}

	@Column(name = "FJ")
	public String getFj() {
		return this.fj;
	}

	public void setFj(String fj) {
		this.fj = fj;
	}

	@Column(name = "FJM", length = 50)
	public String getFjm() {
		return this.fjm;
	}

	public void setFjm(String fjm) {
		this.fjm = fjm;
	}

}