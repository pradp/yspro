<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>list</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="${basePath}/resources/css/zxdk.css" type="text/css">
	<script type="text/javascript" src="${basePath}/dwr/engine.js"></script>
	<script type="text/javascript" src="${basePath}/dwr/util.js"></script>
	<script type="text/javascript" src="${basePath}/dwr/interface/htshService.js"></script>
	
	<script type="text/javascript" src="${basePath}/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="${basePath}/resources/js/myutil.js"></script>
	<script type="text/javascript" src="${basePath}/resources/js/zxdk.js"></script>
	<script type="text/javascript" src="${basePath}/resources/js/tablesort.js"></script>
	
	<script type="text/javascript">
	listPageStyle();
	</script>
  </head>
  
<body > 
<#include "../../showerr.ftl" parse="true">
    <div id="listC" style="text-align:center;">
    <s:form theme="simple" name="theform">
    <s:hidden name="pager.formname" value="theform"/>
    	<table id="listTable" border="1" cellspacing="0" cellpadding="0" width="90%">
    		<thead id="listHead">
    		<tr>
    			<td height="20px" width="5%"></td>
    			<td width="8%">编号</td>
    			<td width="10%">登录ID号</td>
    			<td width="10%">姓名</td>
    			<td width="15%">部门</td>
    			<td width="8%">状态</td>
    			<td colspan="2">操作</td>
    		</tr>
    		</thead>
    		<tbody id="listData">
    		<#if resultData?exists>
		<#list resultData as item >
    		<tr>
    			<td ><input type="checkbox" id="${item.userid}" name="selectNode" value="${item.userid}"/></td>
    			<td>
    				<a href="javascript:input('${item.userid}',true)">${item.userid}</a>
    			</td>
    			<td>
    				&nbsp;${item.userLoginId}
    			</td>
    			<td>
    				&nbsp;${item.userName}
    			</td>
    			<td>
    				&nbsp;${item.tdepart.departname}
    			</td>
    			<td>&nbsp;
				<#if item.state=='0'>
	    			禁用
				<#else>
				可用
				</#if>
    			</td>
    			<td align="left">
    			[<a href="javascript:input('${item.userid}',false)" ><FONT color="blue">修改信息</FONT></a>]
    			</td>
    			<td align="right">
				<#if item.state=="0" >
				[<a href="javascript:void(null)" onclick="audit('${item.userid}','1')"><FONT color="blue">启用</FONT></a>]
				<#else>
				[<a href="javascript:void(null)" onclick="audit('${item.userid}','0')"><FONT color="blue">停用</FONT></a>]
				</#if>
    			</td>
    		</tr>
		</#list>
    		</#if>
    		</tbody>
    	</table>
    	<table border="0" cellspacing="0" cellpadding="0" width="90%">
    		<tr>
    			<td colspan="10" align="right">
				${pager.postToolBar}
    			</td>
    		</tr>
    	</table>
    	</s:form>
    </div>
  </body>
</html>