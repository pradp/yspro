<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<script language="JavaScript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
		<script language="JavaScript" src="<s:property value="basePath"/>/component/ymprompt/ymPrompt_source.js"></script>
		<script language="JavaScript" src="<s:property value="basePath"/>/resources/jquery/plugins/jquery.blockUI.js"></script>
		<script language="JavaScript" src="<s:property value="basePath"/>/resources/js/userlogin.js"></script>
		<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/resources/css/MemberLoginStyle.css">
		<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/ymprompt/skin/qq/ymPrompt.css">
<script type="text/javascript">

	window.onload = init;
	function init(){
		if(document.getElementById("userLoginId"))document.getElementById("userLoginId").focus();
	}
	function checkLoginForm(){
		var loginid = document.getElementById("userLoginId");
		var loginpwd = document.getElementById("userPawd");
		if (loginid.value.length<3||loginid.value.length>20){
			alert("请输入用户名,长度在3到20位。");
			loginid.focus();
			return false;
		}
		if(canstr(loginid)==false){
			alert("用户名含有非法字符!只能是字符 'a - z , A-Z' 数字 '0-9' 及 '_' 为有效字符。");
			return false;
		}
		if (loginpwd.value==""||loginpwd.value.length<2 || loginpwd.value.length>50){
			alert("请输入登录密码，长度为2-50位。");
			loginpwd.focus();
			return false;
		}
		if(canstr(loginpwd)==false){
			alert("密码含有非法字符!只能是字符 'a - z , A-Z' 数字 '0-9' 及 '_' 为有效字符。");
			return false;
		}
		document.getElementById("post").disabled="true";
		return true;
	}
	function canstr(str1){
		var str1;
		for (var i=0; i<str1.value.length;i++) {
			if (((str1.value.charAt(i)>='0')&&(str1.value.charAt(i)<='9'))||((str1.value.charAt(i)>='A')&&(str1.value.charAt(i)<='Z'))||((str1.value.charAt(i)>='a')&&(str1.value.charAt(i)<='z'))||(str1.value.charAt(i)=='_')) {
			} else{
				//alert("这里含有非法字符!只能是字符 'a - z , A-Z' 及 '_' 为有效字符。");
				str1.focus();
	   			return false;
			}
		}
		//return true;
	}
	function jump(uri){
		location.href=uri;
	}
	function changGreen(obj){
		obj.style.color="green";
	}
	function changBlack(obj){
		obj.style.color="black";
	}
	if (top.location !== self.location){
	    top.location = self.location;
	}
	var prevLoadImg = new Image();
	prevLoadImg.src="<s:property value="basePath"/>/resources/images/loading.gif";
	
		</script>
