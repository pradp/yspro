<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<title><s:text name="login.name" /></title>

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<SCRIPT language="JavaScript" src="../resources/jquery/jquery-1.6.4.min.js"></SCRIPT>
		<SCRIPT language="JavaScript" src="../resources/jquery/plugins/jquery.smart3d.js"></SCRIPT>
		<link href="../resources/css/login8reg.css" rel="stylesheet" type="text/css" />
		<SCRIPT language="JavaScript">
var basePath = '${basePath }';
var prevLoadImg = new Image();
prevLoadImg.src="../resources/images/loading.gif";
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
        
	    var url_tz = "../ajaxLogin?act=login";
	    
	    $("#postButtonDiv").hide();
	    $("#postButtonWait").show();

	    $.post(url_tz, {yonghu: userLoginId, mima: userPawd}, function(data){
	    	data = eval("("+data+")");
	    	if(data.msg=='ok'){
	    		if(data.userdepartid=='000'){//admin
	    			window.location.href = '../identity/index.action';
	    		}else{
	    			window.location.href = '../usercenter/index.action';
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
<%-- 引入页头文件 start --%>
<%@include file="../../cms/public/common/head.jsp" %>
<%-- 引入页头文件 end --%>
<br/>
    <div class="clear">&nbsp;</div>
    <div class="" align="center">
		<s:form id="userloginForm" name="userloginForm" theme="simple" action="login" namespace="/identity" method="post">

    		<div id="login-left">
    		<ul id="smartdemo2" style="float:right">
	            <li><img src="../resources/css/img/loginback.jpg" /></li>
	            <li><img src="../resources/css/img/loginback.jpg" /></li>
	            <li><img src="../resources/css/img/loginback.jpg" /></li>
	            <li><img src="../resources/css/img/loginback.jpg" /></li>
	            <li><img src="../resources/css/img/loginback.jpg" /></li>
	        </ul>
	        </div>
    		<div id="login_form">
    					<table border="0" cellspacing="0" cellpadding="0" class="form-table">
    								<tr>
    									<td width="64" valign="middle">用户名</td>
    									<td width="170">
    										<s:textfield tabindex="1" id="yh"
																name="yonghu" cssClass="login" size="30"
																maxLength="50" cssStyle="ime-mode:disabled"
																onblur="deleteSpace()" onkeydown="enterkey(event,this)"
																 />
									</td>

    								</tr>
    								<tr>
    									<td valign="middle">密　码</td>
    									<td>
    										<s:password tabindex="2" id="mm"
																name="mima" cssClass="login" size="30"
																maxLength="50" cssStyle="ime-mode:disabled"
																 onkeydown="enterkey(event,this)"/>
										</td>
    								</tr>
    								<tr>
    									<td>&nbsp;</td>
    									<td>
    										<span id="postButtonDiv"><input id="postButton" tabindex="3" class="btn-login" onclick="doajaxlogin()" value="登 入" type="button"/>
    										</span>
    										<span id="postButtonWait" style="display:none"><img src="../resources/images/loading.gif" /> 处理中，请稍候......&nbsp;&nbsp;&nbsp;</span>
    									</td>
    								</tr>
    								<tr>
    									<td>&nbsp;</td>
    									<td>
    										<p class="to-register">
    											还没有种畜禽场的帐户？<br />
    											现在就&nbsp;<a href="../public/zxqcSqxx-input.action">创建一个帐户</a>
    										</p>
    									</td>
    								</tr>
    					</table>
     		</div>
		</s:form>
    </div>
    <!-- end maincontant -->
<%-- 引入页脚文件 start --%>
    <div align="center"><%@include file="../../cms/public/common/foot.jsp" %>
<%-- 引入页脚文件 end --%>
  	<div class="clear">&nbsp;</div>

	</body>
</html>
