package com.yszoe.biz.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * TExpertqaAppealadd entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "T_EXPERTQA_APPEALADD")
public class TExpertqaAppealadd implements java.io.Serializable {

	// Fields

	private String wid;
	private String appealid;
	private String expertid;
	private String answer;
	private Date dateofreply;
	private String attach;

	// Constructors

	/** default constructor */
	public TExpertqaAppealadd() {
	}

	/** minimal constructor */
	public TExpertqaAppealadd(String wid) {
		this.wid = wid;
	}

	/** full constructor */
	public TExpertqaAppealadd(String wid, String appealid, String expertid, String answer, Date dateofreply,
			String attach) {
		this.wid = wid;
		this.appealid = appealid;
		this.expertid = expertid;
		this.answer = answer;
		this.dateofreply = dateofreply;
		this.attach = attach;
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

	@Column(name = "APPEALID", length = 50)
	public String getAppealid() {
		return this.appealid;
	}

	public void setAppealid(String appealid) {
		this.appealid = appealid;
	}

	@Column(name = "EXPERTID", length = 5)
	public String getExpertid() {
		return this.expertid;
	}

	public void setExpertid(String expertid) {
		this.expertid = expertid;
	}

	@Column(name = "ANSWER")
	public String getAnswer() {
		return this.answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "DATEOFREPLY", length = 7)
	public Date getDateofreply() {
		return this.dateofreply;
	}

	public void setDateofreply(Date dateofreply) {
		this.dateofreply = dateofreply;
	}

	@Column(name = "ATTACH")
	public String getAttach() {
		return this.attach;
	}

	public void setAttach(String attach) {
		this.attach = attach;
	}

}