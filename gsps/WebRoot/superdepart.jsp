<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.imchooser.framework.util.*"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>显示上级部门</title>

  </head>
  <body>
  <table>
    <tr>
    <td>
    <%
    	String depart = request.getParameter("updepartid").toString();
    	if(depart.equals("0"))
    	{
    		out.println("您是最高权限,无上级!");
    	}else{
    		out.println("您的上级部门是"+DBUtil.queryFieldValue("select t.username from t_sys_user t where t.userdepart=?", depart)+"!");
		}
	%>
	 
	</td>
	</tr>
	</table>
  </body>
</html>
