<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>excel导入</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/resources/css/webface.css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/zxdk.js"></script>
	
	<script type="text/javascript">
	function $(ID){
	  return document.getElementById(ID);
  	}
	function showImportContext(obj){		
		$("context").src="excelUserImport-list.c?importTempID=<s:property value='importTempID'/>&filePath=<s:property value='filePath'/>&sheetName="+obj.value;
	}
	function loading(){
		$("context").src="excelUserImport-list.c?importTempID=<s:property value='importTempID'/>&sheetName=<s:property value='sheetIndex'/>&filePath=<s:property value='filePath'/>";
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
		if(frames['context'].isTrue()){			
	  		$("context").src="excelUserImport-saveContext.c?importTempID=<s:property value='importTempID'/>&className="+$('className').value+"&sheetName="+$('sheetIndex').value;
	  	}else{
	  		alert("内容不符,不能提交!");
	  	}
		$('sendMsgButton').disabled=true;
	}
	function isSubmitBtn(is){
		if(is){
			$('sendMsgButton').disabled=false;
		}else{
			$('sendMsgButton').disabled=true;
		}
	}
	
	function toSubmit(){
		super_submitForm();
	}

	</script>
  </head>
  
  <body scroll="no" style="text-align:center" <s:if test="sheetName<2">onload="loading();"</s:if>>
<s:if
			test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
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
				<table width="100%;height:90%" border="0" cellpadding="0" cellspacing="0"
					class="maginB">
					<tr>
						<td style="padding-left: 20px">
							<table width="85%" border="0" align="left" cellpadding="0"
								cellspacing="0" class="maginB">
								<tr>
									<td class="chaxunleft">
										<table id="searchForm" border="0" align="center" cellspacing="1" cellpadding="0" width="100%">
											<tr align="left">
												<s:if test="tempName!=null&&tempName!=''">
												<td align="left" nowrap="nowrap" width="6%">
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<a href="<s:property value="basePath"/>/resources/exceltemplate/<s:property value="%{tempName}"/>" title="下载导入模板" >下载导入模板</a></td></s:if>
												<td align="right" nowrap="nowrap" width="10%">
													&nbsp;&nbsp;导入文件：
												</td>
												<td align="left" nowrap="nowrap" width="20%">
													<s:file name="excelFile" id="excelFile"/>&nbsp;&nbsp;
												</td>
												<td align="left" nowrap="nowrap" width="10%">
													<ul class="btn_gn">						
														<li>
															<a href="#" title="预览导入" onClick="doUpload()" 
																id="sendUploadButton"><span>预览导入</span> </a>
														</li>																					
													</ul>
												</td>
												<td align="left" nowrap="nowrap" width="10%" >	
													<s:select name="sheetIndex" id="sheetIndex" list="sheetNames" headerKey="-1" headerValue="-- 请选择工作区 --" value="%{sheetIndex}" onchange="showImportContext(this)"/>									
												</td>
											</tr>
										</table>
									</td>
									<td width="15" height="49" class="chaxunright">
										&nbsp;
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td style="padding-left: 17px">
							<table id="buttonTable" border="0" cellspacing="3"
								cellpadding="0" width="100%">
								<tr>
									<td height="30px" width="440px">
										<ul class="btn_gn">								
											<li>
												<a href="#" title="确认导入" onClick="save();" disabled="true"  
													id="sendMsgButton"><span>确认导入</span> </a>
											</li>																					
										</ul>
									</td>
										<td id="inp" style="display:none" align="left" width="160px">
									
										</td>
										<td>
											
										</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr style="width:100%;height:88%">
						<td>
							<iframe id="context" frameborder="0" style="width:100%;height:90%"></iframe>  
						</td>
					</tr>				
				</table>
		</div>
</s:form>

  </body>
</html>
