<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<title><s:property value="%{#request.con[1]}"/></title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script type="text/javascript"
			src="<s:property value="basePath"/>/dwr/engine.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
		<link rel="stylesheet"
			href="<s:property value="basePath"/>/resources/css/webface.css"
			type="text/css">
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/p2pMessage.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
			<style type="text/css">
			body{background: #FFF repeat-x left top;text-align: left;}
			</style>
		<script type="text/javascript">
	detailPageStyle();
	</script>
	</head>
	<body>
		<s:if
			test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			<div id="SystemErrorMessage">
				<s:actionerror />
				<s:actionmessage />
				<s:fielderror />
			</div>
		</s:if>
			<s:form theme="simple" name="theform">
				<s:hidden name="pager.formname" value="theform" />
				<s:hidden name="queryType" />
				<s:hidden name="fszt" value="%{#parameters.fs[0]}" id="fszt"/>
				<s:hidden name="fs" value="%{#parameters.fs[0]}" id="fs"/>

		<div id="listC" style="text-align:center;z-index: -100">
				<table align="left">
					<tr><td style="font-size: 14px;text-align: left"><s:property value="%{#request.con[2]}"/></td></tr>
					<tr><td>
					<s:if test="%{#request.con[3]!=null&&!''.equals(#request.con[3])}">
					<b>附件：</b>
					<a href="../system/message-download.c?aId=<s:property value='%{#request.con[0]}'/>&pathStr=<s:property value='%{#request.con[3]}'/>">
					<FONT color="blue"><s:property value='%{#request.con[3]}'/></FONT></a></s:if></td></tr>
				</table>
							
		</div>
			</s:form>
	</body>
</html>

