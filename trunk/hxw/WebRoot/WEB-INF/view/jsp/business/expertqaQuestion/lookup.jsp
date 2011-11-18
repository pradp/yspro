<%@ page language="java" pageEncoding="UTF-8" import="java.util.List,com.yszoe.biz.entity.TExpertqaAppeal,com.yszoe.biz.entity.TExpertqaAppealadd"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
		<link rel="stylesheet" type="text/css" href="../clientui/js/form/CLEditor/jquery.cleditor.css" />
	<script type="text/javascript" src="../clientui/js/form/CLEditor/jquery.cleditor.js"></script>
	
    	<title>问题答疑</title>

	<script type="text/javascript">
	detailPageStyle();

	</script>	
  </head>
  
  <body style="text-align:center;">

<div class="box1" >
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="texpertqaAppeal.wid" id="wid"/>  
<fieldset> 
			<legend>提问详情</legend> 		
			<table class="tableStyle" transMode="true" footer="normal">
				<tr>
					<td align="right" nowrap="nowrap">咨询专家：</td>
					<td align="left"><s:select name="texpertqaAppeal.accepter" id="accepter" list="getExpertqaExpert()" listKey="id" listValue="caption" headerKey="" headerValue="----请选择-----" />
					<button onclick="doupdate();" type="button"><span class="icon_mark">改专家</span></button>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">提问人：</td>
					<td align="left"><s:property value="texpertqaAppeal.writer"/></td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">职务：</td>
					<td align="left"><s:property value="texpertqaAppeal.identity"/></td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">联系方式：</td>
					<td align="left"><s:property value="texpertqaAppeal.contact"/></td>
					<td colspan="2"></td>
				</tr>				
				<tr>
					<td align="right" nowrap="nowrap">问题标题：</td>
					<td align="left"><s:property value="texpertqaAppeal.title"/></td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">问题描述：</td>
					<td align="left"><textarea cols="30" rows="4" class="default" disabled="disabled"><s:property value="texpertqaAppeal.content"/></textarea></td>
					<td colspan="2"></td>
				</tr>
			</table>
		</fieldset> 		 
		<fieldset> 
			<legend>答复详情</legend> 
			<table class="tableStyle" transMode="true" footer="normal" >
				<s:iterator value="#listTExpertqaAppealadd">
					<tr id="<s:property value="wid"/>">									
						<td align="right" nowrap="nowrap" width="10%"><s:property value="expertid"/>答复内容：</td>
						<td align="left" width="70%"><s:property value="answer" escapeHtml="false"/></td>
					</tr>
			    </s:iterator>
			</table>
		</fieldset> 
	 <div>		  
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">									
					<input type="button" value=" 关 闭 " onclick="parent.closeEntityWindow()"/>
					<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
						<span id="SystemErrorMessage" style="top: 20px">
							<s:actionerror cssStyle="color:red"/>
							<s:actionmessage cssStyle="color:blue"/>
							<s:fielderror/>
						</span>
					</s:if>
				</td>
			</tr>
		</table>
	</div>
</s:form>
</div>
 
  </body>
</html>
