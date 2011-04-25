/**
 * ChineseSpell.java
 */
package com.yszoe.sys.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yszoe.framework.util.DBUtil;
import com.yszoe.util.Char2spell;

/**
 * 取每个汉字第一个字母
 * @author Yangjianliang
 * datetime 2008-12-20
 */
@SuppressWarnings("serial")
public class ChineseSpell extends HttpServlet {

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html");

		String tableName = request.getParameter("tableName");
		String tablePKColumn = request.getParameter("tablePKColumn");
		String chineseColumn = request.getParameter("chineseColumn");
		String spellColumn = request.getParameter("spellColumn");
		
		updateSpell(tableName, tablePKColumn, chineseColumn, spellColumn);
		
		PrintWriter out = response.getWriter();
		out
				.println("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">");
		out.println("<HTML>");
		out.println("  <HEAD><TITLE>A Servlet</TITLE></HEAD>");
		out.println("  <BODY>");
		out.print("    OK!");
		out.println("  </BODY>");
		out.println("</HTML>");
		out.flush();
		out.close();
	}

	public static void updateSpell(String tableName, String tablePKColumn, String chineseColumn, String spellColumn){
		if(tableName!=null && tablePKColumn!=null && chineseColumn!=null && spellColumn!=null){
			List<String[]> list = new ArrayList<String[]>();
			String sql = "select "+tablePKColumn+","+chineseColumn+" from "+tableName;
			ResultSet rs = DBUtil.queryRowSet(sql);
			try {
				while(rs.next()){
					String[] bean = new String[2];
					bean[0] = rs.getString(1);
					bean[1] = Char2spell.getPYString(rs.getString(2));
					list.add(bean);
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<String> sqls = new ArrayList<String>(20);
//			List<String[]> list_temp = list.subList(0, 20);
			int size = list.size();
			for(int i=0;i<size;i++){
				String[] s = list.get(i);
				StringBuffer sql_ = new StringBuffer("");
				sql_.append("update ").append(tableName).append(" set ").append(spellColumn)
				.append("='").append(s[1]).append("' where ").append(tablePKColumn)
				.append("='").append(s[0]).append("'");
				sqls.add(sql_.toString());
				if(i%20==0 || i==size-1){
					DBUtil.executeBatch(sqls);
					sqls.clear();
				}
			}
		}
	}
}
