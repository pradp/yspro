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
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath %>clientui/" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title><s:text name="application_name" /></title>

<!--框架必需start-->
		<link href="css/import_basic.css" rel="stylesheet" type="text/css"/>
		<link href="skins/sky/import_skin.css" rel="stylesheet" type="text/css" id="skin" themeColor="blue"/>
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

<script type="text/javascript">
if(top.location != self.location){
	top.location = self.location;
}
	var basePath = '<%=basePath%>';
	function execLogout(){
		var url_tz = "../ajaxLogin?act=logout";
		$.post(url_tz, function(data){
		    data = eval("("+data+")");
		    if(data.msg=='ok'){
		    	window.location.href = '../index.jsp';
			}else{
				alert(data.msg);
			}
		});
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
	
</script>

	</head>
	<body class="" style="height: 100%">
	
<div id="floatPanel-1"></div>		
<div id="mainFrame" style="height: 100%">
<!--头部与导航start-->
<div id="hbox">
	<div id="bs_bannercenter">
	<div id="bs_bannerleft">
	<div id="bs_bannerright">
		<div class="bs_banner_logo"></div>
		<div class="bs_banner_title"></div>
		<div class="subTitle"></div>
	</div>
	</div>
	</div>
	
	<div id="bs_navcenter">
	<div id="bs_navleft">
	<div id="bs_navright">
		<div class="bs_nav">
			<div class="bs_navleft">
				<li>
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
				</li>
				<li class="fontTitle">&nbsp;&nbsp;字号:</li>
				<li class="fontChange"><span><a href="javascript:;" setFont="16">大</a></span></li>
				<li class="fontChange"><span><a href="javascript:;" setFont="14">中</a></span></li>
				<li class="fontChange"><span><a href="javascript:;" setFont="12">小</a></span></li>
				<div class="clear"></div>
			</div>
			<div class="bs_navright">
				<span class="icon_btn_up hand" id="fullSrceen" hideLeft="false">全屏&nbsp;&nbsp;</span> <!--如果将hideLeft设为true则全屏时左侧也会被隐藏-->
				<a href="../index.jsp"><span class="icon_home hand">回到首页&nbsp;&nbsp;</span></a>
				<span class="icon_no hand" onclick='top.Dialog.confirm("确定要退出系统吗",function(){execLogout();});' style="margin-right: ">退出系统</span>
				<div class="clear"></div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	</div>
	</div>
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
		<s:text name="application_name" />  CopyRight 2012 @ <s:text name="application_url" />
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
