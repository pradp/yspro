package com.ht.article.search.model;

import java.util.Date;

/**
 * 
 * @author cdji 2010-5-13
 */
public class Article {
	private int artId;
	private String artTitle;
	private String artContent;
	private String artNavigation;
	private String artUrl;
	private Date artDate;

	public int getArtId() {
		return artId;
	}

	public void setArtId(int artId) {
		this.artId = artId;
	}

	public String getArtTitle() {
		return artTitle;
	}

	public void setArtTitle(String artTitle) {
		this.artTitle = artTitle;
	}

	public String getArtContent() {
		return artContent;
	}

	public void setArtContent(String artContent) {
		this.artContent = artContent;
	}

	public String getArtNavigation() {
		return artNavigation;
	}

	public void setArtNavigation(String artNavigation) {
		this.artNavigation = artNavigation;
	}

	public String getArtUrl() {
		return artUrl;
	}

	public void setArtUrl(String artUrl) {
		this.artUrl = artUrl;
	}

	public Date getArtDate() {
		return artDate;
	}

	public void setArtDate(Date artDate) {
		this.artDate = artDate;
	}

}
