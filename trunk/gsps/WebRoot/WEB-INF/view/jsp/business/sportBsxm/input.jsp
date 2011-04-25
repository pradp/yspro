<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>比赛项目维护</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript">
		detailPageStyle();

		validate_required_fields = [ 
		                			{fieldId:"dxmmc", message:"项目不能为空！", mustMatch: true}, 
		                			{fieldId:"xxmmc", message:"级（赛）别不能为空！", mustMatch: true},
		                			{fieldId:"zb", message:"组别不能为空！", mustMatch: true},
		                			{fieldId:"xbz", message:"性别组不能为空！", mustMatch: true},
		                			{fieldId:"xmdj", message:"项目等级不能为空！", mustMatch: true},
		                			{fieldId:"sfjtxm", message:"是否集体项目不能为空！", mustMatch: true},
		                			{fieldId:"sfdzxm", message:"是否对战项目不能为空！", mustMatch: true},
		                			{fieldId:"pxh", message:"排序号不能为空！", mustMatch: true},
		                			{fieldId:"cjdw", message:"成绩单位不能为空！", mustMatch: true}
		                		];
		
		function dosave(){
			if(isValidateForm()){
			submitForm();
			}
		}	
		function dosavenew(){
			document.getElementById("sfxz").value = "1";
			dosave();
		}
		function dosaveclose(){
			dosave();
			parent.closeInputWindow();
		}
	
	</script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/resources/css/webface.css">
  	<base target="_self">
  </head>
  
  <body style="text-align:center;">
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" style="top: 20px">
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>

<div class="framestyle" style="width:98%;padding: 0pt 10pt 10pt 10pt;">
  <s:form name="theform" method="post" theme="simple" >
  
  <s:hidden name="tsportBsxm.wid" />
  <s:hidden id="menues" name="menues" />
  <s:hidden name="sfxz" id="sfxz" />

 <fieldset> 
　 <legend>比赛项目</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" width="10%" nowrap="nowrap">项目：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:textfield id="dxmmc" name="tsportBsxm.dxmmc" maxlength="150" size="30"/> <label style="color:red">*</label>
	</td>
	<td align="right" width="10%">级（赛）别：</td>
	<td align="left" width="20%" nowrap="nowrap">
      	<s:textfield id="xxmmc" name="tsportBsxm.xxmmc" maxlength="100" size="40"/> <label style="color:red">*</label>
      </td>
    </tr>
 
    <tr> 
      <td align="right" nowrap="nowrap" width="10%">组别：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:select name="tsportBsxm.zb" id ="zb" list="getSysCode('BSXM_ZB')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/> <label style="color:red">*</label>					   
      </td>
      <td align="right" nowrap="nowrap" width="10%">性别组：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:select name="tsportBsxm.xbz" id ="xbz" list="getSysCode('BSXM_XBZ')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/> <label style="color:red">*</label>					   
      </td>
       <td width="3%">&nbsp;</td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap" width="10%">项目等级：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:select name="tsportBsxm.xmdj" id ="xmdj" list="getSysCode('BSXM_XMDJ')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/> <label style="color:red">*</label>					   
      </td>
      <td align="right" nowrap="nowrap" width="10%">是否集体项目:</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:select name="tsportBsxm.sfjtxm" id ="sfjtxm" list="getSysCode('XM_SFJT')" listKey="id" listValue="caption"  headerKey="" headerValue="--请选择--"/> <label style="color:red">*</label>	
      </td>
       <td width="3%">&nbsp;</td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap" width="10%">是否对战项目:</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:select name="tsportBsxm.sfdzxm" id ="sfdzxm" list="getSysCode('BOOLEAN')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/> <label style="color:red">*</label>					   
      </td>
      <td align="right" nowrap="nowrap" width="10%">排序号:</td>
      <td align="left" width="20%" nowrap="nowrap">
       <s:textfield id="pxh" name="tsportBsxm.pxh" maxlength="3" size="3" onkeypress="NumberText(event,false,false);"  cssStyle="ime-mode:disabled"/><label style="color:red">*</label>
      </td>
       <td width="3%">&nbsp;</td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap" width="10%">成绩单位:</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:select name="tsportBsxm.cjdw" id ="cjdw" list="getSysCode('SSRC_CJDW')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/> <label style="color:red">*</label>					   
      </td>
      <td align="right" nowrap="nowrap" width="10%"></td>
      <td align="left" width="20%" nowrap="nowrap">
      </td>
       <td width="3%">&nbsp;</td>
    </tr>
   
  </table>
 </fieldset>

  <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle"> 
	  <td colspan="30">&nbsp;</td>
	    <td height="30" colspan="7">
	    
	      	<ul class="btn_gn">
    			<li><a href="#" title="保存" onClick="dosave()"><span>保存</span></a></li>
				<li><a href="#" title="保存并新增" onclick="dosavenew()"><span>保存并新增</span></a></li>
				<li><a href="#" title="保存并关闭" onclick="dosaveclose()"><span>保存并关闭</span></a></li>
	    		<li><a href="#" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span></a></li>
	    	</ul>
	    	</td>
	  </tr>
  </table>
</s:form>
</div>
  </body>
</html>
