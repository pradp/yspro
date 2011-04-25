<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>新用户</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="${basePath}/dwr/engine.js"></script>
	<script type="text/javascript" src="${basePath}/dwr/util.js"></script>
	<script type="text/javascript" src="${basePath}/dwr/interface/htshService.js"></script>
	
	<script type="text/javascript" src="${basePath}/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="${basePath}/resources/js/myutil.js"></script>
	<script type="text/javascript" src="${basePath}/resources/js/zxdk.js"></script>
	
	<script type="text/javascript" src="${basePath}/resources/js/idcard.js"></script>
	
	<script type="text/javascript">
	$(document).ready(function(){
			v_ctrl_xsly();
			$("#xssfzh").css("ime-mode","disabled").bind("keyup", function( event ) {
				//resetIDcardValue(this);
			});
			$("#jzsfzh").css("ime-mode","disabled").bind("keyup", function( event ) {
				//resetIDcardValue(this);
			});
			$("#xz")[0].selectedIndex = 4;//select下拉框的第5个元素为当前选中值
			$("#rxny")[0].selectedIndex = 4;//select下拉框的第5个元素为当前选中值
			detailPageStyle();
		}
	);
	function v_ctrl_xsly(){
		var xsly = document.getElementById("xsly").value;
		if(xsly=="1"){
			document.getElementById("lx_gx_1").style.display="block";
			document.getElementById("lx_gx_2").style.display="block";
			document.getElementById("lx_gx_3").style.display="block";
			document.getElementById("lx_zx").style.display="none";
		}else{
			document.getElementById("lx_gx_1").style.display="none";
			document.getElementById("lx_gx_2").style.display="none";
			document.getElementById("lx_gx_3").style.display="none";
			document.getElementById("lx_zx").style.display="block";
		}
	}
	
	function checkIsIdcardExist(obj){
		if(obj && obj.value.length>14){
			htshService.checkIsIdcardExist(obj.id,obj.value,cb);
		}
		function cb(res){
			if( res || res=='true'){
				//alert("此身份证号码已经存在！");
				$("#alertXssfzh").html("此身份证号已经存在！").css("color","red");
				obj.focus();
			}else{
				$("#alertXssfzh").html("");
			}
		}
	}
	</script>
  </head>
  
  <body>
  <#include "../../showerr.ftl" parse="true">
<div class="framestyle" style="width:98%;padding: 0pt 10pt 10pt 10pt;">
  <s:form name="theform" method="post" theme="simple" action="create.c" >
  <table width="100%" border="0" align="center">
    <tr>
    	<th height="40px" width="100%"><h3>新增用户信息</h3></th>
    </tr>
  </table>
 <fieldset> 
　 <legend>基本情况</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" width="10%" nowrap="nowrap">姓名：</td>
      <td width="40%"><s:textfield name="tstudentContract.xsxm" id="xsxm" maxlength="15" size="31"/> <label style="color:red">*</label></td>
      <td align="right" width="10%" nowrap="nowrap">申请贷款金额：</td>
      <td width="40%"><s:textfield id="sqdkje" name="tstudentContract.sqdkje" maxlength="4" size="31" onkeypress="NumberText(event);"/> <label style="color:red">*</label></td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap">家庭困难类型：</td>
      <td><s:select id="jtjjknlx" name="tstudentContract.jtjjknlx" list="Jtjjknlx" value="tstudentContract.jtjjknlx" headerKey="" headerValue="---------------请选择---------------" listKey="id" listValue="caption"/>
      <label style="color:red">*</label></td>
      <td align="right">性别：</td>
      <td> <label style="color:red">*</label></td>
    </tr>
    <tr> 
      <td align="right">身份证号：</td>
      <td ><s:textfield name="tstudentContract.xssfzh" id="xssfzh" maxlength="18" size="31" onblur="checkIsIdcardExist(this)"/>
      <label style="color:red">*</label> <span id="alertXssfzh"></span></td>
      <td align="right" >民族：</td>
      <td ><s:select id="mz" name="tstudentContract.mz" list="Mz" headerKey="" headerValue="---------------请选择---------------" listKey="id" listValue="caption"/></td>
    </tr>
    <tr style="display:none"> 
      <td align="right" >学生来源：</td>
      <td >
      <label style="color:red">*</label></td>
      <td align="right"></td>
      <td >&nbsp;</td>
    </tr>
    <tr id="lx_zx"> 
      <td align="right">所在中学：</td>
      <td><s:select id="szzx" name="tstudentContract.szzx" list="Szzx" headerKey="" headerValue="---------------请选择---------------" listKey="id" listValue="caption"/>
      <label style="color:red">*</label></td>
      <td align="right"></td>
      <td >&nbsp;</td>
    </tr>
    <tr id="lx_gx_1"> 
      <td align="right">高校名称：</td>
      <td><s:select id="gxmc" name="tstudentContract.gxmc" list="Gxmc" headerKey="" headerValue="---------------请选择---------------" listKey="id" listValue="caption" onchange="ctrl_gxyx()"/>
      <label style="color:red">*</label></td>
      <td align="right">院系名称：</td>
      <td><select><option value="">---------------请选择---------------</option></select> </td>
    </tr>
    <tr id="lx_gx_2"> 
      <td align="right">专业名称：</td>
      <td><s:textfield name="tstudentContract.zymc" id="zymc" maxlength="50" size="31"/></td>
      <td align="right"></td>
      <td><s:textfield name="tstudentContract.gkksh" id="gkksh" maxlength="50" size="31" cssStyle="display:none"/></td>
    </tr>
    <tr id="lx_gx_3"> 
      <td align="right">学制：</td>
      <td> 年</td>
      <td align="right"></td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td align="right">入学年月：</td>
      <td></td>
      <td align="right"></td>
      <td>&nbsp;</td>
    </tr>
  </table>
  </fieldset>
 
  <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
  <tr align="center" valign="middle"> 
    <td height="30" colspan="7">
    <input type="button" value=" 保存 " onclick="submitForm()"/>
    &nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;
    <input type="button" value=" 关闭 " onclick="window.close()"/></td>
  </tr>
  </table>
</s:form>
</div>
  </body>
</html>
