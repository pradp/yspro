package com.yszoe.identity.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TSysOnline entity. @author MyEclipse Persistence Tools
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "T_SYS_ONLINE")
public class TSysOnline implements java.io.Serializable {

	// Fields

	private String loginid;
	private String clientIp;
	private String serverIp;
	private Date loginTime;

	// Constructors

	/** default constructor */
	public TSysOnline() {
	}

	/** minimal constructor */
	public TSysOnline(String loginid) {
		this.loginid = loginid;
	}

	/** full constructor */
	public TSysOnline(String loginid, String clientIp, String serverIp, Date loginTime) {
		this.loginid = loginid;
		this.clientIp = clientIp;
		this.serverIp = serverIp;
		this.loginTime = loginTime;
	}

	// Property accessors
	@Id
	@Column(name = "LOGINID", unique = true, nullable = false, length = 50)
	public String getLoginid() {
		return this.loginid;
	}

	public void setLoginid(String loginid) {
		this.loginid = loginid;
	}

	@Column(name = "CLIENT_IP", length = 50)
	public String getClientIp() {
		return this.clientIp;
	}

	public void setClientIp(String clientIp) {
		this.clientIp = clientIp;
	}

	@Column(name = "SERVER_IP", length = 50)
	public String getServerIp() {
		return this.serverIp;
	}

	public void setServerIp(String serverIp) {
		this.serverIp = serverIp;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "LOGIN_TIME", length = 7)
	public Date getLoginTime() {
		return this.loginTime;
	}

	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}

}