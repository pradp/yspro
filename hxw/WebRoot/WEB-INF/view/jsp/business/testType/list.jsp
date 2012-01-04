<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/include_list_head.jsp" %>
	
		<script type="text/javascript">

		function openPage(uri){
			//openWindow(uri,850,450);
			location.href = uri;
		}
		$(function(){
			$(".lx_jj").html(isOverBytes($(".lx_jj").html(),50));
		})
	</script>
	</head>

	<body>
    <div id="scrollContent">
    
		<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			<div id="SystemErrorMessage">
				<s:actionerror />
				<s:actionmessage />
				<s:fielderror />
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
						  <td nowrap="nowrap" class="">类型：<s:textfield name="tcsLx.lx" id="lx" maxlength="50"/></td>
						  <td>
						  	<button type="button" onclick="super_doSearch()"><span class="icon_find">查询</span></button>
							<button type="button" onclick="doreset();"><span class="icon_recycle"> 重置 </span></button>
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
			<button onclick="openEntity()"><span class="icon_add">新增</span></button>
		    <button onclick="doModify()"><span class="icon_edit" title="">修改</span></button>
		    <button onclick="doRemove()"><span class="icon_delete" title="">删除</span></button>
			<button onclick="myChangeState('1', '启用', '');"><span class="icon_ok">启用</span></button>	
			<button onclick="myChangeState('0', '禁用', '')"><span class="icon_no">禁用</span></button>	
		</div>
		<div>
			<table class="tableStyle" headFixMode="true"
				useMultColor="false" useCheckBox="false">
				<tr>
					<th width="5%"></th>
					<th width="20%">类型</th>
					<th width="50%">详细信息</th>
					<th width="25%">状态</th>
				</tr>
 				<s:iterator value="resultData">
					<tr>
						<td><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
						<td>
							<a href="javascript:openEntity('<s:property value="wid"/>')"><s:property value="lx" /></a>
						</td>
						<td><span class="lx_jj" title="<s:property value='jj'/>"><s:property value="jj"/></span></td>
						<td>
							<s:if test="state==0">禁用</s:if>
							<s:else>启用</s:else>
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
