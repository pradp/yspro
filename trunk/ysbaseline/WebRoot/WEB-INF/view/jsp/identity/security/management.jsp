<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="com.yszoe.sys.servlets.SysInitAutoLoad"%>
<%@ page import="com.yszoe.sys.util.CommonQuery"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String myportlet = CommonQuery.getSysProperty("systemPortlet");
%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title><%=SysInitAutoLoad.PROVINCE %>学生资助系统</title>
		<script type="text/javascript" src="<%=basePath%>resources/jquery/jquery-1.2.6.pack.js"></script>
		<script language="JavaScript" src="<%=basePath%>resources/jquery/plugins/jquery.blockUI.js"></script>
		<script type="text/javascript">

var basePath = '<%=basePath%>';
function resetSystemHeight(){
	var he=document.body.clientHeight-110;
	document.getElementById("mainFrame").style.height=he;
}
function openPage(uri,target,params){
	var Params = "dialogWidth=800px;dialogHeight=600px";
	var Target = window.self;
	if(target && target!=""){
		Target = target;
	}
	if(params && params!=""){
		Params = params;
	}
	window.showModalDialog(uri,Target,Params);
}
function MM_swapImage_judge() {
	var objsrc,newsrc;
	objsrc = switchPoint.src.slice(-6);
	if (objsrc == "t0.gif"){newsrc = basePath + "resources/images/middleFrameRight0.gif";}
	else if (objsrc == "ft.gif"){newsrc = basePath+"resources/images/middleFrameRight.gif";}
	MM_swapImage('switchPoint','',newsrc,1);
}
function MM_swapImgRestore_judge() {
	if (left_iframe.style.display==""){
		var url = basePath + "resources/images/middleFrameLeft.gif";
		switchPoint.src = url;
	}
	else{
		var url = basePath + "resources/images/middleFrameLeft0.gif";
		switchPoint.src = url;
	}
}
function MM_swapImage() {
	var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
	if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
} 
function MM_findObj(n, d) {
	var p,i,x; if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
	d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
	if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
	for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
	if(!x && d.getElementById) x=d.getElementById(n); return x;
}
function showHideMenu(){
	if (left_iframe.style.display==""){left_iframe.style.display="none";switchPoint.src=basePath+"resources/images/middleFrameLeft0.gif";}
	else{left_iframe.style.display="";switchPoint.src= basePath+"resources/images/middleFrameLeft.gif";}
}
function MM_preloadImages() {
	var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
	var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
	if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}
function prevLoadImages(){
	MM_preloadImages(basePath+'resources/images/middleFrameLeft0.gif',basePath+'resources/images/middleFrameRight0.gif',basePath+'resources/images/middleFrameLeft.gif',basePath+'resources/images/middleFrameRight.gif');
	//resetSystemHeight();
}
function execLogout(){
	var url =   '../identity/logout.c?'+(new Date()).getTime();
	$.blockUI(YSprogressBlockUI());
	$.get(url,function(){
		window.top.location.href = basePath;
	});
}
function dologout() {
	var logouturl = basePath+"identity/logout.c";
	if(event.clientY<0 || event.altKey){
	//点击右上角关闭按钮
		window.frames['hiddenFrame'].location.href=logouturl;
	}else if(event.clientY > document.body.clientHeight || event.altKey){
	//从任务栏关闭
		window.frames['hiddenFrame'].location.href=logouturl;
      }else{
      //刷新等其他方式离开页面
      	//window.event.returnValue="确定要离开吗？";
      }
}

function showHideHeader(){
	if (header.style.display==""){
		header.style.display="none";
	}else{
		header.style.display="";
	}
	//$("#header").slideToggle("slow");
}
window.onload=prevLoadImages;
//window.onunload=dologout;
</script>
<style type="text/css">
html,body {
	margin:0;padding:0;overflow:hidden;height:100%;width:100%;border:none;
}
table {
	font-size:12px;font-family:tahoma, 宋体, fantasy;
}
td {
	font-size:12px;font-family:tahoma, 宋体, fantasy;
}
div{
	color:#000000;
}
.middleFrame{
	background-color:#D9E8FF;
	border-left:1px solid #FFFFFF;
	border-right:1px solid #ACD7F9;
	text-align:center;
	vertical-align:middle;
	width:8px;
}
#header {
	background:url(<%=basePath%>resources/images/vista/headerbg.jpg) repeat-x;
}
</style>
	<link href="<%=basePath%>resources/css/iframepage.css" rel="stylesheet" type="text/css">
	</head>
	<body class="frame_class">
		<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
			<input type="hidden" name="myportlet" id="myportlet" value="<%=myportlet %>"/>
			<tr>
				<td colspan="3">
					<table border="0" cellspacing="0" cellpadding="0" width="100%" id="header">
					  <tr>
					    <td width="862"><img src="<%=basePath%>resources/images/vista/headermain.jpg" width="862" height="79" /></td>
					    <td align="right"><img src="<%=basePath%>resources/images/vista/headerright.jpg" width="198" height="79" /></td>
					  </tr>
					</table>
				</td>
			</tr>
			<tr>
				<td id="head_iframe" colspan="3">
					<iframe src="headMessage.c" width="100%" height="100%" name="topFrame"
						scrolling="no" noresize="noresize" id="topFrame" frameborder="0"></iframe>
				</td>
			</tr>
			<tr>
				<td width="170" valign="top" id="left_iframe">
					<iframe src="leftMenu.c"
						style="height:100%;visibility:inherit;width:167px;background-color:#FFFFFF"
						name="leftFrame" scrolling="no" noresize="noresize" id="leftFrame"
						frameborder="0"></iframe>
				</td>
				<td class="middleFrame">
					<img id="switchPoint" border="0" style="cursor:pointer;" title="关闭/开启菜单栏" onmouseout="MM_swapImgRestore_judge()" onmouseover="MM_swapImage_judge()" onclick="showHideMenu()" src="<%=basePath%>resources/images/middleFrameLeft.gif" name="switchPoint"/>
				</td>
				<td id="main_iframe" valign="top">
						<iframe src=""
							style="height:100%;visibility:inherit;width:100%;z-index:1;"
							name="mainFrame" id="mainFrame" frameborder="0" scrolling="auto"></iframe>
				</td>
			</tr>
			<tr>
				<td height="30" id="foot_iframe" colspan="3">
					&nbsp;
				</td>
			</tr>
		</table>
	</body>
</html>
