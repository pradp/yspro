package com.yszoe.cms.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 * TXxfbPl entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XXFB_PL")
public class TXxfbPl implements java.io.Serializable {

	// Fields

	private String wid;
	private String wzwid;
	private String wzbt;//手动添加，非持久化
	private String lmmc;//手动添加，非持久化
	private String plr;
	private String plrName;//手动添加，非持久化
	private String plnr;
	private String plrip;
	private Date plsj;
	private Date plsjStart;//手动添加，非持久化
	private Date plsjEnd;//手动添加，非持久化
	private String state;

	// Constructors

	/** default constructor */
	public TXxfbPl() {
	}

	/** full constructor */
	public TXxfbPl(String wid, String wzwid, String plr, String plnr, String plrip, Date plsj, String state) {
		this.wid = wid;
		this.wzwid = wzwid;
		this.plr = plr;
		this.plnr = plnr;
		this.plrip = plrip;
		this.plsj = plsj;
		this.state = state;
	}

	/** 前台评论列表页面  constructor */
	public TXxfbPl(String wid, String plr, String plrName, String plnr, Date plsj) {
		this.wid = wid;
		this.plr = plr;
		this.plnr = plnr;
		this.plrName = plrName;
		this.plsj = plsj;
	}

	/** list page constructor */
	public TXxfbPl(String wid, String wzwid, String wzbt, String lmmc, String plr, String plrName, String plnr, String plrip, Date plsj, String state) {
		this.wid = wid;
		this.wzwid = wzwid;
		this.wzbt = wzbt;
		this.lmmc = lmmc;
		this.plr = plr;
		this.plrName = plrName;
		this.plnr = plnr;
		this.plrip = plrip;
		this.plsj = plsj;
		this.state = state;
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

	@Column(name = "WZWID", nullable = false, length = 50)
	public String getWzwid() {
		return this.wzwid;
	}

	public void setWzwid(String wzwid) {
		this.wzwid = wzwid;
	}

	@Transient
	public String getWzbt() {
		return wzbt;
	}

	public void setWzbt(String wzbt) {
		this.wzbt = wzbt;
	}

	@Column(name = "PLR", length = 50, updatable=false)
	public String getPlr() {
		return this.plr;
	}

	public void setPlr(String plr) {
		this.plr = plr;
	}

	@Transient
	public String getPlrName() {
		return plrName;
	}

	public void setPlrName(String plrName) {
		this.plrName = plrName;
	}

	@Column(name = "PLNR", length = 3000)
	public String getPlnr() {
		return this.plnr;
	}

	public void setPlnr(String plnr) {
		this.plnr = plnr;
	}

	@Column(name = "PLRIP", length = 30)
	public String getPlrip() {
		return this.plrip;
	}

	public void setPlrip(String plrip) {
		this.plrip = plrip;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "PLSJ", length = 7, updatable = false, nullable = false)
	public Date getPlsj() {
		return this.plsj;
	}

	public void setPlsj(Date plsj) {
		this.plsj = plsj;
	}

	@Column(name = "STATE", length = 2)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Transient
	public Date getPlsjStart() {
		return plsjStart;
	}

	public void setPlsjStart(Date plsjStart) {
		this.plsjStart = plsjStart;
	}

	@Transient
	public Date getPlsjEnd() {
		return plsjEnd;
	}

	public void setPlsjEnd(Date plsjEnd) {
		this.plsjEnd = plsjEnd;
	}

	@Transient
	public String getLmmc() {
		return lmmc;
	}

	public void setLmmc(String lmmc) {
		this.lmmc = lmmc;
	}

}