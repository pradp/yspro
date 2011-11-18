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
		if($(this).html()=='修改'){
			$(this).html('答复');
		}
		if($(this).html()=='启用'){
			$(this).html('公布');
		}
		if($(this).html()=='禁用'){
			$(this).parent().css("width","80px");
			$(this).html('不公布');
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
			<button onclick="doModify()" class="button" style="width: 66px; padding-left: 5px;"><span class="icon_edit hand" title="">答复</span></button>
			<button onclick="doRemove()" class="button" style="width: 66px; padding-left: 5px;"><span class="icon_delete hand" title="">删除</span></button>
			<button onclick="doUniChangeState(1,this)" class="button" style="width: 66px; padding-left: 5px;"><span class="icon_ok hand" title="">公布</span></button>
			<button onclick="doUniChangeState(0,this)" class="button" style="width: 80px; padding-left: 5px;"><span class="icon_no hand" title="">不公布</span></button>
    		<s:hidden name="changestate_parms" id="changestate_parms" value="entityName:t_expertqa_appeal;stateName:ispublish;"/>
		</div>
		<div>
			<table class="tableStyle" headFixMode="true"
				useMultColor="true" useCheckBox="true">
				<tr>
					<th width="25"></th>
					<th width="260"><span onclick="">问题</span></th>
					<th><span onclick="">问题内容</span></th>
					<th width="100"><span onclick="">提问人</span></th>
					<th width="100"><span onclick="">提问类型</span></th>
					<th width="100"><span onclick="">提问专家</span></th>
					<th width="100"><span onclick="">提问日期</span></th>
					<th width="60"><span onclick="">审核状态</span></th>	
					<th width="80"><span onclick="">答题状态</span></th>					
				</tr>
 				<s:iterator value="resultData">
					<tr>
						<td><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
						<td><a href="javascript:openEntity('<s:property value="wid"/>')"><s:property value="title"/></a></td>
						<td><span class="text_slice" style="width:300px;" title="<s:property value="content" escapeHtml="false"/>"><s:property value="content" escapeHtml="false"/></span></td>
						<td title="<s:property value='writer'/>"><s:property value="writer"/></td>
						<td title="<s:property value='sortId'/>"><s:property value="sortId"/></td>
						<td title="<s:property value='sortId'/>"><s:property value="accepter"/></td>
						<td title="<s:property value='dateofinput'/>"><s:date name="dateofinput"  format="yyyy-MM-dd" /></td>
						<td title="<s:property value='ispublish'/>"><s:if test="ispublish==1">公开</s:if><s:else>不公开</s:else></td>
						<td title="<s:property value='ispublish'/>"><s:if test="cnum>0">已答</s:if><s:else>未答</s:else></td>
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
