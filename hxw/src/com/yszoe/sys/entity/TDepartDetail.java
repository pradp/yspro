package com.yszoe.sys.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 * TDepartDetail entity. @author MyEclipse Persistence Tools
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "T_DEPART_DETAIL")
public class TDepartDetail implements java.io.Serializable {

	// Fields

	private String departid;
	private String xkzbh;
	private String dwxz;
	private String xz;
	private String frdb;
	private Date yxq;
	private Date djsj;
	private Date shsj;
	private String jd;
	private String wd;
	private String zxqct;
	private String bh;
	private String bz;

	private String departname;// t_sys_depart表相应字段，只做查询用
	private String city;// t_sys_depart表相应字段，只做查询用
	private String state;// t_sys_depart表相应字段，只做查询用
	private String updepartid;// //t_sys_depart表相应字段，只做查询用
	private String linkname; //t_sys_depart表相应字段，只做查询用
	private String linktel;	 //t_sys_depart表相应字段，只做查询用
	private String linkfax; //t_sys_depart表相应字段，只做查询用
	private String linkemail; //t_sys_depart表相应字段，只做查询用
	private String linkaddress; //t_sys_depart表相应字段，只做查询用
	private String linkpostcode; //t_sys_depart表相应字段，只做查询用	

	// Constructors

	/** default constructor */
	public TDepartDetail() {
	}

	/** minimal constructor */
	public TDepartDetail(String departid) {
		this.departid = departid;
	}

	/** 启用初始化状态的场的方法里用的(changeState()) constructor */
	public TDepartDetail(String departid, String xz) {
		this.departid = departid;
		this.xz = xz;
	}

	/** 启用初始化状态的场的方法里用的(changeState()) constructor */
	public TDepartDetail(String departid, String updepartid, String city,String departname,String bh) {
		this.departid = departid;
		this.updepartid = updepartid;
		this.city = city;
		this.departname = departname;
		this.bh = bh;
	}

	/** full constructor */
	public TDepartDetail(String departid, String xkzbh, String dwxz, String xz, String frdb, Date yxq, Date djsj,
			Date shsj, String jd, String wd, String zxqct) {
		this.departid = departid;
		this.xkzbh = xkzbh;
		this.dwxz = dwxz;
		this.xz = xz;
		this.frdb = frdb;
		this.yxq = yxq;
		this.djsj = djsj;
		this.shsj = shsj;
		this.jd = jd;
		this.wd = wd;
		this.zxqct = zxqct;
	}	
	
	/** 同步数据的方法里用到 */
	public TDepartDetail(String departid,String bh,String frdb,String departname,String linkname,String linktel,
						 String linkaddress,String linkpostcode,String linkemail,String linkfax, String city,String updepartid) {
		this.departid = departid;
		this.bh = bh;
		this.frdb = frdb;
		this.departname = departname;
		this.linkname = linkname;
		this.linktel = linktel;
		this.linkaddress = linkaddress;
		this.linkpostcode = linkpostcode;
		this.linkemail = linkemail;
		this.linkfax = linkfax;
		this.city=city;
		this.updepartid = updepartid;
	}	
	// Property accessors
	@Id
	@Column(name = "DEPARTID", unique = true, nullable = false, length = 50)
	public String getDepartid() {
		return this.departid;
	}

	public void setDepartid(String departid) {
		this.departid = departid;
	}

	@Column(name = "XKZBH", length = 50)
	public String getXkzbh() {
		return this.xkzbh;
	}

	public void setXkzbh(String xkzbh) {
		this.xkzbh = xkzbh;
	}

	@Column(name = "DWXZ", length = 2)
	public String getDwxz() {
		return this.dwxz;
	}

	public void setDwxz(String dwxz) {
		this.dwxz = dwxz;
	}

	@Column(name = "XZ", length = 2)
	public String getXz() {
		return this.xz;
	}

	public void setXz(String xz) {
		this.xz = xz;
	}

	@Column(name = "FRDB", length = 50)
	public String getFrdb() {
		return this.frdb;
	}

	public void setFrdb(String frdb) {
		this.frdb = frdb;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "YXQ")
	public Date getYxq() {
		return this.yxq;
	}

	public void setYxq(Date yxq) {
		this.yxq = yxq;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "DJSJ")
	public Date getDjsj() {
		return this.djsj;
	}

	public void setDjsj(Date djsj) {
		this.djsj = djsj;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "SHSJ")
	public Date getShsj() {
		return this.shsj;
	}

	public void setShsj(Date shsj) {
		this.shsj = shsj;
	}

	@Column(name = "JD", length = 20)
	public String getJd() {
		return this.jd;
	}

	public void setJd(String jd) {
		this.jd = jd;
	}

	@Column(name = "WD", length = 20)
	public String getWd() {
		return this.wd;
	}

	public void setWd(String wd) {
		this.wd = wd;
	}

	@Column(name = "ZXQCT", length = 50)
	public String getZxqct() {
		return this.zxqct;
	}

	public void setZxqct(String zxqct) {
		this.zxqct = zxqct;
	}

	@Column(name = "BH", length = 20)
	public String getBh() {
		return bh;
	}

	public void setBh(String bh) {
		this.bh = bh;
	}

	@Column(name = "BZ", length = 200)
	public String getBz() {
		return bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

	@Transient
	public String getDepartname() {
		return departname;
	}

	public void setDepartname(String departname) {
		this.departname = departname;
	}

	@Transient
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	@Transient
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Transient
	public String getUpdepartid() {
		return updepartid;
	}

	public void setUpdepartid(String updepartid) {
		this.updepartid = updepartid;
	}
	
	@Transient
	public String getLinkname() {
		return linkname;
	}

	public void setLinkname(String linkname) {
		this.linkname = linkname;
	}

	@Transient
	public String getLinktel() {
		return linktel;
	}

	public void setLinktel(String linktel) {
		this.linktel = linktel;
	}

	@Transient
	public String getLinkfax() {
		return linkfax;
	}

	public void setLinkfax(String linkfax) {
		this.linkfax = linkfax;
	}

	@Transient
	public String getLinkemail() {
		return linkemail;
	}

	public void setLinkemail(String linkemail) {
		this.linkemail = linkemail;
	}

	@Transient
	public String getLinkaddress() {
		return linkaddress;
	}

	public void setLinkaddress(String linkaddress) {
		this.linkaddress = linkaddress;
	}

	@Transient
	public String getLinkpostcode() {
		return linkpostcode;
	}

	public void setLinkpostcode(String linkpostcode) {
		this.linkpostcode = linkpostcode;
	}
	
}