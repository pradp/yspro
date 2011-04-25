<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
  
    <title>江苏省第十七届运动会综合成绩榜</title>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/960.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/reset.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/text.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/main.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/saicheng.css" type="text/css" media="all" />
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
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
	function  myinit(){
	}
	</script>
	<style>
#xmlb ul li a {
	display: block;
	height: 25px;
	padding-top: 10px;
	width: 67px;
	text-align: center;
	color: black;
}
#scinfo {
	border-bottom: 1px solid #3b9dca;
	border-right: 1px solid #3b9dca;
	border-left: 1px solid #3b9dca;
	margin-bottom: 0px;
}

#xmlb ul li .active{
	color: #FF9700;
	font-weight: bold;
	background: url(<s:property value="basePath"/>/resources/images/pages/bg_riqiwip.png)
}
#xmlb ul li a:hover {
	color: #62C966;
	
}
#xmlb {
			margin-bottom: 8px;
		}
	</style>
  </head>
  
<body> 
    <div class="container_16">
		<!-- 导入head 区域  head.jsp-->
			<jsp:include page="../common/head.jsp" flush="true"></jsp:include>
		<!-- 导入head 区域-->
<div id="container" class="grid_16"><!-- container begin -->
  <!--导入赛事日程  区域 （可选） ssrcDate.jsp-->
  <jsp:include page="../common/ssrcDate.jsp" flush="true" ></jsp:include>
  <div id="xmlb" class="grid_16 alpha omega">
 	<ul>
 		<s:iterator value="getAllDxmmc()" status="i">
 		<%int i=0; %>
			 <li>
			 	<a href="../visitor/sportCjcxRc-list.c?cssS=<s:property value='%{#parameters.cssS[0]}'/>&dxmmc=<s:property value='id' />&mi=<s:property value='mi' />&bssj=<s:property value='bssj' />&paixu=0" <s:if test="%{#dxmmc==caption}">class="active"</s:if>>
					<s:iterator value="dxmmcList" status="st">
			 			<s:if test="#dxmmcList[#st.index][0].toString()==caption" >
			 			<%	i++;%>
			 			<s:if test="%{#dxmmc==caption}"><s:property value="caption" id="caption"/></s:if>
			 			<s:else><s:property value="caption" id="caption"/><span style="font-size:12px;">*</span></s:else>
			 			</s:if>
			 		</s:iterator>
					<%
						if(i==0){
							%>
								<s:property value="caption" id="caption"/>
							<%
						}
					%>
				</a>
			 </li>
		</s:iterator>
	 </ul>
  </div>
  <!--导入赛事日程  区域（可选）-->
	<!-- 主体内容区域 -->
  	<s:form theme="simple" name="theform" >
    <s:hidden name="pager.formname" value="theform"/>
    <s:hidden name="bsxm" id="bsxm_id" value="%{#bsxm}"></s:hidden>
    <s:hidden name="listData_size" id="listData_size" value="%{resultData.size()}" />
    <s:hidden name="type" id="type_id" value="%{#type}" />
    <jsp:include page="listInclude1.jsp" flush="true"></jsp:include>
    </s:form>
 
 
  <!-- 主内容区 结束 -->
  <div class="clear"></div>
</div><!-- container end -->

<!-- 脚注部分导入 footer.jsp-->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
<!-- 脚注部分导入-->

</div>
  </body>
</html>
