var compnent_list = new Array("userLoginId", "userPawd", "u_v_i_c", "postButton");
$(document).ready(function(){
    document.getElementById("userLoginId").focus();
    
});
function ys_onkeydown(num, event){
    if (num == 2 && event.keyCode == 13) {//验证码那里输入回车
        dologin();
    }
    else {
        return compnent_onkeydown(num, event);
    }
}

function dologin(){
    var userLoginId = $("#userLoginId").val();
    var userPawd = $("#userPawd").val();
    var u_v_i_c = $("#u_v_i_c").val();
    if (userLoginId == "") {
        alert("请输入用户登录账号！");
        document.getElementById("userLoginId").focus();
        return false;
    }
    if (isContainChinese(userLoginId)) {
        alert("用户登录账号不接受中文！");
        document.getElementById("userLoginId").focus();
        return false;
    }
    if( getLength(userLoginId)>50 ){
	  alert("用户登录账号长度不能超过50！");
	  document.getElementById("userLoginId").focus();
	  return false;
    }
    if (userPawd == "") {
        alert("请输入用户登录密码！");
        document.getElementById("userPawd").focus();
        return false;
    }
    if( getLength(userPawd)>50 ){
	  alert("用户登录密码长度不能超过50！");
	  document.getElementById("userPawd").focus();
	  return false;
    }
    if (u_v_i_c == "") {
        alert("请输入验证码！");
        document.getElementById("u_v_i_c").focus();
        return false;
    }
    if (isContainChinese(u_v_i_c)) {
        alert("验证码不接受中文！");
        document.getElementById("u_v_i_c").focus();
        return false;
    }
    $.blockUI(YSprogressBlockUI());
//    checkUserInSession(userLoginId);
    executeLogin();
    
}

function checkUserInSession(userLoginId){

    var handler = function(clicked){
        if (clicked == "ok") {
            $.blockUI(YSprogressBlockUI());
            executeLogin();
            //document.forms[0].submit();
        }
    }
    var ajaxLoginError = function(XMLHttpRequest, textStatus, errorThrown){
        if (textStatus == "timeout") {
            $.unblockUI();
            var say = "操作超时！<br/><br/>原因可能是目前在线人数超载，请稍候再来尝试！";
            ymPrompt.alert(say, 370, 180, '系统信息', null, '#666666', 0.5);
        }
    }
    var handleResponse = function(data){
        if (data.indexOf("true") != -1) {
            $.unblockUI();
            var say = "另一用户已使用此账号登录！<br/><br/>如果要继续登录（另一用户会退出，可能会造成他操作的数据不完整！），请点击确定。<br/><br/>放弃用此账户登录，请点击取消。";
            ymPrompt.confirmInfo(say, 320, 200, '系统信息', handler, '#666666', 0.5);
            
        }
        else {
//            document.forms[0].submit();
            executeLogin();
        }
    }
    $.ajax({
        url: "checkUserInSession.jsp",
        data: "userLoginId=" + userLoginId + "&" + (new Date()).getTime(),
        timeout: 1000 * 30,
        error: ajaxLoginError,
        success: handleResponse
    });
}

function executeLogin(){
    var url = document.forms["userloginForm"].action;
    var ajaxLoginError = function(XMLHttpRequest, textStatus, errorThrown){
        if (textStatus == "timeout") {
            $.unblockUI();
            var say = "操作超时！<br/><br/>原因可能是目前在线人数超载，请稍候再来尝试！";
            ymPrompt.alert(say, 370, 180, '系统信息', null, '#666666', 0.5);
        }
    }
    var handleResponse = function(data){
        if (data.indexOf("开启菜单栏") != -1) {
            //登录成功
            window.location.href = "../../identity/index.c";
        }else{
        	var say = $(data).find("#SystemResMsg").text();
            if(say=="" ){
            	//say = "一些未知原因导致登录失败，请联系管理员解决此问题！";
            	window.location.href = "../identity/index.c";
            	return;
            }
            if(say=="内容"){
            	//say = "一些未知原因导致登录失败，请重新开启游览器窗口登录系统！";
            	window.location.href = "../identity/index.c";
            	return;
            }
            say = "<p/>"+say;
            $.unblockUI();
            ymPrompt.errorInfo(say, 300, 160, '系统信息', null, '#666666', 0.5);
	  }
    }
    $.ajax({
        url: url,
        type: "POST",
        data: $("input").serialize(),
        timeout: 1000 * 60,
        error: ajaxLoginError,
        success: handleResponse
    });
}

function deleteSpace(){
    var user = document.getElementById("userLoginId").value;
    document.getElementById("userLoginId").value = $.trim(user);
}

function changeUVIC(){
    var url = "../generateImage/u_v_i_c?" + new Date().getTime();
    document.getElementById("img_u_v_i_c").src = url;
    document.getElementById("u_v_i_c").value = "";
    document.getElementById("u_v_i_c").focus();
}
