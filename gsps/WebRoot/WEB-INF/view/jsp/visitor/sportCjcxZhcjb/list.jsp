<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="author" content="" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="robots" content="all" />
	<title>江苏省第十七届运动会综合成绩榜</title>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/960.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/reset.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/text.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/main.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/saicheng.css" type="text/css" media="all" />
	<script type="text/javascript">
	listPageStyle();
	
	function openPage(wid){	
		window.location.href="../visitor/sportCjcxPjl-list.c?wid="+wid+"&reqtime="+(new Date());
		//window.open("../visitor/sportCjcxPjl-list.c?wid="+wid);
		//document.forms[0].action="../visitor/sportCjcxPjl-list.c?wid="+wid+"&reqtime="+(new Date());
		//alert(document.forms[0].action);
		//document.forms[0].submit();
	}
	function turnit(yy,ss){
		$("tr[@id*="+yy+"]").each(function(){
			$(this).toggle();
		});
		if(document.getElementById(yy+"a").style.display=='none'){
			ss.src="<s:property value='basePath'/>/resources/images/pages/plus.gif";
		}else{
			ss.src="<s:property value='basePath'/>/resources/images/pages/plus.jpg";
		}
		
		
	}
	</script>
	<style type="text/css">
		.subTab .top th { 
			padding-top: 4px;
			padding-bottom: 0px;
		}
		
		.subTab th.matchDate { 
		    width:145px;
		}
		.subTab td.matchWidth { 
		    width:145px;
		}
		.subTab th.matchDate { 
			background: url(/SportsScore/resources/images/pages/xiangm_bg.gif) repeat-x; 
			height: 28px; line-height:28px; 
			font-weight:normal; color:#fff; 
			font-size:14px;
			text-align: center;
		}
	</style>
  </head>
<body > 
<div class="container_16">
		<!-- 导入head 区域  head.jsp-->
			<jsp:include page="../common/head.jsp" flush="true"></jsp:include>
		<!-- 导入head 区域-->
<div id="container" class="grid_16"><!-- container begin -->
	<div>
	  	&nbsp;
	</div>
<s:form theme="simple" name="theform">

	<div align="center">
  		<h2>人才输送奖排名</h2>
  	</div>
  	<div class="grid_16 alpha">
  	<table class="subTab" style="width:31%;float: left;" cellSpacing="0" summary="直辖区成绩榜">
  <col width="27" />
  <col width="46" />
  <col width="33" span="4" />
  <col width="39" />
  <tr height="19">
    <th colspan="7" abbr="代表团成绩榜" class="matchDate" >代表团</th>
  </tr>
  <tr height="19">
    <td  class="alt" scope="row" rowspan="2" height="39" width="27">名<br />
      次</td>
    <td class="alt" scope="row" rowspan="2">单位</td>
    <td class="alt" scope="row" colspan="5">人数</td>
  </tr>
  <tr height="20">
    <td class="alt" scope="row" height="20">07年</td>
    <td class="alt" scope="row">08年</td>
    <td class="alt" scope="row">09年</td>
    <td class="alt" scope="row">其他</td>
    <td class="alt" scope="row">总数</td>
  </tr>
  <tr>
    <td>1</td>
    <td>南京市</td>
    <td>43</td>
    <td>33</td>
    <td>31</td>
    <td>　</td>
    <td>107</td>
  </tr>
  <tr height="16">
    <td height="16">2</td>
    <td class="alt" scope="row">苏州市</td>
    <td class="gpai">36</td>
    <td class="gpai">38</td>
    <td class="gpai">32</td>
    <td class="gpai">　</td>
    <td class="gpai">106</td>
  </tr>
  <tr height="16">
    <td height="16">3</td>
    <td>常州市</td>
    <td>19</td>
    <td>44</td>
    <td>37</td>
    <td>　</td>
    <td>100</td>
  </tr>
  <tr height="16">
    <td height="16">4</td>
    <td class="alt" scope="row">无锡市</td>
    <td class="gpai">32</td>
    <td class="gpai">32</td>
    <td class="gpai">24</td>
    <td class="gpai">　</td>
    <td class="gpai">88</td>
  </tr>
  <tr height="16">
    <td height="16">5</td>
    <td>徐州市</td>
    <td>30</td>
    <td>24</td>
    <td>14</td>
    <td>　</td>
    <td>68</td>
  </tr>
  <tr height="16">
    <td height="16">6</td>
    <td class="alt" scope="row">南通市</td>
    <td class="gpai">26</td>
    <td class="gpai">22</td>
    <td class="gpai">12</td>
    <td class="gpai">　</td>
    <td class="gpai">60</td>
  </tr>
  <tr height="16">
    <td height="16">7</td>
    <td>泰州市</td>
    <td>14</td>
    <td>15</td>
    <td>11</td>
    <td>　</td>
    <td>40</td>
  </tr>
  <tr height="16">
    <td height="16">8</td>
    <td class="alt" scope="row">扬州市</td>
    <td class="gpai">20</td>
    <td class="gpai">5</td>
    <td class="gpai">5</td>
    <td class="gpai">　</td>
    <td class="gpai">30</td>
  </tr>
  <tr height="16">
    <td height="16">9</td>
    <td>淮安市</td>
    <td>10</td>
    <td>12</td>
    <td>1</td>
    <td>　</td>
    <td>23</td>
  </tr>
  <tr height="16">
    <td height="16">10</td>
    <td class="alt" scope="row">镇江市</td>
    <td class="gpai">7</td>
    <td class="gpai">8</td>
    <td class="gpai">6</td>
    <td class="gpai">　</td>
    <td class="gpai">21</td>
  </tr>
  <tr height="16">
    <td height="16">11</td>
    <td height="16">连云港市</td>
    <td>4</td>
    <td>9</td>
    <td>5</td>
    <td>　</td>
    <td>18</td>
  </tr>
  <tr height="16">
  	<td height="16">11</td>
    <td class="alt" scope="row" height="16">盐城市</td>
    <td class="gpai">8</td>
    <td class="gpai">4</td>
    <td class="gpai">6</td>
    <td class="gpai">　</td>
    <td class="gpai">18</td>
  </tr>
  <tr height="16">
    <td height="16">13</td>
    <td>宿迁市</td>
    <td>5</td>
    <td>　</td>
    <td>　</td>
    <td>2</td>
    <td>7</td>
  </tr>
