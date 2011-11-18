<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="../../common/include_list_head.jsp" %>

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
    <s:hidden name="entityName" id="entityName" value="t_scjc_code"/>
    <s:hidden name="id_name" id="id_name" value="wid"/>
    <s:hidden name="menuid" id="menuid"/>
<div class="box_tool_mid padding_right5">
	<div class="center">
		<div class="left">
			<div class="right">
				<div class="padding_top8 padding_left10">
					<table>
						<tr>
							<td align="center" nowrap="nowrap" class="">&nbsp;专家类型：
								<s:select name="texpertqaExperts.sortId" list="getSysCode('xz')" listKey="id" listValue="caption" headerKey="" headerValue="----请选择-----"
								onchange="super_doSearch()"/>
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
			<button onclick="openEntity()" class="button" style="width: 66px; padding-left: 5px;"><span class="icon_add hand" title="">新增</span></button>
			<button onclick="doModify()" class="button" style="width: 66px; padding-left: 5px;"><span class="icon_edit hand" title="">修改</span></button>
			<button onclick="doRemove()" class="button" style="width: 66px; padding-left: 5px;"><span class="icon_delete hand" title="">删除</span></button>
		</div>
		<div>
			<table class="tableStyle" headFixMode="true"
				useMultColor="true" useCheckBox="true">
				<tr>
					<th width="30"></th>
					<th width="80"><span onclick="">姓名</span></th>
					<th width="80"><span onclick="">职称</span></th>
					<th width="70"><span onclick="">专家类型</span></th>
					<th width="200"><span onclick="">单位</span></th>
					<th width="100"><span onclick="">电话</span></th>
					<th ><span onclick="">地址</span></th>	
				</tr>
 				<s:iterator value="resultData">
					<tr>
						<td><s:checkbox id="%{userid}" name="selectNode" fieldValue="%{userid}"/></td>
						<td><a href="javascript:openEntity('<s:property value="userid"/>')"><s:property value="name"/></a></td>
						<td title="<s:property value='position'/>"><s:property value="position"/></td>
						<td title="<s:property value='sortId'/>"><s:property value="sortId"/></td>
						<td title="<s:property value='unit'/>"><s:property value="unit"/></td>
						<td title="<s:property value='telnum'/>"><s:property value="telnum"/></td>
						<td title="<s:property value='lxdz'/>"><s:property value="lxdz"/></td>										
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
