package com.yszoe.cms.entity;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.annotations.Type;

/**
 * TXxfbWz entity. @author MyEclipse Persistence Tools
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "T_XXFB_WZ")
public class TXxfbWz implements java.io.Serializable {

	// Fields

	private String wid;
	private String lmwid;
	private String bt;
	private String fbt;
	private String nr;
	private Date shrq;
	private String sftj;
	private String sfsyxs;
	private String ly;
	private String cjr;
	private String cjrName;// 非持久化；
	private String sfpl;
	private int ordernum;
	private String wzzd;//非持久化；文章置顶
	private Date cjrq;
	private long djs;
	private String state;
	private long pls;// 非持久化；评论数
	private Date zhxgrq;
	private Date zhxgrqStart;// 非持久化；
	private Date zhxgrqEnd;// 非持久化；
	private String shyj;
	private String gjz;
	private String syydt;
//	private File syydtFile;// 非持久化；
	private String wzlx;
	private String bturl;
	private String zy;

	// Constructors

	/** default constructor */
	public TXxfbWz() {
	}

	/** 前台 list page constructor */
	public TXxfbWz(String wid, String lmwid, String bt, String ly, String sftj, 
			int ordernum, long pls, Date zhxgrq, long djs, String wzlx, String bturl) {
		this.wid = wid;
		this.lmwid = lmwid;
		this.bt = bt;
		this.sftj = sftj;
		this.ly = ly;
		this.ordernum = ordernum;
		this.pls = pls;
		this.zhxgrq = zhxgrq;
		this.djs = djs;
		this.wzlx = wzlx;
		this.bturl = bturl;
	}

	/** 后台 list page constructor */
	public TXxfbWz(String wid, String lmwid, String bt, Date shrq, String cjr, Date cjrq, String sfpl, 
			int ordernum, long pls, long djs, String state, Date zhxgrq, String shyj, String wzlx) {
		this.wid = wid;
		this.lmwid = lmwid;
		this.bt = bt;
		this.shrq = shrq;
		this.cjr = cjr;
		this.cjrq = cjrq;
		this.sfpl = sfpl;
		this.ordernum = ordernum;
		this.pls = pls;
		this.djs = djs;
		this.state = state;
		this.zhxgrq = zhxgrq;
		this.shyj = shyj;
		this.wzlx = wzlx;
	}

	/** entity full constructor */
	public TXxfbWz(String wid, String lmwid, String bt, String fbt, String nr, Date shrq, String sftj, String sfsyxs,
			String ly, String cjr, String sfpl, int ordernum, Date cjrq, long djs, String state, long pls,
			Date zhxgrq, String shyj) {
		super();
		this.wid = wid;
		this.lmwid = lmwid;
		this.bt = bt;
		this.fbt = fbt;
		this.nr = nr;
		this.shrq = shrq;
		this.sftj = sftj;
		this.sfsyxs = sfsyxs;
		this.ly = ly;
		this.cjr = cjr;
		this.sfpl = sfpl;
		this.ordernum = ordernum;
		this.cjrq = cjrq;
		this.djs = djs;
		this.state = state;
		this.pls = pls;
		this.zhxgrq = zhxgrq;
		this.shyj = shyj;
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

	@Column(name = "LMWID", nullable = false, length = 50)
	public String getLmwid() {
		return this.lmwid;
	}

	public void setLmwid(String lmwid) {
		this.lmwid = lmwid;
	}

	@Column(name = "BT", length = 90)
	public String getBt() {
		return this.bt;
	}

	public void setBt(String bt) {
		this.bt = bt;
	}

	@Column(name = "FBT", length = 60)
	public String getFbt() {
		return this.fbt;
	}

	public void setFbt(String fbt) {
		this.fbt = fbt;
	}

	@Type(type="text")
	@Column(name = "NR")
	public String getNr() {
		return this.nr;
	}

	public void setNr(String nr) {
		this.nr = nr;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "SHRQ")
	public Date getShrq() {
		return this.shrq;
	}

	public void setShrq(Date shrq) {
		this.shrq = shrq;
	}

	@Column(name = "SFTJ", length = 2)
	public String getSftj() {
		return this.sftj;
	}

	public void setSftj(String sftj) {
		this.sftj = sftj;
	}

	@Column(name = "SFSYXS", length = 2)
	public String getSfsyxs() {
		return this.sfsyxs;
	}

	public void setSfsyxs(String sfsyxs) {
		this.sfsyxs = sfsyxs;
	}

	@Column(name = "LY", length = 50)
	public String getLy() {
		return this.ly;
	}

	public void setLy(String ly) {
		this.ly = ly;
	}

	@Column(name = "CJR", length = 50, updatable = false, nullable = false)
	public String getCjr() {
		return this.cjr;
	}

	public void setCjr(String cjr) {
		this.cjr = cjr;
	}

	@Column(name = "SFPL", length = 2)
	public String getSfpl() {
		return this.sfpl;
	}

	public void setSfpl(String sfpl) {
		this.sfpl = sfpl;
	}

	@Column(name = "ORDERNUM", precision = 6, scale = 0)
	public int getOrdernum() {
		return this.ordernum;
	}

	public void setOrdernum(int ordernum) {
		this.ordernum = ordernum;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "CJRQ", updatable = false, nullable = false)
	public Date getCjrq() {
		return this.cjrq;
	}

	public void setCjrq(Date cjrq) {
		this.cjrq = cjrq;
	}

	@Column(name = "DJS", precision = 8, scale = 0)
	public long getDjs() {
		return this.djs;
	}

	public void setDjs(long djs) {
		this.djs = djs;
	}

	@Column(name = "STATE", length = 2)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Transient
	public long getPls() {
		return pls;
	}

	public void setPls(long pls) {
		this.pls = pls;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "ZHXGRQ")
	public Date getZhxgrq() {
		return zhxgrq;
	}

	public void setZhxgrq(Date zhxgrq) {
		this.zhxgrq = zhxgrq;
	}

	@Column(name = "SHYJ", length = 900)
	public String getShyj() {
		return shyj;
	}

	public void setShyj(String shyj) {
		this.shyj = shyj;
	}

	@Transient
	public String getCjrName() {
		return cjrName;
	}

	public void setCjrName(String cjrName) {
		this.cjrName = cjrName;
	}

	@Transient
	public Date getZhxgrqStart() {
		return zhxgrqStart;
	}

	public void setZhxgrqStart(Date zhxgrqStart) {
		this.zhxgrqStart = zhxgrqStart;
	}

	@Transient
	public Date getZhxgrqEnd() {
		return zhxgrqEnd;
	}

	public void setZhxgrqEnd(Date zhxgrqEnd) {
		this.zhxgrqEnd = zhxgrqEnd;
	}

	@Column(name = "GJZ", length = 60)
	public String getGjz() {
		return gjz;
	}

	public void setGjz(String gjz) {
		this.gjz = gjz;
	}

	@Column(name = "SYYDT", length = 50)
	public String getSyydt() {
		return syydt;
	}

	public void setSyydt(String syydt) {
		this.syydt = syydt;
	}

	@Column(name = "WZLX", length = 2)
	public String getWzlx() {
		return wzlx;
	}

	public void setWzlx(String wzlx) {
		this.wzlx = wzlx;
	}

	@Column(name = "BTURL", length = 150)
	public String getBturl() {
		return bturl;
	}

	public void setBturl(String bturl) {
		this.bturl = bturl;
	}

	@Column(name = "ZY", length = 600)
	public String getZy() {
		return zy;
	}

	public void setZy(String zy) {
		this.zy = zy;
	}

	@Transient
	public String getWzzd() {
		return wzzd;
	}

	public void setWzzd(String wzzd) {
		this.wzzd = wzzd;
	}

}