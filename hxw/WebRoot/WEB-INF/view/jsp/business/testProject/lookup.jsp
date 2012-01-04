<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
		<link rel="stylesheet" type="text/css" href="../resources/css/testProject.css"/>
		<script type="text/javascript" src="../resources/js/testProject.js"/>
    	<title><s:property value="tcsXm.name"/></title>
		<script type="text/javascript">
		detailPageStyle();
		</script>
	
  </head>
  
  <body style="text-align:center;">
  	<div class="lookupxm">
	  	<div calss="xmml">
	  		<div class="xmbt"><s:property value="tcsXm.name"/></div>
	  		<div class="xmzz" align="right">
	  			<span style="margin-right: 20px;">发布者：<s:property value="tcsXm.cjr"/></span>
	  			<span style="margin-right: 200px;"><s:date name="tcsXm.cjsj" format="yyyy-MM-dd"/></span>
	  		</div>
  		</div>
  		<div class="xmjj" align="left"><s:property value="tcsXm.jj"/></div>
		<div class="xmxx">
			<s:property value="tcsXm.xxxx" escape="false"/>
		</div>
	</div>
  </body>
</html>
