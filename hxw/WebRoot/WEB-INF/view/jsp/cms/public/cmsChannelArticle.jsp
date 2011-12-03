<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>${lmbean.lmmc } - <fmt:message key="application_name"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<script type="text/javascript" src="../resources/jquery/jquery-1.6.4.min.js"></script>
	<!--分页start-->
	<script type="text/javascript" src="../component/jquery.pagination/jquery.pagination.js"></script>
	<link rel="stylesheet" type="text/css" media="all" href="../component/jquery.pagination/pagination.css" />
	<!--分页end-->
	<script type="text/javascript" src="../resources/jquery/plugins/notification/easy.notification.js"></script>
	<link rel="stylesheet" type="text/css" media="all" href="../resources/jquery/plugins/notification/easy.notification.css" />
	<script type="text/javascript">
	jQuery(function() {
		<c:if test="${bt!=null && bt!=''}">
		$.easyNotification({parent:$('#tagboxspace'), text:'${bt }', callback:function(){alert('closed')}});
		</c:if>
			//$('#clickable').click(function(){ 
			//	$.easyNotification('The paragraph has been clicked!'); 
			//})
    });
	</script>

  </head>
  
  <body>
    <jsp:include page="common/head.jsp" />
    <div id="main">
			     
		<!--search_begin--> 
		<div id="search" class="page box">
		      <div class="searchform fl">
			  <form action="">
		        <input name="q" value="${bt }" type="text" id="txtKey" onfocus="if(this.value=='请输入关键词')this.value=''" onblur="if(this.value=='')this.value='请输入关键词'" maxlength="24" autocomplete="off" />
				<input type="hidden" name="lmwid" value="${lmbean.wid }" />
				<span id="fid_box">
				<select name="channelId" id="fid">
				  <option value="">所有信息</option>
				  <option value="1">新闻资讯</option>
				  <option value="2">影视娱乐</option>
				  <option value="9">下载中心</option>
				  <option value="10">关于我们</option>
				</select>
				</span>
		        <input type="submit" id="btnSearch" value=""/>
		      </form>
			  </div>	  
			  <div class="hottag fr ">
			  &nbsp;
			  </div>
		</div>
		<!--search_end--> 
	    <c:if test="${bt!=null && bt!=''}">
	    <div class="page2 ysTagboxParent" style=""><div id="dd" style="float: left;width:140px"> 您当前的搜索条件是：</div><div id="tagboxspace" style="float: left;"></div> </div>
	    </c:if> 
	    <div class="page2 position" style="clear: both;"> 您现在正在浏览： <a href="../index.jsp" >首页</a>    » ${lmbean.lmmc}
	    </div> 

    <!--cjbd_begin-->
<div class="page2 box">
  <div class="w700 fl">
    <div class="left_top box" style="padding-left: 15px;">
      <h2 class="w340 fl"><a href="../channel/${lmbean.lmbm}.jhtm" target="_blank">${lmbean.lmmc}</a>
          <c:if test="${lmbean.zcrss=='1' }">
			<a href="../rss/${channelid }" target="_blank" title="RSS订阅"><img src="../clientui/images/icons/ico4.gif" border="0" alt="RSS订阅" width="14" /></a>
	      </c:if>
      </h2>
    </div>
    <div class="box"></div>
    <div class="left_div box">
		<div class="w96" style="min-height:800px;">

<div class="c1-body">
    <c:forEach var="entity" items="${resultList}" varStatus="status">
      <div class="c1-bline" style="padding:10px 0;">
      <div class="f-left">
         <img src="../faceui/images/head-mark4.gif" class="img-vm" align="middle" border="0">
         &nbsp;
		<c:choose>
			<c:when test="${entity.wzlx=='2'}">
		         <c:if test="${channelpinyin == 'zhzx'}"><a style="color:#f54100">[${entity.lmwid}]</a>&nbsp;</c:if><a href="${entity.bturl}" target="_blank">${entity.bt}</a> 
			</c:when>
			<c:when test="${entity.wzlx=='3'}">
				<c:if test="${channelpinyin == 'zhzx'}"><a style="color:#f54100">[${entity.lmwid}]</a>&nbsp;</c:if><a href="../html/${lmbm}-${entity.wid}.jhtm" target="_blank">${entity.bt}</a> <img src="../clientui/icons/img.gif" border="0" alt="导读新闻" />
			</c:when>
			<c:otherwise>
				<c:if test="${channelpinyin == 'zhzx'}"><a style="color:#f54100">[${entity.lmwid}]</a>&nbsp;</c:if><a href="../html/${lmbm}-${entity.wid}.jhtm" target="_blank">${entity.bt}</a> 
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${entity.ordernum=='1'}">
		<img src="../clientui/images/layout/pin-dn-off.gif" border="0" alt="置顶" />&nbsp;
			</c:when>
			<c:when test="${entity.ordernum=='2'}">
		<img src="../clientui/images/layout/pin-dn-on.gif" border="0" alt="永久置顶" />&nbsp;
			</c:when>
		</c:choose>
		<c:if test="${entity.sftj=='1' }">
		<img src="../clientui/icons/finger.gif" border="0" alt="推荐" />
		</c:if>
		<br>
	  </div>
     <div class="gray f-right">&nbsp;&nbsp;&nbsp;<fmt:formatDate value="${entity.zhxgrq}" pattern="yyyy.MM.dd"/> </div>
    <div class="clear"></div>
    </div>
   </c:forEach>

   </div>
   <!-- 分页 -->
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
  <!-- left样式 -->
  
<%@include file="common/right.jsp" %>

</div>	  
  <div id="dhcd" align="center" style="clear:both;" >	 
    <jsp:include page="common/foot.jsp" />
    </div>
 </div>   	 
  </body>
</html>