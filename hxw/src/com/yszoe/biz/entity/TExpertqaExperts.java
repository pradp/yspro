package com.yszoe.biz.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.transaction.annotation.Transactional;

/**
 * TExpertqaExperts entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_EXPERTQA_EXPERTS")
public class TExpertqaExperts implements java.io.Serializable {

	// Fields

	private String wid;
	private String userid;
	private String username;//手工添加，非持久化
	private String passwd;//手工添加，非持久化
	private String name;
	private String sex;
	private String sortId;
	private String email;
	private String memo;
	private String photo;
	private String isshowprivate;
	private String relationmethod;
	private String telnum;
	private String mobilenum;
	private Integer submitnum;
	private Integer solved;
	private String unit;
	private String identity;
	private String position;
	private String fax;
	private String lxdz;
	private String yzbm;
	private String jianjie;
	private String gzly;
	private Integer sx;

	// Constructors

	/** default constructor */
	public TExpertqaExperts() {
	}

	/** minimal constructor */
	public TExpertqaExperts(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public TExpertqaExperts(String wid, String userid, String name, String sex, String sortId,
			String email, String memo, String photo, String isshowprivate, String relationmethod, String telnum,
			String mobilenum, Integer submitnum, Integer solved, String unit, String identity, String position,
			String fax, String lxdz, String yzbm, String jianjie, String gzly, Integer sx) {
		this.wid = wid;
		this.userid = userid;
		this.name = name;
		this.sex = sex;
		this.sortId = sortId;
		this.email = email;
		this.memo = memo;
		this.photo = photo;
		this.isshowprivate = isshowprivate;
		this.relationmethod = relationmethod;
		this.telnum = telnum;
		this.mobilenum = mobilenum;
		this.submitnum = submitnum;
		this.solved = solved;
		this.unit = unit;
		this.identity = identity;
		this.position = position;
		this.fax = fax;
		this.lxdz = lxdz;
		this.yzbm = yzbm;
		this.jianjie = jianjie;
		this.gzly = gzly;
		this.sx = sx;
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

	@Column(name = "USERID", length = 50, updatable=false)
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Column(name = "NAME", length = 20)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "SEX", length = 1)
	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	@Column(name = "SORT_ID", length = 50)
	public String getSortId() {
		return this.sortId;
	}

	public void setSortId(String sortId) {
		this.sortId = sortId;
	}

	@Column(name = "EMAIL", length = 50)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "MEMO")
	public String getMemo() {
		return this.memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	@Column(name = "PHOTO")
	public String getPhoto() {
		return this.photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	@Column(name = "ISSHOWPRIVATE", length = 1)
	public String getIsshowprivate() {
		return this.isshowprivate;
	}

	public void setIsshowprivate(String isshowprivate) {
		this.isshowprivate = isshowprivate;
	}

	@Column(name = "RELATIONMETHOD", length = 200)
	public String getRelationmethod() {
		return this.relationmethod;
	}

	public void setRelationmethod(String relationmethod) {
		this.relationmethod = relationmethod;
	}

	@Column(name = "TELNUM", length = 20)
	public String getTelnum() {
		return this.telnum;
	}

	public void setTelnum(String telnum) {
		this.telnum = telnum;
	}

	@Column(name = "MOBILENUM", length = 20)
	public String getMobilenum() {
		return this.mobilenum;
	}

	public void setMobilenum(String mobilenum) {
		this.mobilenum = mobilenum;
	}

	@Column(name = "SUBMITNUM", precision = 5, scale = 0)
	public Integer getSubmitnum() {
		return this.submitnum;
	}

	public void setSubmitnum(Integer submitnum) {
		this.submitnum = submitnum;
	}

	@Column(name = "SOLVED", precision = 5, scale = 0)
	public Integer getSolved() {
		return this.solved;
	}

	public void setSolved(Integer solved) {
		this.solved = solved;
	}

	@Column(name = "UNIT", length = 100)
	public String getUnit() {
		return this.unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	@Column(name = "IDENTITY", length = 18)
	public String getIdentity() {
		return this.identity;
	}

	public void setIdentity(String identity) {
		this.identity = identity;
	}

	@Column(name = "POSITION", length = 30)
	public String getPosition() {
		return this.position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	@Column(name = "FAX", length = 20)
	public String getFax() {
		return this.fax;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	@Column(name = "LXDZ", length = 100)
	public String getLxdz() {
		return this.lxdz;
	}

	public void setLxdz(String lxdz) {
		this.lxdz = lxdz;
	}

	@Column(name = "YZBM", length = 20)
	public String getYzbm() {
		return this.yzbm;
	}

	public void setYzbm(String yzbm) {
		this.yzbm = yzbm;
	}

	@Column(name = "JIANJIE", length = 1500)
	public String getJianjie() {
		return this.jianjie;
	}

	public void setJianjie(String jianjie) {
		this.jianjie = jianjie;
	}

	@Column(name = "GZLY", length = 1500)
	public String getGzly() {
		return this.gzly;
	}

	public void setGzly(String gzly) {
		this.gzly = gzly;
	}

	@Column(name = "SX", precision = 5, scale = 0)
	public Integer getSx() {
		return this.sx;
	}

	public void setSx(Integer sx) {
		this.sx = sx;
	}

	@Transient
	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	@Transient
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

}