<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>消息</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/idcard.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	
	<script type="text/javascript">
		detailPageStyle();

		validate_required_fields = [ 
			{fieldId:"xxbt", message:"标题不能为空！", mustMatch: false}, 
			{fieldId:"xxnr", message:"内容不能为空！", mustMatch: false}
		];
		validate_length_range_fields = [
			{fieldId:"xxbt", minLen:0, maxLen:50, message:"标题过长！", ignoreIfEmpty: false},
			{fieldId:"xxnr", minLen:0, maxLen:1200, message:"内容过长！", ignoreIfEmpty: false}
		];
	
		function super_submitForm(){
			if(isValidateForm()){
			    if (actionName == null || actionName == "") {
			        actionName = getActionName();
			    }
			    document.forms[0].action = actionName + "-submitModify.c";
			    $(".btn_gn a").each(function(i){
			        if ($(this).attr("title").indexOf("保存") != -1) {
			            $(this).html("<span>处理中...</span>");
			            $(this).unbind();
			        }
			    });
			    document.forms[0].submit();
			    return true;
			}
		}
		function PreviewFile(myFile){
		    var filepath=myFile.value;
		    document.getElementById("fjm").value=filepath.substring(filepath.lastIndexOf('.')+1,filepath.length);
		}
	    </script>
  	<base target="_self">
  </head>
   <body>
     <div id="listC" style="text-align:center;">
    <s:form theme="simple" name="theform" enctype="multipart/form-data">
    <s:hidden name="tsysMessage.wid" id="wid" value="%{#parameters.ids[0]}"/> 
  	<s:hidden id="fjm" name="tsysMessage.fjm"/>

          <fieldset>
				<table width="100%" border="0" align="center">
				    <tr class="fzline"> 
				      <td align="right" width="10%" nowrap="nowrap">标题：</td>
				      <td width="40%"><s:textfield id="xxbt" name="tsysMessage.xxbt" maxlength="50" size="50"/> <label style="color:red">*</label></td>
				    </tr>
				    <tr class="fzline">
				     <td align="right" width="10%" nowrap="nowrap">内容：</td>
				      <td width="40%"><s:textarea id="xxnr" name="tsysMessage.xxnr" cols="50" rows="10"></s:textarea> <label style="color:red">*</label></td>
				    </tr>
				    <s:if test="tsysMessage.fjm != null">
				    <tr class="fzline">
				     <td align="right" width="10%" nowrap="nowrap">附件：</td>
				      <td width="40%"><a href="../system/message-download.c?aId=<s:property value='tsysMessage.wid'/>&pathStr=<s:property value='tsysMessage.fjm'/>"><FONT color="blue"><s:property value='tsysMessage.fjm'/></FONT></a>
				      		<input id="myFile" name="myFile" type="file"  class="w390"  value="修改"  onchange="javascript:PreviewFile(this);"/>
					        <input type="button" name="Submit3" value="清除" onclick="doReset()"/>
					  </td>
				    </tr>
				    </s:if>
				</table>
			</fieldset>
  <table width="100%" border="0" align="center">
    <tr>  
    <td colspan="20"></td>
       <td align="center">
       <ul class="btn_gn">
	    	<li><a href="#" title="" onclick="super_submitForm()"><span>保存</span></a></li>
	    	<li><a href="#" title="" onclick="parent.closeInputWindow();"><span>取消</span></a></li>
		</ul>
		</td>
    </tr>
  </table>
</s:form>
  </div>
  </body>
</html>

