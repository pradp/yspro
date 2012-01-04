package com.yszoe.sys.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TSysUserExt entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_USER_EXT", schema = "HXW")
public class TSysUserExt implements java.io.Serializable {

	// Fields

	private String userid;
	private String nc;
	private String lb1;
	private String lb2;
	private String lb3;
	private Short nl;
	private String xb;
	private String sf;
	private String cs;
	private String qx;
	private String lxfs;
	private String dwgm;
	private String szks;
	private String xl;
	private String zy;
	private String zc;
	private Byte gznx;
	private String sr;
	private String jbmc;
	private Date hbsj;
	private String tx;

	// Constructors

	/** default constructor */
	public TSysUserExt() {
	}

	/** minimal constructor */
	public TSysUserExt(String userid) {
		this.userid = userid;
	}

	/** full constructor */
	public TSysUserExt(String userid, String nc, String lb1, String lb2, String lb3, Short nl, String xb, String sf,
			String cs, String qx, String lxfs, String dwgm, String szks, String xl, String zy, String zc, Byte gznx,
			String sr, String jbmc, Date hbsj, String tx) {
		this.userid = userid;
		this.nc = nc;
		this.lb1 = lb1;
		this.lb2 = lb2;
		this.lb3 = lb3;
		this.nl = nl;
		this.xb = xb;
		this.sf = sf;
		this.cs = cs;
		this.qx = qx;
		this.lxfs = lxfs;
		this.dwgm = dwgm;
		this.szks = szks;
		this.xl = xl;
		this.zy = zy;
		this.zc = zc;
		this.gznx = gznx;
		this.sr = sr;
		this.jbmc = jbmc;
		this.hbsj = hbsj;
		this.tx = tx;
	}

	// Property accessors
	@Id
	@Column(name = "USERID", unique = true, nullable = false, length = 50)
	public String getUserid() {
		return this.userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Column(name = "NC", length = 50)
	public String getNc() {
		return this.nc;
	}

	public void setNc(String nc) {
		this.nc = nc;
	}

	@Column(name = "LB1", length = 2)
	public String getLb1() {
		return this.lb1;
	}

	public void setLb1(String lb1) {
		this.lb1 = lb1;
	}

	@Column(name = "LB2", length = 2)
	public String getLb2() {
		return this.lb2;
	}

	public void setLb2(String lb2) {
		this.lb2 = lb2;
	}

	@Column(name = "LB3", length = 2)
	public String getLb3() {
		return this.lb3;
	}

	public void setLb3(String lb3) {
		this.lb3 = lb3;
	}

	@Column(name = "NL", precision = 3, scale = 0)
	public Short getNl() {
		return this.nl;
	}

	public void setNl(Short nl) {
		this.nl = nl;
	}

	@Column(name = "XB", length = 2)
	public String getXb() {
		return this.xb;
	}

	public void setXb(String xb) {
		this.xb = xb;
	}

	@Column(name = "SF", length = 2)
	public String getSf() {
		return this.sf;
	}

	public void setSf(String sf) {
		this.sf = sf;
	}

	@Column(name = "CS", length = 2)
	public String getCs() {
		return this.cs;
	}

	public void setCs(String cs) {
		this.cs = cs;
	}

	@Column(name = "QX", length = 2)
	public String getQx() {
		return this.qx;
	}

	public void setQx(String qx) {
		this.qx = qx;
	}

	@Column(name = "LXFS", length = 12)
	public String getLxfs() {
		return this.lxfs;
	}

	public void setLxfs(String lxfs) {
		this.lxfs = lxfs;
	}

	@Column(name = "DWGM", length = 2)
	public String getDwgm() {
		return this.dwgm;
	}

	public void setDwgm(String dwgm) {
		this.dwgm = dwgm;
	}

	@Column(name = "SZKS", length = 20)
	public String getSzks() {
		return this.szks;
	}

	public void setSzks(String szks) {
		this.szks = szks;
	}

	@Column(name = "XL", length = 2)
	public String getXl() {
		return this.xl;
	}

	public void setXl(String xl) {
		this.xl = xl;
	}

	@Column(name = "ZY", length = 2)
	public String getZy() {
		return this.zy;
	}

	public void setZy(String zy) {
		this.zy = zy;
	}

	@Column(name = "ZC", length = 20)
	public String getZc() {
		return this.zc;
	}

	public void setZc(String zc) {
		this.zc = zc;
	}

	@Column(name = "GZNX", precision = 2, scale = 0)
	public Byte getGznx() {
		return this.gznx;
	}

	public void setGznx(Byte gznx) {
		this.gznx = gznx;
	}

	@Column(name = "SR", length = 2)
	public String getSr() {
		return this.sr;
	}

	public void setSr(String sr) {
		this.sr = sr;
	}

	@Column(name = "JBMC", length = 50)
	public String getJbmc() {
		return this.jbmc;
	}

	public void setJbmc(String jbmc) {
		this.jbmc = jbmc;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "HBSJ", length = 7)
	public Date getHbsj() {
		return this.hbsj;
	}

	public void setHbsj(Date hbsj) {
		this.hbsj = hbsj;
	}

	@Column(name = "TX")
	public String getTx() {
		return this.tx;
	}

	public void setTx(String tx) {
		this.tx = tx;
	}

}