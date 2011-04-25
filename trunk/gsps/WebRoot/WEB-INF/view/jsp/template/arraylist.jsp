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
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/util/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/util/tablesort.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/webctrl.js"></script>
	
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
    			<td height="20px" width="5%"><s:checkbox name="selectAll" onclick="doSelectAll()"/></td>
    			<td width="8%">报表年度</td>
    			<td width="10%">学生姓名</td>
    			<td width="8%">性别</td>
    			<td width="15%">所在学校</td>
    			<td width="10%">所在县市</td>
    			<td width="8%">申请金额(元)</td>
    			<td width="10%">状态</td>
    			<td colspan="1">操作</td>
    		</tr>
    		</thead>
    		<tbody id="listData">
    	<s:iterator value="resultData" status="i">
    	<s:set name="bean" value="resultData[#i.index]" />
    		<tr>
    			<td ><s:checkbox id="%{#bean[0]}" name="selectNode" fieldValue="%{#bean[0]}"/></td>
    			<td>
    				&nbsp;<s:property value="#bean[1]"/>
    			</td>
    			<td>
    				<a href="javascript:input('<s:property value="#bean[0]"/>',true)"><s:property value="#bean[2]"/></a>
    			</td>
    			<td>
    				&nbsp;
	    			<s:if test="#bean[3]=='1'.toString()">男</s:if>
	    			<s:else>女</s:else>
    			</td>
    			<td>
    				&nbsp;<s:property value="#bean[4]"/>
    			</td>
    			<td>
    				&nbsp;<s:property value="#bean[5]"/>
    			</td>
    			<td>
    				&nbsp;<s:property value="#bean[6]"/>
    			</td>
    			<td>&nbsp;<s:property value="#bean[7]"/>
    			</td>
    			<td align="left">
    			[<a href="javascript:input('<s:property value="#bean[0]"/>',false)" ><FONT color="blue">编辑</FONT></a>]
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
