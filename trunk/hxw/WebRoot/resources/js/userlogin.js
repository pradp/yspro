//var compnent_list = new Array("userLoginId", "userPawd", "u_v_i_c", "postButton");
var compnent_list = new Array("userLoginId", "userPawd", "postButton");
$(document).ready(function(){
    document.getElementById("userLoginId").focus();
    
});

function dologin(){
    var userLoginId = $("#userLoginId").val();
    var userPawd = $("#userPawd").val();
    var u_v_i_c = "test";
    if(document.getElementById("u_v_i_c")){
    	u_v_i_c = $("#u_v_i_c").val();
    }
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
    return true;
    
}

function deleteSpace(){
    var user = document.getElementById("userLoginId").value;
    document.getElementById("userLoginId").value = $.trim(user);
}
