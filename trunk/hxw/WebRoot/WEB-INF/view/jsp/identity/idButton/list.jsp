<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/include_list_head.jsp" %>
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
	</s:form>

		<div id="userRoleMenuButton">
		  <button onclick="openEntity()"><span class="icon_add" title="">新增</span></button>
		  <button onclick="doModify()"><span class="icon_edit" title="">修改</span></button>
		  <button onclick="doRemove()"><span class="icon_delete" title="">删除</span></button>
		  <button onclick="doUniChangeState(1,this)"><span class="icon_ok" title="">启用</span></button>
		  <button onclick="doUniChangeState(0,this)"><span class="icon_no" title="">禁用</span></button>
		  <s:property value="userRoleMenuButton"  escape="false"/>
    	  <s:hidden name="changestate_parms" id="changestate_parms" value="entityName:t_sys_button;idName:buttonid"/>
		</div>
		
		<div>
			<table class="tableStyle" headFixMode="true"
				useMultColor="false" useCheckBox="false">
				<tr>
					<th width="25"></th>
					<th width="100">
						按钮名称
					</th>
					<th width="200">
						按钮事件
					</th>
					<th width="50">
						状态
					</th>
					<th width="100">
						企业管理员可见
					</th>
					<th width="50">
						排序值
					</th>
					<th>
						描述
					</th>
				</tr>
 	<s:iterator value="resultData">
				<tr>
					<td width="25">
						<s:checkbox id="%{wid}" name="selectNode" fieldValue="%{buttonid}"/>
					</td>
					<td width="100">
						&nbsp;<a href="javascript:openEntity('<s:property value="buttonid"/>')"><FONT color="blue"><s:property value="buttonname"/></FONT></a>
					</td>
					<td width="200">
						&nbsp;<s:property value="buttonevent"/>
					</td>
					<td width="50">
						&nbsp;<s:property value="state"/>
					</td>
					<td width="100">
						&nbsp;<s:property value="share2enterprise"/>
					</td>
					<td width="50">
						&nbsp;<s:property value="ordernum"/>
					</td>
					<td>
						&nbsp;<s:property value="memo"/>
					</td>
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
