package com.yszoe.identity.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * TSysMenu entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_MENU")
public class TSysMenu implements java.io.Serializable {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private String menuid;
	private String menuname;
	private String menupath;
	private String upmenuid;
	private Short depth;
	private String state;
	private Integer ordernum;
	private String share2enterprise;// 是否允许企业管理员为本企业自定义角色权限时分配此菜单

	private long childMenuCount; // 该菜单的下级菜单的个数,非持久化

	// Constructors

	/** default constructor */
	public TSysMenu() {
	}

	/** minimal constructor */
	public TSysMenu(String menuid) {
		this.menuid = menuid;
	}

	/** full constructor */
	public TSysMenu(String menuid, String menuname, String menupath, String upmenuid, Short depth, String state,
			Integer ordernum, String share2enterprise) {
		this.menuid = menuid;
		this.menuname = menuname;
		this.menupath = menupath;
		this.upmenuid = upmenuid;
		this.depth = depth;
		this.state = state;
		this.ordernum = ordernum;
		this.share2enterprise = share2enterprise;
	}

	public TSysMenu(String menuid, String menuname, String menupath, String upmenuid, Short depth, String state,
			Integer ordernum, String share2enterprise, long childMenuCount) {
		super();
		this.menuid = menuid;
		this.menuname = menuname;
		this.menupath = menupath;
		this.upmenuid = upmenuid;
		this.depth = depth;
		this.state = state;
		this.ordernum = ordernum;
		this.share2enterprise = share2enterprise;
		this.childMenuCount = childMenuCount;
	}

	// Property accessors
	@Id
	@Column(name = "MENUID", unique = true, nullable = false, length = 50)
	public String getMenuid() {
		return this.menuid;
	}

	public void setMenuid(String menuid) {
		this.menuid = menuid;
	}

	@Column(name = "MENUNAME", length = 100)
	public String getMenuname() {
		return this.menuname;
	}

	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}

	@Column(name = "MENUPATH", length = 400)
	public String getMenupath() {
		return this.menupath;
	}

	public void setMenupath(String menupath) {
		this.menupath = menupath;
	}

	@Column(name = "UPMENUID", length = 50)
	public String getUpmenuid() {
		if (upmenuid == null && menuid != null) {
			upmenuid = menuid.substring(0, menuid.length() - 3);
		}
		return this.upmenuid;
	}

	public void setUpmenuid(String upmenuid) {
		this.upmenuid = upmenuid;
	}

	@Column(name = "DEPTH", precision = 2, scale = 0)
	public Short getDepth() {
		return this.depth;
	}

	public void setDepth(Short depth) {
		this.depth = depth;
	}

	@Column(name = "STATE", length = 3)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "ORDERNUM", precision = 6, scale = 0)
	public Integer getOrdernum() {
		return this.ordernum;
	}

	public void setOrdernum(Integer ordernum) {
		this.ordernum = ordernum;
	}

	@Column(name = "SHARE2ENTERPRISE", length = 2)
	public String getShare2enterprise() {
		return this.share2enterprise;
	}

	public void setShare2enterprise(String share2enterprise) {
		this.share2enterprise = share2enterprise;
	}

	@Transient
	public long getChildMenuCount() {
		return childMenuCount;
	}

	public void setChildMenuCount(long childMenuCount) {
		this.childMenuCount = childMenuCount;
	}

}