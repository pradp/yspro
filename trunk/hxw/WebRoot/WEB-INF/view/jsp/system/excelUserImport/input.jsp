<%@ page language="java" import="java.net.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<%@include file="../../common/Include_input_head.jsp" %>
    <title>配置导入规则</title>
    <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <script type="text/javascript">
    $(function(){
    	L("context").src="excelUserImport-list.action?importTempID=<s:property value='importTempID'/>";
    })
    function L(ID){
	  return document.getElementById(ID);
  	}
	function showImportContext(obj){	
		$("#con").show();
		L("context").src="excelUserImport-list.action?importTempID=<s:property value='importTempID'/>&filePath=<s:property value='filePath'/>&sheetName="+obj.value;
	}
	function loading(){
		L("context").src="excelUserImport-list.action?importTempID=<s:property value='importTempID'/>&sheetName=<s:property value='sheetIndex'/>&filePath=<s:property value='filePath'/>";
	}
	function doUpload(){
		var f = checkFileExt("excelFile");
		if(f){
			document.forms[0].submit();
		}else{
			alert("只允许上传Excel文件，如后缀名是 xls、csv 的文件！");
		}
	}
	function checkFileExt(fileInputId){
		 //获取欲上传的文件路径
		var filepath = document.getElementById(fileInputId).value;
		filepath = filepath.toLowerCase();
		//为了避免转义反斜杠出问题，这里将对其进行转换
		var re = /(\\+)/g; 
		var filename=filepath.replace(re,"#");
		//对路径字符串进行剪切截取
		var one=filename.split("#");
		//获取数组中最后一个，即文件名
		var two=one[one.length-1];
		//再对文件名进行截取，以取得后缀名
		var three=two.split(".");
		 //获取截取的最后一个字符串，即为后缀名
		var last=three[three.length-1];
		//添加需要判断的后缀名类型
		var tp ="xls,csv";
		//返回符合条件的后缀名在字符串中的位置
		var rs=tp.indexOf(last);
		//如果返回的结果大于或等于0，说明包含允许上传的文件类型
		if(rs>=0){
			return true;
		}else{
			//选择的上传文件不是指定格式的文件类型！
			return false;
		}
	}
	function save(){
	       // if(window.frames['context'].isTrue()){
	  		  $("#context").attr("src","excelUserImport-saveContext.action?importTempID=<s:property value='importTempID'/>&className="+$('className').value+"&sheetName="+$("#sheetIndex").val());
	  	    //}else{
	  		  // alert("内容不符,不能提交!");
	  	    //}
		    L('sendMsgButton').disabled=true;
	    }
		
	function isSubmitBtn(is){
		if(is){
			L('sendMsgButton').disabled=false;
		}else{
			L('sendMsgButton').disabled=true;
		}
	}
	
	function toSubmit(){
		super_submitForm();
	}
	</script>
  </head>
  
<body> 
   <div id="scrollContent">
         <s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			<div id="SystemErrorMessage">
				<s:actionerror />
				<s:actionmessage />
				<s:fielderror />
			</div>
		</s:if>
<s:form name="theform" method="post" theme="simple" enctype="multipart/form-data">
        <s:hidden name="importTempID" value="%{importTempID}"/>
		<s:hidden name="sheetName" value="%{sheetIndex}"/>	
		<s:hidden name="className" value="%{className}"/>
		<s:hidden name="tempName" value="%{tempName}"/>
        <div id="listC" style="text-align:center;z-index: -100;width:100%height:100%">
          <s:form theme="simple" name="theform" action="excelImportAdminSetup-saveValidateFields">
			<div class="box_tool_mid padding_right5">
			  <div class="center">
				<div class="left">
					<div class="right">
						<div class="padding_top8 padding_left10">
							<table id="searchForm" border="0" align="center" cellspacing="1" cellpadding="0" width="100%">
							  <tr align="left">
								<td nowrap="nowrap" width="4%" style="font-size:12px;" align="right">
									&nbsp;&nbsp;导入文件：
								</td>
								<td align="left" nowrap="nowrap" width="15%">
									<input type="file" name="excelFile" id="excelFile" class="default"/>
								</td>
								<td align="center" nowrap="nowrap" width="4%">
									<button onClick="doUpload()"><span class="icon_xls" id="sendUploadButton">预览导入</span></button>
								</td>
								<td align="left" nowrap="nowrap" width="30%" >	
									&nbsp;&nbsp;
									<s:select name="sheetIndex" id="sheetIndex" list="sheetNames" 
									   headerKey="" headerValue="-请选择工作区-" value="%{sheetIndex}" 
									   onchange="showImportContext(this)" cssClass="default"/>	
								</td>
							   </tr>
							</table>
					</div>
				</div>
			  </div>
			</div>
		  </div>
		</div>
			<div style="display: none" id="con">
			<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%">
				<tr>
				    <td height="30px" width="440px" style="padding-left:5px;">
					    <button onClick="save()" id="sendMsgButton"><span class="icon_ok">确定导入</span></button>	
					</td>
					<td id="inp" style="display:none" align="left" width="160px">
					</td>
				</tr>
				<tr style="width:100%;height:88%">
					<td colspan="3">
						<iframe id="context" frameborder="0" style="width:100%;height:90%"></iframe>  
					</td>
				</tr>	
			</table>
			</s:form>
		</div>
		</s:form>
   </div>
  </body>
</html>