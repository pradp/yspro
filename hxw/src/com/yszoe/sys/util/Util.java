package com.yszoe.sys.util;

import java.sql.ResultSet;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.framework.util.DBUtil;
import com.yszoe.sys.entity.TSysCode;


public class Util {

	private static Log log = LogFactory.getLog(Util.class);

    private static String WEB_APP_PATH = null;
    
    /**
	 * 返回系统命名约定的URI前缀，如/coc/biz
	 * @return
	 */
	public static final String getUriPrefix(){
		
		return SysConfigUtil.getString("uri_prefix");
	}

	/**
	 * 返回系统命名约定的URI后缀，如.do
	 * @return
	 */
	public static final String getUriSuffix(){
		
		return SysConfigUtil.getString("uri_suffix");
	}

	/**
	 * 返回组装好的HTML控件select的代码
	 * @param data 数据源
	 * @param name 改元素的name和id属性的值
	 * @param selectedValue 默认选中的一项
	 * @return
	 */
	public static final String getSelectHtml(List<TSysCode> data ,String name, String selectedValue) {

	    StringBuffer sb=new StringBuffer();
	    sb.append("<select name=\"").append(name).append("\" id=\"").append(name).append("\">\n");
		for(int i=0;i<data.size();i++){
			TSysCode bean = data.get(i);
		      sb.append("  <option value=").append(bean.getZdbm());
		      if(bean.getZdbm().equalsIgnoreCase(selectedValue)){
		    	  sb.append(" selected ");
		      }
		      sb.append( ">" ).append(bean.getZdmc());
		      sb.append("</option>\n");
		}
		sb.append("</select>");
		return sb.toString();
	}
	
	/**
	 * 返回html中select对象中的OPTION系列字符串
	 * 
	 * @param sqlstr
	 *            String 需要查询的sql语句
	 * @param selectValue
	 *            String 选中值
	 * @return String html中select对象中的OPTION系列字符串
	 */
	public static String htmlSelect(String sqlstr, String selectValue) {
		StringBuffer buf = new StringBuffer();
		selectValue = selectValue==null?"":selectValue;
		ResultSet rs = null;
		try {
			rs = DBUtil.queryRowSet(sqlstr);
			while (rs.next()) {
				if (rs.getString(1).equals(selectValue))
					buf.append("<option value='" + rs.getString(1)
							+ "' selected>");
				else
					buf.append("<option value='" + rs.getString(1) + "'>");
				buf.append(rs.getString(2));
				buf.append("</option>\n");
			}
			rs.close();
		} catch (Exception ex) {
			log.error( ex );
		} finally {
			rs = null;
		}
		return buf.toString();
	}

	/**
	 * 取得当前项目根路径
	 * @return windows下 /D:/web_dist/.../ ; linux下 /opt/IBM/Websphere/.../
	 */
    public static String getAppRootPath(){
    	if(WEB_APP_PATH == null){
            String pa = Util.class.getResource("").toString();
    		WEB_APP_PATH = pa.substring(5,pa.indexOf("WEB-INF"));//如果取第六位开始，linux下会丢失跟符号
    	}
    	return WEB_APP_PATH;
    }

    public static void main(String s[]){
    	
//    	System.out.print(Util.getAppRootPath());
//    	(System.getProperties()).list(System.out); 
    }
}

