<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.imchooser.util.StringUtil"%>
<%@page import="com.imchooser.util.DateUtil"%>
<%@ page import="com.imchooser.framework.identity.entity.LoginUserVO"%>
<%@ page import="com.imchooser.framework.identity.entity.TSysDepart"%>
<%@ page import="com.imchooser.framework.identity.IdConstants"%>
<%
//后台管理页面的抬头页面
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String cssS = request.getParameter("cssS");
if(StringUtil.isBlank(cssS))
	cssS="8";
String d = DateUtil.currentDateString();

LoginUserVO tsysUser = (LoginUserVO) session.getAttribute(IdConstants.SESSION_USER);
String departid = null;
if(tsysUser!=null){
	TSysDepart tdepart = tsysUser.getDepart();
	String userDepartname = tdepart.getDepartname();
	departid = tdepart.getDepartid();
	String userLoginId = tsysUser.getUserLoginId();
	String userName = tsysUser.getUserName();
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" >
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="author" content="" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="robots" content="all" />
	<title>江苏省第十七届运动会综合成绩榜</title>
	<link rel="stylesheet" href="<%=basePath%>resources/css/pages/960.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<%=basePath%>resources/css/pages/reset.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<%=basePath%>resources/css/pages/text.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<%=basePath%>resources/css/pages/main.css" type="text/css" media="all" />
	<script type="text/javascript">
	 function onChoose(uri){
	  window.location.href = uri;
     	}
	  </script>
<style type="text/css">
#header h1.home {
	margin: 0;
	padding: 0;
	height: 101px;
	<% 
		if("320".equals(departid)){
			%>
		background: url(/SportsScore/resources/images/pages/logo_cjgl.jpg) no-repeat left top;	
			<%
		}else{
			%>
		background: url(/SportsScore/resources/images/pages/logo_dbtcj.jpg) no-repeat left top;	
	<%
		}
	%>
	
}
#header {
	background: url(/SportsScore/resources/images/pages/bg_headerdl.jpg)
		no-repeat left top;
}
#nav p.subnav {
	float: right;
	margin: 4px 0 0;
	padding: 8px 0 0;
	width: 300px;
	background: url(/SportsScore/resources/images/pages/subnav_dl.png)
		no-repeat right;
	text-align: center;
	color: #fffeff;
	height: 20px;
}
body {
	background: url(/SportsScore/resources/images/pages/indexbg_dl.jpg)
		repeat-x left top;
	font-size: 12px;
}
</style>
</head>
<body>
<div class="container_16">
<!-- 头部开始 -->
<div id="header" class="grid_16">
	<h1 class="home"><span>江苏省第十七届运动会综合成绩榜</span></h1>
  <div id="nav"><!-- 导航开始 -->
    <ul class="mainnav">
        <li><a target="_top" href="./visitor/sportCjTdHz-list.c?cssS=1" title="首 页">首 页</a></li>
		<li><a target="_top" href="./visitor/sportCjcxDbt-list.c?jp=3&cssS=2" title="代表团成绩查询" >代表团成绩查询</a></li>
		<li><a target="_top" href="./visitor/sportCjcxRcZk-list.c?cssS=4" title="赛程查询" >赛程查询</a></li>
		<li><a target="_top" href="./visitor/sportDxmmc-list.c?cssS=5" title="项目查询" >项目查询</a></li>
	    <li><a target="_top" href="./visitor/sportCjcxPjl-list.c?cssS=6" title="破纪录查询" >破纪录查询</a></li>
	    <li><a target="_top" href="./visitor/sportCjcxZhcjb-list.c?cssS=9" title="其他奖项" >其他奖项</a></li>
	    <li><a target="_top" href="./visitor/sportCjcxNbbd-list.c?cssS=7" title="代表团全部成绩榜" >代表团全部成绩榜 </a> </li>
	    <li><a target="_top" href="./visitor/sportCjcxXscjb-list.c?cssS=3" title="区县成绩榜" >区县成绩榜</a></li>
	    <li><a target="_top" href="./identity/index.c?cssS=8" title="成绩管理"  class="active">成绩管理</a></li>
	</ul>
  </div><!-- 导航结束 -->
</div>
<!-- 头部结束 -->
</div>
</body>
</html>