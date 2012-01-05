<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.yszoe.identity.entity.TSysUser"%>
<%@ page import="com.yszoe.identity.IdConstants"%>
<%
//单独页面，不加入缓存
TSysUser user = (TSysUser)session.getAttribute(IdConstants.SESSION_USER);
String usertype = user!=null?user.getUsertype():"";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<title>用户登录</title>

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<SCRIPT language="JavaScript" src="resources/jquery/jquery-1.6.4.min.js"></SCRIPT>
		<SCRIPT language="JavaScript" src="resources/jquery/plugins/jquery.smart3d.js"></SCRIPT>
		<link href="resources/css/login8reg.css" rel="stylesheet" type="text/css" />
		<SCRIPT language="JavaScript">
		var prevLoadImg = new Image();
		prevLoadImg.src="resources/images/loading.gif";
		$(document).ready(function() {
		    $('#smartdemo2').smart3d({
								invertHorizontal: true, 
								invertVertical: true
							});
			
		});
		function doajaxlogin(){
		    var userLoginId = document.getElementById('yh').value;
		    var userPawd = document.getElementById('mm').value;
		    if (userLoginId == "") {
		        alert("请输入用户登录账号！");
		        document.getElementById('yh').focus();
		        return false;
		    }
		    if (isContainChinese(userLoginId)) {
		        alert("用户登录账号不接受中文！");
		        document.getElementById('yh').focus();
		        return false;
		    }
		    if( userLoginId.length<3 ){
			  alert("用户登录账号长度不能小于3！");
			  document.getElementById('yh').focus();
			  return false;
		    }
		    if( userLoginId.length>20 ){
			  alert("用户登录账号长度不能超过20！");
			  document.getElementById('yh').focus();
			  return false;
		    }
		    if (userPawd == "") {
		        alert("请输入登录密码！");
		        document.getElementById('mm').focus();
		        return false;
		    }
		    if( userPawd.length<3 ){
		    	  alert("用户登录密码长度不能小于3！");
			  document.getElementById('mm').focus();
			  return false;
		    }
		    if( userPawd.length>20 ){
			  alert("用户登录密码长度不能超过20！");
			  document.getElementById('mm').focus();
			  return false;
		    }
	        
		    var url_tz = "ajaxLogin?act=login";
		    
		    $("#postButtonDiv").hide();
		    $("#postButtonWait").show();
		    $.post(url_tz, {yonghu: userLoginId, mima: userPawd}, function(data){
		    	data = eval("("+data+")");
		    	if(data.msg=='ok'){
		    		if(data.usertype != '0'){
		    			window.location.href = 'identity/index.action';
		    		}else{
		    			window.location.href = 'memberInfo/192222.jhtm';
		    		}
			    }else{
			    	$("#postButtonDiv").show();
		            $("#postButtonWait").hide();
				    alert(data.msg);
				}
			});
		}
	 
		/** 转码检验字符串中是否包含中文 */
		function isContainChinese(str){
			if(!str){ //如果 str 为空则直接返回 false
			    return false;
			}
			if(escape(str).indexOf("%u") != -1){
			    // 包含有中文
			    return true;
			}else{
			    // 没有中文
			    return false;
			}
		}
		function deleteSpace(){
	    var user = document.getElementById("yh").value;
	    document.getElementById("yh").value = $.trim(user);
	}
		/**
		 * 输入用户名后回车跳转到密码栏，输入密码后回车直接登录
		 * @param {Object} eventObj
		 * @param {Object} obj 用户名或密码栏
		 */
		function enterkey(eventObj,obj){
			if(!$.browser.mozilla){ //火狐不支持event.keyCode
			if (event.keyCode == 13){ 
			    event.keyCode = 9;
			    event.returnValue = false;
				if($(obj).attr("type")=='text'){
					$("#mm").focus();
				}else{
					doajaxlogin();
				}
			}
			}else{
				if (eventObj.which == 13){ 
				eventObj.keyCode = 9;
			    eventObj.returnValue = false;
				if($(obj).attr("type")=='text'){
					$("#mm").focus();
				}else{
					doajaxlogin();
				}
			 }
			}
		}
		</SCRIPT>
	</head>
	<body>
		<div class="">
			<link type="text/css" rel="stylesheet" href="faceui/css/front.css" />
			<link type="text/css" rel="stylesheet" href="faceui/css/layout.css" />
			<script type="text/javascript" src="faceui/js/common.js"></script>
			<style>
			<!--
			#headmenu li {
				list-style: none;
				float: left;
			}
			
			#headmenu li a {
				display: block;
				margin: 8px 1px 0 4px;
				padding: 4px 8px;
				width: 65px;
				color: #FFF;
				font-weight: bold;
				text-align: center;
				text-decoration: none
			}
			
			#headmenu li a:hover {
				background: #F5F5F5;
				color: #FD9305;
			}
			
			#headmenu div {
				position: absolute;
				visibility: hidden;
				margin: 0;
				padding: 0;
			}
			
			#headmenu div a {
				width: 65px;
				position: relative;
				display: block;
				margin: 0 1px 0 4px;
				padding: 7px 8px 3px 8px;
				white-space: nowrap;
				text-align: center;
				text-decoration: none;
				background: #f5f5f5;
				color: #FD9305;
			}
			
			#headmenu div a:hover {
				background: #F8AD13;
				color: #FFF
			}
			-->
			</style>
			<script type="text/javascript">
			<!--
			var timeout	= 500;
			var closetimer	= 0;
			var ddmenuitem	= 0;
			// open hidden layer
			function mopen(id){	
				// cancel close timer
				mcancelclosetime();
				// close old layer
				if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
				// get new layer and show it
				ddmenuitem = document.getElementById(id);
				ddmenuitem.style.visibility = 'visible';
			}
			// close showed layer
			function mclose(){
				if(ddmenuitem) ddmenuitem.style.visibility = 'hidden';
			}
			// go close timer
			function mclosetime(){
				closetimer = window.setTimeout(mclose, timeout);
			}
			// cancel close timer
			function mcancelclosetime(){
				if(closetimer){
					window.clearTimeout(closetimer);
					closetimer = null;
				}
			}
			 
			// close layer when click-out
			document.onclick = mclose; 
			//-->
			</script>
			<div id="header" class="box">
				<div id="logo" class="page box">
					<div class="">
						<img src="faceui/images/logo.gif" border="0" width="960" />
					</div>
				</div>

				<div id="menu" class="page box relative" align="center">
					<ul id="headmenu">
						<li class="menu_first">
							<a href="../index.jsp" id="index"><span>首 页</span> </a>
						</li>
						<li>
							<a href="../public/takeiteasy.jhtm" id="xlzx"><span>心理咨询</span>
							</a>
						</li>
						<li>
							<a href="../public/dosamething.jhtm" id="xlcs"><span>心理测试</span>
							</a>
						</li>

						<li>
							<a href="../channel/zhzx.jhtm" id="zhzx"
								onmouseover="mopen('mzhzx')" onmouseout="mclosetime()"><span>综合资讯</span>
							</a>
							<div id="mzhzx" onmouseover="mcancelclosetime()"
								onmouseout="mclosetime()">

								<a href="../channel/hydt.jhtm">行业动态</a>

								<a href="../channel/zcfg.jhtm">政策法规</a>

								<a href="../channel/gfbz.jhtm">心理新闻</a>

								<a href="../channel/wzgg.jhtm">网站公告</a>

							</div>
						</li>

						<li>
							<a href="../channel/xlxw.jhtm" id="xlxw"
								onmouseover="mopen('mxlxw')" onmouseout="mclosetime()"><span>咨询师</span>
							</a>
							<div id="mxlxw" onmouseover="mcancelclosetime()"
								onmouseout="mclosetime()">

							</div>
						</li>

						<li>
							<a href="../channel/hdxz.jhtm" id="hdxz"
								onmouseover="mopen('mhdxz')" onmouseout="mclosetime()"><span>活动小组</span>
							</a>
							<div id="mhdxz" onmouseover="mcancelclosetime()"
								onmouseout="mclosetime()">

								<a href="../channel/rxaxz.jhtm">乳腺癌小组</a>

								<a href="../channel/zwczxz.jhtm">自我成长组</a>

								<a href="../channel/bxbxz.jhtm">白血病小组</a>

							</div>
						</li>

						<li>
							<a href="../channel/xlwk.jhtm" id="xlwk"
								onmouseover="mopen('mxlwk')" onmouseout="mclosetime()"><span>心理文库</span>
							</a>
							<div id="mxlwk" onmouseover="mcancelclosetime()"
								onmouseout="mclosetime()">

							</div>
						</li>

						<li>
							<a href="../public/xlyp.jhtm" id="xlyp"><span>心理研培</span> </a>
						</li>
						<li>
							<a href="../bbs" id="bbs"><span>互助论坛</span> </a>
						</li>
					</ul>
				</div>

			</div>


			<br />
			<div class="clear">
				&nbsp;
			</div>
			<div class="" align="center">
				<form id="userloginForm" name="userloginForm"
					action="/hxw/identity/login.action" method="post">

					<div id="login-left">
						<ul id="smartdemo2" style="float: right">
							<li>
								<img src="resources/css/img/loginback.jpg" />
							</li>
							<li>
								<img src="resources/css/img/loginback.jpg" />
							</li>
							<li>
								<img src="resources/css/img/loginback.jpg" />
							</li>
							<li>
								<img src="resources/css/img/loginback.jpg" />
							</li>
							<li>
								<img src="resources/css/img/loginback.jpg" />
							</li>
						</ul>
					</div>
					<div id="login_form">
						<table border="0" cellspacing="0" cellpadding="0"
							class="form-table">
							<tr>
								<td width="64" valign="middle">
									用户名
								</td>
								<td width="170">
									<input type="text" name="yonghu" size="30" maxlength="50"
										value="" tabindex="1" id="yh" class="login"
										style="ime-mode: disabled" onblur="deleteSpace()"
										onkeydown="enterkey(event,this)" />

								</td>

							</tr>
							<tr>
								<td valign="middle">
									密 码
								</td>
								<td>
									<input type="password" name="mima" size="30" maxlength="50"
										tabindex="2" id="mm" class="login" style="ime-mode: disabled"
										onkeydown="enterkey(event,this)" />
								</td>
							</tr>
							<tr>
								<td>
									&nbsp;
								</td>
								<td>
									<span id="postButtonDiv"><input id="postButton"
											tabindex="3" class="btn-login" onclick="doajaxlogin()"
											value="登 入" type="button" /> </span>
									<span id="postButtonWait" style="display: none"><img
											src="resources/images/loading.gif" />
										处理中，请稍候......&nbsp;&nbsp;&nbsp;</span>
								</td>
							</tr>
							<tr>
								<td>
									&nbsp;
								</td>
								<td>
									<p class="to-register">
										还没有的帐户？
										<br />
										现在就&nbsp;
										<a href="public/zxqcSqxx-input.action">创建一个帐户</a>
									</p>
								</td>
							</tr>
						</table>
					</div>
				</form>




			</div>
			<!-- end maincontant -->

			<div align="center">

				<img src="../faceui/images/index_90.jpg" border="0" height="6"
					width="960" />
				<!--footer_begin-->
				<div class="footer page2">
					版权所有 北京市畜牧兽医总站 ©2011
					<br />

					电话：010-84929056&nbsp;&nbsp;&nbsp;84929053 地址：北京市朝阳区安外北宛路甲15号
					邮编100107
					<br>
						技术支持：<a target="_blank" href="http://www.njfstech.com">南京丰顿科技有限公司</a>
						电话：025-86983857 
				</div>
				<!--footer_end-->



				<div class="clear">
					&nbsp;
				</div>
	</body>
</html>

