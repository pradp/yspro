<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/include_list_head.jsp" %>
	</head>
  
<body > 
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
    		<s:hidden name="changestate_parms" id="changestate_parms" value="entityName:t_sys_group;idName:groupid"/>
		</div>
		<div>
			<table class="tableStyle" headFixMode="true"
				useMultColor="false" useCheckBox="false">
				<tr>
					<th width="25"></th>
					<th width="200">
						组名称
					</th>
					<th width="100">
						状态
					</th>
					<th>
						描述
					</th>
				</tr>
 	<s:iterator value="resultData">
				<tr>
					<td width="25">
						<s:checkbox id="%{wid}" name="selectNode" fieldValue="%{groupid}"/>
					</td>
					<td width="200">
						<a href="javascript:openEntity('<s:property value="groupid"/>')">
						<font color="blue"><s:property value="groupname"/></font></a>
					</td>
					<td width="100">
			    			<s:if test="state==0">禁用</s:if>
			    			<s:else>可用</s:else>
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
