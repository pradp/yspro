<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
	
    	<title>栏目维护</title>

	<script type="text/javascript">
	detailPageStyle();

	validate_required_fields = [ 
			{fieldId:"lmmc", message:"栏目名称不能为空！", mustMatch: true},
			{fieldId:"ordernum", message:"栏目排序值不能为空！", mustMatch: true},
			{fieldId:"lmbm", message:"栏目别名不能为空！", mustMatch: true}
			
		];
	function doSave(){
		if(isValidateForm()){
			super_doSave();
		}
	}
	</script>
	
	
  </head>
  
  <body style="text-align:center;">

<div class="box1">
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="txxfbLm.wid"/>

 <fieldset> 
　 <legend>栏目信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td width="15%" align="right">&nbsp;栏目名称：</td>
      <td width="35%" align="left" nowrap="nowrap">
        <s:textfield name="txxfbLm.lmmc" id="lmmc" maxlength="50" size="20" title="最多16个汉字"/> <label style="color:red">*</label></td>
	  <td align="right" width="15%">父栏目：</td>
	  <td align="left">
	    <s:select id="pwid" name="txxfbLm.parentwid" disabled="%{txxfbLm==null?'false':'true'}" list="getParentwids()" listKey="id" listValue="caption" headerKey="000" headerValue="根栏目"/> 
	  </td>
	</tr>
    <tr> 
      <td align="right">&nbsp;允许网友供稿：</td>
	  <td align="left">
	    <s:select id="yxwygg" name="txxfbLm.yxwygg" list="getSysCode('BOOLEAN')" listKey="id" listValue="caption"/> <label style="color:red">*</label></td>
	  <td align="right">状态：</td>
	  <td align="left">
	    <s:select name="txxfbLm.state" list="getSysCode('qyyf')" listKey="id" listValue="caption" value="txxfbLm==null?'1':txxfbLm.state"/> <label style="color:red">*</label></td>
	</tr>
    <tr> 
      <td align="right">&nbsp;默认评论权限：</td>
	  <td align="left">
	    <span class="float_left"><s:select id="sfpl" name="txxfbLm.sfpl" list="getSysCode('xxfb_plqx')" listKey="id" listValue="caption" /> <label style="color:red">*</label></span>
	    <span class="img_light" style="height:22px;" title="此栏目下的文章，默认都使用这个评论级别。但也可以修改。"></span>
	  </td>
	  <td align="right">前台排序值：</td>
	  <td align="left">
	    <s:textfield name="txxfbLm.ordernum" value="%{txxfbLm==null?0:txxfbLm.ordernum}" id="ordernum" maxlength="6" size="20" title="0-999999的数字，同一层栏目间排序"/> <label style="color:red">*</label></td>
	</tr>
    <tr> 
      <td align="right">&nbsp;栏目别名：</td>
	  <td align="left" >
	    <s:textfield name="txxfbLm.lmbm" id="lmbm" maxlength="50" size="20" title="前台栏目超链接上显示的文件名。请使用小写英文字母。且不要与其他栏目重复。"/> <label style="color:red">*</label></td>
	  <td align="right" width="15%">开放RSS支持：</td>
	  <td align="left">
	    <s:select id="zcrss" name="txxfbLm.zcrss" list="getSysCode('BOOLEAN')" listKey="id" listValue="caption"/> <label style="color:red">*</label>
	  </td>
	</tr>
  </table>
 </fieldset>
  
</s:form>
</div>

<div class="padding_top10">
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">
					<input type="button" id="ysSaveButton" value=" 保 存 " onclick="doSave()"/>
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
  </body>
</html>
