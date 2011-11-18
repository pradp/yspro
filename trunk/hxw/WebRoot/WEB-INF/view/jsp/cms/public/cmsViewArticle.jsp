<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>${entityBean.bt } - <fmt:message key="application_name"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<script type="text/javascript" src="../resources/jquery/jquery-1.6.4.min.js"></script>
		<!--分页start-->
	<script type="text/javascript" src="../component/jquery.pagination/jquery.pagination.js"></script>
	<link rel="stylesheet" type="text/css" media="all" href="../component/jquery.pagination/pagination.css" />
		<!--分页end-->
	<script language="javascript">

		function doComment(){
			var url = '../docomment/${entityBean.wid}.jhtm';
			//url = url.replace("/html/", "/docomment/");
			var comment = encodeURIComponent($("#plnr").val());
			$.post(url, {plnr: comment}, function(data){
				var obj = eval('('+data+')');
				if(obj.msg == 'ok'){
					alert('评论成功！');
					trunPage();
				}else{
					alert(obj.msg);
				}
			});
		}
		$(function(){
			if(document.getElementById('syydt'))
				ResizeImages("syydt", 650);//自动缩放图片
		})
	</script>
  </head>
  
  <body>
    <jsp:include page="common/head.jsp" />
    <div id="main">
    <div class="page2 position"> 您现在正在浏览： <a href="../index.jsp">首页</a> » <a href="../channel/${wzEntityBean.lmbm }.jhtm" id="${wzEntityBean.lmbm }">${wzEntityBean.lmmc } </a>»正文</div>
        <!--cjbd_begin-->
  <div class="page2 box">
    <div class="w700 fl">
      <div class="rb_top"></div>
      <div class="rb_mid box">
        <div class="w96">
          <h1>${entityBean.bt }</h1>
          <div class="msgbar">发布时间：<fmt:formatDate value="${entityBean.cjrq}" pattern="yyyy.MM.dd"/>  &nbsp;  来源：${entityBean.ly }&nbsp; 
             <c:if test="${entityBean.sfpl!='0'}">
	             &nbsp;<a href="#comment">我要评论（${entityBean.pls }）</a>&nbsp;
	         </c:if>
	         &nbsp;&nbsp;&nbsp;有${entityBean.djs }人游览
          </div>
          <c:if test="${entityBean.zy!=null && entityBean.zy!=''}">
          <div class="summary">
		  	<strong>摘要：</strong>${entityBean.zy }
		  </div>
	      </c:if>
          <div class="content">
             <c:if test="${entityBean.syydt!=null && entityBean.syydt!=''}">
	             <img id="syydt" src="../${entityBean.syydt}" border="0"/><br/>
	         </c:if>
              ${entityBean.nr }
          </div>
          <div class="pagebar"></div>
          <div class="tags"> 
		  	<strong>相关链接：</strong><br/>
			<c:forEach var="relationEntity" items="${relationNews}" varStatus="status">
		    ${status.index+1}、<a href="${wzEntityBean.lmbm }-${relationEntity.wid}.jhtm">${relationEntity.bt}</a> 
		    <fmt:formatDate value="${relationEntity.zhxgrq}" pattern="yyyy.MM.dd"/> <br>
		    </c:forEach>
		  </div> 
		  <c:if test="${entityBean.sfpl!='0'}">
	    <div align="left" style="background-color: #eee">
           <div class="comment">
              <h2><span>网友评论</span>&nbsp;&nbsp;&nbsp; 已有 <em>${entityBean.pls }</em> 条评论</h2>
	           <hr/>
	            <c:forEach var="comment" items="${comments}" varStatus="status">
		        ${status.index+1}、评论人：${comment.plrName} &nbsp;&nbsp;&nbsp;&nbsp; 
		                      评论时间：<fmt:formatDate value="${comment.plsj}" pattern="yyyy.MM.dd HH:mm:ss"/>
		        <br/><br/> ${comment.plnr } <br/>
		        <div style= "border-bottom:#ccc 1px dashed"></div> 
		        </c:forEach>
		        <br/>
		<div id="pagelist" style="display: none" align="center">
		        ${pager.postToolBar }
		</div>
		        <br/>
         </div>
	   </div>
       <form name="ysform" method="get">
		 <input type="hidden" name="formname" value="ysform"/>
		 <input type="hidden" name="currentPageno" id="yspager_currentPageno" value="${pager.currentPageno }"/>
		 <input type="hidden" name='eachPageRows' id='yspager_eachPageRows' value="${pager.eachPageRows }"/>
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

</c:if>
       </div>
     </div>
   <div class="left_low"></div>	
 </div>  

    <!-- left样式 -->
  <%@include file="common/right.jsp" %>
  <div id="dhcd" align="center" style="clear:both;" >	 
    <jsp:include page="common/foot.jsp" />
    </div> 
    </div>
  </body>
</html>