<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="../../common/include_list_head.jsp" %>

<body>
<script type="text/javascript">

</script>
<%@include file="../../cms/public/common/head.jsp" %>	

    <hr />
		
	<br/> <br/>
	<div align="left">
	<c:forEach var="entity" items="${resultData}" varStatus="status">
		${status.index+1}、<a href="" target="_blank">${entity.title}</a> 
		
		&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${entity.dateofinput}" pattern="yyyy.MM.dd"/> <br>
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

	<script language="javascript">
		function trunPage(){
			var reqPageNo = document.getElementById('pager_currentPageno').value;
			if( reqPageNo<1 || reqPageNo>2 ){
					alert('当前的有效页码是小于或等于2的正整数，请重新输入！');
					return;
			}
			$("#yspager_currentPageno").val($("#pager_currentPageno").val());
			$("#yspager_eachPageRows").val($("#eachPageRows").val());//让spring可以接收，转为bean
			document.forms[0].submit();
		}
	</script>
  </body>
</html>
