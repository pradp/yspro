<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>添加审核退回意见</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript">
	detailPageStyle();

		validate_required_fields = [ 
		                			{fieldId:"shyj", message:"退回审核意见不能为空！", mustMatch: true}
		                		];
		
		function dosave(){
			if(isValidateForm()){
				var id =document.getElementById("wid").value;
				var shzt =document.getElementById("shzt").value;
				var shyj =document.getElementById("shyj").value;
				var scbm =document.getElementById("scbm").value;
				var isjtxm =document.getElementById("isjtxm").value;
				ajaxService.changeShyj(id,shyj,shzt,scbm,function(data){
					if("-2"==shzt){
						ajaxService.auditGameProcess('-2',id,'','','','',function (data){
							alert(data);
							parent.document.forms[0].submit();
							submitForm();
							return false;
						});
					}else if("-1"==shzt){
						var tt = id.split(",");
						ajaxService.auditScore('-1',tt,scbm,isjtxm,function (data){
							alert(data);
							parent.parent.document.forms[0].submit();
							return false;
						});
					}
				});
			}
		}	

		function checkLength(obj){
			var lengths = getLength(obj.value);
			if(lengths>600){
				alert('输入的字符超过 600!');
//				$("#bz").val(val.substring(0,600));//截取前200个字符
				return false;
			}
			return true;
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
  <s:hidden name="wid" id="wid" />
  <s:hidden name="scbm" id="scbm" value="%{#scbm}"/>
  <s:hidden name="isjtxm" id="isjtxm" value="%{#isjtxm}"/>
  <s:hidden name="shzt" id="shzt" value="%{#shzt}"/>
<s:if test="#parameters.model[0]=='look'">
<fieldset> 
	  <legend>审核意见</legend>
	  <table width="100%" border="0" align="center">  
	      <tr> 
	      <td colspan="5"  align="left"><s:property value="sportSsrc.shyj"/> </td>
	      </tr>
	  </table>
 </fieldset>
</s:if>
<s:else>
 <fieldset> 
	  <legend>审核意见</legend>
	  <table width="100%" border="0" align="center">  
	      <tr> 
	      <td align="right" nowrap="nowrap">审核意见备注：</td>
	      <td colspan="5"  align="left"><s:textarea rows="10" cols="50" name="sportSsrc.shyj" id="shyj" onkeyup="checkLength(this)"></s:textarea></td>
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
    			<li><a href="#" title="提交" onClick="dosave()"><span>提交</span></a></li>
	    		<li><a href="#" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span></a></li>
	    	</ul>
	    	</td>
	  </tr>
  </table>
  </s:else>
</s:form>
</div>
  </body>
</html>
