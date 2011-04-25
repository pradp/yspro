<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title><s:text name="login.name" /></title>

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link rel="stylesheet" type="text/css" href="./resources/css/MemberLoginStyle.css">
		<link rel="stylesheet" type="text/css" href="./component/ymprompt/skin/qq/ymPrompt.css">
		<script language="JavaScript" src="./resources/js/common/myutil.js"></script>
		<script language="JavaScript" src="./component/ymprompt/ymPrompt_source.js"></script>
		<SCRIPT language="JavaScript" src="./resources/jquery/jquery-1.2.6.pack.js"></SCRIPT>
		<script language="JavaScript" src="./resources/jquery/plugins/jquery.blockUI.js"></script>
		<script language="JavaScript" src="./resources/js/userlogin.js"></script>
		<SCRIPT language="JavaScript">
var basePath = "<%=basePath%>";//need
if (top.location !== self.location){
    top.location = self.location;
}
var prevLoadImg = new Image();
prevLoadImg.src="resources/images/loading.gif";
	</SCRIPT>
	<style type="text/css">
body {
	margin:0;
	padding:0;
	background-color: #030406;
	font-size: 12px;
}
#main {
	font-size: 12px;
	background-image: url(resources/images/login/loginbg.jpg);
	background-repeat: no-repeat;
	background-position: left top;
	height: 704px;
}
.STYLE1 {
	color: #3E95CA;
	font-size: 9pt;
}
	</style>
	</head>

	<body>
		<s:form id="userloginForm" name="userloginForm" theme="simple" action="login" namespace="/identity" method="post">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="100%" height="100%" align="center" valign="middle">
						<table width="1024" border="0" align="center" cellpadding="0"
							cellspacing="0" id="main">
							<tr>
								<td valign="top">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="283" colspan="2">
												&nbsp;
											</td>
										</tr>
										<tr>
											<td width="560" height="192" valign="top">
												&nbsp;
											</td>
											<td valign="top">
												<table width="309" border="0" cellspacing="3"
													cellpadding="0">
													<tr>
														<td width="85">
															&nbsp;
														</td>
														<td width="117">
															&nbsp;
														</td>
														<td width="101">
															&nbsp;
														</td>
													</tr>
													<tr>
														<td colspan="3">
															<table width="309" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="21">
																		&nbsp;
																	</td>
																	<td width="288">
																		欢迎使用学生资助管理系统
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td height="43">
															&nbsp;
														</td>
														<td>
															&nbsp;
														</td>
													</tr>
													<tr>
														<td height="27">
															<div align="right">
																用户名：
															</div>
														</td>
														<td height="27">
															<s:textfield tabindex="1" id="userLoginId"
																name="tsysUser.userLoginId" cssClass="login" size="15"
																maxLength="50" cssStyle="ime-mode:disabled"
																onblur="deleteSpace()"
																onkeydown="return ys_onkeydown(0,event);" />
														</td>
														<td rowspan="2">
															<table width="77" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="22">
																		&nbsp;
																	</td>
																	<td width="89">
																		<img id="postButton"
																			onclick="dologin()" style="cursor:pointer"
																			src="resources/images/login/login.png" alt="登入"
																			width="56" height="56" />
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td height="27">
															<div align="right">
																密码：
															</div>
														</td>
														<td height="27">
														<table width="100%" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="50"><s:password tabindex="2" id="userPawd"
																name="tsysUser.userPwd" cssClass="login" size="4"
																maxLength="50" cssStyle="ime-mode:disabled"
																onkeydown="return ys_onkeydown(1,event)" /></td>
																	<td width="50"><a href="xzmm.jsp" ><font color="black" style="text-decoration: none">忘记密码</font></a></td>
																</tr>
														</table>
															
														</td>
													</tr>
													<tr>
														<td height="27">
															<div align="right">
																验证码：
															</div>
														</td>
														<td height="27" colspan="2">
															<table width="100%" border="0" cellspacing="0"
																cellpadding="0">
																<tr>
																	<td width="50">
																		<s:textfield tabindex="3" id="u_v_i_c" name="u_v_i_c"
																			cssClass="login" size="4" maxLength="10"
																			cssStyle="ime-mode:disabled"
																			onkeydown="return ys_onkeydown(2,event);" />
																	</td>
																	<td width="44" id="td_img_u_v_i_c">
																		<img id="img_u_v_i_c" src="generateImage/u_v_i_c" />
																	</td>
																	<td width="90">
																		<img onclick="changeUVIC()" style="cursor:pointer"
																			src="resources/images/login/change.png" alt="换一个验证码？"
																			width="76" height="27" />
																	</td>
																</tr>
															</table>
														</td>
													</tr>
												</table>
											</td>
										</tr>
										<tr valign="bottom">
											<td height="42">
											</td>
											<td align="left" style="color:red" id="SystemResMsg">
												<s:actionerror theme="simple"/>
												<s:actionmessage theme="simple"/>
												<s:fielderror theme="simple"/>
											</td>
										</tr>
										<tr>
											<td height="120" colspan="2" align="center" valign="bottom">
												<span class="STYLE1">Copyright ©2008-2012 南京君度科技有限公司</span>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</s:form>
	</body>
</html>