</table>
<table class="subTab" style="width:2%;float: left;" >
	<tr>
		<td></td>
	</tr>
</table>
       <table class="subTab" style="width:31%;float: left;" cellSpacing="0" >
  <col width="27" />
  <col width="56" />
  <col width="33" span="4" />
  <col width="39" />
  <tr height="19">
    <th class="matchDate" abbr="省辖市成绩榜" colSpan="6" height="19" width="221">省辖市地区</th>
  </tr>
 <tr height="19">
<td class="alt" scope="row" rowspan="2" height="39" width="27">名<br />
次</td>
<td class="alt" scope="row" rowspan="2">单位</td>
<td class="alt" scope="row" colspan="4">人数</td>
</tr>
<tr height="20">
<td class="alt" scope="row" height="20">07年</td>
<td class="alt" scope="row">08年</td>
<td class="alt" scope="row">09年</td>
<td class="alt" scope="row">总数</td>
</tr>
  <tr height="16">
    <td height="16">1</td>
    <td>崇川区</td>
    <td >9</td>
    <td>9</td>
    <td>7</td>
    <td>25</td>
  </tr>
  <tr height="16">
    <td height="16">2</td>
    <td class="alt" scope="row">南长区</td>
    <td class="gpai">9</td>
    <td class="gpai">11</td>
    <td class="gpai">1</td>
    <td class="gpai">21</td>
  </tr>
  <tr height="16">
    <td height="16">3</td>
    <td>玄武区</td>
    <td>6</td>
    <td>8</td>
    <td>4</td>
    <td>18</td>
  </tr>
  <tr height="16">
    <td height="16">4</td>
    <td class="alt" scope="row" >鼓楼区</td>
    <td class="gpai">9</td>
    <td class="gpai">2</td>
    <td class="gpai">4</td>
    <td class="gpai">15</td>
  </tr>
  <tr height="16">
    <td height="16">5</td>
    <td>滨湖区</td>
    <td>5</td>
    <td>3</td>
    <td>5</td>
    <td>13</td>
  </tr>
  <tr height="16">
    <td height="16">6</td>
    <td class="alt" scope="row" >白下区</td>
    <td class="gpai">4</td>
    <td class="gpai">6</td>
    <td class="gpai">2</td>
    <td class="gpai">12</td>
  </tr>
  <tr height="16">
    <td height="16">7</td>
    <td>泉山区</td>
    <td>5</td>
    <td>4</td>
    <td>2</td>
    <td>11</td>
  </tr>
  <tr height="16">
  	<td height="16">7</td>
    <td class="alt" scope="row" height="16">广陵区</td>
    <td class="gpai">6</td>
    <td class="gpai">2</td>
    <td class="gpai">3</td>
    <td class="gpai">11</td>
  </tr>
  <tr height="16">
    <td height="16">9</td>
    <td>建邺区</td>
    <td>1</td>
    <td>4</td>
    <td>5</td>
    <td>10</td>
  </tr>
  <tr height="16">
    <td height="16">10</td>
    <td class="alt" scope="row">沧浪区</td>
    <td class="gpai">3</td>
    <td class="gpai">2</td>
    <td class="gpai">3</td>
    <td class="gpai">8</td>
  </tr>
  <tr height="16">
  	<td height="16">10</td>
    <td height="16">亭湖区</td>
    <td>3</td>
    <td>2</td>
    <td>3</td>
    <td>8</td>
  </tr>
  <tr height="16">
    <td height="16">12</td>
    <td class="alt" scope="row">京口区</td>
    <td class="gpai">1</td>
    <td class="gpai">5</td>
    <td class="gpai">1</td>
    <td class="gpai">7</td>
  </tr>
  <tr height="16">
    <td height="16">13</td>
    <td>下关区</td>
    <td>2</td>
    <td>1</td>
    <td>3</td>
    <td>6</td>
  </tr>
  <tr height="16">
  	<td height="16">13</td>
    <td class="alt" scope="row" height="16">新北区</td>
    <td class="gpai">2</td>
    <td class="gpai">1</td>
    <td class="gpai">3</td>
    <td class="gpai">6</td>
  </tr>
  <tr height="16">
    <td height="16">15</td>
    <td>天宁区</td>
    <td>2</td>
    <td>1</td>
    <td>2</td>
    <td>5</td>
  </tr>
  <tr height="16">
  	<td height="16">15</td>
    <td class="alt" scope="row" height="16">港闸区</td>
    <td class="gpai">3</td>
    <td class="gpai">1</td>
    <td class="gpai">1</td>
    <td class="gpai">5</td>
  </tr>
  <tr height="16">
  	<td height="16">15</td>
    <td height="16">北塘区</td>
    <td>1</td>
    <td>2</td>
    <td>2</td>
    <td>5</td>
  </tr>
  <tr height="16">
  	<td height="16">15</td>
    <td class="alt" scope="row" height="16">云龙区</td>
    <td class="gpai">3</td>
    <td class="gpai">1</td>
    <td class="gpai">1</td>
    <td class="gpai">5</td>
  </tr>
  <tr height="16">
  	<td height="16">15</td>
    <td height="16">维扬区</td>
    <td>3</td>
    <td>1</td>
    <td>1</td>
    <td>5</td>
  </tr>
  <tr height="16">
  	<td height="16">15</td>
    <td class="alt" scope="row" height="16">新浦区</td>
    <td class="gpai">　</td>
    <td class="gpai">3</td>
    <td class="gpai">2</td>
    <td class="gpai">5</td>
  </tr>
  <tr height="16">
    <td height="16">21</td>
    <td>清河区</td>
    <td>　</td>
    <td>4</td>
    <td>　</td>
    <td>4</td>
  </tr>
  <tr height="16">
  	<td height="16">21</td>
    <td class="alt" scope="row" height="16">栖霞区</td>
    <td class="gpai">2</td>
    <td class="gpai">　</td>
    <td class="gpai">2</td>
    <td class="gpai">4</td>
  </tr>
  <tr height="16">
  	<td height="16">21</td>
    <td height="16">秦淮区</td>
    <td>2</td>
    <td>2</td>
    <td>　</td>
    <td>4</td>
  </tr>
  <tr height="16">
  	<td height="16">21</td>
    <td class="alt" scope="row" height="16">海陵区</td>
    <td class="gpai">3</td>
    <td class="gpai">　</td>
    <td class="gpai">1</td>
    <td class="gpai">4</td>
  </tr>
  <tr height="16">
  	<td height="16">21</td>
    <td height="16">崇安区</td>
    <td>1</td>
    <td>2</td>
    <td>1</td>
    <td>4</td>
  </tr>
  <tr height="16">
  	<td height="16">21</td>
    <td class="alt" scope="row" height="16">鼓楼区(徐)</td>
    <td class="gpai">　</td>
    <td class="gpai">2</td>
    <td class="gpai">2</td>
    <td class="gpai">4</td>
  </tr>
  <tr height="16">
    <td height="16">27</td>
    <td>金阊区</td>
    <td>2</td>
    <td>1</td>
    <td>　</td>
    <td>3</td>
  </tr>
  <tr height="16">
  	<td height="16">27</td>
    <td class="alt" scope="row" height="16">惠山区</td>
    <td class="gpai">　</td>
    <td class="gpai">1</td>
    <td class="gpai">2</td>
    <td class="gpai">3</td>
  </tr>
  <tr height="16">
  	<td height="16">27</td>
    <td height="16">贾汪区</td>
    <td>　</td>
    <td>2</td>
    <td>1</td>
    <td>3</td>
  </tr>
  <tr height="16">
  	<td height="16">27</td>
    <td class="alt" scope="row" height="16">平江区</td>
    <td class="gpai">　</td>
    <td class="gpai">2</td>
    <td class="gpai">1</td>
    <td class="gpai">3</td>
  </tr>
  <tr height="16">
    <td height="16">31</td>
    <td>戚墅堰区</td>
    <td>　</td>
    <td>2</td>
    <td>　</td>
    <td>2</td>
  </tr>
  <tr height="16">
  	<td height="16">31</td>
    <td class="alt" scope="row" height="16">清浦区</td>
    <td class="gpai">2</td>
    <td class="gpai">　</td>
    <td class="gpai">　</td>
    <td class="gpai">2</td>
  </tr>
  <tr height="16">
  	<td height="16">31</td>
    <td height="16">宿城区</td>
    <td>2</td>
    <td>　</td>
    <td>　</td>
    <td>2</td>
  </tr>
  <tr height="16">
  	<td height="16">31</td>
    <td class="alt" scope="row" height="16">高港区</td>
    <td class="gpai">1</td>
    <td class="gpai">1</td>
    <td class="gpai">　</td>
    <td class="gpai">2</td>
  </tr>
  <tr height="16">
  	<td height="16">31</td>
    <td height="16">工业园区</td>
    <td>2</td>
    <td>　</td>
    <td>　</td>
    <td>2</td>
  </tr>
  <tr height="16">
    <td height="16">36</td>
    <td class="alt" scope="row">钟楼区</td>
    <td class="gpai">1</td>
    <td class="gpai">　</td>
    <td class="gpai">　</td>
    <td class="gpai">1</td>
  </tr>
  <tr height="16">
  	<td height="16">36</td>
    <td height="16">海州区</td>
    <td>　</td>
    <td>　</td>
    <td>1</td>
    <td>1</td>
  </tr>
  <tr height="16">
  	<td height="16">36</td>
    <td class="alt" scope="row" height="16">雨花台区</td>
    <td class="gpai">　</td>
    <td class="gpai">1</td>
    <td class="gpai">　</td>
    <td class="gpai">1</td>
  </tr>
  <tr height="16">
  	<td height="16">36</td>
    <td height="16">虎丘区</td>
    <td>1</td>
    <td>　</td>
    <td>　</td>
    <td>1</td>
  </tr>
  <tr height="16">
  	<td height="16">36</td>
    <td class="alt" scope="row" height="16">新区</td>
    <td class="gpai">　</td>
    <td class="gpai">1</td>
    <td class="gpai">　</td>
    <td class="gpai">1</td>
  </tr>
  <tr height="16">
  	<td height="16">36</td>
    <td height="16">九里区</td>
    <td>1</td>
    <td>　</td>
    <td>　</td>
    <td>1</td>
  </tr>
