package com.imchooser.infoms.entity.biz;

/**
 * TSportCjTdSxJjf entity. @author MyEclipse Persistence Tools
 */

@SuppressWarnings("serial")
public class TSportCjTdSxJjf implements java.io.Serializable {

	// Fields

	private String departid;
	private Double jjf;
	private Double jjjps;
	private Double jjyps;
	private Double jjtps;
	private String bz;

	// Constructors

	/** default constructor */
	public TSportCjTdSxJjf() {
	}

	/** minimal constructor */
	public TSportCjTdSxJjf(String departid) {
		this.departid = departid;
	}

	/** full constructor */
	public TSportCjTdSxJjf(String departid, Double jjf, Double jjjps, Double jjyps, Double jjtps, String bz) {
		this.departid = departid;
		this.jjf = jjf;
		this.jjjps = jjjps;
		this.jjyps = jjyps;
		this.jjtps = jjtps;
		this.bz = bz;
	}

	// Property accessors

	public String getDepartid() {
		return this.departid;
	}

	public void setDepartid(String departid) {
		this.departid = departid;
	}

	public Double getJjf() {
		return this.jjf;
	}

	public void setJjf(Double jjf) {
		this.jjf = jjf;
	}

	public Double getJjjps() {
		return this.jjjps;
	}

	public void setJjjps(Double jjjps) {
		this.jjjps = jjjps;
	}

	public Double getJjyps() {
		return this.jjyps;
	}

	public void setJjyps(Double jjyps) {
		this.jjyps = jjyps;
	}

	public Double getJjtps() {
		return this.jjtps;
	}

	public void setJjtps(Double jjtps) {
		this.jjtps = jjtps;
	}

	public String getBz() {
		return this.bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

}