package com.yszoe.identity.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * TSysButton entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_SYS_BUTTON")
public class TSysButton implements java.io.Serializable {

	/**
	 * 希望类的不同版本对序列化兼容，只要确保类的不同版本具有相同的serialVersionUID
	 */
	private static final long serialVersionUID = 1L;

	private String buttonid;
	private String buttonname;
	private String buttonevent;
	private String buttonicon;
	private String state;
	private String share2enterprise;
	private String memo;
	private Integer ordernum;

	private String menuid; // 用于初始化用户权限菜单按钮时 保存菜单id

	// Constructors

	/** default constructor */
	public TSysButton() {
	}

	/** minimal constructor */
	public TSysButton(String buttonid) {
		this.buttonid = buttonid;
	}

	/** full constructor */
	public TSysButton(String buttonid, String buttonname, String buttonevent, String buttonicon, String state,
			String share2enterprise, String memo, Integer ordernum) {
		this.buttonid = buttonid;
		this.buttonname = buttonname;
		this.buttonevent = buttonevent;
		this.buttonicon = buttonicon;
		this.state = state;
		this.share2enterprise = share2enterprise;
		this.memo = memo;
		this.ordernum = ordernum;
	}

	public TSysButton(String buttonid, String buttonname, String buttonevent, String buttonicon, String state,
			String share2enterprise, String memo, Integer ordernum, String menuid) {
		this.buttonid = buttonid;
		this.buttonname = buttonname;
		this.buttonevent = buttonevent;
		this.buttonicon = buttonicon;
		this.state = state;
		this.share2enterprise = share2enterprise;
		this.memo = memo;
		this.ordernum = ordernum;
		this.menuid = menuid;
	}

	// Property accessors
	@Id
	@Column(name = "BUTTONID", unique = true, nullable = false, length = 50)
	public String getButtonid() {
		return this.buttonid;
	}

	public void setButtonid(String buttonid) {
		this.buttonid = buttonid;
	}

	@Column(name = "BUTTONNAME", length = 50)
	public String getButtonname() {
		return this.buttonname;
	}

	public void setButtonname(String buttonname) {
		this.buttonname = buttonname;
	}

	@Column(name = "BUTTONEVENT", length = 100)
	public String getButtonevent() {
		return this.buttonevent;
	}

	public void setButtonevent(String buttonevent) {
		this.buttonevent = buttonevent;
	}

	@Column(name = "BUTTONICON", length = 50)
	public String getButtonicon() {
		return this.buttonicon;
	}

	public void setButtonicon(String buttonicon) {
		this.buttonicon = buttonicon;
	}

	@Column(name = "STATE", length = 2)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "SHARE2ENTERPRISE", length = 2)
	public String getShare2enterprise() {
		return this.share2enterprise;
	}

	public void setShare2enterprise(String share2enterprise) {
		this.share2enterprise = share2enterprise;
	}

	@Column(name = "MEMO", length = 100)
	public String getMemo() {
		return this.memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	@Column(name = "ORDERNUM", precision = 6, scale = 0)
	public Integer getOrdernum() {
		return this.ordernum;
	}

	public void setOrdernum(Integer ordernum) {
		this.ordernum = ordernum;
	}

	@Transient
	public String getMenuid() {
		return menuid;
	}

	public void setMenuid(String menuid) {
		this.menuid = menuid;
	}

}