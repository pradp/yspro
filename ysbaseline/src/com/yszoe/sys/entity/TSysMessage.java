package com.yszoe.sys.entity;

// Generated by MyEclipse Persistence Tools

import java.sql.Blob;
import java.util.Date;

/**
 * TSysMessage generated by MyEclipse Persistence Tools
 */
public class TSysMessage implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String wid;

	private String xxly;

	private String xxjsr;

	private String xxjsrName;

	private String xxfsr;

	private String xxfsrDepartid;

	private String xxfsrDepartname;

	private Date xxfssj;

	private Date xxydsj;

	private String xxzt;

	private String xxnr;

	private String xxbt;

	// 新增字段,判断发件人消息是否删除,1为删除
	private String fxxsc;

	// 新增字段,判断收件人信息是否删除,1为删除
	private String sxxsc;

	private long ydrs; // 新增字段,用于记录已读人数,不保存到数据库
	private long wdrs; // 新增字段,用于记录未读人数,不保存到数据库

	private String fszt; // 新增字段,用于判断消息是否发送 0未未发送 1为发送

	private String realWid; // 新增字段,用于记录发件箱的wid
	
	private Blob fj; // 新增字段

	private String fjm; // 新增字段,用于记录附件名

	// Constructors

	/** default constructor */
	public TSysMessage() {
	}

	/** minimal constructor */
	public TSysMessage(String wid) {
		this.wid = wid;
	}

	/**
	 * 用于消息发送列表页面的 非admin用户 和 admin用户的收件箱
	 */
	public TSysMessage(String wid, String xxly, String xxfsr, String xxjsr, Date xxfssj, String xxzt, String xxnr,
			String xxbt, String xxfsrDepartid, String realWid,Blob fj,String fjm) {
		super();
		this.wid = wid;
		this.xxly = xxly;
		this.xxfsr = xxfsr;
		this.xxjsr = xxjsr;
		this.xxfsrDepartid = xxfsrDepartid;
		this.xxfssj = xxfssj;
		this.xxzt = xxzt;
		this.xxnr = xxnr;
		this.xxbt = xxbt;
		this.realWid = realWid;
		this.fj = fj;
		this.fjm = fjm;
	}

	/**
	 * 用于消息发送列表页面 admin用户的发件箱
	 */
	public TSysMessage(String wid, String xxly, Date xxfssj, String xxnr, String xxbt, long ydrs, long wdrs,
			String xxfsrDepartid, String realWid) {
		super();
		this.wid = wid;
		this.xxly = xxly;
		this.xxfssj = xxfssj;
		this.xxnr = xxnr;
		this.xxbt = xxbt;
		this.ydrs = ydrs;
		this.wdrs = wdrs;
		this.xxfsrDepartid = xxfsrDepartid;
		this.realWid = realWid;
	}

	/** full constructor */
	public TSysMessage(String wid, String xxly, String xxjsr, String xxjsrName, String xxfsr, String xxfsrDepartid,
			String xxfsrDepartname, Date xxfssj, Date xxydsj, String xxzt, String xxnr, String xxbt, String fxxsc,
			String sxxsc, long ydrs, long wdrs, String fszt) {
		super();
		this.wid = wid;
		this.xxly = xxly;
		this.xxjsr = xxjsr;
		this.xxjsrName = xxjsrName;
		this.xxfsr = xxfsr;
		this.xxfsrDepartid = xxfsrDepartid;
		this.xxfsrDepartname = xxfsrDepartname;
		this.xxfssj = xxfssj;
		this.xxydsj = xxydsj;
		this.xxzt = xxzt;
		this.xxnr = xxnr;
		this.xxbt = xxbt;
		this.fxxsc = fxxsc;
		this.sxxsc = sxxsc;
		this.ydrs = ydrs;
		this.wdrs = wdrs;
		this.fszt = fszt;
	}

	// Property accessors

	public String getWid() {
		return this.wid;
	}

	public void setWid(String wid) {
		this.wid = wid;
	}

	public String getXxly() {
		return this.xxly;
	}

	public void setXxly(String xxly) {
		this.xxly = xxly;
	}

	public String getXxjsr() {
		return this.xxjsr;
	}

	public void setXxjsr(String xxjsr) {
		this.xxjsr = xxjsr;
	}

	public String getXxfsr() {
		return this.xxfsr;
	}

	public void setXxfsr(String xxfsr) {
		this.xxfsr = xxfsr;
	}

	public Date getXxfssj() {
		return this.xxfssj;
	}

	public void setXxfssj(Date xxfssj) {
		this.xxfssj = xxfssj;
	}

	public Date getXxydsj() {
		return this.xxydsj;
	}

	public void setXxydsj(Date xxydsj) {
		this.xxydsj = xxydsj;
	}

	public String getXxzt() {
		return this.xxzt;
	}

	public void setXxzt(String xxzt) {
		this.xxzt = xxzt;
	}

	public String getXxnr() {
		return this.xxnr;
	}

	public void setXxnr(String xxnr) {
		this.xxnr = xxnr;
	}

	public String getXxbt() {
		return this.xxbt;
	}

	public void setXxbt(String xxbt) {
		this.xxbt = xxbt;
	}

	public String getXxjsrName() {
		return xxjsrName;
	}

	public void setXxjsrName(String xxjsrName) {
		this.xxjsrName = xxjsrName;
	}

	public String getXxfsrDepartid() {
		return xxfsrDepartid;
	}

	public void setXxfsrDepartid(String xxfsrDepartid) {
		this.xxfsrDepartid = xxfsrDepartid;
	}

	public String getXxfsrDepartname() {
		return xxfsrDepartname;
	}

	public void setXxfsrDepartname(String xxfsrDepartname) {
		this.xxfsrDepartname = xxfsrDepartname;
	}

	public String getFxxsc() {
		return fxxsc;
	}

	public void setFxxsc(String fxxsc) {
		this.fxxsc = fxxsc;
	}

	public String getSxxsc() {
		return sxxsc;
	}

	public void setSxxsc(String sxxsc) {
		this.sxxsc = sxxsc;
	}

	public long getYdrs() {
		return ydrs;
	}

	public void setYdrs(long ydrs) {
		this.ydrs = ydrs;
	}

	public long getWdrs() {
		return wdrs;
	}

	public void setWdrs(long wdrs) {
		this.wdrs = wdrs;
	}

	public String getFszt() {
		return fszt;
	}

	public void setFszt(String fszt) {
		this.fszt = fszt;
	}

	public String getRealWid() {
		return realWid;
	}

	public void setRealWid(String realWid) {
		this.realWid = realWid;
	}

	public Blob getFj() {
		return fj;
	}

	public void setFj(Blob fj) {
		this.fj = fj;
	}

	public String getFjm() {
		return fjm;
	}

	public void setFjm(String fjm) {
		this.fjm = fjm;
	}

}
