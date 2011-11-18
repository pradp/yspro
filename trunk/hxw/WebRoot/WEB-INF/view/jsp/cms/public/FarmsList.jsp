<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<jsp:useBean class="com.yszoe.util.StringUtil" id="item" scope="page"/> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>种畜禽场 - 北京种畜禽遗传资源网</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<script type="text/javascript" src="../resources/jquery/jquery-1.6.2.min.js"></script>
		<!--分页start-->
	<script type="text/javascript" src="../component/jquery.pagination/jquery.pagination.js"></script>
	<link rel="stylesheet" type="text/css" media="all" href="../component/jquery.pagination/pagination.css" />
		<!--分页end-->
	<script type="text/javascript">

	</script>
  </head>
  
  <body>
    <jsp:include page="common/head.jsp" />
    <!--body_begin-->
<div id="main">
<div class="page2 position"> 您现在正在浏览： <a href="../index.jsp" >首页</a> » 种畜禽场 
 </div> 
<!--cjbd_begin-->
<div class="page2 box">
  <div class="w700 fl">
  
    <div class="left_top" style="padding-left: 15px;">
      <h2 class="w340 fl"><a href="../farms/index.jhtm" target="_blank">种畜禽场</a></h2>
    </div>
    <div class="box"></div>
    <div class="left_div">
		<div class="w96" style="min-height:800px;">

<div class="c1-body">
   <c:forEach var="entity" items="${resultList}" varStatus="status">
   <div class="c1-bline" style="padding:10px 0;">
   <div class="f-left">
      <img src="../faceui/images/head-mark4.gif" class="img-vm" align="middle" border="0">
         &nbsp;<a href="../farms/${entity.departnamePy}.jhtm" target="_blank"><span style="">${entity.departname}</span>
         </a>
      
   </div>
   <div class="clear"></div>
   </div>
   </c:forEach>
</div>
 <div class="pagination">
     <div id="pagelist" style="display: none" align="center">
		${pager.postToolBar }
	 </div>
     <form name="ysform" method="get">
		<input type="hidden" name="formname" value="ysform"/>
		 <input type="hidden" name="currentPageno" id="yspager_currentPageno" value="${pager.currentPageno }"/>
		 <input type="hidden" name='eachPageRows' id='yspager_eachPageRows' value="${pager.eachPageRows }"/>
     </form>
	 <br/>

    </div>		
    </div>
    </div>
    <div class="left_low"></div>	
  </div> 

<%@include file="common/right.jsp" %>

</div>
	   </div> 
    </div>
	</div>
  <div id="dhcd" align="center" style="clear:both;" >	 
    <jsp:include page="common/foot.jsp" />
    </div>	  	    
  </body>
</html>

