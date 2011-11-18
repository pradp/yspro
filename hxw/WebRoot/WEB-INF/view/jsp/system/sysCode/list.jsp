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

		<div class="box_tool_mid padding_right5">
			<div class="center">
				<div class="left">
					<div class="right">
						<div class="padding_top8 padding_left10">
							<table>
								<tr >
						<s:form theme="simple" name="ysform">
						    <s:hidden name="pager.formname" value="ysform"/>
						    <s:hidden name="pager.currentPageno" id="yspager_currentPageno"/>
									<td nowrap="nowrap" class="">
										类别：
										<s:select id="zdlb" onchange="super_doSearch()"
											name="tsysCode.zdlb" list="SysCodeSort" listKey="id"
											listValue="caption" headerKey="" headerValue="------请选择------" autoWidth="true"/>
									</td>
									<td align="center" nowrap="nowrap" class="">
										&nbsp;字典编码：
										<s:textfield name="tsysCode.zdbm" id="zdbm" maxlength="50"
											size="20" />
									</td>
									<td align="center" nowrap="nowrap" class="">
										&nbsp;字典名称：
										<s:textfield name="tsysCode.zdmc" id="zdmc" maxlength="30"
											size="20" />
									</td>
						</s:form>
									<td><button type="button" onclick="super_doSearch()"><span class="icon_find">查询</span></button>
										<button type="button" onclick="doreset();"><span class="icon_recycle"> 重置 </span></button></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div id="userRoleMenuButton">
			<button onclick="openEntity('',false,'zdlb=<s:property value="tsysCode.zdlb"/>')"><span class="icon_add">新增</span></button>
		    <button onclick="doModify()"><span class="icon_edit" title="">修改</span></button>
		    <button onclick="doRemove()"><span class="icon_delete" title="">删除</span></button>
			<button onclick="openPage('../system/sysCodeSort-list.action')"><span class="icon_list">维护字典类别</span></button>
			<s:property value="userRoleMenuButton" escape="false"/>
			<s:hidden name="changestate_parms" id="changestate_parms" value="entityName:t_sys_code"/>
		</div>
		<div>
			<table class="tableStyle" headFixMode="true"
				useMultColor="false" useCheckBox="false">
				<tr>
					<th width="5%"></th>
					<th width="20%">字典类别</th>
					<th width="20%">字典名称</th>
					<th width="20%">字典值</th>
					<th width="8%">状态</th>
					<th width="27%">注释</th>
				</tr>
 	<s:iterator value="resultData">
				<tr>
					<td>
						<s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/>
					</td>
					<td>
						<s:property value="lbmc" />(<s:property value="zdlb" />)
					</td>
					<td>
						&nbsp;<a href="javascript:openEntity('<s:property value="wid"/>')"><FONT color="blue"><s:property value="zdmc"/></FONT></a>
					</td>
						<td>
							<s:property value="zdbm" />
						</td>
						<td>
							<s:if test="sfsy==0">禁用</s:if>
							<s:else>可用</s:else>
						</td>
						<td>
							<s:property value="zs" />
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
