<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title><s:property value="tsysMessage.xxbt"/></title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script type="text/javascript"　src="<s:property value="basePath"/>/dwr/engine.js"></script>
		<script type="text/javascript"　src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
		<link rel="stylesheet"　href="<s:property value="basePath"/>/resources/css/webface.css"
			type="text/css">
		<script type="text/javascript"
			src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
		<script type="text/javascript"　src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
		<script type="text/javascript"　src="<s:property value="basePath"/>/resources/js/p2pMessage.js"></script>
		<script type="text/javascript"　src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
		<script type="text/javascript"　src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
		<style type="text/css">
			body{background: #FFF repeat-x left top;text-align: left;}
		</style>
		<script type="text/javascript">
			detailPageStyle();
		</script>
	</head>
	<body>
		<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			<div id="SystemErrorMessage">
				<s:actionerror />
				<s:actionmessage />
				<s:fielderror />
			</div>
		</s:if>
			<s:form theme="simple" name="theform">
				<s:hidden name="pager.formname" value="theform" />
				<s:hidden name="queryType" />
		<div id="listC" style="text-align:center;z-index: -100">
				<table align="left">
					<tr><td><b>标题：</b></td><td><s:property value="tsysMessage.xxbt"/></td></tr>
					<tr><td><b>内容：</b></td><td><s:property value='tsysMessage.xxnr'/></td></tr>
					<tbody id="listData">
					<s:if test="#fjbs!='false'">
					<tr><td><b>附件：</b> </td><td>&nbsp;</td></tr>
						<s:iterator value="tsysMessageFjbs">
						<tr><td>&nbsp;</td>
						<td>
							<a href="../system/message-download.c?aId=<s:property value='zbwid'/>&fjm=<s:property value='fjm'/>&pathStr=<s:property value='fjm'/>">
							<FONT color="blue"><s:property value='fjm'/></FONT></a>
						</td></tr>
						</s:iterator>
					</s:if>
					</tbody>
				</table>
							
		</div>
			</s:form>
	</body>
</html>

