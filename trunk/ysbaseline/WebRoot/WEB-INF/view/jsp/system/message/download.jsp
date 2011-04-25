<%@page pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.yszoe.sys.action.*"%>
<%@page language="java"%>
<%
	String wid = request.getParameter("aId");
	String pathStr = request.getParameter("pathStr");
	MessageAction message = new MessageAction();
	//关于文件下载时采用文件流输出的方式处理：   
	response.setContentType("APPLICATION/OCTET-STREAM");
	response.setHeader("Content-Disposition","attachment;fileName="+pathStr);
	//message.getNR_XZ(wid,pathStr,response);
    OutputStream servletOutPutStream=response.getOutputStream();   
	out.clear();
	out = pageContext.pushBody();
%>