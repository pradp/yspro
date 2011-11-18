package com.yszoe.sys.entity;

import java.util.List;

/**
 * flash图表控件FusionCharts的数据模型类
 * @author Yangjianliang datetime 2010-12-26
 */
public class FusionChartsDTO {

	private String caption;//
	private String subCaption;//
	private List<String[]> data;//FusionCharts xml的set部分内容

	public String getCaption() {
		return caption;
	}
	public void setCaption(String caption) {
		this.caption = caption;
	}
	public String getSubCaption() {
		return subCaption;
	}
	public void setSubCaption(String subCaption) {
		this.subCaption = subCaption;
	}
	public List<String[]> getData() {
		return data;
	}
	public void setData(List<String[]> data) {
		this.data = data;
	}

}
