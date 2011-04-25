<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.imchooser.framework.identity.entity.LoginUserVO"%>
<%@ page import="com.imchooser.framework.identity.entity.TSysDepart"%>
<%@ page import="com.imchooser.framework.identity.IdConstants"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	LoginUserVO tsysUser = (LoginUserVO) session.getAttribute(IdConstants.SESSION_USER);
	TSysDepart tdepart = tsysUser.getDepart();
	String userDepartname = tdepart.getDepartname();
	String departid = tdepart.getDepartid();
	String userLoginId = tsysUser.getUserLoginId();
	String userName = tsysUser.getUserName();
	String userType = tsysUser.getUsertype();
%>

<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		
		<script type="text/javascript" src="dwr/engine.js"></script>
		<script type="text/javascript" src="dwr/interface/ajaxService.js"></script>
		<script type="text/javascript" src="resources/jquery/jquery-1.2.6.pack.js"></script>
		<script type="text/javascript" src="resources/js/common/myutil.js"></script>
		<SCRIPT language="JavaScript">
		var userId = "<%=departid%>";

		var PendingRequestUrl = "";
		<%if("1".equals(userType)){ //发布者 %>
		PendingRequestUrl = "<%=basePath%>business/sportCjYdy-list.c?type=sp&sccj=fb&sportBsxm.shzt=-3%2B2";
		<%}else if("2".equals(userType)){ //审批者  %>
		PendingRequestUrl = "<%=basePath%>business/sportCjYdy-list.c?type=sp&sportBsxm.shzt=-2%2B1";
		<%}else if("3".equals(userType)){ //登记者  %>
		PendingRequestUrl = "<%=basePath%>business/sportCjYdy-list.c?type=dj&sportBsxm.shzt=-1%2B0.5";
		<%}  %>
		
		$(function(){
			getRefreshTime();
			getPendingApproveGames();
			window.setInterval(exitIfOvertime,5*1000*60);//每隔5分钟检查一次
		});
		function exitIfOvertime(){
			if(isCookieOverTime()){
				doLogout();
			}
		}
		function getPendingApproveGames(){
			ajaxService.getPendingApproveGames(callback);
			function callback(result){
				var locationId=document.getElementById('messageLocation');
				if(result>0){
					locationId.innerHTML = "<img src='resources/images/member/new.gif' border='0'/><a href=\"javascript:openMsgPage('"+encodeURIComponent(PendingRequestUrl)+"')\">您有"+result+" 个待处理的比赛！</a>";
				}else{
					locationId.innerHTML = "您没有待处理的比赛";
				}
			}
		}
		//定时刷新时间从系统参数配置表中读取
		function getRefreshTime(){
		 	ajaxService.getMsgRefreshTime(callbackTime);
			function callbackTime(result){
				if(result && parseInt(result)>0){
					 var refreshTime= parseInt(result)*1000*60;
					 document.getElementById("refreshTime").value=refreshTime;
				}else{
				 	//如果系统参数表没定义刷新时间，默认设置成10分钟
				 	 var refreshTime=10*1000*60;
					 document.getElementById("refreshTime").value=refreshTime;
				}
  				execRefreshMessageState();//取到刷新时间后立即开始执行定时刷新
			}
		}
  		function execRefreshMessageState(){
  			 var refreshTime = document.getElementById("refreshTime").value;
  			 if(refreshTime!="" && parseInt(refreshTime)>(1000*30)){
  			 	//必须大于30秒才执行
  			 	window.setInterval(getPendingApproveGames,parseInt(refreshTime));
  			 }
  		}
		function openMsgPage(uri){
			window.parent.frames["mainFrame"].location.href=uri;
		}
		function doLogout(){
			parent.execLogout();
		}
		function showPortlets(){
			window.parent.frames["mainFrame"].location.href="../business/portlets-list.c?portletWids=zxxx,gw,tzgg,dbtx";
		}
		function showHideHeader(){
			parent.showHideHeader();
		}
	</SCRIPT>
<style type="text/css">
form,body {
	margin:0;
	padding:0;
}
td{
	color: #FFFFFF;
	font-size: 12px;
}
a{
	text-decoration:none;
	cursor:pointer;
	font-size: 12px;
	color: #FFFFFF;
}
a:hover {
	text-decoration: underline;
}
#headerinfo {
	background:url(resources/images/vista/headerinfo.jpg) repeat-x;
	height:28px;
}
</style>
</head>
<body>
<input type="hidden" name="refreshTime" id="refreshTime" value="">

<table border="0" cellspacing="0" cellpadding="0" width="100%" id="headerinfo">
  <tr>
    <td><table width="100%" border="0" cellspacing="5" cellpadding="0">
      <tr>
        <td nowrap="nowrap" onclick="showHideHeader()" style="cursor:pointer;" title="单击此横条可隐藏/显示上方区域"><%=userName %>(<%=userLoginId %>)，您好！&nbsp;&nbsp; &nbsp;&nbsp;所属：<%=userDepartname %></td>
        <td width="15%" onclick="showHideHeader()" style="cursor:pointer;" title="单击此横条可隐藏/显示上方区域"><script language="JavaScript" src="resources/js/date.js"></script></td>
        <td width="15%" style="cursor:pointer;" title="单击此横条可隐藏/显示上方区域"><span id="messageLocation"></span></td>
        <td width="20%"><div align="center">
        &nbsp; 
        【<a href="javascript:void(null)" onclick="doLogout()">退出</a>】</div></td> 
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>