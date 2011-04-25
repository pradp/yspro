/**
 * StringUtil.java
 */
package com.imchooser.util;

import java.io.UnsupportedEncodingException;

import org.apache.commons.lang.StringUtils;

/**
 * 字符串工具类，扩展了apache的StringUtils
 * @author Yangjianliang
 * datetime 2008-11-23
 */
public final class StringUtil extends StringUtils{

	/**
	 * 检查字符串中是否包含中文
	 * @param string
	 * @return
	 */
	public static final boolean checkContainChinese(String string){
		int n = string.length();
		for(int i=0;i<n;i++){
			if(string.charAt(i)>127){
				return true;
			}
		}
		return false;
	}

	/**
	 * 检查字符串是否全是字母
	 * @param string
	 * @return
	 */
	public static final boolean checkIsAllEnglish(String string){
		
		return string.matches("[a-zA-Z]+");
	}

	/**
	 * 通过URL传递的中文，会因为默认的编码格式，导致request取得的值为乱码。
	 * 此方法就是返回UTF8编码的中文。
	 * @param string 西方编码的乱码字符串
	 * @return UTF8编码的中文
	 * @throws UnsupportedEncodingException 
	 */
	public static final String toChinese(String string) throws UnsupportedEncodingException{
		return new String(string.getBytes("ISO8859_1"),"UTF-8");
	}
	
	public static void main(String[] args) {
		System.out.println(StringUtil.checkIsAllEnglish("adwafwggegm,sll"));
	}
}
