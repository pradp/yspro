<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%--header_begin--%>
<div id="header" class="box">
  <div id="logo" class="page box">
    <div class=""></div>
  </div>
  	<fmt:bundle basename="sysconfig" >
    <div id="menu" class="page box relative" align="center">
      <ul id="headmenu">
	   <li class="menu_first"><a href="<%=request.getContextPath() %>/index.jsp" id="index"><span>首 页</span></a></li>
	   <li><a href="<%=request.getContextPath() %>/public/takeiteasy.jhtm" id="xlzx"><span>心理咨询</span></a></li>
	   <li><a href="<%=request.getContextPath() %>/public/dosamething.jhtm" id="xlcs"><span>心理测试</span></a></li>
	   <li><a href="<%=request.getContextPath() %>/s/activities" id="xlyp"><span>活动</span></a></li>
	   <li><a href="<%=request.getContextPath() %>/usercenter/myactivities" id="xlyp"><span>我的活动</span></a></li>
	   <li><a href="<%=request.getContextPath() %>/bbs" id="bbs"><span>互助论坛</span></a></li>
	 </ul>   
    </div>
    </fmt:bundle>
  </div>  
 <%--header_end--%>