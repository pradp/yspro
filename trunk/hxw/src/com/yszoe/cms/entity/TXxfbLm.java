package com.yszoe.cms.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;

/**
 * TXxfbLm entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_XXFB_LM", uniqueConstraints = @UniqueConstraint(columnNames = "LMBM"))
public class TXxfbLm implements java.io.Serializable {

	// Fields

	private String wid;
	private String lmmc;
	private String state;
	private String parentwid;
	private String zcrss;
	private String yxwygg;
	private String memo;
	private String sfpl;
	private int ordernum;
	private String lmbm;
	private long children;

	// Constructors

	/** default constructor */
	public TXxfbLm() {
	}

	/** minimal constructor */
	public TXxfbLm(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public TXxfbLm(String wid, String lmmc, String state, String parentwid, String zcrss, 
			String yxwygg, String memo, String sfpl, int ordernum, String lmbm, long children) {
		this.wid = wid;
		this.lmmc = lmmc;
		this.state = state;
		this.parentwid = parentwid;
		this.zcrss = zcrss;
		this.yxwygg = yxwygg;
		this.memo = memo;
		this.sfpl = sfpl;
		this.ordernum = ordernum;
		this.lmbm = lmbm;
		this.children = children;
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

	@Column(name = "LMMC", length = 50)
	public String getLmmc() {
		return this.lmmc;
	}

	public void setLmmc(String lmmc) {
		this.lmmc = lmmc;
	}

	@Column(name = "STATE", length = 2)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "PARENTWID", length = 50)
	public String getParentwid() {
		return this.parentwid;
	}

	public void setParentwid(String parentwid) {
		this.parentwid = parentwid;
	}

	@Column(name = "ZCRSS", length = 2)
	public String getZcrss() {
		return this.zcrss;
	}

	public void setZcrss(String zcrss) {
		this.zcrss = zcrss;
	}

	@Column(name = "YXWYGG", length = 2)
	public String getYxwygg() {
		return this.yxwygg;
	}

	public void setYxwygg(String yxwygg) {
		this.yxwygg = yxwygg;
	}

	@Column(name = "MEMO", length = 600)
	public String getMemo() {
		return this.memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	@Column(name = "SFPL", length = 2)
	public String getSfpl() {
		return sfpl;
	}

	public void setSfpl(String sfpl) {
		this.sfpl = sfpl;
	}

	@Column(name = "ORDERNUM", precision = 6, scale = 0)
	public int getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(int ordernum) {
		this.ordernum = ordernum;
	}

	@Column(name = "LMBM", unique = true, length = 50)
	public String getLmbm() {
		return lmbm;
	}

	public void setLmbm(String lmbm) {
		this.lmbm = lmbm;
	}

	@Transient
	public long getChildren() {
		return children;
	}

	public void setChildren(long children) {
		this.children = children;
	}

}