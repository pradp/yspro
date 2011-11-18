<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<title>消息发送</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/p2pMessage.js"></script>
	
	<script type="text/javascript">
	detailPageStyle();
	var tem_valueObjid,tem_nameObjid;
	function selectDepart(valueObjid,nameObjid){
		tem_valueObjid = valueObjid;
		tem_nameObjid = nameObjid;
		var depart = '<s:property value="depart.departtype" />';
		var isISHUNAN = '<s:property value="@com.imchooser.infoms.action.sys.BaseActionAbstractSupport@isISHUNAN()"/>';
		if(depart =='1' && isISHUNAN=='true'){
			var url = "<s:property value="basePath"/>/system/depart-selectDepartName.c";
		}else{
			var url = "<s:property value="basePath"/>/system/depart-selectDepart.c";
		}
		openWindow(url,700,300);
	}
	function selectStudent(valueObjid,nameObjid){
		tem_valueObjid = valueObjid;
		tem_nameObjid = nameObjid;
		$("#xxly").val("051");
		var url = "<s:property value="basePath"/>/business/xsfwStudent-selectStudent.c";
		openWindow(url,700,300);
		if(document.getElementById("xxjsrName").value == '全部学生'){
			document.getElementById("xxjsrName").value = '';
			document.getElementById("xxjsr").value = '';
		}
	}
	function AllStudent(){
		$("#xxly").val("050");
		document.getElementById("xxjsrName").value = '全部学生';
		document.getElementById("xxjsr").value = '0';
	}
	function submitForm(str){
        var depart = '<s:property value="depart.departtype" />';
		if(document.getElementById("xxjsr").value==""){
			alert("请选择消息接收者！");
			return false;
		}
		var xxbt = document.getElementById("xxbt").value;
		if(xxbt==""){
			alert("请输入标题！");
			return false;
		}
		if(getLength(xxbt)>50){
			alert("标题字数超出最大值！");
			return false;
		}
		var xxnr = document.getElementById("xxnr").value;
		if(xxnr==""){
			alert("请输入内容！");
			return false;
		}
		if(getLength(document.getElementById("xxnr").value)>3000){
			alert("内容字数超出最大值！");
			return false;
		}
		if(document.getElementById("messageType")){
			if(document.getElementById("messageType").checked)
			$("#xxly").val("100");
			//alert(document.getElementById("messageType").value);
		}
		document.getElementById("fszt").value = str;
		return super_submitForm();
	}
	function doReset(obj){
	     document.getElementById(obj).focus();
	     document.execCommand("selectall");   
         document.execCommand("Delete"); 
	}
	function PreviewFile(myFile,index){
	    var filepath=myFile.value;
	    var id = "fjm"+index;
	    document.getElementById(id).value=filepath.substring(filepath.lastIndexOf('.')+1,filepath.length);
	}
	function postNoDeparts(){
		document.getElementById('xxjsrName').value = '';
		document.getElementById('xxjsr').value = '';
	}
	function chJsrLx(){		
		var isISHUNAN = '<s:property value="@com.imchooser.infoms.action.sys.BaseActionAbstractSupport@isISHUNAN()"/>';
		if(isISHUNAN=='true' || document.getElementsByName('jsrLx')[0].checked){
			document.getElementById('jsrButton').style.display = "";
			document.getElementById('departButton').style.display = "";
			document.getElementById('batchCollege').style.display = "";
			document.getElementById('studentButton').style.display = "none";
			document.getElementById('allStudentButton').style.display = "none";
			document.getElementById('adminChoose').style.display = "";
		}else if(document.getElementsByName('jsrLx')[1].checked){
			document.getElementById('jsrButton').style.display = "";
			document.getElementById('studentButton').style.display = "";
			document.getElementById('allStudentButton').style.display = "";
			document.getElementById('departButton').style.display = "none";
			document.getElementById('batchCollege').style.display = "none";
			document.getElementById('adminChoose').style.display = "none";
		}
	}
	function init(){
		document.getElementById('xxbt').value = "";
		document.getElementById('xxnr').value = "";
		chJsrLx();
	}
	function addFj(fjName){
		document.getElementById(fjName).style.display = "";
	}
	function displayFj(fjName){
		document.getElementById(fjName).style.display = "none";
	}
	function search(valueObjid,nameObjid,deptype){
		tem_valueObjid = valueObjid;
		tem_nameObjid = nameObjid;
		var url = "<s:property value="basePath"/>/system/depart-selectDepartName.c?deptype="+deptype+"";
		openWindow(url,700,300);
		//super_doSearch();
	}
	//删除一行家庭成员
	function removeThisRow(obj){
	    $("#" + obj.id).parent().parent().remove();
	}
	function getFjMaxNum(){
	    var num = 0;
	    var ryInput = $("input[@name*=tsysMessageFjbs]").each(function(i){
	        if (this.name.indexOf(".myFile") != -1) {
	            var thisIndexStr = this.name;
	            var end = thisIndexStr.substring("tsysMessageFjbs[".length);
	            var thisIndex = end.substring(0, end.indexOf("]"));
	            if (thisIndex > num) 
	                num = thisIndex;
	        }
	    });
	    return num;
	}
	function createFj(){
		var id = (new Date()).getTime() + "";
	    var maxNum = getFjMaxNum();
	    var newnum = parseInt(maxNum) + 1;
	    var newfjindex = parseInt(maxNum) + 2;
	    var newTag = "fj" + newnum + "";
	    var myFile = "myFile" + newnum + "";
	    jQuery.noConflict();
	    var cellFuncs = [function(data){
	        return "<span style='float: right' >附件"+newfjindex+"：</span>";
	    },function(data){
		    var str = "<input id='"+myFile+"' name='tsysMessageFjbs["+newnum+"].myFile' type='file'  class='w390'  value='提交'  onchange=javascript:PreviewFile(this,'"+newfjindex+"') />";
		    str += "&nbsp;<input type='button' name='Submit3' value='清除' onclick=doReset('"+myFile+"') />";
		    str += "&nbsp;<input id='" + id + "' type='button' value='删除' onclick='removeThisRow(this)' />";
		    str += "&nbsp;<input type='hidden' id='fjm"+newfjindex+"'  name='tsysMessageFjbs["+newnum+"].fjm' />";
		    return str;
	    }
	];
	    DWRUtil.addRows("tsysmessageFjb", [id], cellFuncs, {
	        escapeHtml: false
	    });
	    $ = jQuery;
	}
	window.onload = init;
	</script>
  	<base target="_self">
  </head>
  
  <body style="text-align:center;">

