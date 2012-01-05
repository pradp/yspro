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
	   <a href="<%=request.getContextPath() %>/index.jsp" id=""><span>首 页</span></a>
	   <a href="<%=request.getContextPath() %>/usercenter/index" id=""><span>个人主页</span></a>
	   <a href="<%=request.getContextPath() %>/s/counsel" id=""><span>心理咨询</span></a>
	   <a href="<%=request.getContextPath() %>/s/test" id=""><span>心理测试</span></a>
	   <a href="<%=request.getContextPath() %>/s/activities" id=""><span>活动</span></a>
	   <a href="<%=request.getContextPath() %>/bbs" id="bbs"><span>互助论坛</span></a>
	 </ul>   
    </div>
    </fmt:bundle>
  </div>  
  <hr/>
 <%--header_end--%>