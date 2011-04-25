package com.imchooser.infoms.entity.sys;

/**
 * TSysButtonRule entity. @author MyEclipse Persistence Tools
 */

public class TSysButtonRule implements java.io.Serializable {

	// Fields

	private String wid;
	private String cycleType;
	private String cycleStart;
	private String cycleEnd;
	private String state;

	// Constructors

	/** default constructor */
	public TSysButtonRule() {
	}

	/** minimal constructor */
	public TSysButtonRule(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public TSysButtonRule(String wid, String cycleType, String cycleStart,
			String cycleEnd, String state) {
		this.wid = wid;
		this.cycleType = cycleType;
		this.cycleStart = cycleStart;
		this.cycleEnd = cycleEnd;
		this.state = state;
	}

	// Property accessors

	public String getWid() {
		return this.wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	public String getCycleType() {
		return this.cycleType;
	}

	public void setCycleType(String cycleType) {
		this.cycleType = cycleType;
	}

	public String getCycleStart() {
		return this.cycleStart;
	}

	public void setCycleStart(String cycleStart) {
		this.cycleStart = cycleStart;
	}

	public String getCycleEnd() {
		return this.cycleEnd;
	}

	public void setCycleEnd(String cycleEnd) {
		this.cycleEnd = cycleEnd;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

}