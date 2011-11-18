package com.yszoe.identity.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * TSysGroup entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_GROUP")
public class TSysGroup implements java.io.Serializable {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private String groupid;
	private String groupname;
	private String state;
	private String memo;

	// Constructors

	/** default constructor */
	public TSysGroup() {
	}

	/** minimal constructor */
	public TSysGroup(String groupid) {
		this.groupid = groupid;
	}

	/** full constructor */
	public TSysGroup(String groupid, String groupname, String state, String memo) {
		this.groupid = groupid;
		this.groupname = groupname;
		this.state = state;
		this.memo = memo;
	}

	// Property accessors
	@Id
	@Column(name = "GROUPID", unique = true, nullable = false, length = 50)
	public String getGroupid() {
		return this.groupid;
	}

	public void setGroupid(String groupid) {
		this.groupid = groupid;
	}

	@Column(name = "GROUPNAME", length = 100)
	public String getGroupname() {
		return this.groupname;
	}

	public void setGroupname(String groupname) {
		this.groupname = groupname;
	}

	@Column(name = "STATE", length = 3)
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