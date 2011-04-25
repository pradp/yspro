<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>市县汇总成绩预览</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/idcard.js"></script>
	<script type="text/javascript">
	    detailPageStyle();
	    
		validate_required_fields = [ 
			{fieldId: "jjf",  message:"加减分不能为空！", mustMatch: true},
		    {fieldId:"jjjps", message:"金牌数不能为空！", mustMatch: true}, 
		    {fieldId:"jjyps", message:"银牌数不能为空！", mustMatch: true},
		    {fieldId:"jjtps", message:"铜牌数不能为空！", mustMatch: true}
		     ];
		function dosave(){
			if(isValidateForm()){
				submitForm();
			}
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
  <s:hidden name="tsportCjSxHzYl.wid" id="wid"/>
  
 <fieldset> 
　 <legend>成绩更新</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" width="8%" nowrap="nowrap">加减分：</td>
      <td align="left" width="10%" nowrap="nowrap">
      <s:textfield id="jjf" name="tsportCjSxHzYl.jjf" maxlength="15" size="15" /> <label style="color:red">*</label>
      </td>
      <td align="right" width="10%" nowrap="nowrap">加减金牌数：</td>
      <td align="left" width="15%" nowrap="nowrap">
      <s:textfield id="jjjps" name="tsportCjSxHzYl.jjjps" maxlength="15" size="15" /> <label style="color:red">*</label>
	</td>
	<td align="right" width="10%">加减银牌数：：</td>
	<td align="left" width="15%" nowrap="nowrap">
      	<s:textfield id="jjyps" name="tsportCjSxHzYl.jjyps" maxlength="15" size="10" /> <label style="color:red">*</label>
      </td>
      <td align="right" width="10%">加减铜牌数：：</td>
	<td align="left" width="15%" nowrap="nowrap">
      	<s:textfield id="jjtps" name="tsportCjSxHzYl.jjtps" maxlength="15" size="10" /> <label style="color:red">*</label>
      </td>
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
	    		<li><a href="#" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span></a></li>
	    	</ul>
	    	</td>
	  </tr>
  </table>
</s:form>
</div>
  </body>
</html>
