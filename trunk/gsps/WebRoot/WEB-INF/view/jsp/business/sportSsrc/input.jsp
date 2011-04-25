<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>赛事日程维护</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
	<script type="text/javascript">
		detailPageStyle();

		validate_required_fields = [ 
		                			{fieldId:"xxjsrName", message:"指定比赛项目不能为空！", mustMatch: true}, 
		                			{fieldId:"cjdw", message:"成绩单位不能为空！", mustMatch: true},
		                			{fieldId:"bssj", message:"比赛时间不能为空！", mustMatch: true},
		                			{fieldId:"scbm", message:"赛次编码不能为空！", mustMatch: true},
		                			{fieldId:"djjd", message:"第几阶段不能为空！", mustMatch: true},
		                			{fieldId:"sfxnsc", message:"是否虚拟赛程不能为空！", mustMatch: true}
		                		];

		
		var tem_valueObjid,tem_nameObjid;
		function selectDepart(valueObjid,nameObjid){
			tem_valueObjid = valueObjid;
			tem_nameObjid = nameObjid;
			var url = "<s:property value="basePath"/>/business/sportBsxm-list.c?cd=1";
			openWindow(url,900,400);
		}

		var tem_valueObjid1,tem_nameObjid1;
		function selectDepart1(valueObjid1,nameObjid1){
			tem_valueObjid1 = valueObjid1;
			tem_nameObjid1 = nameObjid1;
			var url = "<s:property value="basePath"/>/business/sportSsrc-list.c?cd=1";
			openWindow(url,900,400);
		}

		function IsURL(){
			var a = "http://";
			var b = document.getElementById("cdzy").value;
			b = b.substring(0,7);
			if(b==""){
				return true;
			}else if(b.length<7){
				alert("场地信息的主页:输入长度不对！");
				return false;
			}else if(b.substring(5,6)=="\\"){
				alert("场地信息的主页:\\\\应该写//！");
				return false;
			}else if(b!=a){
				alert("场地信息的主页:没有加http://！");
				return false;
			}else{
				return true;
				}
		}
		function dosave(){
			if(isValidateForm()){
				document.getElementById("bssj").value = document.getElementById("bssj").value+":00";
				if(IsURL()){
					submitForm();
				}
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
  
  <s:hidden name="tsportSsrc.wid" />
  <s:hidden id="menues" name="menues" />
  <s:hidden name="sfxz" id="sfxz" />

 <fieldset> 
　 <legend>赛事日程</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" width="10%" nowrap="nowrap" >
      	指定比赛项目：
      	<s:hidden name="tsportSsrc.xmbm" id="xxjsr" value="%{#xmbm}" ></s:hidden>
      </td>
      <td colspan="4"><s:textfield name="xxjsrName" id="xxjsrName" size="100" readonly="true" value="%{#xxjsrName}" />
      <input type="button" value="..." onclick="selectDepart('xxjsr','xxjsrName')" style="display: " id="departButton"/><label style="color:red">*</label> </td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap" width="10%">成绩单位：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:select name="tsportSsrc.cjdw" id ="cjdw" list="getSysCode('SSRC_CJDW')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/> <label style="color:red">*</label>					   
      </td>
      <td align="right" nowrap="nowrap" width="10%">比赛时间：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:if test="#type==0">
      	 <input name="tsportSsrc.bssj1" id="bssj" readonly="readonly" value="<s:date name="tsportSsrc.bssj" format="yyyy-MM-dd HH:mm"/>" />
      </s:if>
      <s:else>
      	 <input name="tsportSsrc.bssj1" id="bssj" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:false})" value="<s:date name="tsportSsrc.bssj" format="yyyy-MM-dd HH:mm"/>" />
      </s:else>
     
      <label style="color:red">*</label>   
      </td>
       <td width="3%">&nbsp;</td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap" width="10%">编排分组：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:select name="tsportSsrc.bpfz" id ="bpfz" list="getSysCode('SSRC_BPFZ')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>					   
      </td>
      <td align="right" nowrap="nowrap" width="10%">赛次编码：</td>
      <td align="left" width="20%" nowrap="nowrap">
       <s:select name="tsportSsrc.scbm" id ="scbm" list="getSysCode('SSRC_SCBM')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/> <label style="color:red">*</label>
      </td>
       <td width="3%">&nbsp;</td>
    </tr>
       <tr> 
      <td align="right" width="10%" nowrap="nowrap">比赛场地：</td>
      <td align="left" width="20%" nowrap="nowrap">
       <s:textfield id="bscd" name="tsportSsrc.bscd" maxlength="150" size="30"/>
	</td>
	<td align="right" width="10%">场地信息的主页：</td>
	<td align="left" width="20%" nowrap="nowrap">
       <s:textfield id="cdzy" name="tsportSsrc.cdzy" maxlength="150" size="30"/>
      </td>
    </tr>
     <tr>
     <td align="right" width="10%" nowrap="nowrap" >
      	上一赛次：
      	<s:hidden name="tsportSsrc.sysc" id="xxjsrwid" ></s:hidden>
      </td>
      <td colspan="4"><s:textfield name="sxyscName" id="sxyscName" size="100" readonly="true" value="%{#sxyscName}" />
      <input type="button" value="..." onclick="selectDepart1('xxjsrwid','sxyscName')" style="display: " id="departButton"/></td>
      </tr>
      <tr>
	 <td align="right" width="10%" nowrap="nowrap" >
      	下一赛次：
      	<s:hidden name="tsportSsrc.xysc" id="xxjsrwid1" ></s:hidden>
      </td>
      <td colspan="4"><s:textfield name="sxyscName1" id="sxyscName1" size="100" readonly="true" value="%{#sxyscName1}" />
      <input type="button" value="..." onclick="selectDepart1('xxjsrwid1','sxyscName1')" style="display: " id="departButton"/></td>
     </tr>
     <tr>
     <td align="right" width="10%" nowrap="nowrap">第几阶段：</td>
      <td align="left" width="20%" nowrap="nowrap">
       <s:select name="tsportSsrc.djjd" id ="djjd" list="#{'1':'第一阶段','2':'第二阶段','3':'第三阶段'}"  headerKey="" headerValue="--请选择--"/> <label style="color:red">*</label>
	</td>
   	<td align="right" width="10%">是否虚拟赛程：</td>
	<td align="left" width="20%" nowrap="nowrap">
       <s:select name="tsportSsrc.sfxnsc" id ="sfxnsc" list="#{'0':'否','1':'是'}" headerKey="" /> <label style="color:red">*</label>
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
