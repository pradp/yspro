package com.imchooser.infoms.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.util.DBUtil;
import com.imchooser.infoms.Constants;
import com.imchooser.infoms.util.SQLConfigUtil;

/**
 * 提供类似Google的下拉建议功能 客户端配合jquery的插件使用
 * 
 * @author Yangjianliang datetime 2008-11-19
 */
@SuppressWarnings("serial")
public class AutoSuggest extends HttpServlet {

	private static final Log log = LogFactory.getLog(AutoSuggest.class);

	private static boolean openSuggestCacheModel = false;
	private static final int maxSuggestCacheSize = 100;

	private static final Map<String, String> suggestCache = new ConcurrentHashMap<String, String>(maxSuggestCacheSize);

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String aim = request.getParameter("aim");
		String qvalue = request.getParameter("q");
		String scbmd = request.getParameter("scbmd");
		String scbmx = request.getParameter("scbmx");
		String sqlwhere = request.getParameter("sqlwhere");
		String ds = request.getParameter("ds");

		if (aim == null || "".equals(aim)) {
			return;
		}
		if (qvalue == null || "".equals(qvalue)) {
			return;
		}
		if (scbmd != null) {
			if (scbmd.replaceAll(" ", "").equals("")) {
				scbmd = null;// SQL中不传该参数
			} else {
				//scbmd += "%";
			}
		}
		if (scbmx != null) {
			if (scbmx.replaceAll(" ", "").equals("")) {
				scbmx = null;// SQL中不传该参数
			} else {
				scbmx += "%";
			}
			if(StringUtils.isBlank(ds)){
				ds = "%";// SQL中不传该参数
			}
		}

		if (ds != null) {
			if (("").equals(ds.trim())) {
				ds = "%";// SQL中不传该参数
			} else {
				ds += "%";
			}
		}

		// 登录验证
		HttpSession session = request.getSession(false);
		if (session == null) {
			return;
		}
		Object member = session.getAttribute(Constants.SESSION_USER_FLAG);
		if (member == null) {
			return;
		}

		// qvalue = new String(qvalue.getBytes("ISO-8859-1"),"utf-8");
		qvalue = URLDecoder.decode(qvalue, "UTF-8");

		String responseString = "";
		if (openSuggestCacheModel) {

			String cacheKey = aim + qvalue + scbmd + scbmx + ds + sqlwhere;
			if (suggestCache.containsKey(cacheKey)) {

				responseString = suggestCache.get(cacheKey);
			} else {
				responseString = queryFromDB(aim, qvalue, scbmd, scbmx, ds, sqlwhere);
				if (suggestCache.size() >= maxSuggestCacheSize) {
					suggestCache.clear();
				}
				suggestCache.put(cacheKey, responseString);
			}
		} else {
			responseString = queryFromDB(aim, qvalue, scbmd, scbmx, ds, sqlwhere);
		}

		response.setContentType("text/javascript;charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println(responseString);
		out.flush();
		out.close();
	}

	protected static String queryFromDB(String aim, String qvalue, String scbmd, String scbmx, String ds,
			String sqlwhere) {

		String responseString = "";
		String sql = SQLConfigUtil.getSqlString("suggest." + aim);
		if (sql == null || sql.trim().equals("")) {
			return "";
		}
		if (aim.indexOf("getYdyXx") != -1) {
			// 内置支持部门查询
			qvalue = qvalue.toUpperCase();// 数据库中都是大写
		} else if (aim.indexOf("depart") != -1) {
			// 内置支持部门查询
			qvalue = qvalue.toUpperCase();// 数据库中都是大写
		}
		if (sqlwhere != null && !"".equals(sqlwhere.trim())) {
			sql += " " + sqlwhere;
		}
		if (log.isInfoEnabled()) {
			log.info("sql: " + sql);
		}
		
		List<Object[]> list = null;
	//	if(aim.equals("getYdyXxDxm")){
	//		 list =  DBUtil.queryAllList(sql, "%" + qvalue + "%", "%" + qvalue + "%", ds, scbmd);
	//	}else{
		if(aim.equals("depart")){
			list = DBUtil.queryAllList(sql, "%" + qvalue + "%", "%" + qvalue + "%");
		}else{
			// 二次报名项目+1 2 阶段的 一次报名
			//list = DBUtil.queryAllList(sql, "%" + qvalue + "%", "%" + qvalue + "%", ds,scbmd,"%" + qvalue + "%", "%" + qvalue + "%", ds,scbmd);
			//约束为 只有二次报名项目
			list = DBUtil.queryAllList(sql, "%" + qvalue + "%", "%" + qvalue + "%", ds,scbmd);
		}
	//	}
		
		StringBuffer sb = new StringBuffer("[");
		if (list != null && !list.isEmpty()) {
			for (int i = 0, j = list.size(); i < j; i++) {
				Object[] ss = list.get(i);
				if (ss != null) {
					String value = String.valueOf(ss[0]);
					String name = String.valueOf(ss[1]);
					if (name != null && name.trim().equals("") == false) {
						if (i < list.size() - 1) {
							sb.append("{name:\"").append(name).append("\", value:\"").append(value).append("\"},");
						} else {
							sb.append("{name:\"").append(name).append("\", value:\"").append(value).append("\"}");
						}
					}
				}
			}
		} else {
			sb.append("{name:\"\", value:\"\"}");
		}
		sb.append("]");
		responseString = sb.toString();

		return responseString;
	}
}
