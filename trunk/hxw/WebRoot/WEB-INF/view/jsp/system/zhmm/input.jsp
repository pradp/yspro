<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
	<head>
		<base target="_self">
		<title>设置密码保护</title>
		
		<meta http-equiv="Content-Type" content="text/html; charset=utf8">
		<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
		<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
		<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>

		<script language="JavaScript" type="text/JavaScript">
		detailPageStyle();
	
		$(document).ready(function(){
		});

		function submitForm(){
			if(document.getElementById("wtdaOne").value==""||document.getElementById("wtdaTwo").value==""||document.getElementById("mmbhwtOne").value==""||document.getElementById("mmbhwtTwo").value==""){
				alert("你还有选项没有填写,必须填写完才可提交");
				return;	
			}
			if(document.getElementById("mmbhwtOne").value==document.getElementById("mmbhwtTwo").value){
				alert("两个问题不能一样");
				return;
			}
			super_submitForm();
		}

		function doreset(){
			document.getElementById("wtdaOne").value="";
			document.getElementById("wtdaTwo").value="";
			document.getElementById("mmbhwtOne").value="";
			document.getElementById("mmbhwtTwo").value="";
		}
		
	</script>
	</head>
	<body>
		<s:if
			test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			<div id="SystemErrorMessage" style="top: 20px" align="center">
				<s:actionerror />
				<s:actionmessage />
				<s:fielderror />
			</div>
		</s:if>
		<s:form name="theform" method="post" theme="simple">
			<div align="center">

				<table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td>
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="200" height="34" class="wintitle_left">
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="60%">
													&nbsp;
													<b>&nbsp;&nbsp;设置密码保护</b>
												</td>
												<td width="40%">
													&nbsp;
												</td>
											</tr>
										</table>
									</td>
									<td height="34" class="wintitle_right">
										<table width="72" border="0" align="right" cellpadding="0"
											cellspacing="0">
											<tr>
												<td>
													&nbsp;
												</td>
												<td>
													&nbsp;
												</td>
												<td>
													&nbsp;
												</td>
												<td>
													&nbsp;
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td>

							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="winmain_left">


										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td width="7" rowspan="2"></td>
												<td
													style="background-color: #fff; border: 1px solid #d7d8d9">

													<table align="center" border="0" cellpadding="0"
														cellspacing="0">
														<tr>
															<td height="35" align="right" width="20%">
																&nbsp;用户名：
																<strong>&nbsp; </strong>
															</td>
															<td valign="middle">
																<INPUT type="text" value="${tsysUser.userLoginId}"
																	id="userName" name="tsysUser.userLoginId"
																	disabled="disabled" maxlength="30" size="41" />
															</td>
															<td width="5%"></td>
															<td align="left" valign="middle" style="color: #666666">当前登录的用户名</td>
														</tr>
														<tr>
															<td height="35" align="right" width="20%">
																密码保护问题一：
																<strong>&nbsp; </strong>
															</td>
															<td valign="middle">
																<s:select list="getSysCode('zhmm')" headerKey="" 
																	headerValue="------------请选择密码保护问题-----------"
																	listKey="id" listValue="caption" id="mmbhwtOne"
																	name="tsysUserZhmm.mmbhwtOne"></s:select>
																<font color="red">*</font>
															</td>
															<td width="5%"></td>
															<td align="left" valign="middle" style="color: #666666"><span id="s1">请选择密码保护问题</span></td>
														</tr>
														<tr>
															<td height="35" align="right" width="20%">
																问题一答案：
																<strong>&nbsp; </strong>
															</td>
															<td valign="middle">
																<INPUT type="text" value="<s:property value='%{tsysUserZhmm.wtdaOne}'/>" id="wtdaOne"
																	name="tsysUserZhmm.wtdaOne" maxlength="20" size="41" />
																<font color="red">*</font>
															</td>
															<td></td>
															<td valign="middle" style="color: #666666"><span id="s2">答案长度不得超过20个字(日期的格式为'1988-08-15')</span></td>
														</tr>
														<tr>
															<td height="35" align="right" width="20%">
																密码保护问题二：
																<strong>&nbsp; </strong>
															</td>
															<td valign="middle">
																<s:select list="getSysCode('zhmm')" headerKey=""
																	headerValue="------------请选择密码保护问题-----------"
																	listKey="id" listValue="caption" id="mmbhwtTwo"
																	name="tsysUserZhmm.mmbhwtTwo"></s:select>
																<font color="red">*</font>
															</td>
															<td width="5%"></td>
															<td align="left" valign="middle" style="color: #666666"><span id="s3">请选择密码保护问题</span></td>
														</tr>
														<tr>
															<td height="35" align="right" width="20%">
																问题二答案：
																<strong>&nbsp; </strong>
															</td>
															<td valign="middle">
																<INPUT type="text" value="<s:property value='%{tsysUserZhmm.wtdaTwo}'/>" id="wtdaTwo"
																	name="tsysUserZhmm.wtdaTwo" maxlength="20" size="41" />
																<font color="red">*</font>
															</td>
															<td></td>
															<td valign="middle" style="color: #666666"><span id="s4">答案长度不得超过20个字(日期的格式为'1988-08-15')</span></td>
														</tr>
														<tr>
															<td>
																&nbsp;
															</td>
															<td height="50" colspan="3" align="left">

																<ul class="btn_gn">
																	<li>
																		<a href="#" title="提交" onClick="submitForm()"><span>提交</span>
																		</a>
																	</li>
																	<li>
																		<a href="#" title="清除" onclick="doreset();"><span>清除</span>
																		</a>
																	</li>
																</ul>
															</td>
														</tr>
														<tr>
															<td height="165">
																&nbsp;
															</td>
														</tr>
													</table>
												</td>
											</tr>
											<tr>
												<td height="35">


												</td>
											</tr>
										</table>
									</td>
									<td width="7" class="winmain_right" style="width: 7px"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</s:form>
	</body>

</html>
