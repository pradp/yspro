package com.yszoe.util;

import org.apache.struts2.json.JSONException;
import org.apache.struts2.json.JSONUtil;

/**
 * 
 * @author Yangjianliang
 * datetime 2011-7-28
 */
public class JSONUtils {

//	private static final Log LOG = LogFactory.getLog(JSONUtils.class);

    /**
     * 配合ajax效果。直接返回字符串到视图
     * @param resultString
     */
    public static String castToString(Object object){

		String jsonString;
		try {
			jsonString = JSONUtil.serialize(object);
		} catch (JSONException e) {
			jsonString = "{msg:'json对象转换异常："+e+"'}";
		}
		return jsonString; 
    }

}
