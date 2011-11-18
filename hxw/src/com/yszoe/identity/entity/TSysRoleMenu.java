package com.yszoe.identity.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TSysRoleMenu entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_ROLE_MENU")
public class TSysRoleMenu implements java.io.Serializable {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private String id;
	private String roleid;
	private String menuid;

	// Constructors

	/** default constructor */
	public TSysRoleMenu() {
	}

	/** minimal constructor */
	public TSysRoleMenu(String id) {
		this.id = id;
	}

	/** full constructor */
	public TSysRoleMenu(String id, String roleid, String menuid) {
		this.id = id;
		this.roleid = roleid;
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

	@Column(name = "ROLEID", length = 50)
	public String getRoleid() {
		return this.roleid;
	}

	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}

	@Column(name = "MENUID", length = 50)
	public String getMenuid() {
		return this.menuid;
	}

	public void setMenuid(String menuid) {
		this.menuid = menuid;
	}

}