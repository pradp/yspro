package com.imchooser.infoms.entity.biz;

/**
 * TSportXyjfgz entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class TSportXyjfgz implements java.io.Serializable {

	// Fields

	private String wid;
	private Double dbdjfgz;
	private Double ssdjfgz;
	private String bz;

	// Constructors

	/** default constructor */
	public TSportXyjfgz() {
	}

	/** minimal constructor */
	public TSportXyjfgz(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public TSportXyjfgz(String wid, Double dbdjfgz, Double ssdjfgz, String bz) {
		this.wid = wid;
		this.dbdjfgz = dbdjfgz;
		this.ssdjfgz = ssdjfgz;
		this.bz = bz;
	}

	// Property accessors

	public String getWid() {
		return this.wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	public Double getDbdjfgz() {
		return this.dbdjfgz;
	}

	public void setDbdjfgz(Double dbdjfgz) {
		this.dbdjfgz = dbdjfgz;
	}

	public Double getSsdjfgz() {
		return this.ssdjfgz;
	}

	public void setSsdjfgz(Double ssdjfgz) {
		this.ssdjfgz = ssdjfgz;
	}

	public String getBz() {
		return this.bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

}