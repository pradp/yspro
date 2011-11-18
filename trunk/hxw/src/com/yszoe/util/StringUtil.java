/**
 * StringUtil.java
 */
package com.yszoe.util;

import java.io.UnsupportedEncodingException;

import org.apache.commons.lang.StringUtils;

/**
 * 字符串工具类，扩展了apache的StringUtils
 *
 * @author Yangjianliang datetime 2008-11-23
 */
public final class StringUtil extends StringUtils {

	/**
	 * 获取文章标题的前多少个字
	 *
	 * @param title
	 * @param length
	 * @return
	 */
	public static final String getShortTitle(String title, int length) {
		String shortTitle = "";
		if (StringUtils.isNotBlank(title)) {
			if (title.length() > length) {
				shortTitle = title.substring(0, length) + "...";
			} else {
				shortTitle = title;
			}
		}
		return shortTitle;
	}

	/**
	 * 获取昵称的前多少个字。因是昵称，所以自动根据是否包含汉字，减少一个字数。
	 * 如果包含中文，就少返回一个汉字。
	 * @param nickname
	 * @param length 按字节计算，3，就返回3个汉字，或者一个字母，两个汉字。
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static final String getShortNickname(String nickname, int length) {
		String shortTitle = getShortTitle(nickname, length);
		if(checkContainChinese(shortTitle)){

			return getShortTitle(shortTitle, length-1);
		}else{

			return shortTitle;
		}
	}

	/**
	 * 获取文章标题的前12个字
	 *
	 * @param title
	 * @return
	 */
	public static final String getShortTitle(String title) {

		return getShortTitle(title, 12);
	}

	/**
	 * 检查字符串中是否包含中文
	 *
	 * @param string
	 * @return
	 */
	public static final boolean checkContainChinese(String string) {
		int n = string.length();
		for (int i = 0; i < n; i++) {
			if (string.charAt(i) > 127) {
				return true;
			}
		}
		return false;
	}

	/**
	 * 检查字符串是否全是字母
	 *
	 * @param string
	 * @return
	 */
	public static final boolean checkIsAllEnglish(String string) {

		return string.matches("[a-zA-Z]+");
	}

	/**
	 * 通过URL传递的中文，会因为默认的编码格式，导致request取得的值为乱码。 此方法就是返回UTF8编码的中文。
	 *
	 * @param string 西方编码的乱码字符串
	 * @return UTF8编码的中文
	 * @throws UnsupportedEncodingException
	 */
	public static final String toChinese(String string) throws UnsupportedEncodingException {
		return new String(string.getBytes("ISO8859_1"), "UTF-8");
	}

	/**
	 * 过滤HTML符号，安全输出内容到HTML文档中显示
	 * @param code
	 * @return
	 */
	public static final String escapeHtml(String code) {
		if(isBlank(code)){
			return code;
		}
		code = code.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
		code = code.replaceAll("'", "").replaceAll("\"", "");
		return code;
	}
	
	public static void main(String[] args) throws UnsupportedEncodingException {
//		System.out.println(StringUtil.checkIsAllEnglish("adwafwggegm,sll"));
	}
}