<!-- 右邊區域  开始-->
  <div id="silder" class="grid_4 omega" align="left">
  <s:if test="getUserLoginId() != null && getUserLoginId() != '' " >
  	<div id="histry" style="text-align: left;">
          <h2>本团今日比赛项目</h2>
          <s:if test="getTodayCsxm().size()>0">
          <marquee scrollAmount="2" width="220" height="160" onmouseover="stop()" onmouseout="start()"direction="up" scrollDelay="80">
          	<s:iterator value="getTodayCsxm()" status="i">
    		<s:set name="bean" value="todayCsxm[#i.index]" />
          	<ul>
          	<%
          	int i=0;
          	if(i%3==0){%><li><%}%>
          	<s:if test="#bean[3]==3">
          		<a href="../visitor/sportCjcxRc-input.c?cssS=5&scbm=<s:property value="#bean[2]" />&type=cj&paixu=0&xmmc=<s:property value="@java.net.URLEncoder@encode(#bean[0],'utf-8')" />&wid=&sfjtxm=<s:property value="#bean[4]" />&sfxnsc=<s:property value="#bean[5]" />&sfdzxm=<s:property value="#bean[6]" />&totalXm=<s:property value="@java.net.URLEncoder@encode(#bean[7],'utf-8')" />" title="<s:property value="#bean[1]"/>">&nbsp;
          	【<s:property value="#bean[0]"/>】  <s:property value="#bean[1]"/>&nbsp;</a>
          	</s:if>
          	<s:else>
          		<a href="../visitor/sportCjcxRc-input.c?cssS=5&scbm=<s:property value="#bean[2]" />&type=md&paixu=0&xmmc=<s:property value="@java.net.URLEncoder@encode(#bean[0],'utf-8')" />&wid=&sfjtxm=<s:property value="#bean[4]" />&sfxnsc=<s:property value="#bean[5]" />&sfdzxm=<s:property value="#bean[6]" />&totalXm=<s:property value="@java.net.URLEncoder@encode(#bean[7],'utf-8')" />" title="<s:property value="#bean[1]"/>">&nbsp;
          	【<s:property value="#bean[0]"/>】  <s:property value="#bean[1]"/>&nbsp;</a>
          	</s:else>
          	
          	<%if(i%3==0){%></li>
          	<%
          	}
          	i++; 
          	%>
          	</ul>
          </s:iterator>
          </marquee>
          </s:if>
          <s:else>
			&nbsp;&nbsp;&nbsp;&nbsp;今日无参赛项目
          	<br />
          	<br />
          </s:else>
      </div><%--
      <div id="histry" style="text-align: left;">
          <h2>本团历史战绩</h2>
          <s:iterator value="getHistoryGamesLogined()"></s:iterator>
          <s:iterator value="#dates" status="i"><span><s:property value="%{#dates[#i.index]}" /></span><ul><s:iterator value="#loginedHistoryGames" status="st"><s:if test="#loginedHistoryGames[#st.index][3]==#dates[#i.index]"><li>
          	<div style="cursor: pointer; color: black; font-size: 12px; font-weight: normal" onmousemove="changGreen(this)" onmouseout="changBlack(this)" 
          	onclick="jump('../visitor/sportCjcxRc-input.c?scbm=<s:property value="#loginedHistoryGames[#st.index][0]" />&type=cj&xmmc=<s:property value="@java.net.URLEncoder@encode(#loginedHistoryGames[#st.index][1],'utf-8')" />&wid=&sfdzxm=<s:property value="#loginedHistoryGames[#st.index][5]" />')">
          	【<s:property value="#loginedHistoryGames[#st.index][1]"/>】
          	<s:if test="#loginedHistoryGames[#st.index][2].toString().length()<5" ><s:property value="#loginedHistoryGames[#st.index][2]"/>|</s:if>
          	<s:else><s:property value="#loginedHistoryGames[#st.index][2].toString().substring(0,3)"/>...| </s:else><s:property value="#loginedHistoryGames[#st.index][4].toString().replaceAll('市', '')"/>
          	</div></li>
          	</s:if></s:iterator></ul></s:iterator>
      </div>
  --%></s:if>
  <s:else>
	<s:form id="userloginForm" name="userloginForm" theme="simple" action="login" namespace="/identity" method="post" onsubmit="return checkLoginForm()">
      <div id="login" >
          <h2>代表团登录</h2>
          <span class="rp_membrpwd" >用户名：</span>
          <s:textfield id="userLoginId" name="tsysUser.userLoginId" cssClass="rp_usrip1" maxLength="50" cssStyle="ime-mode:disabled" /> 
          <span class="rp_membrpwd2" >密码：</span>
          <s:password id="userPawd" name="tsysUser.userPwd" cssClass="rp_usrip2" maxLength="50" cssStyle="ime-mode:disabled" />
          <span class="rp_membrpwd3" >验证码：</span>
         <s:textfield id="u_v_i_c" size="3" name="u_v_i_c" cssClass="rp_pwdrip"  maxLength="10" cssStyle="ime-mode:disabled" onkeydown="return ys_onkeydown(2,event);" />
          <a href="#" class="rp_login"><img id="img_u_v_i_c" src="../generateImage/u_v_i_c" onclick="changeUVIC()" style="cursor:pointer;padding-left: 1px;padding-right: 1px;" height="18" title="点击更换验证码" /></a>
         <a href="#" class="rp_login"><img onclick="dologin()" src="<s:property value='basePath'/>/resources/images/pages/login.png" width="39" height="19"  /></a>
      </div>
    </s:form>
	<div id="SystemResMsg"  style="color:red">
		<s:actionerror theme="simple"/>
		<s:actionmessage theme="simple"/>
		<s:fielderror theme="simple"/>
	</div>
  </s:else>
       <div id="histry" style="text-align: left;">
          <h2>已结束最近四项比赛</h2>
          <s:iterator value="getHistoryGames()" status="i">
    		<s:set name="bean" value="historyGames[#i.index]" />
          <span><s:property value="%{#bean[2]}" /></span>
          	<ul>
          	<%
          	int i=0;
          	if(i%3==0){%><li><%}%>
          	<a href="../visitor/sportCjcxRc-list.c?dxmmc=<s:property value="@java.net.URLEncoder@encode(#bean[0],'utf-8')" />&paixu=0&bssj=<s:property value='#bean[2]' />&cssS=5" title="<s:property value="#bean[0]"/>">&nbsp;
          	【<s:property value="#bean[0]"/>】  <s:property value="#bean[1]"/>&nbsp;项</a>
          	<%if(i%3==0){%></li>
          	<%
          	}
          	i++; 
          	%>
          	</ul>
          </s:iterator>
      </div>
      
  </div>
  <!-- 右邊區域  结束-->
