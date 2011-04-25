package com.imchooser.infoms.entity.sys;

/**
 * TSysButtonEnumRule entity. @author MyEclipse Persistence Tools
 */

public class TSysButtonEnumRule implements java.io.Serializable {

	// Fields

	private String wid;
	private String menuId;
	private String buttonEnumId;
	private String buttonRuleId;

	// Constructors

	/** default constructor */
	public TSysButtonEnumRule() {
	}

	/** minimal constructor */
	public TSysButtonEnumRule(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public TSysButtonEnumRule(String wid, String menuId, String buttonEnumId,
			String buttonRuleId) {
		this.wid = wid;
		this.menuId = menuId;
		this.buttonEnumId = buttonEnumId;
		this.buttonRuleId = buttonRuleId;
	}

	// Property accessors

	public String getWid() {
		return this.wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	public String getMenuId() {
		return this.menuId;
	}

	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}

	public String getButtonEnumId() {
		return this.buttonEnumId;
	}

	public void setButtonEnumId(String buttonEnumId) {
		this.buttonEnumId = buttonEnumId;
	}

	public String getButtonRuleId() {
		return this.buttonRuleId;
	}

	public void setButtonRuleId(String buttonRuleId) {
		this.buttonRuleId = buttonRuleId;
	}

}