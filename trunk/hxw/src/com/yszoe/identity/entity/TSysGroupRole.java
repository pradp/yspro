package com.yszoe.identity.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TSysGroupRole entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_GROUP_ROLE")
public class TSysGroupRole implements java.io.Serializable {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private String id;
	private String groupid;
	private String roleid;

	// Constructors

	/** default constructor */
	public TSysGroupRole() {
	}

	/** minimal constructor */
	public TSysGroupRole(String id) {
		this.id = id;
	}

	/** full constructor */
	public TSysGroupRole(String id, String groupid, String roleid) {
		this.id = id;
		this.groupid = groupid;
		this.roleid = roleid;
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

	@Column(name = "GROUPID", length = 50)
	public String getGroupid() {
		return this.groupid;
	}

	public void setGroupid(String groupid) {
		this.groupid = groupid;
	}

	@Column(name = "ROLEID", length = 50)
	public String getRoleid() {
		return this.roleid;
	}

	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}

}