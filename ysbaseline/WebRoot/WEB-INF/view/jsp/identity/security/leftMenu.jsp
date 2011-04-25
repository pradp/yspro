<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.yszoe.framework.identity.entity.TSysMenu"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	//List<TSysMenu> tsysMenues = (List<TSysMenu>)request.getAttribute("tsysMenues");
	List tsysMenues = (List) session.getAttribute(com.yszoe.framework.identity.IdConstants.SESSION_USER_RIGHT_MENUS);
	String sysMessage = "";
	if (tsysMenues == null) {
		sysMessage = "系统警告：会话交互失败！";
	} else if (tsysMenues.isEmpty()) {
		sysMessage = "用户没有被分配菜单！"; 
	}
%>

<html>
	<head>
		<base href="<%=basePath%>">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script type="text/javascript"
			src="resources/jquery/jquery-1.2.6.pack.js"></script>
		<style type="text/css">
td,input,select,body {font-family:Verdana;font-size:12px;}
form,body {margin:0;padding:0;}
body {
	margin-left:8px;
	background:#e6fbf8;
	margin:0;
	padding:0;
}
a {color:#dde8f2;}
.listflow {
	background-color: #FFFFFF;
}
.listbg {
	border-right-width: 1px;
	border-left-width: 1px;
	border-right-style: solid;
	border-left-style: solid;
	border-right-color: #b1b2b2;
	border-left-color: #b1b2b2;
}
.navbottom {
	background-image: url(resources/images/vista/leftbottom.png);
	background-repeat: no-repeat;
	background-position: center top;
}
.menu_list {	
	width: 165px;
	margin:0;
}
.menu_head {
	padding: 5px 10px;
	cursor: pointer;
	position: relative;
	margin:0;
	height:28px;
	font-weight:bold;
	background-color: #66CCFF;
	background-image: url(resources/images/vista/navnormal.jpg);
	background-repeat: no-repeat;
	background-position: right center;
}
.menu_body {
	display:none;
	scrollbar-face-color:#97CCEE;
	scrollbar-highlight-color:#fff;
	scrollbar-arrow-color:#000;
	scrollbar-track-color:#fff;
	scrollbar-darkshadow-color:#fff;
}
.menu_body ul {
	margin: 0px;
	padding: 0px;
	list-style-type: none;
	background-color:#FFFFFF;
	background-image: url(resources/images/vista/subnavbg.png);
	background-repeat: repeat-x;
	background-position: center top;
}
.menu_body ul li {
	margin: 0 10px;
	padding-top: 5px;
	padding-bottom: 5px;
	width: 130px;
	border-bottom-width: 1px;
	border-bottom-style: dashed;
	border-bottom-color: #D7D7D7;
   
}
.menu_body a{
	color:#006699;
	padding-left:10px;
	font-weight:bold;
	text-decoration:none;
}
.menu_body a:hover{
  color: #000000;
  text-decoration:underline;
  }

</style>
		<script type="text/javascript">
$(document).ready(function()
{
	//slides the element with class "menu_body" when mouse is over the paragraph
	$("#secondpane p.menu_head").click(function(){
		var currentImage = $(this).css("backgroundImage");
		var isNormalImage = currentImage.indexOf("navnormal.jpg")!=-1;//当前图标是navnormal.jpg文件，说明是非激活状态的菜单
		if(isNormalImage){
			$(this).css({backgroundImage:"url(resources/images/vista/navactive.jpg)"}).next("div.menu_body")
			.slideDown(500,function(){
			     		if($(this).height()>360){
			     			$(this).css("height","360").css("overflow-y","scroll");
			     		}
				})
			.siblings("div.menu_body").slideUp("slow");
	     		$(this).siblings().css({backgroundImage:"url(resources/images/vista/navnormal.jpg)"});
		}else{
			$(this).css({backgroundImage:"url(resources/images/vista/navnormal.jpg)"}).next("div.menu_body").slideUp("slow");
		}
	});
});
function menuHeadClick(obj){
}
function flagMenu(obj){
	var secondMenues = document.getElementsByName("secondMenu");
	for(var i=0;i<secondMenues.length;i++){
		secondMenues[i].style.color="";
	}
	obj.style.color="red";
	obj.blur();
}
function setHeight(){
	var he=document.body.clientHeight-75;
	document.getElementById("secondpane").style.height=he;
}

//window.onload=setHeight;
</script>

	</head>
	<body>
		<table width="167" height="100%" cellpadding="0" cellspacing="0"
			class="listflow">
			<tr>
				<td width="167" height="32" background="resources/images/vista/sidertop.jpg" style="cursor:pointer" align="center">
					
				</td>
			</tr>
			<tr>
				<td valign="top" class="listbg" colspan="2">
					<div class="menu_list" id="secondpane">
						<!--Code for menu starts here-->
			<%
				for (int i = 0; i < tsysMenues.size(); i++) {
					TSysMenu tsysMemu = (TSysMenu) tsysMenues.get(i);
					if (tsysMemu.getDepth().intValue() == 2 && tsysMemu.getState().equals("1")) {
						String firstMemuId = tsysMemu.getMenuid();
			%>
						<p class="menu_head">
							<%=tsysMemu.getMenuName()%>
						</p>
						<div class="menu_body">
							<ul>
						<%
							for (int k = 0; k < tsysMenues.size(); k++) {
								TSysMenu tsysMemu2 = (TSysMenu)tsysMenues.get(k);
								if (firstMemuId.equals(tsysMemu2.getUpMenuId()) && tsysMemu2.getState().equals("1")) {
						%>
								<li>
									<a name="secondMenu" href="<%=tsysMemu2.getMenuPath()%>" target="mainFrame" onclick="flagMenu(this)"><%=tsysMemu2.getMenuName()%></a>
								</li>
						<%
								}
							}
						%>
							</ul>
						</div>
			<%
				}
			}
			%>
			<%=sysMessage.equals("")?"":sysMessage+"<br/>" %>
					</div>
					<!--Code for menu ends here-->
				</td>
			</tr>
			<tr>
				<td colspan="2" class="navbottom" style="background-repeat:no-repeat;cursor:pointer">
				
				</td>
			</tr>
		</table>
	</body>
</html>
