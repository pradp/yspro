<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>list</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/zxdk.js"></script>
	
	<script type="text/javascript">
	listPageStyle();
	</script>
  </head>
  
<body > 
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" >
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>

    <div id="listC" style="text-align:center;">
    <s:form theme="simple" name="theform">
    <s:hidden name="pager.formname" value="theform"/>
    <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="70%">
			<tr align="center">
				<td align="center" nowrap="nowrap" class="">&nbsp;类别:
					<s:select id="zdlb" onchange="super_doSearch()" name="tsysCode.zdlb" list="sysCodeSort" headerKey="" headerValue="---全部---" listKey="key" listValue="value"/>
				</td>
				<td align="center" nowrap="nowrap" class="">&nbsp;字典编码:
					<s:textfield name="tsysCode.zdbm" id="zdbm" maxlength="50" size="20"/>
				</td>
				<td align="center" nowrap="nowrap" class="">&nbsp;字典名称:
					<s:textfield name="tsysCode.zdmc" id="zdmc" maxlength="30" size="20"/>
				</td>
				<td align="center" nowrap="nowrap">&nbsp;
					<input type="button" id="searchButton" name="btn3" value="查询" onClick="super_doSearch();">                      
    				</td>
			</tr>
	</table>
    	<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="90%">
    		<tr>
    			<td height="30px" colspan="10">
    			<input value="新增角色" type="button" onclick="input()"/>&nbsp;&nbsp;&nbsp;
    			<input value="修改角色" type="button" onclick="modifySelected()"/>&nbsp;&nbsp;&nbsp;
    			<input value="删除角色" type="button" onclick="submitRemove()"/>
    			</td>
    		</tr>
    	</table>
    	<table id="listTable" border="1" cellspacing="0" cellpadding="0" width="70%">
    		<thead id="listHead">
    		<tr>
    			<td height="20px" width="5%"></td>
    			<td width="12%">编号</td>
    			<td width="25%">角色</td>
    			<td width="8%">状态</td>
    			<td >操作</td>
    		</tr>
    		</thead>
    		<tbody id="listData">
    	<s:iterator value="resultData">
    		<tr>
    			<td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
    			<td>
    				<a href="javascript:input('<s:property value="wid"/>')"><s:property value="wid"/></a>
    			</td>
    			<td>
    				&nbsp;<s:property value="roleName"/>
    			</td>
    			<td>&nbsp;
	    			<s:if test="state=='0'.toString()">禁用</s:if>
	    			<s:else>可用</s:else>
    			</td>
    			<td align="left">
    			[<a href="javascript:input('<s:property value="wid"/>',false)" >编辑</a>]
    			</td>
    		</tr>
    	</s:iterator>
    		</tbody>
    	</table>
    	<table border="0" cellspacing="0" cellpadding="0" width="90%">
    		<tr>
    			<td colspan="10" align="right">
    			<s:property value="pager.postToolBar" escape="false"/>
    			</td>
    		</tr>
    	</table>
    	</s:form>
    </div>
  </body>
</html>
