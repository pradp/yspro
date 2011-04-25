<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<base target="_self">
    <title>维护角色</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	
	<script type="text/javascript">
	detailPageStyle();
	
	var menues_init = '<s:property value="menues"/>';

	function submitForm(){
		
		if( !checkInput("roleName","名称不能为空！") ){
			return false;
		}

		return super_submitForm();
		
	}

	</script>
	
  </head>
  
  <body style="text-align:center;">

<div class="framestyle" style="width:98%;padding: 0pt 10pt 10pt 10pt;">
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="tsysRole.roleid" />
  <s:hidden id="menues" name="menues" />

 <fieldset> 
　 <legend>角色信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td width="3%">&nbsp;</td>
      <td align="center" width="30%" nowrap="nowrap">角色名称：<s:textfield id="roleName" name="tsysRole.roleName" maxlength="15" size="15"/> <label style="color:red">*</label></td>
	<td align="center">状态：
	<s:select name="tsysRole.state" list="#{'1':'启用','0':'禁用'}" listKey="key" listValue="value"/>
	</td>
      <td width="3%">&nbsp;</td>
    </tr>
  </table>
 </fieldset>
 <fieldset> 
　 <legend>权限菜单</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="center" width="100%" nowrap="nowrap">
      	<iframe id="menuFrame" name="menuFrame" frameborder="0" width="100%" height="350" src="idMenu-list.c?showCheckBox=true"></iframe>
      </td>
    </tr>
  </table>
  </fieldset>
 
  <table width="20%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle"> 
	
	    <td height="30" colspan="7">
	    	<ul class="btn_gn">
    			<li><a href="javascript:void(null)" title="保存" onclick="submitForm()"><span>保存</span></a></li>
	    		<li><a href="javascript:void(null)" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span></a></li>
	    	</ul>
	    </td>
	  </tr>
  </table>
  
</s:form>
</div>

<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" style="top: 20px">
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>

  </body>
</html>
