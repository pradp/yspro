package com.yszoe.identity.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TSysRole entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_ROLE")
public class TSysRole implements java.io.Serializable {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private String roleid;
	private String rolename;
	private String state;
	private String memo;

	// Constructors

	/** default constructor */
	public TSysRole() {
	}

	/** minimal constructor */
	public TSysRole(String roleid) {
		this.roleid = roleid;
	}

	/** full constructor */
	public TSysRole(String roleid, String rolename, String state, String memo) {
		this.roleid = roleid;
		this.rolename = rolename;
		this.state = state;
		this.memo = memo;
	}

	// Property accessors
	@Id
	@Column(name = "ROLEID", unique = true, nullable = false, length = 50)
	public String getRoleid() {
		return this.roleid;
	}

	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}

	@Column(name = "ROLENAME", length = 100)
	public String getRolename() {
		return this.rolename;
	}

	public void setRolename(String rolename) {
		this.rolename = rolename;
	}

	@Column(name = "STATE", length = 6)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "MEMO", length = 100)
	public String getMemo() {
		return this.memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

}