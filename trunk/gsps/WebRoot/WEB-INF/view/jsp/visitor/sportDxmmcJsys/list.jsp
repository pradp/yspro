<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/960.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/reset.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/text.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/main.css" type="text/css" media="all" />
	<script type="text/javascript">
	listPageStyle();
	
	}
	
	</script>
  </head>
<body > 
<center>
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" >
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>
    <s:form theme="simple" name="theform">
  <s:hidden name="cd" value="%{#parameters.cd[0]}" id="cd" />
    <div class="container_16">
		<!-- 导入head 区域  head.jsp-->
			<jsp:include page="../common/head.jsp" flush="true"></jsp:include>
		<!-- 导入head 区域-->
<div id="container" class="grid_16"><!-- container begin -->
  
  <!--导入赛事日程  区域 （可选） ssrcDate.jsp-->
	<jsp:include page="../common/ssrcDate.jsp" flush="true"></jsp:include>
  <!--导入赛事日程  区域（可选）-->
  
  
	<!-- 主体内容区域  开始 -->
	<div id="saichengxx" class="grid_12 alpha">
	<table width="100" border="1">

    		<tr>
    			<s:iterator value="resultData"  status="i">
  				<s:if test="#i.index%7==0">
  				<tr></tr>
  				</s:if>
    		<td width="95" height="95" >
							<a class="link10" href="../visitor/sportCjcxDxmmc-list.c?dxmmc=<s:property value="dxmmc" />">
							<b><span style="font-size: 9pt">
							<img border="0" src="../resources/images/sportsimage/<s:property value="dxmtb"/>" width="90" height="90"></span></b><p style="line-height: 100%; margin-top: 3px; margin-bottom: 0"></p>
							<b><span style="font-size: 9pt;color:black"><s:property value="dxmmc"/></span></b></a></td>            		   			       			    		    
    		
    	</s:iterator>
    		
    		</tr>
      			
	
	</table>
     </div> 

 <!-- 主内容区 结束 -->
	<!-- 右边 登录、历史成绩、模块导入(可选) right.jsp -->
		<jsp:include page="../common/right.jsp" flush="true"></jsp:include>
	<!-- 右边 登录、历史成绩、模块导入(可选) -->
 
  
  <div class="clear"></div>
</div><!-- container end -->

<!-- 脚注部分导入 footer.jsp-->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
<!-- 脚注部分导入-->

</div>
    </s:form>
    </center>
  </body>
</html>

