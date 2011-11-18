<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>专家在线答疑信息公布</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<script type="text/javascript" src="../resources/jquery/jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="../faceui/js/wsdyIndex.js"></script>
		<!--分页start-->
	<script type="text/javascript" src="../component/jquery.pagination/jquery.pagination.js"></script>
	<link rel="stylesheet" type="text/css" media="all" href="../component/jquery.pagination/pagination.css" />
		<!--分页end-->
  </head>
  
  <body>
    <jsp:include page="common/head.jsp" />
    <!--body_begin-->
<div id="main">
  <div class="page2 position"> 您现在正在浏览： <a href="../index.jsp">首页</a> » 答疑公布</div>
  <!--cjbd_begin-->
  <div class="page2 box">
    <div class="w700 fl">
      <div class="rb_top"></div>
      <div class="rb_mid box">
        <div class="w96" style="min-height:800px;">
            <div class="gb_logo">
				<img src="../faceui/images/lyb.jpg">
			</div>
			<c:forEach var="Dyentity" items="${DyresultList}" varStatus="status">
			<dl class="gb">
				<dt><span style="color:#999999">${Dyentity.writer}</span>问：<span>${Dyentity.title}</span></dt>
				<dd><strong>${Dyentity.replyexpert}：</strong>${Dyentity.answer}</dd>
		   </dl>
	       </c:forEach>
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
    <div id="dhcd"; align="center"; style="clear:both;" >	  
    <jsp:include page="common/foot.jsp" />
    </div>	 
	   </div>  	    
  </body>
</html>

