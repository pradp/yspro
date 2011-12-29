<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>

	<link type="text/css" rel="stylesheet" href="../faceui/css/front.css"/>
    <link type="text/css" rel="stylesheet" href="../faceui/css/layout.css"/>
    <script type="text/javascript" src="../faceui/js/common.js"></script>
<style>
<!--
#headmenu li
{
	list-style: none;
	float: left;
}
#headmenu li a
{	display: block;
	margin: 8px 1px 0 4px;
	padding: 4px 8px;
	width: 65px;
	color: #FFF;
	font-weight:bold;
	text-align: center;
	text-decoration: none
}
#headmenu li a:hover
{	
	background: #F5F5F5;
	color: #FD9305;
}
#headmenu div
{	position: absolute;
	visibility: hidden;
	margin: 0;
	padding: 0;
}
#headmenu div a{	
	width: 65px;
	position: relative;
	display: block;
	margin: 0 1px 0 4px;
	padding: 7px 8px 3px 8px;
	white-space: nowrap;
	text-align: center;
	text-decoration: none;
	background: #f5f5f5;
	color: #FD9305;
}
#headmenu div a:hover{	
	background: #F8AD13;
	color: #FFF
}
-->
</style>
<script type="text/javascript">
<!--
var timeout	= 500;
var closetimer	= 0;
var ddmenuitem	= 0;
// open hidden layer
function mopen(id){	
	// cancel close timer
	mcancelclosetime();
	// close old layer
	if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
	// get new layer and show it
	ddmenuitem = document.getElementById(id);
	ddmenuitem.style.visibility = 'visible';
}
// close showed layer
function mclose(){
	if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
}
// go close timer
function mclosetime(){
	closetimer = window.setTimeout(mclose, timeout);
}
// cancel close timer
function mcancelclosetime(){
	if(closetimer){
		window.clearTimeout(closetimer);
		closetimer = null;
	}
}

// close layer when click-out
document.onclick = mclose; 
//-->
</script>

<%--header_begin--%>
<div id="header" class="box">
  <div id="logo" class="page box">
    <div class=""><img src="../faceui/images/logo.gif" border="0" width="960" /></div>
  </div>
  	<fmt:bundle basename="sysconfig" >
    <div id="menu" class="page box relative" align="center">
      <ul id="headmenu">
	   <li class="menu_first"><a href="../index.jsp" id="index"><span>首 页</span></a></li>
	   <li><a href="../public/takeiteasy.jhtm" id="xlzx"><span>心理咨询</span></a></li>
	   <li><a href="../public/dosamething.jhtm" id="xlcs"><span>心理测试</span></a></li>
	   <%
	    java.util.List<TXxfbLm> lms = CachedQuery.getCmsChannels();
	    for(TXxfbLm lm : lms){
	    	if("000".equals(lm.getParentwid())){//一级栏目
	    %>
	   <li><a href="../channel/<%=lm.getLmbm() %>.jhtm" id="<%=lm.getLmbm() %>" onmouseover="mopen('m<%=lm.getLmbm() %>')" onmouseout="mclosetime()"><span><%=lm.getLmmc() %></span></a>
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
	   <li><a href="../public/xlyp.jhtm" id="xlyp"><span>心理研培</span></a></li>
	   <li><a href="../bbs" id="bbs"><span>互助论坛</span></a></li>
	 </ul>   
    </div>
    </fmt:bundle>
  </div>  
 <%--header_end--%>