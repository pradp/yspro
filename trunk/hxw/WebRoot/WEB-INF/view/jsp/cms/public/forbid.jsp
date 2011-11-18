<%@ page language="java" pageEncoding="UTF-8" session="false" %>
<% 
	//out.println("<script>alert('您访问的资源需要登录后才有权限使用，请先登录！');window.close()</script>");
response.sendRedirect( request.getContextPath() + "/identity/login.action" );
%> 

