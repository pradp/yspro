package com.yszoe.biz.entity;

import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 * TExpertqaAppeal entity. @author MyEclipse Persistence Tools
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "T_EXPERTQA_APPEAL")
public class TExpertqaAppeal implements java.io.Serializable {

	// Fields

	private String wid;
	private String writer;
	private String identity;
	private Date dateofinput;
	private String content;
	private String contact;
	private String sortId;
	private String relationtel;
	private String address;
	private String email;
	private String answer;
	private String ispublish;
	private String digest;
	private String accepter;
	private BigDecimal read;
	private String title;
	private String attach;
	private Date dateofreply;
	private String replyexpert;

	private String cnum;
	private String writerToString;

	// Constructors

	/** default constructor */
	public TExpertqaAppeal() {
	}

	/** minimal constructor */
	public TExpertqaAppeal(String wid, String writer) {
		this.wid = wid;
		this.writer = writer;
	}

	/** full constructor */
	public TExpertqaAppeal(String wid, String writer, String identity, Date dateofinput, String content,
			String contact, String sortId, String relationtel, String address, String email, String answer,
			String ispublish, String digest, String accepter, BigDecimal read, String title, String attach,
			Date dateofreply, String replyexpert) {
		this.wid = wid;
		this.writer = writer;
		this.identity = identity;
		this.dateofinput = dateofinput;
		this.content = content;
		this.contact = contact;
		this.sortId = sortId;
		this.relationtel = relationtel;
		this.address = address;
		this.email = email;
		this.answer = answer;
		this.ispublish = ispublish;
		this.digest = digest;
		this.accepter = accepter;
		this.read = read;
		this.title = title;
		this.attach = attach;
		this.dateofreply = dateofreply;
		this.replyexpert = replyexpert;
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

	@Column(name = "WRITER", nullable = false, length = 20)
	public String getWriter() {
		return this.writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	@Column(name = "IDENTITY", length = 100)
	public String getIdentity() {
		return this.identity;
	}

	public void setIdentity(String identity) {
		this.identity = identity;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "DATEOFINPUT", length = 7)
	public Date getDateofinput() {
		return this.dateofinput;
	}

	public void setDateofinput(Date dateofinput) {
		this.dateofinput = dateofinput;
	}

	@Column(name = "CONTENT")
	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "CONTACT", length = 200)
	public String getContact() {
		return this.contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	@Column(name = "SORT_ID", length = 4)
	public String getSortId() {
		return this.sortId;
	}

	public void setSortId(String sortId) {
		this.sortId = sortId;
	}

	@Column(name = "RELATIONTEL", length = 20)
	public String getRelationtel() {
		return this.relationtel;
	}

	public void setRelationtel(String relationtel) {
		this.relationtel = relationtel;
	}

	@Column(name = "ADDRESS", length = 200)
	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Column(name = "EMAIL", length = 50)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "ANSWER")
	public String getAnswer() {
		return this.answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	@Column(name = "ISPUBLISH", length = 1)
	public String getIspublish() {
		return this.ispublish;
	}

	public void setIspublish(String ispublish) {
		this.ispublish = ispublish;
	}

	@Column(name = "DIGEST")
	public String getDigest() {
		return this.digest;
	}

	public void setDigest(String digest) {
		this.digest = digest;
	}

	@Column(name = "ACCEPTER", length = 4)
	public String getAccepter() {
		return this.accepter;
	}

	public void setAccepter(String accepter) {
		this.accepter = accepter;
	}

	@Column(name = "READ", precision = 22, scale = 0)
	public BigDecimal getRead() {
		return this.read;
	}

	public void setRead(BigDecimal read) {
		this.read = read;
	}

	@Column(name = "TITLE", length = 50)
	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "ATTACH")
	public String getAttach() {
		return this.attach;
	}

	public void setAttach(String attach) {
		this.attach = attach;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "DATEOFREPLY", length = 7)
	public Date getDateofreply() {
		return this.dateofreply;
	}

	public void setDateofreply(Date dateofreply) {
		this.dateofreply = dateofreply;
	}

	@Column(name = "REPLYEXPERT", length = 200)
	public String getReplyexpert() {
		return this.replyexpert;
	}

	public void setReplyexpert(String replyexpert) {
		this.replyexpert = replyexpert;
	}

	@Transient
	public String getCnum() {
		return cnum;
	}

	public void setCnum(String cnum) {
		this.cnum = cnum;
	}

	@Transient
	public String getWriterToString() {
		return writerToString;
	}

	public void setWriterToString(String writerToString) {
		this.writerToString = writerToString;
	}

}