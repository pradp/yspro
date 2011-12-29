<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.yszoe.identity.entity.TSysUser"%>
<%@ page import="com.yszoe.identity.entity.TSysDepart"%>
<%@ page import="com.yszoe.identity.IdConstants"%>
<%
//单独页面，不加入缓存
TSysUser user = (TSysUser)session.getAttribute(IdConstants.SESSION_USER);
String user_loginid = user!=null?user.getUserloginid():"";
String user_name = user!=null?user.getDepart().getDepartname():"";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><fmt:message key="application_name" /> </title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=7" />
		<link type="text/css" rel="stylesheet" href="faceui/css/layout.css" />
		<script type="text/javascript" src="resources/jquery/jquery-1.6.4.min.js"></script>
		<script type="text/javascript" src="faceui/js/common.js"></script>
	</head>

	<body style="background-color: #FFFFFF">

						<table width="100%" border="0" cellspacing="0"
							cellpadding="0" id="drh_table" style="display: none">
							<tr height="10px"></tr>
							<tr height="25px">
								<td align="right" width="35%">欢&nbsp;&nbsp;&nbsp;迎：</td>
								<td align="left" width="65%" id="login_id1"><%=user_loginid%></td>
							</tr>
							<tr height="25px">
								<td align="right">单&nbsp;&nbsp;&nbsp;位：</td>
								<td align="left" id="login_id2"><%=user_name%></td>
							</tr>
							<tr height="10px"></tr>
							<tr>
								<td align="center" colspan="2">
									<button class="button" type="button" onclick="top.window.location='./identity/index.action'"><span>进入系统</span></button>
									&nbsp;&nbsp;									
									<button class="button" type="button" onclick="execLogout();"><span>退&nbsp;&nbsp;&nbsp;出</span></button>
								</td>
							</tr>
						</table>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" id="drq_table">
				<form id="userloginForm" name="userloginForm" action="" method="post" class="login_form">
							<tr height="10px"></tr>
							<tr height="25px">
								<td align="right" nowrap="nowrap" width="35%">用户名：</td>
								<td align="left" width="65%">
									<input type="text" name="tsysUser.userloginid" id="userloginid" style="width: 100px" onkeydown="enterkey(event,this)"/>
								</td>
							</tr>
							<tr height="25px">
								<td align="right" nowrap="nowrap">
									密&nbsp;&nbsp;&nbsp;码：</td>
								<td align="left">
									<input type="password" name="tsysUser.userpwd" id="userpwd" 
									 style="ime-mode:disabled;width: 100px" onkeydown="enterkey(event,this)"/>
								</td>
							</tr>
							<tr height="18px">
								<td colspan="2" align="center"><font color="red"><span id="msg_id"></span></font></td>
							</tr>
							<tr>
								<td align="center" colspan="2" id="button_td">
									<button class="button" type="button" onclick="dologin();"><span>登&nbsp;&nbsp;&nbsp;录</span></button>
									&nbsp;&nbsp;									
									<button class="button" type="button" onclick="parent.window.location='public/zxqcSqxx-input.action'"><span>注&nbsp;&nbsp;&nbsp;册</span></button>
								</td>
							</tr>
					</form>
						</table>
						<script type="text/javascript">
							$(function(){
								var user_loginid = '<%=user_loginid%>';
								if(user_loginid!=''){
									$('#drh_table').show();
									$('#drq_table').hide();
								}
								//输入密码后回车直接登录
								$("#userpwd").keydown(function(){
								});
								$(".button").css({
									"width":"72px","height":"25px",
									"background-image":"url('faceui/images/button_bg.gif')",
									"border": "0px solid #83B1F2","color":"#0B56A0","font-size":"12px","cursor":"pointer"});
							})
							function enterkey(eventObj,obj){
								if(!$.browser.mozilla){ //火狐不支持event.keyCode
									if (event.keyCode == 13){ 
							           event.keyCode = 9;
							           event.returnValue = false;
							           if($(obj).attr("type")=='text'){
							        	   $("#userpwd").focus();
							           }else{
							           	   dologin();
							           }
							        }
								}else{
									if (eventObj.which == 13){ 
							           eventObj.keyCode = 9;
							           eventObj.returnValue = false;
							           if($(obj).attr("type")=='text'){
							        	   $("#userpwd").focus();
							           }else{
							           	   dologin();
							           }
							        }
								}
							}
							function execLogout(){
								//项目集成DHI系统，所以这里登出两个平台。
								//$.getJSON(dhiurl);
								//Dialog.open({URL:dhiurl, Title:"退出DHI", Modal:false});
								var drh_table = $("#drh_table").html();
								var span = '<span><img src="resources/images/loading.gif" /> 处理中...</span>';
								$('#drh_table button').parent().html(span);
								$.post('ajaxLogin?act=logout',function(data){
									var jsonarray = eval("("+data+")");
									var obj = jsonarray;
									if(obj.msg == 'ok'){
										$("#drh_table").html(drh_table);
										$('#drh_table').hide();
										$('#drq_table').show();
										$('#msg_id').html("");
										$('#userloginid').val('');
										$('#userpwd').val('');
									}else{
										$("#drh_table").html(drh_table);
										$('#msg_id').html(obj.msg);
									}
								});
							}
							function dologin(){
								$('#msg_id').html("");
								var button_td = $("#button_td").html();
								var span = '<span><img src="resources/images/loading.gif" /> 处理中...</span>';
								$('#button_td').html(span);
								var userloginid = $('#userloginid').val();
								var userpwd = $('#userpwd').val();
								$.post('ajaxLogin?act=login', {yonghu : userloginid,mima: userpwd}, function(data) {
									var jsonarray = eval("("+data+")");
									var obj = jsonarray;
									if(obj.msg == 'ok'){
										$('#drh_table').show();
										$("#button_td").html(button_td);
										$('#login_id1').html(userloginid);
										$('#login_id2').html(obj.userdepart);
										$('#drq_table').hide();
									}else{
										$("#button_td").html(button_td);
										$('#msg_id').html(obj.msg);
									}
								});
							}
						</script>
	</body>
	</html>