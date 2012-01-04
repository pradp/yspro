<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<%@include file="../../common/usercenter_head_meta.jsp" %>	
    <title>${bean.bt } - <fmt:message key="application_name"/></title>
	<script type="text/javascript">

	function doComment(){
		var url = '../docomment/${bean.wid}.jhtm';
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
	<%@include file="../../common/usercenter_head.jsp" %>	
	<div id="main">
        <!--cjbd_begin-->
  <div class="page2 box">
    <div class="w700 fl">
      <div class="rb_top"></div>
      <div class="rb_mid box">
        <div class="w96">
          <h1>${bean.bt }</h1>
          <div class="msgbar">发布时间：<fmt:formatDate value="${bean.cjrq}" pattern="yyyy.MM.dd"/>  &nbsp;  组织者：${bean.zzz }&nbsp; 
             <c:if test="${bean.bmrs<bean.zdrs}">
	             &nbsp;<a href="#apply">我要报名（${bean.bmrs }）</a>&nbsp;
	         </c:if>
	         &nbsp;&nbsp;&nbsp;有${bean.djs }人关注
	         &nbsp;&nbsp;&nbsp;已有${bean.bmrs }人报名
          </div>
          <c:if test="${bean.hddd!=null && bean.hddd!=''}">
          <div class="summary">
		  	<strong>活动地点：</strong>${bean.hddd }
		  	<strong>活动时间：</strong>${bean.hdsj }
		  </div>
	      </c:if>
          <div class="content">
             <c:if test="${bean.syydt!=null && bean.syydt!=''}">
	             <img id="syydt" src="../${bean.syydt}" border="0"/><br/>
	         </c:if>
              ${bean.nr }
          </div>
          <div class="pagebar"></div>
		  
       </div>
     </div>
   <div class="left_low"></div>	
 </div>  

    <!-- left样式 -->
  <%@include file="../../common/usercenter_left.jsp" %>
  <div id="dhcd" align="center" style="clear:both;" >	 
    <jsp:include page="../../common/public_foot.jsp" />
    </div> 
    </div>
	 
  </body>
</html>
