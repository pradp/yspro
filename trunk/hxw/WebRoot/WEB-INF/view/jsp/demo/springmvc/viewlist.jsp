<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>${lmmc } - 北京种畜禽遗传资源网</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<script type="text/javascript" src="../resources/jquery/jquery-1.6.2.min.js"></script>
  </head>
  
  <body>

	<hr />
		<strong>${lmmc}
		<c:if test="${zcrss=='1' }">
			<a href="../rss/${channelid }" target="_blank"><img src="../clientui/images/icons/ico4.gif" border="0" alt="RSS" width="14" /></a> 
		</c:if>
		</strong>
	<br/> <br/>
	<div align="left">
	<c:forEach var="entity" items="${resultList}" varStatus="status">
		${status.index+1}、
		<c:choose>
			<c:when test="${entity.wzlx=='2'}">
		<a href="${entity.bturl}" target="_blank">${entity.bt}</a> 
			</c:when>
			<c:when test="${entity.wzlx=='3'}">
		<a href="../html/${entity.wid}.jhtm" target="_blank">${entity.bt}</a> <img src="../clientui/icons/img.gif" border="0" alt="导读新闻" />
			</c:when>
			<c:otherwise>
		<a href="../html/${entity.wid}.jhtm" target="_blank">${entity.bt}</a> 
			</c:otherwise>
		</c:choose>
		<c:if test="${entity.sftj=='1' }">
		<img src="../clientui/icons/finger.gif" border="0" alt="推荐" />
		</c:if>
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