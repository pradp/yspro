<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@page import="com.yszoe.framework.util.DBUtil"%>
<%@page import="com.yszoe.cms.entity.TXxfbLm"%>
<%@page import="com.yszoe.cms.util.CachedQuery"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<title><fmt:message key="application_name" /> - 会员中心 </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<script type="text/javascript" src="resources/jquery/jquery-1.6.4.min.js"></script>
  </head>
  
  <body>
    <div align="center">
	    <br/>
	    <a href="../index.jsp">首页</a>      
	    <a href="../public/takeiteasy.jhtm">心理咨询</a>  
	    <a href="../public/dosamething.jhtm">心理测试</a>  
	    <%
	    java.util.List<TXxfbLm> lms = CachedQuery.getCmsChannels();
	    for(TXxfbLm lm : lms){
	    	if("000".equals(lm.getParentwid())){
	    %>
	    <a href="../channel/<%=lm.getLmbm() %>.jhtm"><%=lm.getLmmc() %></a>    
	    <%} 
	    }%>  
	    <a href="../s/activity/index">活 动</a>    
	    <a href="../usercenter/myactivities">我的活动</a>   
	    <a href="../bbs">互助论坛</a>      
    </div>
   <br/><br/>
    <div align="center">
	    <br/>
	    这是会员主页     
	    <br/>
	    ......     
	    <br/>
	    
    </div>
  </body>
</html>
