<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

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
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/960.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/reset.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/text.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/main.css" type="text/css" media="all" />

    
</head>
<body>
<div class="container_16">
		<!-- 导入head 区域  head.jsp-->
			<jsp:include page="../common/head.jsp" flush="true"></jsp:include>
		<!-- 导入head 区域-->
<div id="container" class="grid_16"><!-- container begin -->
  
  <!--导入赛事日程  区域 （可选） ssrcDate.jsp-->
	<jsp:include page="../common/ssrcDate.jsp" flush="true"></jsp:include>
  <!--导入赛事日程  区域（可选）-->
  
  
	<!-- 主体内容区域  开始 -->
  <div id="jiangpai" class="grid_4 alpha">
       <table class="mytable" cellspacing="0" summary="金牌榜">
         <tr>
           <th scope="col" abbr="排名">排名</th>
           <th scope="col" abbr="代表团">代表团</th>
           <th scope="col" abbr="金牌"><img src="styles/img/g.png" alt="金牌" /></th>
           <th scope="col" abbr="银牌"><img src="styles/img/s.png" alt="银牌" /></th>
           <th scope="col" abbr="铜牌"><img src="styles/img/b.png" alt="铜牌" /></th>
           <th scope="col" abbr="合计">合计</th>
         </tr>
         <tr>
           <th scope="row" abbr="南京" class="spec">1</th>
           <td>南京</td>
           <td class="gpai">18</td>
           <td class="spai">17</td>
           <td class="bpai">10</td>
           <td>37</td>
         </tr>
         
         <tr>
           <th scope="row" abbr="南京" class="spec">1</th>
           <td>南京</td>
           <td class="gpai">18</td>
           <td class="spai">17</td>
           <td class="bpai">10</td>
           <td>37</td>
         </tr>
       </table>
       
  </div>

 <!-- 主内容区 结束 -->
	<!-- 右边 登录、历史成绩、模块导入(可选) right.jsp -->
		<jsp:include page="../common/right.jsp" flush="true"></jsp:include>
	<!-- 右边 登录、历史成绩、模块导入(可选) -->
 
  
  <div class="clear"></div>
</div><!-- container end -->

<!-- 脚注部分导入 footer.jsp-->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
<!-- 脚注部分导入-->

</div>
</body>
</html>