<div  class="framestyle" style="width:100%;">
  <s:form name="theform" method="post" theme="simple" enctype="multipart/form-data">
  <s:hidden id="xxjsr" name="tsysMessage.xxjsr" />
  <s:hidden id="xxly" name="tsysMessage.xxly" />
  <s:hidden id="fszt" name="tsysMessage.fszt" value="0"/>
 
  
  <table width="100%" border="0" align="center">
    <s:if test="user.depart.departtype == 1 && !ISHUNAN">
    <tr>
      	<td align="right" width="10%" nowrap="nowrap">接受者类型：</td>
    	<td nowrap="nowrap"  width="40%" align="left">
	      	<s:radio  name="jsrLx" list="#{'0':'部门','1':'学生'}" onclick="chJsrLx()" value="0"/>
    	</td>
    </tr>
    </s:if>
    <tr class="fzline"> 
      <td align="right" width="10%" nowrap="nowrap">接收者：</td>
      <td width="40%">
	      <s:if test="user.depart.departtype!='8'.toString()&&user.depart.departtype!='9'.toString()">
	      <s:textarea name="tsysMessage.xxjsrName" id="xxjsrName" cols="40" rows="10" readonly="true"/> 
		      <s:if test="user.depart.departtype!=1">
		      	<input type="button" value="部门" onclick="selectDepart('xxjsr','xxjsrName')"/>
		      </s:if>
	      </s:if>
	      <s:else>
	      	<s:textarea name="tsysMessage.xxjsrName" id="xxjsrName" cols="40" rows="10" readonly="true"/> 
	      </s:else>
	      <label style="color:red">*</label>
      </td>
      <s:if test="ISHUNAN">
      <td><label style="color:red">*</label></br>
        <input type="button" value="省中心" onclick="search('xxjsr','xxjsrName',1)"  id="departButton"/></br>
	 	<input type="button" value="高  校" onclick="search('xxjsr','xxjsrName',6)"  id="departButton"/></br>
	    <input type="button" value="市  县" onclick="search('xxjsr','xxjsrName',7)"  id="departButton"/></br>
	    <input type="button" value="全  部" onclick="search('xxjsr','xxjsrName',0)"  id="departButton"/>
	    <input type="hidden" name="deptype" id="deptype" />
	  </td>
	  </s:if>
    </tr>
    <s:if test="user.depart.departtype=='1'.toString()">
    <tr id="jsrButton" style="display: none">
      	<td align="right" width="10%" nowrap="nowrap">&nbsp;</td>
    	<td nowrap="nowrap"  width="40%" align="left">
    	  <s:if test="ISHUNAN">
	      	<input type="button" value="选择接收对象" onclick="selectDepart('xxjsr','xxjsrName')" style="display: " id="departButton"/>
	      </s:if>
	      <s:else>
	      	<input type="button" value="指定部门" onclick="selectDepart('xxjsr','xxjsrName')" style="display: " id="departButton"/>
	      </s:else>
	      <input type="button" value="指定学生" onclick="selectStudent('xxjsr','xxjsrName')" style="display: " id="studentButton"/>
	      <input type="button" value="全部学生" onclick="AllStudent()" style="display: " id="allStudentButton"/>
    </td></tr>
    
    <tr id="batchCollege" style="display: none"><td nowrap="nowrap" colspan="3" align="center">
    <s:if test="!ISHUNAN">
