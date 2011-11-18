<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
	<%@include file="../../common/include_list_head.jsp" %>
    <title>输出对象集合的例子</title>
    
	<script type="text/javascript">

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
    <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="70%">
			<tr align="center">
    	<s:form theme="simple" name="ysform">
		<s:hidden name="pager.formname" value="ysform"/>
		<s:hidden name="pager.currentPageno" id="yspager_currentPageno"/>
				<td align="center" nowrap="nowrap" class="">&nbsp;类别:
					<s:select id="zdlb" onchange="super_doSearch()" name="tsysCode.zdlb" list="sysCodeSort" headerKey="" headerValue="---全部---" listKey="key" listValue="value"/>
				</td>
				<td align="center" nowrap="nowrap" class="">&nbsp;字典编码:
					<s:textfield name="tsysCode.zdbm" id="zdbm" maxlength="50" size="20"/>
				</td>
				<td align="center" nowrap="nowrap" class="">&nbsp;字典名称:
					<s:textfield name="tsysCode.zdmc" id="zdmc" maxlength="30" size="20"/>
				</td>
		</s:form>
				<td align="center" nowrap="nowrap">&nbsp;
					<input type="button" id="searchButton" name="btn3" value="查询" onClick="super_doSearch();">                      
    			</td>
			</tr>
	</table>
    	<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="90%">
    		<tr>
    			<td height="30px" colspan="10">
			<button onclick="openEntity()"><span class="icon_add">新增</span></button>
			<button onclick="doModify()"><span class="icon_edit">修改</span></button>
			<button onclick="doRemove()"><span class="icon_delete">删除</span></button>
			<button onclick="myChangeState('1', '提交')"><span class="icon_ok">提交供稿</span></button>
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
	    			<s:if test="state==0">禁用</s:if>
	    			<s:else>可用</s:else>
    			</td>
    			<td align="left">
    			[<a href="javascript:input('<s:property value="wid"/>')" >编辑</a>]
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
    </div>
  </body>
</html>
