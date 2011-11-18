package com.yszoe.identity.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TSysUserMenu entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_USER_MENU")
public class TSysUserMenu implements java.io.Serializable {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private String id;
	private String userid;
	private String menuid;

	// Constructors

	/** default constructor */
	public TSysUserMenu() {
	}

	/** minimal constructor */
	public TSysUserMenu(String id) {
		this.id = id;
	}

	/** full constructor */
	public TSysUserMenu(String id, String userid, String menuid) {
		this.id = id;
		this.userid = userid;
		this.menuid = menuid;
	}

	// Property accessors
	@Id
	@Column(name = "ID", unique = true, nullable = false, length = 50)
	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "USERID", length = 50)
	public String getUserid() {
		return this.userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Column(name = "MENUID", length = 50)
	public String getMenuid() {
		return this.menuid;
	}

	public void setMenuid(String menuid) {
		this.menuid = menuid;
	}

}