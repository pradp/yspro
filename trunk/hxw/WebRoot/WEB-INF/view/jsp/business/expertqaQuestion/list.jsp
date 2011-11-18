<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="../../common/include_list_head.jsp" %>

<body>
<script type="text/javascript">
$(function(){
	$("button span").each(function(){
		if($(this).html()=='新增'){
			$(this).html('提问');
		}		
	})
})
</script>	
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
							<td align="center" nowrap="nowrap" class="">&nbsp;问题类型：
								<s:select name="texpertqaAppeal.sortId" list="getSysCode('xz')" listKey="id" listValue="caption" headerKey="" headerValue="----请选择-----"
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
			<button onclick="openEntity();"><span class="icon_add">提问</span></button>
		</div>
		<div>
			<table class="tableStyle" headFixMode="true"
				useMultColor="true" useCheckBox="true">
				<tr>
					<th width="25"></th>
					<th width="300"><span onclick="">问题</span></th>
					<th><span onclick="">问题内容</span></th>
					<th width="100"><span onclick="">提问人</span></th>
					<th width="100"><span onclick="">提问类型</span></th>
					<th width="100"><span onclick="">提问专家</span></th>
					<th width="100"><span onclick="">提问日期</span></th>								
				</tr>
 				<s:iterator value="resultData">
					<tr>
						<td><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
						<td>
							<s:if test="cnum>0">
								<a href="javascript:openEntity('<s:property value="wid"/>','','','lookup')"><s:property value="title"/></a>
							</s:if>
							<s:else>
								<a href="javascript:openEntity('<s:property value="wid"/>')"><s:property value="title"/></a>
							</s:else>
						</td>
						<td><span class="text_slice" style="width:100px;" title="<s:property value="content" escapeHtml="false"/>">
						<s:property value="content" escapeHtml="false"/></span></td>
						<td title="<s:property value='writer'/>"><s:property value="writer"/></td>
						<td title="<s:property value='sortId'/>"><s:property value="sortId"/></td>
						<td title="<s:property value='sortId'/>"><s:property value="accepter"/></td>
						<td title="<s:property value='dateofinput'/>"><s:date name="dateofinput"  format="yyyy-MM-dd" /></td>						
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
