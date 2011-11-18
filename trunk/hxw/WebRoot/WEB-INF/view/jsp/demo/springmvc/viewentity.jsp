<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>${entityBean.bt }</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<script type="text/javascript" src="../resources/jquery/jquery-1.6.2.min.js"></script>
  </head>
  
  <body>

    <div align="center">
	    <br/>
	    <h1>${entityBean.bt }</h1>
	    &nbsp;&nbsp;&nbsp;&nbsp;<h3>${entityBean.fbt }</h3>
	    <hr />
	    来源：${entityBean.ly } &nbsp;&nbsp;&nbsp;&nbsp;发布日期：<fmt:formatDate value="${entityBean.cjrq}" pattern="yyyy.MM.dd"/> 
	    &nbsp;&nbsp;&nbsp;
	<c:if test="${entityBean.sfpl!='0'}">
	    &nbsp;<a href="#comment">我要评论（${entityBean.pls }）</a>&nbsp;
	</c:if>
	    &nbsp;&nbsp;&nbsp;有${entityBean.djs }人游览
	    <br/>
	    <br/>
	    <div align="left">
	    ${entityBean.nr }
	    </div>
    </div>
	<hr />
	<h3>相关链接</h3>
	<br/>
	<div align="left">
	    <c:forEach var="relationEntity" items="${relationNews}" varStatus="status">
		${status.index+1}、<a href="${relationEntity.wid}.jhtm">${relationEntity.bt}</a> 
		<fmt:formatDate value="${relationEntity.zhxgrq}" pattern="yyyy.MM.dd"/> <br>
		</c:forEach>
	</div>
<c:if test="${entityBean.sfpl!='0'}">
	<hr />
	<h3>网友评论</h3> 已有${entityBean.pls }条评论
	<br/>
	<div align="left">
	    <c:forEach var="comment" items="${comments}" varStatus="status">
		${status.index+1}、评论人：${comment.plrName} &nbsp;&nbsp;&nbsp;&nbsp; 
		评论时间：<fmt:formatDate value="${comment.plsj}" pattern="yyyy.MM.dd"/> <br>
		${comment.plnr } <br/>
		<hr/>
		</c:forEach>
		${pager.postToolBar }
	</div>
<form name="ysform" method="get">
		<input type="hidden" name="formname" value="ysform"/>
		<input type="hidden" name="currentPageno" id="yspager_currentPageno"/>
		<input type="hidden" name='eachPageRows' id='yspager_eachPageRows'/>
</form>
	 <br/>
	<a name="comment"></a>
	<c:choose>
      <c:when test="${entityBean.sfpl=='1'}">
		<div align="left">
			<textarea id="plnr" name="plnr" rows="5" cols="70"></textarea> <br/>
			<input name="pl" type="button" value="游客评论" onclick="doComment()"/>
		</div>
      </c:when>
      <c:when test="${entityBean.sfpl=='2' && sessionScope.ys_LoginUser!=null}">
		<div align="left">
			<textarea id="plnr" name="plnr" rows="5" cols="70"></textarea> <br/>
			<input name="pl" type="button" value="发表评论" onclick="doComment()"/>
		</div>
      </c:when>
      <c:when test="${entityBean.sfpl=='2' && sessionScope.ys_LoginUser==null}">
		<div align="left">
			<textarea id="plnr" name="plnr" rows="5" cols="70"></textarea> <br/>
			登录后才可评论！
		</div>
      </c:when>
      <c:otherwise>
      
      </c:otherwise>
    </c:choose>

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
		function doComment(){
			var url = window.location.href;
			url = url.replace("html", "docomment");
			var comment = encodeURIComponent($("#plnr").val());
			$.post(url, {plnr: comment}, function(data){
				var obj = $.parseJSON(data);
				if(obj.msg=='ok'){
					alert('评论成功！');
					trunPage();
				}else{
					alert(obj.msg);
				}
			});
		}
	</script>
</c:if>

  </body>
</html>