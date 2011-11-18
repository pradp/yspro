<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/include_list_head.jsp" %>
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
			var url = "sysProperties" + "-refreshSysProp.action";
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

		<div class="box_tool_mid padding_right5">
		  <div class="center">
			<div class="left">
			  <div class="right">
				<div class="padding_top8 padding_left10">
					<table>
				      <s:form theme="simple" name="ysform">
				      <s:hidden name="pager.formname" value="ysform"/>
				      <s:hidden name="pager.currentPageno" id="yspager_currentPageno"/>
						<tr>
							<td>参数名称：</td>
							<td><s:textfield name="tsysPropertity.csfl" id="csfl"/></td>
							<td><button type="button" onclick="super_doSearch()"><span class="icon_find">查询</span></button></td>
						</tr>
					  </s:form>
					</table>
				</div>
			  </div>
			</div>
		  </div>
		</div>

		<div id="userRoleMenuButton">
		    <button onclick="openEntity()"><span class="icon_add" title="">新增</span></button>
		    <button onclick="doModify()"><span class="icon_edit" title="">修改</span></button>
		    <button onclick="doRemove()"><span class="icon_delete" title="">删除</span></button>
		    <button onclick="doRefreshSysProp()"><span class="icon_refresh" title="刷新系统内存">刷新</span></button>
			<s:property value="userRoleMenuButton" escape="false"/>
			<font color="red">维护后请刷新</font>
		</div>
		<div>
		  <table class="tableStyle" headFixMode="true" useMultColor="false" useCheckBox="false">
			<tr>
				<th width="25"></th>
				<th width="100">参数名称</th>
				<th width="100">参数</th>
				<th width="100">参数值</th>
				<th width="100">参数类型</th>
				<th width="200">参数说明</th>
			</tr>
 		  <s:iterator value="resultData">
			<tr>
				<td width="25"><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
				<td width="100"><a href="javascript:openEntity('<s:property value="wid"/>')"><s:property value="csfl"/></a></td>
				<td width="100">&nbsp;<s:property value="csmc"/></td>
				<td width="100">&nbsp;<s:property value="cs"/></td>
				<td width="100">&nbsp;<s:property value="cslx"/></td>
				<td width="200">&nbsp;<s:property value="cssm"/></td>
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
