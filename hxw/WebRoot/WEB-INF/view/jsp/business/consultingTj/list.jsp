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

		<div id="userRoleMenuButton">
			<button onclick=""><span class="icon_add">咨询必读</span></button>
		    <button onclick=""><span class="icon_edit" title="">公益咨询</span></button>
		    <button onclick=""><span class="icon_delete" title="">收费咨询</span></button>
			<button onclick=""><span class="icon_list">疾病咨询</span></button>
			<s:property value="userRoleMenuButton" escape="false"/>
			<s:hidden name="changestate_parms" id="changestate_parms" value="entityName:t_sys_code"/>
		</div>
		<div>
			<table class="tableStyle" headFixMode="true"
				useMultColor="false" useCheckBox="false">
				<tr>
					<th width="25%">&nbsp;&nbsp;&nbsp;咨询类型</th>
					<th width="25%">咨询师在线人数</th>
					<th width="25%">求助者等待人数</th>
					<th width="25%">操作</th>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;公益咨询</td>
					<td><s:property value="#zxs_gy"/></td>
					<td><s:property value="#zxz_gy"/></td>
					<td><a href="#">咨询</a></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;收费咨询</td>
					<td><s:property value="#zxs_sf"/></td>
					<td><s:property value="#zxz_sf"/></td>
					<td><a href="#">咨询</a></td>
				</tr>
				<tr>
					<td>&nbsp;&nbsp;&nbsp;疾病咨询</td>
					<td><s:property value="#zxs_jb"/></td>
					<td><s:property value="#zxz_jb"/></td>
					<td><a href="#">咨询</a></td>
				</tr>
			</table>
		</div>

		<div style="height: 45px;">
		</div>
	</div>
	</body>
</html>
