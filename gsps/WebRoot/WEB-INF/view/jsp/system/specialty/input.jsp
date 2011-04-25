<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<base target="_self">
    <title>专业维护</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	
	<script type="text/javascript">
	detailPageStyle();
	$(document).ready(function(){
			
			<s:if test="refresh">
			window.parent.window.frames["menuFrame"].location.reload();
			</s:if>
		}
	);
	function submitForm(){
		
		if( !checkInput("zymc","专业名称不能为空！") ){
			return false;
		}
		if( !checkInput("ordernum","排序值不能为空！") ){
			return false;
		}
		if(getLength($("#zymc").val())>60){
			alert("专业名称字数超出最大字数限制了！");
			return false;
		}
		if(getLength($("#yszybm").val())>20){
			alert("专业编号字数超出最大字数限制了！");
			return false;
		}
		if(getLength($("#zyjc").val())>30){
			alert("专业简称字数超出最大字数限制了！");
			return false;
		}
		return super_submitForm();
	}
	function submitRemove(action){
		var conf = window.confirm("对此专业的操作会同时作用到其下所有子专业！\n\n您确定要继续吗？");
		if(conf==true){
			var ids = document.getElementById("zybm").value;
			if(ids.length>0){
				var url = actionName + "-remove.c";
				$.post(url,
				       { wid: ids, action: action, reqtime: (new Date()).getTime() },
				       function(data){
					 	//alert(data);
						if(data.indexOf("删除成功")!=-1){
							alert("操作成功！");
						}else{
							alert($(data).find("span:first").html());
						}
						window.parent.window.frames["menuFrame"].location.reload();
				       }
				);
			}else{
				alert("无要操作的项!");
			}
		}
	}
	function input(){
		var uri = actionName+"-input.c?tzy.sjbm=<s:property value="tzy.zybm"/>";
		window.location.href = uri;
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

<div class="framestyle" style="width:98%;">
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden id="zybm" name="tzy.zybm" />
  <s:hidden name="tzy.wid" />
  <s:hidden name="tzy.sjbm" />
  <s:hidden name="tzy.zycc" />
  <s:hidden name="tzy.gxbm" />
  
  
  
  
  
  
  
  
  <table width="100%" border="0" align="center">
    <tr>
    	<th height="40px" width="100%"><h3><s:if test="depart.departtype==6">查看</s:if><s:elseif test="tzy.zymc!=null">维护</s:elseif><s:else>新增</s:else>专业</h3></th>
    </tr>
  </table>
  
    <fieldset> 
　 <legend>专业信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" width="10%" nowrap="nowrap">名称：</td>
      <td width="90%"><s:textfield id="zymc" name="tzy.zymc" maxlength="30" size="30"/> <label style="color:red">*</label></td>
    </tr>
    <tr> 
      <td align="right"></td>
      <td></td>
    </tr>
    <tr> 
      <td align="right">编号：</td>
      <td><s:textfield id="yszybm" name="tzy.yszybm" maxlength="20" size="20"/></td>
    </tr>
    <tr> 
      <td align="right"></td>
      <td></td>
    </tr>
    <tr> 
      <td align="right">简称：</td>
      <td><s:textfield id="zyjc" name="tzy.zyjc" maxlength="30" size="20" /> </td>
    </tr>
    <tr> 
      <td align="right"></td>
      <td></td>
    </tr>
    <tr> 
      <td align="right">状态：</td>
      <td><s:select name="tzy.sfky" list="#{'1':'可用','0':'禁用'}" listKey="key" listValue="value"/> </td>
    </tr>
    <tr> 
      <td align="right"></td>
      <td></td>
    </tr>
    <tr> 
      <td align="right">排序值：</td>
      <td><s:textfield id="ordernum" name="tzy.pxh" maxlength="4" size="4" onkeypress="NumberText(event)" cssStyle="ime-mode:disabled"/> <label style="color:red">*</label>
      <font color="#999999">说明：同一层次中数值大的往前排</font></td>
    </tr>
  </table>
  </fieldset>
 
  <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle"> 
	  <td colspan="6">&nbsp;</td>
	    <td height="30" colspan="1">
	    
	    
	    <ul class="btn_gn">
    			
<s:if test="#allowChangeSpecialty==true">
	<s:if test="depart.departtype!=6">
	    <s:if test="tzy.sjbm==null">
	    <li><a href="#" title="新增子专业" onClick="input()"><span>新增子专业</span></a></li>
	    </s:if>
	    <s:else>
	     <li><a href="#" title="保存" onClick="submitForm()"><span>保存</span></a></li>
	   
	    </s:else>
	</s:if>
	<s:if test="tzy.zymc!=null&&tzy.sjbm!=null">
	     <li><a href="#" title="禁用" onclick="submitRemove('taboo')"><span>禁用</span></a></li>
	   
	    <s:if test="depart.departtype!='6'.toString()">
	     <li><a href="#" title="删除" onclick="submitRemove('delete')"><span>删除</span></a></li>
	    
	    </s:if>
	</s:if>
	
</s:if>



	    </ul>
	    </td>
	  </tr>
  </table>
  
  
</s:form>
</div>
  </body>
</html>
