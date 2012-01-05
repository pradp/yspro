<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title> 活动列表 </title>
	<%@include file="../../common/usercenter_head_meta.jsp" %>	
	<script type="text/javascript">
	
	</script>
</head>

<body>
<%@include file="../../common/usercenter_head.jsp" %>	

    <div class="middler">
		<%@include file="../../common/usercenter_left.jsp" %>	
		<div class="middleright">
	
	    <hr />
		
		<br/> <br/>
		<div align="left">
		<c:forEach var="entity" items="${resultList}" varStatus="status">
			${status.index+1}、<a href="myactivity/${entity.wid }" target="_blank">${entity.bt}</a> 
			
			&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${entity.zhxgrq}" pattern="yyyy.MM.dd"/> <br>
		</c:forEach>
		</div>
		<hr />
		<div align="left">
			${pager.postToolBar }
		</div>
			<form name="ysform" method="get">
					<input type="hidden" name="formname" value="ysform"/>
					<input type="hidden" name="currentPageno" id="yspager_currentPageno"/>
					<input type="hidden" name='eachPageRows' id='yspager_eachPageRows'/>
			</form>
		 <br/>
	    </div>
	</div>
<%@include file="../../common/public_foot.jsp" %>	

  </body>
</html>
