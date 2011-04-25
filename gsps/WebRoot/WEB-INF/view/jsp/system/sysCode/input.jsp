<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<base target="_self">
    <title>维护字典</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	
	<script type="text/javascript">
	detailPageStyle();

	validate_required_fields = [ 
			{fieldId:"zdbm", message:"标准代码不能为空！", mustMatch: true}, 
			{fieldId:"zdmc", message:"标准名称不能为空！", mustMatch: true}
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
  <s:hidden name="tsysCode.wid" />
  <s:hidden name="sfxz" id="sfxz" />

 <fieldset> 
　 <legend>字典信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td width="3%">&nbsp;</td>
      <td align="center" width="30%" nowrap="nowrap">标准代码：
      <s:textfield id="zdbm" name="tsysCode.zdbm" maxlength="50" size="20"/> <label style="color:red">*</label></td>
	<td align="center">标准名称：
	<s:textfield id="zdmc" name="tsysCode.zdmc" maxlength="50" size="20"/> <label style="color:red">*</label>
	</td>
      <td width="3%">&nbsp;</td>
    </tr>
    <tr> 
      <td >&nbsp;</td>
      <td align="center" nowrap="nowrap">上级标准代码：
      <s:textfield id="sjdm" name="tsysCode.sjdm" maxlength="50" size="20"/>&nbsp;&nbsp;
      </td>
	<td align="center">标准层次：
      <s:textfield id="zdcc" name="tsysCode.zdcc" maxlength="6" size="20"/>&nbsp;&nbsp;&nbsp;
	</td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td >&nbsp;</td>
      <td align="center" nowrap="nowrap">类别：
      <s:select id="zdlb" name="tsysCode.zdlb" list="SysCodeSort" listKey="id" listValue="caption"/> </td>
	<td align="center">状态：
	<s:select name="tsysCode.sfsy" list="#{'1':'启用','0':'禁用'}" listKey="key" listValue="value"/> <label style="color:red">*</label>
	</td>
      <td>&nbsp;</td>
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
