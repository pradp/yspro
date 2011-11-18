package com.yszoe.sys.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TSysMessageGxqf entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_MESSAGE_GXQF")
public class TSysMessageGxqf implements java.io.Serializable {

	// Fields

	private String wid;
	private String messageWid;
	private String xxjsr;
	private Date xxydsj;
	private String xxzt;
	private String sxxsc;
	private String fszt;

	// Constructors

	/** default constructor */
	public TSysMessageGxqf() {
	}

	/** minimal constructor */
	public TSysMessageGxqf(String wid, String messageWid) {
		this.wid = wid;
		this.messageWid = messageWid;
	}

	/** full constructor */
	public TSysMessageGxqf(String wid, String messageWid, String xxjsr, Date xxydsj, String xxzt, String sxxsc,
			String fszt) {
		this.wid = wid;
		this.messageWid = messageWid;
		this.xxjsr = xxjsr;
		this.xxydsj = xxydsj;
		this.xxzt = xxzt;
		this.sxxsc = sxxsc;
		this.fszt = fszt;
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

	@Column(name = "MESSAGE_WID", nullable = false, length = 50)
	public String getMessageWid() {
		return this.messageWid;
	}

	public void setMessageWid(String messageWid) {
		this.messageWid = messageWid;
	}

	@Column(name = "XXJSR", length = 50)
	public String getXxjsr() {
		return this.xxjsr;
	}

	public void setXxjsr(String xxjsr) {
		this.xxjsr = xxjsr;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "XXYDSJ", length = 7)
	public Date getXxydsj() {
		return this.xxydsj;
	}

	public void setXxydsj(Date xxydsj) {
		this.xxydsj = xxydsj;
	}

	@Column(name = "XXZT", length = 50)
	public String getXxzt() {
		return this.xxzt;
	}

	public void setXxzt(String xxzt) {
		this.xxzt = xxzt;
	}

	@Column(name = "SXXSC", length = 50)
	public String getSxxsc() {
		return this.sxxsc;
	}

	public void setSxxsc(String sxxsc) {
		this.sxxsc = sxxsc;
	}

	@Column(name = "FSZT", length = 2)
	public String getFszt() {
		return this.fszt;
	}

	public void setFszt(String fszt) {
		this.fszt = fszt;
	}

}