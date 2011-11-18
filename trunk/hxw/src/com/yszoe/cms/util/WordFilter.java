package com.yszoe.cms.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.util.StringUtil;

/**
 * 敏感词过滤
 * @author Yangjianliang
 * datetime 2011-7-30
 */
public final class WordFilter {

	private static final Log LOG = LogFactory.getLog(WordFilter.class);

	private static final String REPLACE_STRING = "*";
	
	public enum FilterType{
		REMOVE_BADWORD, REPLACE_BADWORD
	}

	/**
	 * 敏感词过滤，默认用替换敏感词的方式，将敏感词替换为*。
	 * @param srcstring 原内容
	 * @return 过滤掉敏感词后的内容
	 */
	public static final String filter(String srcstring){
		
		return filter(srcstring, FilterType.REPLACE_BADWORD);
	}

	/**
	 * 敏感词过滤
	 * @param srcstring 原内容
	 * @param filterType 敏感词处理方式：删除；替换
	 * @return 过滤掉敏感词后的内容
	 */
	public static final String filter(String srcstring, FilterType filterType){
		if( StringUtil.isBlank(srcstring) ){
			return srcstring;
		}
		return srcstring;
	}
	
	
	public static void main(String[] args){
		//EXAMPLE
		String safecontent = WordFilter.filter("dsadado9k吊毛", WordFilter.FilterType.REMOVE_BADWORD);
		
	}
}
