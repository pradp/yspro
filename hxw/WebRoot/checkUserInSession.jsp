<%@ page language="java" pageEncoding="UTF-8" session="false"%>
<%@ page import="com.yszoe.sys.uniid.server.UniIdServiceImpl"%>
<%
	String userLoginId = request.getParameter("userLoginId");
	boolean isLogined = false;
	if(userLoginId!=null){
		isLogined = UniIdServiceImpl.isThisUserAlreadyLogined(userLoginId);
	}
	out.println(isLogined);
%>