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
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
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
    	<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%">
    		<tr>
    			<td height="30px" colspan="10">
    			<ul class="btn_gn">
			    <li><a href="#" title="新增组" onClick="input()"><span>新增组</span></a></li>
			    <li><a href="#" title="修改组" onclick="modifySelected()"><span>修改组</span></a></li>
			    <li><a href="#" title="删除组" onclick="submitRemove()"><span>删除组</span></a></li>
			</ul>
    			</td>
    		</tr>
    	</table>
    	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
	  <tr>
	    <td class="infomainbg"><table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>
    	<table class="middle" border="0" cellspacing="0" cellpadding="0" width="100%">
    		<thead id="listHead">
    		<tr>
    			<th height="20px" width="5%"><s:checkbox name="selectAll" onclick="doSelectAll()" /></th>
    			<th width="40%">组名称</th>
    			<th width="10%">状态</th>
    			<th >操作</th>
    		</tr>
    		</thead>
    		<tbody id="listData">
    	<s:iterator value="resultData">
    		<tr>
    			<td ><s:checkbox id="%{groupid}" name="selectNode" fieldValue="%{groupid}"/></td>
    			<td>
    				<a href="javascript:input('<s:property value="groupid"/>',false)"><font color="blue"><s:property value="groupName"/></font></a>
    			</td>
    			<td>&nbsp;
	    			<s:if test="state=='0'.toString()">禁用</s:if>
	    			<s:else>可用</s:else>
    			</td>
    			<td>
    			[<a href="javascript:input('<s:property value="groupid"/>',false)" ><FONT color="blue">编辑</FONT></a>]
    			</td>
    		</tr>
    	</s:iterator>
    		</tbody>
    	</table>
	        </td>
	        </tr>
	    </table></td>
	    <td width="10" class="infomainright">&nbsp;</td>
	  </tr>
	  <tr>
	    <td height="20" class="infobottomleft"></td>
	    <td width="10" class="infobottomright"></td>
	  </tr>
	</table>
	
    	<table border="0" cellspacing="0" cellpadding="0" width="100%">
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
