<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="com.yszoe.framework.util.DBUtil"%>
<%@page import="com.yszoe.cms.entity.TXxfbLm"%>
<%@page import="com.yszoe.cms.util.CachedQuery"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

<%--header_begin--%>
<div id="header" class="box">
  <div id="logo" class="page box">
    <div class=""><img src="../../faceui/images/logo.gif" border="0" width="960" /></div>
  </div>
  	<fmt:bundle basename="sysconfig" >
    <div id="menu" class="page box relative" align="center">
      <ul id="headmenu">
	   <li class="menu_first"><a href="../../index.jsp" id="index"><span>首 页</span></a></li>
	   <li><a href="../../public/takeiteasy.jhtm" id="xlzx"><span>心理咨询</span></a></li>
	   <li><a href="../../public/dosamething.jhtm" id="xlcs"><span>心理测试</span></a></li>
	   <%
	    java.util.List<TXxfbLm> lms = CachedQuery.getCmsChannels();
	    for(TXxfbLm lm : lms){
	    	if("000".equals(lm.getParentwid())){//一级栏目
	    %>
	   <li><a href="../../channel/<%=lm.getLmbm() %>.jhtm" id="<%=lm.getLmbm() %>" onmouseover="mopen('m<%=lm.getLmbm() %>')" onmouseout="mclosetime()"><span><%=lm.getLmmc() %></span></a>
	       <div id="m<%=lm.getLmbm() %>" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
	   <%
			    for(TXxfbLm lmSon : lms){
			    	if(lm.getWid().equals(lmSon.getParentwid())){
	    %>
		           <a href="../channel/<%=lmSon.getLmbm() %>.jhtm"><%=lmSon.getLmmc() %></a>
	    <%
			    	}
			    }
	    %> 
	       </div>
	   </li>
	    <%} 
	    }%> 
	   <li><a href="../../service/activity/index" id="xlyp"><span>活 动</span></a></li>
	   <li><a href="../../bbs" id="bbs"><span>互助论坛</span></a></li>
	 </ul>   
    </div>
    </fmt:bundle>
  </div>  
 <%--header_end--%>