</table>
<!-- 主内容区 结束 --><!-- 右边 登录、历史成绩、模块导入(可选) right.jsp -->
<SCRIPT language="JavaScript" src="image.files/myutil.js"></SCRIPT>

<SCRIPT language="JavaScript"
src="image.files/ymPrompt_source.js"></SCRIPT>

<SCRIPT language="JavaScript"
src="image.files/jquery.blockUI.js"></SCRIPT>

<SCRIPT language="JavaScript" src="image.files/userlogin.js"></SCRIPT>
<LINK href="image.files/MemberLoginStyle.css" type="text/css" 
rel="stylesheet"><LINK href="image.files/ymPrompt.css" type="text/css" 
rel="stylesheet">
<SCRIPT type="text/javascript">

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
	prevLoadImg.src="http://218.93.1.67:7080/SportsScore/resources/images/loading.gif";
		
		</SCRIPT>
<!-- 右邊區域  开始-->

<table class="subTab" style="width:2%;float: left;" >
	<tr>
		<td></td>
	</tr>
</table>
<table class="subTab" style="width:33%;float: left;" cellSpacing="0" summary="直辖区成绩榜">
 <col width="27" />
<col width="52" />
<col width="33" span="3" />
<col width="39" />
<tr height="19">
 <th class="matchDate" align="center" abbr="县成绩榜" colSpan="6" height="19" width="221">县（市、区）</th></tr>
