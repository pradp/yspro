<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
	<script>
		function csh(xm_span, wid_xm,wid_bm){
			if(wid_xm!=""){
				var wid_xms = wid_xm.split(",");//wid_xm,wid_xm....
				var wid_bms = wid_bm.split(",");//wid_xm,wid_xm....
				//alert(wid_xms);
				var uri = '';
				for(i=0;i<wid_xms.length;i++){
					var url1 = "../visitor/sportCjcxYdyxx-input.c?wid=" + wid_bms[i];
					uri = uri + " <a href='#' onclick=\"openPage2('"+url1+"')\" ><font color='blue'>"+wid_xms[i]+"</font></a> ";
				}
				document.getElementById(xm_span).innerHTML=uri;
			}
		}
		function openPage2(uri){
			omvc = window.open(uri, '_blank', 'height=600, width=800, top=50, left=100, toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=yes, status=yes');
			omvc.focus();
		}
	</script>
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
	  				<div style="font-size: 12px;color: red"><s:property value="%{@java.net.URLDecoder@decode(#totalXm, 'utf-8')}" />			 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;<s:property value="%{@java.net.URLDecoder@decode(#dbtmc, 'utf-8')}" />代表团参赛人员</div>
	  				<br />
     <div id="saichengxx" class="grid_12 alpha" style="margin-right: 2px;">
    	 <table class="subTab" id="mainTable"  summary="今日赛程" >
       	 <tr>
           <th scope="col"  abbr="运动员" width="30%" class="matchDate">运动员</th>
           <th scope="col"  abbr="编排序号" width="20%" class="matchDate">编排序号</th>
           <th scope="col"  abbr="运动员" width="30%" class="matchDate">运动员</th>
           <th scope="col"  abbr="编排序号" width="20%" class="matchDate">编排序号</th>
         </tr>
	          <s:iterator value="#tdry" status="st">
	    			<s:if test="%{#st.index%2==0}" >
	    				<tr>
	    			</s:if>
	    				<td>&nbsp;<span id="<s:property value='#st.index' />_c"></span>  <script> csh("<s:property value='#st.index' />_c","<s:property value='%{#tdry[#st.index][0]}'/>","<s:property value='%{#tdry[#st.index][1]}'/>"); </script></td>
	    				<td>&nbsp;<s:property value="%{#tdry[#st.index][2]}"/></td>
	           	   <s:if test="%{#st.index%2==1}" >
	    				</tr>
	    			</s:if>
	 		 </s:iterator>
         </table>
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
