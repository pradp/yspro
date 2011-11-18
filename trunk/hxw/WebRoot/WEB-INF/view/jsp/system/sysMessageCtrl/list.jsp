<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/include_list_head.jsp" %>
		<script type="text/javascript" src="../resources/js/common/idcard.js"></script>
		<script type="text/javascript">
		 $(function(){
			var success = getCookieValue("dorefresh");
			if(success == 'true'){
				document.cookie = "dorefresh=;";
				alert('刷新成功！');
			}
		 })
		 function doRefreshSysProp() {
			document.cookie = "dorefresh=true;";
			var url_bak = document.forms[0].action;
			var url = "sysMessageCtrl" + "-refreshSysProp.action";
			jQuery.post(url,
			       { reqtime: (new Date()).getTime() },
			       function(data){
						document.cookie = "dorefresh=true;";
						document.forms[0].action = url_bak;//还原URL，防止点查询按钮却执行删除！
						document.forms[0].submit();
			       }
			);
		}
		</script>
	</head>
  
<body> 
    <div id="scrollContent">
    
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" >
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>

<s:form theme="simple" name="ysform">
    <s:hidden name="pager.formname" value="ysform"/>
    <s:hidden name="pager.currentPageno" id="yspager_currentPageno"/>
								
	<div class="box_tool_mid padding_right5">
	  <div class="center">
		<div class="left">
		  <div class="right">
			<div class="padding_top8 padding_left10">
			  <table>
				<tr>
				  <td align="center" nowrap="nowrap" width="15%">&nbsp;用户类型：
					<s:select name="tsysMessageCtrl.departtype" id="departtype" list="getSysCode('departtype')"
					 listKey="id" listValue="caption" headerKey="" headerValue="----请选择----"/>
				  </td>
				  <td align="center" nowrap="nowrap" width="15%">&nbsp;关联上级菜单：
					<s:textfield name="tsysMessageCtrl.upmenuname" id="upmenuname" maxlength="15"/>
				  </td>
				  <td align="center" nowrap="nowrap" width="15%">&nbsp;关联菜单：
					<s:textfield name="tsysMessageCtrl.menuname" id="menuname" maxlength="15"/>
				  </td>
				  <td align="center" nowrap="nowrap" width="15%">&nbsp;状态：
					<s:select name="tsysMessageCtrl.state" id="state" list="#{'':'----请选择----','1':'启用','0':'禁用'}"/>
				  </td>
				  <td>
					<button onclick="super_doSearch()"><span class="icon_find">查询</span></button>
					<button onclick="doreset();"><span class="icon_recycle"> 重置 </span></button>
				  </td>
				</tr>
			  </table>
			</div>
		  </div>
		</div>
	  </div>
	</div>
</s:form>
		
		<div id="userRoleMenuButton">
		  <button onclick="openEntity()"><span class="icon_add" title="">新增</span></button>
		  <button onclick="doModify()"><span class="icon_edit" title="">修改</span></button>
		  <button onclick="doRemove()"><span class="icon_delete" title="">删除</span></button>
		  <button onclick="doUniChangeState(1,this)"><span class="icon_ok" title="">启用</span></button>
		  <button onclick="doUniChangeState(0,this)"><span class="icon_no" title="">禁用</span></button>
		  <button onclick="doRefreshSysProp()"><span class="icon_refresh" title="刷新系统内存">刷新</span></button>
		  <s:property value="userRoleMenuButton" escape="false"/>
    	  <s:hidden name="changestate_parms" id="changestate_parms" value="entityName:t_sys_message_ctrl"/>
		  <font color="red">维护后请刷新</font>
		</div>
		
		<div>
			<table class="tableStyle" headFixMode="true"
				useMultColor="false" useCheckBox="false">
				<tr>
					<th width="5%" align="left"><s:checkbox name="selectAll" onclick="doSelectAll()" /></th>
					<th width="15%" align="left">名称</th>
					<th width="10%" align="left">用户类型</th>
					<th width="15%" align="left">关联上级菜单</th>
					<th width="15%" align="left">关联菜单</th>
					<th width="10%" align="left">状态</th>
					<th width="10%" align="left">排序值</th>
				</tr>
 				<s:iterator value="resultData">
					<tr>
						<td><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
						<td><a href="javascript:openEntity('<s:property value="wid"/>')"><s:property value="name"/></a></td>
						<td><s:property value="departtype"/></td>
						<td><s:property value="upmenuname"/></td>
						<td><s:property value="menuname"/></td>
						<td><s:if test="state == 1">启用</s:if><s:else>禁用</s:else></td>
						<td><s:property value="ordernum"/></td>
					</tr>
    			</s:iterator>
			</table>
		</div>

		<div style="height: 45px;">
			<div id="pagelist" style="display: none">
	  			<s:property value="pager.postToolBar" escape="false"/>
	  		</div>
	
			<div class="clear"></div>
		</div>
		
    </div>
  </body>
</html>
