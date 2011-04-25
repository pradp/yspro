package com.imchooser.infoms.entity.sys;

import java.util.Date;

/**
 * TSysMessageGxqf entity. @author MyEclipse Persistence Tools
 */

public class TSysMessageGxqf implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String wid;
	private String messageWid;
	private String xxjsr;
	private Date xxydsj;
	private String xxzt;
	private String sxxsc;
	private String fszt; // 新增字段,用于判断消息是否发送 0未未发送 1为发送

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
	public TSysMessageGxqf(String wid, String messageWid, String xxjsr, Date xxydsj, String xxzt, String sxxsc) {
		this.wid = wid;
		this.messageWid = messageWid;
		this.xxjsr = xxjsr;
		this.xxydsj = xxydsj;
		this.xxzt = xxzt;
		this.sxxsc = sxxsc;
	}

	// Property accessors

	public String getWid() {
		return this.wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	public String getMessageWid() {
		return this.messageWid;
	}

	public void setMessageWid(String messageWid) {
		this.messageWid = messageWid;
	}

	public String getXxjsr() {
		return this.xxjsr;
	}

	public void setXxjsr(String xxjsr) {
		this.xxjsr = xxjsr;
	}

	public Date getXxydsj() {
		return this.xxydsj;
	}

	public void setXxydsj(Date xxydsj) {
		this.xxydsj = xxydsj;
	}

	public String getXxzt() {
		return this.xxzt;
	}

	public void setXxzt(String xxzt) {
		this.xxzt = xxzt;
	}

	public String getSxxsc() {
		return this.sxxsc;
	}

	public void setSxxsc(String sxxsc) {
		this.sxxsc = sxxsc;
	}

	public String getFszt() {
		return fszt;
	}

	public void setFszt(String fszt) {
		this.fszt = fszt;
	}

}