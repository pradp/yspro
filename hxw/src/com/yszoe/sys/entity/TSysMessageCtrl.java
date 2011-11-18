package com.yszoe.sys.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * TSysMessageCttl entity. @author MyEclipse Persistence Tools
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "T_SYS_MESSAGE_CTRL")
public class TSysMessageCtrl implements java.io.Serializable {

	// Fields

	private String wid;
	private String departtype;
	private String name;
	private String sql;
	private String menuid;
	private String description;
	private String state;
	private Integer ordernum;

	private String menupath; // 非持久化,用于页面跳转用url,根据menuid获取
	private String menuname; // 非持久化,用于页面显示菜单名
	private String upmenuname; // 非持久化,用于页面显示上级菜单名
	private long count; //非持久化,用于页面显示sql查询结果

	// Constructors

	/** default constructor */
	public TSysMessageCtrl() {
	}

	/** minimal constructor */
	public TSysMessageCtrl(String wid) {
		this.wid = wid;
	}

	public TSysMessageCtrl(String wid, String departtype, String name, String sql, String menuid, String description,
			String state, Integer ordernum) {
		this.wid = wid;
		this.departtype = departtype;
		this.name = name;
		this.sql = sql;
		this.menuid = menuid;
		this.description = description;
		this.state = state;
	}

	/** full constructor */
	public TSysMessageCtrl(String wid, String departtype, String name, String sql, String menuid, String description,
			String state, Integer ordernum, String menupath, String menuname, String upmenuname) {
		super();
		this.wid = wid;
		this.departtype = departtype;
		this.name = name;
		this.sql = sql;
		this.menuid = menuid;
		this.description = description;
		this.state = state;
		this.ordernum = ordernum;
		this.menupath = menupath;
		this.menuname = menuname;
		this.upmenuname = upmenuname;
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

	@Column(name = "DEPARTTYPE", length = 2)
	public String getDeparttype() {
		return this.departtype;
	}

	public void setDeparttype(String departtype) {
		this.departtype = departtype;
	}

	@Column(name = "NAME", length = 50)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "SQL", length = 500)
	public String getSql() {
		return this.sql;
	}

	public void setSql(String sql) {
		this.sql = sql;
	}

	@Column(name = "MENUID", length = 50)
	public String getMenuid() {
		return this.menuid;
	}

	public void setMenuid(String menuid) {
		this.menuid = menuid;
	}

	@Column(name = "DESCRIPTION", length = 500)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "STATE", length = 2)
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "ORDERNUM", precision = 4, scale = 0)
	public Integer getOrdernum() {
		return ordernum;
	}

	public void setOrdernum(Integer ordernum) {
		this.ordernum = ordernum;
	}

	@Transient
	public String getMenupath() {
		return menupath;
	}

	public void setMenupath(String menupath) {
		this.menupath = menupath;
	}

	@Transient
	public String getMenuname() {
		return menuname;
	}

	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}

	@Transient
	public String getUpmenuname() {
		return upmenuname;
	}

	public void setUpmenuname(String upmenuname) {
		this.upmenuname = upmenuname;
	}

	@Transient
	public long getCount() {
		return count;
	}

	public void setCount(long count) {
		this.count = count;
	}

}