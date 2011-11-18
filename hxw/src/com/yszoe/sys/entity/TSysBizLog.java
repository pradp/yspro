package com.yszoe.sys.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TSysBizLog entity. @author MyEclipse Persistence Tools
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "T_SYS_BIZ_LOG")
public class TSysBizLog implements java.io.Serializable {

	// Fields

	private String wid;
	private Date czsj;
	private String czdx;
	private String czr;
	private String czlx;
	private String czbid;
	private String type;
	private String field1;
	private String field2;
	private String czms;
	private String cznrzy;
	private String clientIp; // 新增字段，用于记录登录客户端IP

	// Constructors

	/** default constructor */
	public TSysBizLog() {
	}

	/** minimal constructor */
	public TSysBizLog(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public TSysBizLog(String wid, Date czsj, String czdx, String czr, String czlx, String czbid, String type,
			String field1, String field2, String czms, String cznrzy) {
		this.wid = wid;
		this.czsj = czsj;
		this.czdx = czdx;
		this.czr = czr;
		this.czlx = czlx;
		this.czbid = czbid;
		this.type = type;
		this.field1 = field1;
		this.field2 = field2;
		this.czms = czms;
		this.cznrzy = cznrzy;
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

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "CZSJ")
	public Date getCzsj() {
		return this.czsj;
	}

	public void setCzsj(Date czsj) {
		this.czsj = czsj;
	}

	@Column(name = "CZDX", length = 50)
	public String getCzdx() {
		return this.czdx;
	}

	public void setCzdx(String czdx) {
		this.czdx = czdx;
	}

	@Column(name = "CZR", length = 18)
	public String getCzr() {
		return this.czr;
	}

	public void setCzr(String czr) {
		this.czr = czr;
	}

	@Column(name = "CZLX", length = 1)
	public String getCzlx() {
		return this.czlx;
	}

	public void setCzlx(String czlx) {
		this.czlx = czlx;
	}

	@Column(name = "CZBID", length = 50)
	public String getCzbid() {
		return this.czbid;
	}

	public void setCzbid(String czbid) {
		this.czbid = czbid;
	}

	@Column(name = "TYPE", length = 3)
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "FIELD1", length = 100)
	public String getField1() {
		return this.field1;
	}

	public void setField1(String field1) {
		this.field1 = field1;
	}

	@Column(name = "FIELD2", length = 100)
	public String getField2() {
		return this.field2;
	}

	public void setField2(String field2) {
		this.field2 = field2;
	}

	@Column(name = "CZMS", length = 300)
	public String getCzms() {
		return this.czms;
	}

	public void setCzms(String czms) {
		this.czms = czms;
	}

	@Column(name = "CZNRZY", length = 900)
	public String getCznrzy() {
		return this.cznrzy;
	}

	public void setCznrzy(String cznrzy) {
		this.cznrzy = cznrzy;
	}

	@Column(name = "CLIENT_IP", length = 50)
	public String getClientIp() {
		return clientIp;
	}

	public void setClientIp(String clientIp) {
		this.clientIp = clientIp;
	}

}