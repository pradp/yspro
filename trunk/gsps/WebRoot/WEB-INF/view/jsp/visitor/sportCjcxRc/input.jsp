<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
  
    <title>江苏省第十七届运动会综合成绩榜</title>
    
	<meta http-equiv="pragma" content="no-cache"></meta>
	<meta http-equiv="cache-control" content="no-cache"></meta>
	<meta http-equiv="expires" content="0"></meta>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta>
	
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/960.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/reset.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/text.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/main.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/saicheng.css" type="text/css" media="all" />
	<script type="text/javascript">
	
	function openPage(uri){
		openWindow(uri,1000,600);
	}
	function changeStyle(obj){
		obj.style.color="#7CFC00";
	}
	function changeStyle2(obj){
		obj.style.color="#000000";
	}
	function toPrint2(){
		window.print();
	    return false;
	}
	
	</script>
	<style type="text/css" media="print">
		.todis{
			display: none;
		}
		#paipang{
			display: block;
		}
		body {
			background: ;
		}
	</style>
  </head>
  
<body> 
    <div class="container_16">
		<!-- 导入head 区域  head.jsp-->
		<div class="todis"> 
			<jsp:include page="../common/head.jsp" flush="true"></jsp:include>
		</div>
		<!-- 导入head 区域-->
<div id="container" class="grid_16"><!-- container begin -->
  <!--导入赛事日程  区域 （可选） ssrcDate.jsp-->
  <div class="todis"> 
 		 <jsp:include page="../common/ssrcDate.jsp" flush="true"></jsp:include>
  </div>
  <!--导入赛事日程  区域（可选）-->
	<!-- 主体内容区域 -->
  <s:form theme="simple" name="theform">
    <s:hidden name="pager.formname" value="theform"/>
    <s:hidden name="bsxm" id="bsxm_id" value="%{#bsxm}"></s:hidden>
    <s:hidden name="listData_size" id="listData_size" value="%{resultData.size()}" />
    <s:hidden name="type" id="type_id" value="%{#type}" />
    <!--  xmtype: 是否对仗项目  ； sfxnsc： 是否虚拟赛次 ；sfjtxm ： 是否集体项目； jscj： 决赛 -->
    <div id="paipang">
	 <s:if test="#sfjtxm==1">
	 	 <s:if test="#xmtype==1">
	 	 	<s:if test="#sfxnsc==1" >
	 	 		<s:include value="jsxm.jsp"></s:include> 
	 	 	</s:if>
	 	 	<s:else>
	 	 		<s:include value="ball.jsp"></s:include> 
	 	 	</s:else>
	 	 </s:if>
	 	 <s:else>
	 	 	<s:include value="nomal.jsp"></s:include> 
	 	 </s:else>
	 </s:if>
	 <s:else>
	 <!-- 
	 	<s:if test="#xmtype==1 && #sfxnsc==0">
	 		<s:include value="ball.jsp"></s:include> 
	 	</s:if>
	 	<s:else>
	 		<s:include value="nomal.jsp"></s:include> 
	 	</s:else>
	 	 -->
	 		<s:include value="nomal.jsp"></s:include> 
	 </s:else>
	 </div>
    </s:form>
   
    <div class="todis"> 
	<!-- 右边 登录、历史成绩、模块导入(可选) right.jsp -->
		<jsp:include page="../common/right.jsp" flush="true"></jsp:include>
	<!-- 右边 登录、历史成绩、模块导入(可选) -->
	</div>
 
  <!-- 主内容区 结束 -->
  <div class="clear"></div>
</div><!-- container end -->
  <div class="todis"> 
<!-- 脚注部分导入 footer.jsp-->
		<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
<!-- 脚注部分导入-->
  </div>

</div>
  </body>
</html>
