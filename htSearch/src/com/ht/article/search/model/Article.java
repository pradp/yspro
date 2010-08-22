package com.ht.article.search.model;

import java.util.Date;

import org.apache.solr.client.solrj.beans.Field;

/**
 * 
 * @author cdji 2010-5-13
 */
public class Article {
	@Field
	private int artId;
	@Field
	private String artTitle;
	@Field
	private String artContent;
	@Field
	private String artNavigation;
	@Field
	private String artUrl;
	@Field
	private Date artDate;
	@Field
	private String artSort;

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

	public String getArtSort() {
		return artSort;
	}

	public void setArtSort(String artSort) {
		this.artSort = artSort;
	}

}
