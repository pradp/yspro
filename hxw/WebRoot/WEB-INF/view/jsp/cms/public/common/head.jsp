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
    <div class=""><img src="../faceui/images/index_03.gif" border="0" width="960" /></div>
  </div>
  	<fmt:bundle basename="sysconfig" >
    <div id="menu" class="page box relative" align="center">
      <ul id="headmenu">
	   <li class="menu_first"><a href="../index.jsp" id="index"><span>首 页</span></a></li>
	   <li><a href="../channel/tzgg.jhtm" id="tzgg"><span>通知公告</span></a></li>
	   <li><a href="../farms/index.jhtm" id="farms"><span>种畜禽场</span></a></li>
	   <li><a href="#" id="zzyz" onmouseover="mopen('m1')" onmouseout="mclosetime()"><span>种猪育种</span></a>
	       <div id="m1" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
		           <a href="http://www.bcage.org.cn/docc/zcxx.jsp" target="_blank">综合查询</a>
		           <a href="http://www.bcage.org.cn/docc/cdxxquery.jsp?sendLocation=/docc/cdxxquery.jsp" target="_blank">网络育种</a>
	       </div>
	   </li>
	   <li><a href="../logindhi.jsp" id="dhi"><span style="font-family:新宋体;">奶牛DHI</span></a></li>
	   <li><a href="../identity/index.action" id="scjc"><span>生产监测</span></a></li>
	   <li><a href="../channel/zxdt1.jhtm" onmouseover="mopen('m2')" onmouseout="mclosetime()" id="zxdt1"><span>资讯动态</span></a>
	      <div id="m2" onmouseover="mcancelclosetime()" onmouseout="mclosetime()">
	           <a href="../channel/zxdt.jhtm">中心动态</a>
	           <a href="../channel/hydt.jhtm">行业动态</a>
		       <a href="../channel/gfbz.jhtm">规范标准</a>
	       </div>
	   </li>
	   <li><a href="../channel/pzjs.jhtm" id="pzjs"><span>品种介绍</span></a></li>
       <li><a href="../channel/fyjs.jhtm" id="fyjs"><span>繁育技术</span></a></li>
	   <li><a href="../answer/index.jhtm" id="answer"><span>网上答疑</span></a></li>
       <li><a href="../channel/zlxz.jhtm" id="zlxz"><span>资料下载</span></a></li>
	 </ul>   
    </div>
    </fmt:bundle>
  </div>  
 <%--header_end--%>