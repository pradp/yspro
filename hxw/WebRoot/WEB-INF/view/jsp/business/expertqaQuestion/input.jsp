<%@ page language="java" pageEncoding="UTF-8" import="java.util.List,com.yszoe.biz.entity.TExpertqaAppeal,com.yszoe.biz.entity.TExpertqaAppealadd"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
		<link rel="stylesheet" type="text/css" href="../clientui/js/form/CLEditor/jquery.cleditor.css" />
		<script type="text/javascript" src="../clientui/js/form/CLEditor/jquery.cleditor.js"></script>
	
    	<title>向专家提问</title>

	<script type="text/javascript">
	detailPageStyle();

	validate_required_fields = [ 
			{fieldId:"accepter", message:"咨询专家不能为空！", mustMatch: true},
			{fieldId:"sortId", message:"问题类型不能为空！", mustMatch: true},  
			{fieldId:"title", message:"问题标题不能为空！", mustMatch: true},
			{fieldId:"content", message:"问题描述不能为空！", mustMatch: true}
		];
	
	/**
	 * 选中的纪录。
	 * AJAX 请求传统页面方式实现
	 */
	function doupdate(){
		var entityName='t_expertqa_appeal';
		var id_name='wid';
		var itemname='accepter';	
		var conf = window.confirm("您确定问题给这位专家吗？");
		if(conf==true){
			var ids = document.getElementById("wid").value;
			var value = document.getElementById("accepter").value;
			if(value.length>0){
				var url_bak = document.forms[0].action;
				var url = actionName + "-update."+uri_suffix;
				$.post(url, 
						{wid: ids,entityName:entityName,id_name:id_name,itemname:itemname,state:value,reqtime: (new Date()).getTime()  },
						function(data){
							alert(data);
						}
					);				
			}else{
				alert("请选择专家!");
			}
		}
	}
	</script>	
  </head>
  
  <body style="text-align:center;">

<div class="box1" >
  <s:form name="theform" method="post" theme="simple" >  
  <s:hidden name="texpertqaAppeal.wid" />
<fieldset> 
			<legend>提问详情</legend> 		
			<table class="tableStyle" transMode="true" footer="normal">
				<tr>
					<td align="right" nowrap="nowrap">咨询专家：</td>
					<td align="left"><s:select name="texpertqaAppeal.accepter" id="accepter" list="getExpertqaExpert()" listKey="id" listValue="caption" headerKey="" headerValue="----请选择-----" />&nbsp;&nbsp;<label style="color:red">*</label>					
				</tr>				
				<tr>
					<td align="right" nowrap="nowrap">职务：</td>
					<td align="left"><s:textfield name="texpertqaAppeal.identity" /></td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">联系方式：</td>
					<td align="left"><s:textfield name="texpertqaAppeal.contact" /></td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">问题类型：</td>
					<td align="left"><s:select name="texpertqaAppeal.sortId" list="getSysCode('xz')" id="sortId" listKey="id" listValue="caption" headerKey="" headerValue="----请选择-----"/>&nbsp;<label style="color:red">*</label></td>
				</tr>				
				<tr>
					<td align="right" nowrap="nowrap">问题标题：</td>
					<td align="left"><s:textfield name="texpertqaAppeal.title" id="title"/>&nbsp;&nbsp;<label style="color:red">*</label></td>
				</tr>
				<tr>
					<td align="right" nowrap="nowrap">问题描述：</td>
					<td align="left" ><textarea cols="30" rows="4" name="texpertqaAppeal.content" id="content" class="default"></textarea></td>
				</tr>
			</table>
		</fieldset> 	
	<div class="padding_top10">
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">									
					<input type="button" id="ysSaveButton" value=" 保存 " onclick="doSave(false)"/>
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
