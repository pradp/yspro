<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="java.util.*"%>
<%@ page import="com.yszoe.sys.servlets.SysInitAutoLoad"%>
<%@ page import="com.yszoe.sys.util.CommonQuery"%>
<%@ page import="com.yszoe.identity.entity.LoginUserVO"%>
<%@ page import="com.yszoe.identity.entity.TSysDepart"%>
<%@ page import="com.yszoe.identity.entity.TSysMenu"%>
<%@ page import="com.yszoe.identity.IdConstants"%>
<%@page import="com.yszoe.sys.util.SysConfigUtil"%>
<%@page import="com.yszoe.sys.entity.TSysMessageCtrl"%>
<%@page import="com.yszoe.framework.util.DBUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	LoginUserVO tsysUser = (LoginUserVO) session.getAttribute(IdConstants.SESSION_USER);
	TSysDepart tdepart = tsysUser.getDepart();
	String userDepartname = tdepart.getDepartname();
	String departid = tdepart.getDepartid();
	String userLoginId = tsysUser.getUserloginid();
	String userName = tsysUser.getUsername();
	String userid = tsysUser.getUserid();
	
	List tsysMenues = (List) session.getAttribute(com.yszoe.identity.IdConstants.SESSION_USER_RIGHT_MENUS);
	String sysMessage = "";
	if (tsysMenues == null) {
		sysMessage = "系统警告：会话交互失败！";
	} else if (tsysMenues.isEmpty()) {
		sysMessage = "用户没有被分配菜单，或者权限被禁用！";
	}
	String DhiLogoutUrl = SysConfigUtil.getString("DhiLogoutUrl");
	//获取提示信息
	List<TSysMessageCtrl> listMessageCtrl = SysInitAutoLoad.listMessageCtrl;
	List<TSysMessageCtrl> list = new ArrayList<TSysMessageCtrl>();
	for (int i = 0; i < listMessageCtrl.size(); i++) {
		TSysMessageCtrl t = listMessageCtrl.get(i);
		if (t.getDeparttype().equals(tdepart.getDeparttype())) {
			long c = DBUtil.count(t.getSql(), tdepart.getDepartid() + "%");
			if(c>0){
				t.setCount(c);
				list.add(t);
			}
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>clientui/">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title><s:text name="application_name" /></title>

<!--框架必需start-->
		<link href="css/framework/reset.css" rel="stylesheet" type="text/css"/>
		<link href="css/framework/basic.css" rel="stylesheet" type="text/css"/>
		<link href="css/framework/position.css" rel="stylesheet" type="text/css"/>
		<link href="css/framework/form.css" rel="stylesheet" type="text/css"/>
		<link href="css/framework/icon.css" rel="stylesheet" type="text/css"/>
		<link href="css/framework/code.css" rel="stylesheet" type="text/css"/>
		<link href="skins/sky/style.css" rel="stylesheet" type="text/css" id="skin" themeColor="blue" prePath="./"/>
		<link href="skins/custom.css" rel="stylesheet" type="text/css" id="skin" themeColor="blue" prePath="./"/>
		<script type="text/javascript" src="js/jquery-1.4.js"></script>
		<script type="text/javascript" src="js/bsFormat.js"></script>
<!--框架必需end-->

<!--引入组件start-->
<script type="text/javascript" src="js/attention/zDialog/zDrag.js"></script>
<script type="text/javascript" src="js/attention/zDialog/zDialog.js"></script>
<!--引入弹窗组件end-->

<!--修正IE6支持透明png图片start-->
<script type="text/javascript" src="js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明png图片end-->

<!--弹出式提示框start-->
<script type="text/javascript" src="js/attention/messager.js"></script>
<script>
	$(function(){
		var count_list = <%=list.size()%>;
		if(count_list != 0){
			setTimeout("openMsg()",1000);
		}
	})
	function openMsg(){
		$.messager.lays(250, 180);
		$.messager.show(0,'<ul>'
		<%for (int i = 0; i < list.size(); i++) {
			TSysMessageCtrl t = list.get(i);
			if(t.getCount()>0){	
		%>	
		+'<li style="padding-top:10px"><span class="icon_lightOn">&nbsp;&nbsp;<a href="javascript:openWin(\'<%=t.getMenuid()%>\',\'<%=t.getMenupath()%>\')"><%=t.getName()%>：<%=t.getCount()%>条</span></a></li><div class="clear"></div>'
		<%}}%>
		+'</ul>','stay');
		$(".box_msg_title").html("待办提醒");
	}
	function openWin(menuid,menupath){
		var ifr1=document.getElementById('frmleft');
		var me_up = ifr1.contentWindow.document.getElementById(menuid.substr(0,6));
		if($(me_up).next("ul").css("display")=='none'){
			$(me_up).click();
		}
		var me = ifr1.contentWindow.document.getElementById(menuid);
		$(me).find("a span").click();
		if($.browser.mozilla){ //火狐不支持非input控件的click()
			document.getElementById('frmright').src = "../"+menupath;
		}
	}
</script>
<!--弹出式提示框end-->

<script type="text/javascript">
if(top.location != self.location){
	top.location = self.location;
}
	var basePath = '<%=basePath%>';
	function execLogout(){
		//项目集成DHI系统，所以这里登出两个平台。
		var dhiurl = "<%=DhiLogoutUrl%>?"+(new Date()).getTime();
		//jQuery.getJSON(dhiurl);
		Dialog.open({URL:dhiurl, Title:"退出DHI", Modal:false});
		window.location = "../identity/logout.action?" + (new Date()).getTime();
	}
	$(function(){
		var hiconIdx=0;
		var hiconIndex=jQuery.jCookie('hiconIndex');
		if(hiconIndex!=false){
			hiconIdx=parseInt(hiconIndex);
		}
		$(".nav_icon_h_item >a").filter(':eq('+hiconIdx+')').addClass("current");
		$(".nav_icon_h_item >a").each(function(i){
			$(this).click(function(){
				$(".nav_icon_h_item >a").removeClass("current");
				$(this).addClass("current");
				document.getElementById("frmleft").src = "../identity/leftMenu.action?divIndexNum="+i;
				jQuery.jCookie('hiconIndex',i.toString());
			})
		})
	})
	/**
	 * 隐藏或显示头部
	 */
	function hideOrShowHeader(){
		var height = $("#zw_id").height();
		if($("#header").css("display") == 'block'){
			 $("#header").hide();
			 $("#zw_id").height(height + 80);
			 $("#bs_left").height(height +80);
			 $("#frmleft").height(height+80);
			 $(document.getElementById('frmleft').contentWindow.document.getElementById("scrollContent")).height(height+80);
			 $("#bs_right").height(height +80);
			 $("#frmright").height(height+80);
			 //子页面高度调整
			 var div_0 = $(document.getElementById('frmright').contentWindow.document.getElementsByTagName("div")[0]);
			 if(div_0[0]){
				 div_0.height(height+80);
			 }else{ //树结构页面高度调整
				 //树结构页面左侧的树结构
				 var iframe_0 = document.getElementById('frmright').contentWindow.document.getElementsByTagName("iframe")[0];
				 if(iframe_0){
					 $(iframe_0).height(height+80);
					 //树结构页面右侧的明细信息
					 $(document.getElementById('frmright').contentWindow.document.getElementsByTagName("iframe")[1]).height(height+80);
					 //树结构右侧明细信息里的div高度调整
					 div_0 = $(document.getElementById('frmright').contentWindow.document.getElementsByTagName("iframe")[1]
						 .contentWindow.document.getElementsByTagName("div")[0]);
					 if(div_0[0]){
					 	div_0.height(height+80);
					 }
				 }
			 }
		}else{
			 $("#header").show();
			 $("#zw_id").height(height - 80);
			 $("#bs_left").height(height -80);
			 $("#frmleft").height(height-80);
			 $(document.getElementById('frmleft').contentWindow.document.getElementById("scrollContent")).height(height-80);
			 $("#bs_right").height(height -80);
			 $("#frmright").height(height-80);
			 //子页面高度调整
			 var div_0 = $(document.getElementById('frmright').contentWindow.document.getElementsByTagName("div")[0]);
			 if(div_0[0]){ 
				 div_0.height(height-80);
			 }else{ //树结构页面高度调整
				 //树结构页面左侧的树结构
				 var iframe_0 = document.getElementById('frmright').contentWindow.document.getElementsByTagName("iframe")[0];
				 if(iframe_0){
					 $(iframe_0).height(height-80);
					 //树结构页面右侧的明细信息
					 $(document.getElementById('frmright').contentWindow.document.getElementsByTagName("iframe")[1]).height(height-80);
					 //树结构右侧明细信息里的div高度调整
					 div_0 = $(document.getElementById('frmright').contentWindow.document.getElementsByTagName("iframe")[1]
						 .contentWindow.document.getElementsByTagName("div")[0]);
					 if(div_0[0]){ 
					 	div_0.height(height-80);
					 }
				 }
			 }
		}
	}
</script>
<style>
a {
	behavior:url(js/method/focus.htc)
}
</style>

	</head>
	<body class="" style="height: 100%">
		<div id="floatPanel-1"></div>		
<div id="mainFrame" style="height: 100%">
<!--头部与导航start-->
<div id="hbox">
	<div id="header" style="width: 100%;height: 80px;background-image: url(skins/sky/mainframe/bs_header.jpg);background-repeat: repeat-x;">
	<div id="bs_bannerleft">
	<div id="bs_bannerright2">
		<div class="bs_banner_logo_hmenu" id="header1"></div>
		<div class="bs_banner_title" id="header2"></div>
		<div class="nav_icon_h" id="header3">
			<%=sysMessage.equals("")?"":sysMessage+"<br/>" %>
			<div class="clear"></div>
		</div>
	</div>
	</div>
	</div>
	<table title="点击展开/收起上方区域" style="text-decoration:none;padding: 0 0 0 5px;color: #19366e;overflow:hidden;width: 100%;height: 28px;background-image: url(skins/sky/mainframe/bs_message.jpg);background-repeat: repeat-x;">
		<tr>
			<td align="left" width="20%" onclick="hideOrShowHeader()" style="cursor: pointer" nowrap="nowrap">
					欢迎<%=userName %>(<%=userLoginId %>)，&nbsp;隶属：<%=userDepartname %>，&nbsp;今天是
				<script>
					var weekDayLabels = new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
					var now = new Date();
				    var year=now.getFullYear();
					var month=now.getMonth()+1;
					var day=now.getDate()
				    var currentime = year+"年"+month+"月"+day+"日 "+weekDayLabels[now.getDay()]
					document.write(currentime)
				</script>
			</td>
			<td width="90px" nowrap="nowrap">
					&nbsp;&nbsp;字号:
					<span class="fontChange"><a href="javascript:;" setFont="16">大</a></span>
					<span class="fontChange"><a href="javascript:;" setFont="14">中</a></span>
					<span class="fontChange"><a href="javascript:;" setFont="12">小</a></span>
			</td>
			<td width="" onclick="hideOrShowHeader()" style="cursor: pointer">&nbsp;</td>
			<td align="right" width="160px" nowrap="nowrap">		
				<span class="icon_home hand" onclick="window.location.href='../index.jsp'">回到首页&nbsp;&nbsp;</span>	
				<span class="icon_no hand" onclick='top.Dialog.confirm("确定要退出系统吗",function(){execLogout();});' style="margin-right: ">退出系统</span>
			</td>
		</tr>
	</table>
</div>
<!--头部与导航end-->

<table width="100%" cellpadding="0" cellspacing="0" class="table_border0" id="zw_id">
	<tr>
		<!--左侧区域start-->
		<td id="hideCon" class="ver01 ali01">
							<div id="lbox">
								<div id="lbox_topcenter">
								<div id="lbox_topleft">
								<div id="lbox_topright">
									<div class="lbox_title">操作菜单</div>
								</div>
								</div>
								</div>
								<div id="lbox_middlecenter">
								<div id="lbox_middleleft">
								<div id="lbox_middleright">
										<div id="bs_left">
										<IFRAME scrolling="no" width="100%"  frameBorder=0 id=frmleft name=frmleft src="../identity/leftMenu.action?divIndexNum=0"  allowTransparency="true"></IFRAME>
										</div>
										<!--更改左侧栏的宽度需要修改id="bs_left"的样式-->
								</div>
								</div>
								</div>
								<div id="lbox_bottomcenter">
								<div id="lbox_bottomleft">
								<div id="lbox_bottomright">
									<div class="lbox_foot"></div>
								</div>
								</div>
								</div>
							</div>
		</td>
		<!--左侧区域end-->
		
		<!--中间栏区域start-->
		<td class="main_shutiao">
			<div class="bs_leftArr" id="bs_center" title="收缩面板"></div>
		</td>
		<!--中间栏区域end-->
		
		<!--右侧区域start-->
		<td class="ali01 ver01"  width="100%">
							<div id="rbox">
								<div id="rbox_topcenter">
								<div id="rbox_topleft">
								<div id="rbox_topright">
									<div class="rbox_title">
										操作内容
									</div>
								</div>
								</div>
								</div>
								<div id="rbox_middlecenter">
								<div id="rbox_middleleft">
								<div id="rbox_middleright">
									<div id="bs_right">
									       <IFRAME scrolling="no" width="100%" frameBorder=0 id="frmright" name="frmright" src="main/welcome.html" allowTransparency="true"></IFRAME>
									</div>
								</div>
								</div>
								</div>
								<div id="rbox_bottomcenter" >
								<div id="rbox_bottomleft">
								<div id="rbox_bottomright">

								</div>
								</div>
								</div>
							</div>
		</td>
		<!--右侧区域end-->
	</tr>
</table>

<!--尾部区域start-->
<div id="fbox">
	<div id="bs_footcenter">
	<div id="bs_footleft">
	<div id="bs_footright" class="white">
		<s:text name="application_name" />  CopyRight 2011 @ <s:text name="application_url" />
	</div>
	</div>
	</div>
</div>
</div>
<!--尾部区域end-->

<!--浏览器resize事件修正start-->
<div id="resizeFix"></div>
<!--浏览器resize事件修正end-->

<!--载进度条start-->
<div class="progressBg" id="progress" style="display:none;"><div class="progressBar"></div></div>
<!--载进度条end-->
	</body>
</html>
