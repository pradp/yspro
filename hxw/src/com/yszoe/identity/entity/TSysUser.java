package com.yszoe.identity.entity;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * TSysUser entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_USER")
public class TSysUser implements java.io.Serializable {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private String userid;
	private String userloginid;
	private String username;
	private String userpwd;
//	private String userdepart;
	private String state;
	private String usertype;

	private TSysDepart depart = null;
	
	private String bh; // T_Depart_Detail表相应字段，只做查询用
	private String frdb; // T_Depart_Detail表相应字段，只做查询用
	

	// Constructors

	/** default constructor */
	public TSysUser() {
	}

	/** minimal constructor */
	public TSysUser(String userid) {
		this.userid = userid;
	}
	public TSysUser(String userid, String userloginid, String username, String state) {
		super();
		this.userid = userid;
		this.userloginid = userloginid;
		this.username = username;
		this.state = state;
	}

	public TSysUser(String userid, String userloginid, String username, String state, String departname) {
		super();
		this.userid = userid;
		this.userloginid = userloginid;
		this.username = username;
		this.state = state;
		if(depart==null){
			depart = new TSysDepart();
		}
		this.depart.setDepartname(departname);
	}

	/** full constructor */
	public TSysUser(String userid, String userloginid, String username, String state, String departname, String usertype) {
		super();
		this.userid = userid;
		this.userloginid = userloginid;
		this.username = username;
		this.state = state;
		if(depart==null){
			depart = new TSysDepart();
		}
		this.depart.setDepartname(departname);
		this.usertype = usertype;
	}
	/**
	 * 同步数据用的
	 */
	public TSysUser(String userid, String userloginid, String username,String userpwd,String bh,String frdb,String departname,
			String linkname,String linktel,String linkaddress,String linkpostcode,String linkemail,String city,String linkfax,String departtype) {
		super();
		this.userid = userid;
		this.userloginid = userloginid;
		this.username = username;
		this.userpwd = userpwd;
		this.bh = bh;
		this.frdb = frdb;		
		if(depart==null){
			depart = new TSysDepart();
		}
		this.depart.setDepartname(departname);
		this.depart.setLinkname(linkname);		
		this.depart.setLinktel(linktel);
		this.depart.setLinkaddress(linkaddress);
		this.depart.setLinkpostcode(linkpostcode);
		this.depart.setLinkemail(linkemail);
		this.depart.setCity(city);		
		this.depart.setLinkfax(linkfax);		
		this.depart.setDeparttype(departtype);
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

	@Column(name = "USERLOGINID", length = 50)
	public String getUserloginid() {
		return this.userloginid;
	}

	public void setUserloginid(String userloginid) {
		this.userloginid = userloginid;
	}

	@Column(name = "USERNAME", length = 200)
	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "USERPWD", length = 100)
	public String getUserpwd() {
		return this.userpwd;
	}

	public void setUserpwd(String userpwd) {
		this.userpwd = userpwd;
	}

	@Column(name = "STATE", length = 3)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "USERTYPE", length = 3)
	public String getUsertype() {
		return this.usertype;
	}

	public void setUsertype(String usertype) {
		this.usertype = usertype;
	}

	@ManyToOne (optional=true, cascade = { CascadeType.REFRESH}, fetch = FetchType.EAGER, targetEntity=TSysDepart.class)   
	@JoinColumn(name="userdepart", nullable=true)
	public TSysDepart getDepart() {
		return depart;
	}

	/**
	 * @param depart the depart to set
	 */
	public void setDepart(TSysDepart depart) {
		this.depart = depart;
	}

	@Transient
	public String getBh() {
		return bh;
	}

	public void setBh(String bh) {
		this.bh = bh;
	}

	@Transient
	public String getFrdb() {
		return frdb;
	}

	public void setFrdb(String frdb) {
		this.frdb = frdb;
	}

}