<tr height="19">
<td class="alt" scope="row" rowspan="2" height="39" width="27">名<br />
次</td>
<td class="alt" scope="row" rowspan="2">单位</td>
<td class="alt" scope="row" colspan="4">人数</td>
</tr>
<tr height="20">
<td class="alt" scope="row" height="20">07年</td>
<td class="alt" scope="row">08年</td>
<td class="alt" scope="row">09年</td>
<td class="alt" scope="row">总数</td>
</tr>
<tr height="16">
<td height="16">1</td>
<td>武进区</td>
<td >5</td>
<td>24</td>
<td>21</td>
<td>50</td>
</tr>
<tr height="16">
<td height="16">2</td>
<td class="alt" scope="row">金坛市</td>
<td class="gpai">9</td>
<td class="gpai">12</td>
<td class="gpai">8</td>
<td class="gpai">29</td>
</tr>
<tr height="16">
<td height="16">3</td>
<td>吴江市</td>
<td>9</td>
<td>7</td>
<td>12</td>
<td>28</td>
</tr>
<tr height="16">
<td height="16">4</td>
<td class="alt" scope="row" >锡山区</td>
<td class="gpai">8</td>
<td class="gpai">7</td>
<td class="gpai">4</td>
<td class="gpai">19</td>
</tr>
<tr height="16">
<td height="16">5</td>
<td>吴中区</td>
<td>8</td>
<td>3</td>
<td>6</td>
<td>17</td>
</tr>
<tr height="16">
<td height="16"> 6</td>
<td class="alt" scope="row" >泰兴市</td>
<td class="gpai">5</td>
<td class="gpai">6</td>
<td class="gpai">3</td>
<td class="gpai">14</td>
</tr>
<tr height="16">
<td height="16"> 6</td>
<td height="16">常熟市</td>
<td>3</td>
<td>8</td>
<td>3</td>
<td>14</td>
</tr>
<tr height="16">
<td height="16">8</td>
<td class="alt" scope="row">江宁区</td>
<td class="gpai">9</td>
<td class="gpai">1</td>
<td class="gpai">3</td>
<td class="gpai">13</td>
</tr>
<tr height="16">
<td height="16">9</td>
<td>江阴市</td>
<td>5</td>
<td>2</td>
<td>5</td>
<td>12</td>
</tr>
<tr height="16">
<td height="16">9</td>
<td class="alt" scope="row" height="16">沛县</td>
<td class="gpai">7</td>
<td class="gpai">4</td>
<td class="gpai">1</td>
<td class="gpai">12</td>
</tr>
<tr height="16">
<td height="16">9</td>
<td height="16">太仓市</td>
<td>3</td>
<td>4</td>
<td>5</td>
<td>12</td>
</tr>
<tr height="16">
<td height="16">12</td>
<td class="alt" scope="row">宜兴市</td>
<td class="gpai">3</td>
<td class="gpai">3</td>
<td class="gpai">4</td>
<td class="gpai">10</td>
</tr>
<tr height="16">
<td height="16">12</td>
<td height="16">六合区</td>
<td>3</td>
<td>6</td>
<td>1</td>
<td>10</td>
</tr>
<tr height="16">
<td height="16">12</td>
<td class="alt" scope="row" height="16">如东县</td>
<td class="gpai">5</td>
<td class="gpai">2</td>
<td class="gpai">3</td>
<td class="gpai">10</td>
</tr>
<tr height="16">
<td height="16">15</td>
<td>昆山市</td>
<td>3</td>
<td>5</td>
<td>1</td>
<td>9</td>
</tr>
<tr height="16">
<td height="16">15</td>
<td class="alt" scope="row" height="16">丹阳市</td>
<td class="gpai">6</td>
<td class="gpai">　</td>
<td class="gpai">3</td>
<td class="gpai">9</td>
</tr>
<tr height="16">
<td height="16">15</td>
<td height="16">通州市</td>
<td>4</td>
<td>4</td>
<td>1</td>
<td>9</td>
</tr>
<tr height="16">
<td height="16">15</td>
<td class="alt" scope="row" height="16">张家港市</td>
<td class="gpai">2</td>
<td class="gpai">6</td>
<td class="gpai">1</td>
<td class="gpai">9</td>
</tr>
<tr height="16">
<td height="16">15</td>
<td height="16">铜山县</td>
<td>3</td>
<td>4</td>
<td>2</td>
<td>9</td>
</tr>
<tr height="16">
<td height="16">20</td>
<td class="alt" scope="row">涟水县</td>
<td class="gpai">1</td>
<td class="gpai">5</td>
<td class="gpai">1</td>
<td class="gpai">7</td>
</tr>
<tr height="16">
<td height="16">20</td>
<td height="16">靖江市</td>
<td>2</td>
<td>4</td>
<td>1</td>
<td>7</td>
</tr>
<tr height="16">
<td height="16">20</td>
<td class="alt" scope="row" height="16">新沂市</td>
<td class="gpai">2</td>
<td class="gpai">2</td>
<td class="gpai">3</td>
<td class="gpai">7</td>
</tr>
<tr height="16">
<td height="16">20</td>
<td height="16">溧阳市</td>
<td>　</td>
<td>4</td>
<td>3</td>
<td>7</td>
</tr>
<tr height="16">
<td height="16">20</td>
<td class="alt" scope="row" height="16">兴化市</td>
<td class="gpai">1</td>
<td class="gpai">3</td>
<td class="gpai">3</td>
<td class="gpai">7</td>
</tr>
<tr height="16">
<td height="16">25</td>
<td>姜堰市</td>
<td>2</td>
<td>1</td>
<td>3</td>
<td>6</td>
</tr>
<tr height="16">
<td height="16">25</td>
<td class="alt" scope="row" height="16">丰县</td>
<td class="gpai">2</td>
<td class="gpai">3</td>
<td class="gpai">1</td>
<td class="gpai">6</td>
</tr>
<tr height="16">
<td height="16">27</td>
<td>溧水县</td>
<td>1</td>
<td>1</td>
<td>3</td>
<td>5</td>
</tr>
<tr height="16">
<td height="16">27</td>
<td class="alt" scope="row" height="16">淮阴区</td>
<td class="gpai">4</td>
<td class="gpai">1</td>
<td class="gpai">　</td>
<td class="gpai">5</td>
</tr>
<tr height="16">
<td height="16">27</td>
<td height="16">浦口区</td>
<td>4</td>
<td>1</td>
<td>　</td>
<td>5</td>
</tr>
<tr height="16">
<td height="16">27</td>
<td class="alt" scope="row" height="16">海门市</td>
<td class="gpai">1</td>
<td class="gpai">4</td>
<td class="gpai">　</td>
<td class="gpai">5</td>
</tr>
<tr height="16">
<td height="16">27</td>
<td height="16">邳州市</td>
<td>4</td>
<td>　</td>
<td>1</td>
<td>5</td>
</tr>
<tr height="16">
<td height="16">27</td>
<td class="alt" scope="row" height="16">睢宁县</td>
<td class="gpai">3</td>
<td class="gpai">2</td>
<td class="gpai">　</td>
<td class="gpai">5</td>
</tr>
<tr height="16">
<td height="16">27</td>
<td height="16">高邮市</td>
<td>5</td>
<td>　</td>
<td>　</td>
<td>5</td>
</tr>
<tr height="16">
<td height="16">27</td>
<td class="alt" scope="row" height="16">江都市</td>
<td class="gpai">2</td>
<td class="gpai">2</td>
<td class="gpai">1</td>
<td class="gpai">5</td>
</tr>
<tr height="16">
<td height="16">35</td>
<td>楚州区</td>
<td>2</td>
<td>2</td>
<td>　</td>
<td>4</td>
</tr>
<tr height="16">
<td height="16">35</td>
<td class="alt" scope="row" height="16">灌云县</td>
<td class="gpai">1</td>
<td class="gpai">2</td>
<td class="gpai">1</td>
<td class="gpai">4</td>
</tr>
<tr height="16">
<td height="16">35</td>
<td height="16">如皋市</td>
<td>2</td>
<td>2</td>
<td>　</td>
<td>4</td>
</tr>
<tr height="16">
<td height="16">35</td>
<td class="alt" scope="row" height="16">高淳县</td>
<td class="gpai">　</td>
<td class="gpai">　</td>
<td class="gpai">4</td>
<td class="gpai">4</td>
</tr>
<tr height="16">
<td height="16">39</td>
<td>沭阳县</td>
<td>3</td>
<td>　</td>
<td>　</td>
<td>3</td>
</tr>
<tr height="16">
<td height="16">39</td>
<td class="alt" scope="row" height="16">盐都区</td>
<td class="gpai">2</td>
<td class="gpai">　</td>
<td class="gpai">1</td>
<td class="gpai">3</td>
</tr>
<tr height="16">
<td height="16">39</td>
<td height="16">宝应县</td>
<td>3</td>
<td>　</td>
<td>　</td>
<td>3</td>
</tr>
<tr height="16">
<td height="16">39</td>
<td class="alt" scope="row" height="16">扬中市</td>
<td class="gpai">　</td>
<td class="gpai">2</td>
<td class="gpai">1</td>
<td class="gpai">3</td>
</tr>
<tr height="16">
<td height="16">39</td>
<td height="16">东海县</td>
<td>3</td>
<td>　</td>
<td>　</td>
<td>3</td>
</tr>
<tr height="16">
<td height="16">39</td>
<td class="alt" scope="row" height="16">赣榆县</td>
<td class="gpai">　</td>
<td class="gpai">3</td>
<td class="gpai">　</td>
<td class="gpai">3</td>
</tr>
<tr height="16">
<td height="16">45</td>
<td>启东市</td>
<td>2</td>
<td>　</td>
<td>　</td>
<td>2</td>
</tr>
<tr height="16">
<td height="16">45</td>
<td class="alt" scope="row" height="16">大丰市</td>
<td class="gpai">1</td>
<td class="gpai">　</td>
<td class="gpai">1</td>
<td class="gpai">2</td>
</tr>
<tr height="16">
<td height="16">45</td>
<td height="16">阜宁县</td>
<td>1</td>
<td>1</td>
<td>　</td>
<td>2</td>
</tr>
<tr height="16">
<td height="16">45</td>
<td class="alt" scope="row" height="16">响水县</td>
<td class="gpai">1</td>
<td class="gpai">　</td>
<td class="gpai">1</td>
<td class="gpai">2</td>
</tr>
<tr height="16">
<td height="16">45</td>
<td height="16">灌南县</td>
<td>　</td>
<td>1</td>
<td>1</td>
<td>2</td>
</tr>
<tr height="16">
<td height="16">50</td>
<td class="alt" scope="row" >金湖县</td>
<td class="gpai">1</td>
<td class="gpai">　</td>
<td class="gpai">　</td>
<td class="gpai">1</td>
</tr>
<tr height="16">
<td height="16">50</td>
<td height="16">射阳县</td>
<td>　</td>
<td>1</td>
<td>　</td>
<td>1</td>
</tr>
<tr height="16">
<td height="16">50</td>
<td class="alt" scope="row" height="16">邗江区</td>
<td class="gpai">1</td>
<td class="gpai">　</td>
<td class="gpai">　</td>
<td class="gpai">1</td>
</tr>
<tr height="16">
<td height="16">50</td>
<td height="16">句容市</td>
<td>　</td>
<td>　</td>
<td>1</td>
<td>1</td>
</tr>
<tr height="16">
<td height="16">50</td>
<td class="alt" scope="row" height="16">丹徒区</td>
<td class="gpai">　</td>
<td class="gpai">1</td>
<td class="gpai">　</td>
<td class="gpai">1</td>
</tr>
</table>
  </div>
</s:form>
      <!-- 主内容区 结束 -->
 
 
  
  <div class="clear"></div>
</div><!-- container end -->

<!-- 脚注部分导入 footer.jsp-->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
<!-- 脚注部分导入-->

</div>
  </body>
</html>

