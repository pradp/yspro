<%@page import="com.yszoe.identity.IdConstants"%>
<%@ page language="java" pageEncoding="UTF-8"%>

<%--header_begin--%>
<div id="header" class="" align="center">
    <div id="logo" class="page box">
       <div class=""><img src="<%=request.getContextPath() %>/UI/webui/img/logo.gif" border="0" width="960" /></div>
    </div>
    <div id="menu" class="" align="center">
	   <a href="<%=request.getContextPath() %>/index.jsp" id=""><span>首 页</span></a>
	   <a href="<%=request.getContextPath() %>/public/takeiteasy.jhtm" id=""><span>心理咨询</span></a>
	   <a href="<%=request.getContextPath() %>/public/dosamething.jhtm" id=""><span>心理测试</span></a>
	   <a href="<%=request.getContextPath() %>/s/activities" id=""><span>活 动</span></a>
	   <a href="<%=request.getContextPath() %>/bbs" id="bbs"><span>互助论坛</span></a>
	   <%
	   if(session.getAttribute(IdConstants.SESSION_USER)!=null){
	%>
	   <a href="<%=request.getContextPath() %>/usercenter/index" id=""><span>个人中心</span></a>
	<%
	   }else{
	   %>
	    <a href="<%=request.getContextPath() %>/identity/index.action">会员登录</a> 
	    <%} %>
    </div>
</div>  
<%--header_end--%>