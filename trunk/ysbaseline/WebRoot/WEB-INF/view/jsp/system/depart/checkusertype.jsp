<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>业务主管</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	
	<script type="text/javascript">
	detailPageStyle();

	validate_required_fields = [ 
			{fieldId:"userLoginid", message:"业务主管账号不能为空！", mustMatch: true}, 
			{fieldId:"userpwd", message:"业务主管密码不能为空！", mustMatch: true}
		];
	function doCheck(){
			if(isValidateForm()){
				var userLoginid = document.getElementById('userLoginid').value;
				var userpwd = document.getElementById('userpwd').value;
				var zzlx = document.getElementById('zzlx').value;
				ajaxService.checkUsertype(userLoginid,userpwd,ajaxBackString);
				function ajaxBackString(result){
				    var zg = '<s:property value="@com.imchooser.infoms.Constants@JYSF_ZG"/>';
				    var fzg = '<s:property value="@com.imchooser.infoms.Constants@JYSF_FZG"/>';
				    var bcz = '<s:property value="@com.imchooser.infoms.Constants@JYSF_BCZ"/>';
				    var mmcw = '<s:property value="@com.imchooser.infoms.Constants@JYSF_MMCW"/>';
					if(result==zg){
						ajaxService.newYearWorkStartInit(zzlx,ajaxBackString1);
						function ajaxBackString1(result){
							alert(result);
							document.forms[0].submit();
							parent.closeInputWindow();
						}
					}else if(result==fzg){
						alert("该账号不是业务主管!");
					}else if(result==bcz){
						alert("账号不存在!");
					}else if(result==mmcw){
						alert("密码错误!");
					}
				}
			}
		}
	</script>
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
  <s:hidden name="zzlx" id="zzlx" value="%{#parameters.zzlx[0]}"/>

 <fieldset> 
　 <legend>业务主管身份确认</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" nowrap="nowrap">账号：</td>
      <td><s:textfield name="userLoginid"  id="userLoginid" maxlength="50" size="20"/> <label style="color:red">*</label></td>
      </tr>
      <tr>
		<td align="right" nowrap="nowrap">密码：</td>
		<td><s:password name="userpwd" id="userpwd" maxlength="50" size="20"/> <label style="color:red">*</label></td>
	 </tr>
  </table>
 </fieldset>

  <table width="80%" border="0" align="center">
	  <tr align="center" valign="middle"> 
	    <td >
	    
	      	<ul class="btn_gn">
    			<li><a href="#" title="下一步" onClick="doCheck()"><span>下一步</span></a></li>
    		
	    		<li><a href="#" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span></a></li>
	    	</ul>
	    	</td>
	  </tr>
  </table>
  
  
</s:form>
</div>
  </body>
</html>