　<fieldset style="width:60%;align:center;display: ">
	<legend>批量选取高校</legend>
  <table border="0" align="center">
	    <tr>
	     <td nowrap="nowrap" colspan="3" align="left">
	        <s:checkbox name="allGx"></s:checkbox><label>全部高校</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <s:checkbox name="gxlx1_1"></s:checkbox><label> 省属高校</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <s:checkbox name="gxlx1_2"></s:checkbox><label> 市属高校</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <s:checkbox name="gxlx1_3"></s:checkbox><label> 厅属高校</label>
	     </td>
	    </tr>
	    <tr>
	     <td nowrap="nowrap" colspan="3" align="left">
	        <s:checkbox name="gxlx2_1"></s:checkbox><label> 本科高校</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <s:checkbox name="gxlx2_2"></s:checkbox><label> 高职高专</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <s:checkbox name="gxlx2_3"></s:checkbox><label> 民办高校</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <s:checkbox name="gxlx2_4"></s:checkbox><label> 三本院系</label>
	     </td>
	    </tr>
    </table>
    </fieldset></s:if>
    </td></tr></s:if>
    <tr class="fzline"> 
      <td align="right" width="10%" nowrap="nowrap">标题：</td>
      <td width="40%"><s:textfield id="xxbt" name="tsysMessage.xxbt" maxlength="50" size="78"/> </td><td> <label style="color:red">*</label></td>
    </tr>
    <tr class="fzline" id="adminChoose" style="display: "> 
      <td align="right" width="10%" nowrap="nowrap"></td>
      <td width="40%">
    <s:if test="depart.departid.length()<=6 && !ISHUNAN">
      <s:checkbox id="messageType" name="messageType"></s:checkbox><label for="messageType">并抄送给接收者的所有下级单位</label>
    </s:if>
      </td>
    </tr>
    <tr class="fzline">
     <td align="right" width="10%" nowrap="nowrap">内容：</td>
      <td width="40%"><s:textarea id="xxnr" name="tsysMessage.xxnr" cols="50" rows="10"></s:textarea></td><td> <label style="color:red">*</label></td>
    </tr>
	   <!--  <tr height="30">
	     <td nowrap="nowrap" colspan="3" align="center">
	        <s:checkbox name="xxlx_1" id="xxlx_1"></s:checkbox><label for="xxlx_1"> 在线消息</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <s:checkbox name="xxlx_2" id="xxlx_2"></s:checkbox><label for="xxlx_2"> 手机短信</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <s:checkbox name="xxlx_3" id="xxlx_3"></s:checkbox><label for="xxlx_3"> 电子邮件</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <s:checkbox name="xxlx_4" id="xxlx_4"></s:checkbox><label for="xxlx_4"> QQ群(39858430)</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        <s:checkbox name="xxlx_5" id="xxlx_5"></s:checkbox><label for="xxlx_5"> 办公OA系统</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	     </td>
	    </tr> -->
    <s:if test="ISHUNAN">
	    <s:if test="user.depart.departtype==1 || user.depart.departtype==6 || user.depart.departtype==7">
	    <tbody id="tsysmessageFjb">
	    	<tr>
			     <td align="right" width="20%" nowrap="nowrap">附件1：</td>
				 <td><input id="myFile" name="tsysMessageFjbs[0].myFile" type="file"  class="w390"  value="提交"  onchange="javascript:PreviewFile(this,'1');"/>
		        	 <input id="" type="button" name="Submit3" value="清除" onclick="doReset('myFile')"/>
		        	 <input id="" type="button" name="Submit5" value="添加" onclick="createFj()"/>
		        	 <s:hidden id="fjm1"  name="tsysMessageFjbs[0].fjm"/></td>
			 </tr>
	    </tbody>
	    </s:if>
    </s:if>
    <s:else>
    	<s:if test="user.depart.departtype=='1'.toString()">
		     <tr>
		     <td align="right" width="10%" nowrap="nowrap">附件：</td>
			 <td width="40%"><input id="myFile0" name="myFile" type="file"  class="w390"  value="提交"  onchange="javascript:PreviewFile(this,'');"/>
			        		<input type="button" name="Submit3" value="清除" onclick="doReset('myFile0')"/>&nbsp;&nbsp;
			        		 <s:hidden id="fjm" name="tsysMessage.fjm"/></td>
		    </tr> 
		</s:if>
    </s:else>
    </table>
  
  <table width="35%" border="0" align="center">
  <br/>
    <tr> 
    	<td height="30" colspan="2" >
    		<ul class="btn_gn">
    			<!-- li><a href="#" title="保存为草稿" onClick="submitForm('0')"><span>保存为草稿</span></a></li -->
    			<li><a href="#" title="保存并发送" onClick="submitForm('1')"><span>保存并发送</span></a></li>
	    		<li><a href="#" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span></a></li>
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
