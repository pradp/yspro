<%@ page language="java" pageEncoding="UTF-8"%>
<jsp:directive.page import="com.imchooser.sys.Constants"/>
<%
	String message = "";
//message = "发现最新更新程序发布，服务需要重起。请立即保存数据，稍后再登录！";
Object user = session.getAttribute(Constants.SESSION_USER_FLAG);
if( user!=null ){
	//message = "2008年4月1日17：00~4月2日9：00维护网站！这期间请不要登记，正在登记部分请保存！";
}else{
	message = "您与服务器的连接已经断开！请重新登录.";
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>客户机与服务器连接检查</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
  </head>
  
  <body>
    <%=message %>
  </body>
</html>
