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
							        <td>&nbsp;</td>
							            <td align="center" nowrap="nowrap" class="">&nbsp;状态：
							                <s:select id="state" name="tsysUser.state" list="#{'-1':'全部','1':'可用','0':'禁用'}" listKey="key" listValue="value" onchange="super_doSearch()"/>
									</td>
									<td align="center" nowrap="nowrap" class="">&nbsp;登录标识：
										<s:textfield name="tsysUser.userloginid" id="userLoginId" maxlength="50" size="10"/>
									</td>
									<td align="center" nowrap="nowrap" class="">&nbsp;用户名称：
										<s:textfield name="tsysUser.username" id="userName" maxlength="30" size="15"/>
									</td>
									<td align="center" nowrap="nowrap" class="">&nbsp;所属部门：
										<s:textfield name="tsysUser.depart.departname" id="departname" maxlength="30" size="20"/>
									</td>
									<td align="center" nowrap="nowrap" class="">&nbsp;所在组：
										<s:select id="qgroup" name="qgroup" value="#parameters.qgroup[0]" list="allGroups" headerKey="" headerValue="----全部组----" listKey="groupid" listValue="groupname" onchange="super_doSearch()"/>
									</td>
									<td>
										<button onclick="super_doSearch()"><span class="icon_find">查询</span></button>
										<button onclick="doreset();"><span class="icon_recycle"> 重置 </span></button>
							        </td>
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
		    <button onclick="doUniChangeState(1,this)"><span class="icon_ok" title="">启用</span></button>
		    <button onclick="doUniChangeState(0,this)"><span class="icon_no" title="">禁用</span></button>
			<s:property value="userRoleMenuButton" escape="false"/>
    		<s:hidden name="changestate_parms" id="changestate_parms" value="entityName:t_sys_user;idName:userid"/>
		</div>
		<div>
			<table class="tableStyle" headFixMode="true"
				useMultColor="false" useCheckBox="false">
				<tr>
			    	<th width="25"></th>
	    			<th width="120">登录标识</th>
	    			<th width="200">用户名称</th>
	    			<th width="200">所属部门</th>
	    			<th width="80">状态</th>
				</tr>
 	<s:iterator value="resultData">
				<tr>
	    			<td><s:checkbox id="%{userid}" name="selectNode" fieldValue="%{userid}"/></td>
	    			<td>
	    				<a href="javascript:openEntity('<s:property value="userid"/>')"><font color="blue"><s:property value="userloginid"/></font></a>
	    			</td>
	    			<td >
	    				&nbsp;<s:property value="username"/>
	    			</td>
	    			<td >
	    				&nbsp;<s:property value="depart.departname"/>
	    			</td>
	    			<td >&nbsp;
		    			<s:if test="state==0">禁用</s:if>
		    			<s:else>可用</s:else>
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
