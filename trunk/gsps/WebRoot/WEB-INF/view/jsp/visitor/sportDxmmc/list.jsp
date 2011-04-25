<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" >
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="author" content="" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="robots" content="all" />
	<title>江苏省第十七届运动会综合成绩榜</title>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/960.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/reset.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/text.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/main.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/saicheng.css" type="text/css" media="all" />
  </head>
  
<body > 
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" >
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>

    <div class="container_16">
		<!-- 导入head 区域  head.jsp-->
			<jsp:include page="../common/head.jsp" flush="true"></jsp:include>
		<!-- 导入head 区域-->
 <div id="container" class="grid_16"><!-- container begin -->
  
  <!--导入赛事日程  区域 （可选） ssrcDate.jsp-->
	<jsp:include page="../common/ssrcDate.jsp" flush="true"></jsp:include>
  <!--导入赛事日程  区域（可选）-->
  
  
	<!-- 主体内容区域  开始 -->
 <s:form theme="simple" name="theform">
 <s:hidden name="cd" value="%{#parameters.cd[0]}" id="cd" />
  <div id="saichengxx" class="grid_16 alpha">
  		
    	<table class="subTab" id="mainTable" summary="项目成绩">
         <tr class="top">
           <th colspan="10" abbr="项目成绩">项目成绩</th>
         </tr>
         <tr>
           <th  colspan="10" abbr="" class="matchDate"></th>
         </tr>
			  
  		 <tbody id="listData">
	    	<s:iterator value="resultData"  status="status">
  				<s:if test="#status.index%10==0">
  				<tr></tr>
  				</s:if>
      			<td>
  				<s:if test="resultData[#status.index][2]==0">
  					<b><span style="font-size: 9pt">
						<img  src="<s:property value="basePath"/>/resources/images/sportsimage/<s:property value="resultData[#status.index][1]"/>" width="90" height="90"></img></span></b>
					<b><span style="font-size: 9pt;color:black"><s:property value="resultData[#status.index][0]" /></span></b>
  				</s:if>
  				<s:else>
      			    <a class="" href="<s:property value="basePath"/>/visitor/sportCjcxRc-list.c?cssS=5&paixu=0&dxmmc=<s:property value="@java.net.URLEncoder@encode(resultData[#status.index][0],'utf-8')" />">
					<b><span style="font-size: 9pt">
					<img  src="<s:property value="basePath"/>/resources/images/sportsimage/<s:property value="resultData[#status.index][1]"/>" width="90" height="90"></img></span></b>
					<b><span style="font-size: 9pt;color:black"><s:property value="resultData[#status.index][0]" /></span></b></a>
				</s:else>
			</td> 
    		</s:iterator>
	    	<tr>
	          <td  colspan="8" abbr="说明">&nbsp;</td>
	        </tr>
   		 </tbody>
   		</table>
       
  </div>
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

