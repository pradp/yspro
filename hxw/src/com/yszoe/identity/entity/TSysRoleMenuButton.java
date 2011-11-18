package com.yszoe.identity.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TSysRoleMenuButton entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_ROLE_MENU_BUTTON")
public class TSysRoleMenuButton implements java.io.Serializable {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private String id;
	private String roleid;
	private String menuid;
	private String buttonid;

	// Constructors

	/** default constructor */
	public TSysRoleMenuButton() {
	}

	/** minimal constructor */
	public TSysRoleMenuButton(String id) {
		this.id = id;
	}

	/** full constructor */
	public TSysRoleMenuButton(String id, String roleid, String menuid, String buttonid) {
		this.id = id;
		this.roleid = roleid;
		this.menuid = menuid;
		this.buttonid = buttonid;
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

	@Column(name = "BUTTONID", length = 50)
	public String getButtonid() {
		return this.buttonid;
	}

	public void setButtonid(String buttonid) {
		this.buttonid = buttonid;
	}

}