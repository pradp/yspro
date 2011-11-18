<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.yszoe.identity.entity.TSysMenu"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	List tsysMenues = (List) session.getAttribute(com.yszoe.identity.IdConstants.SESSION_USER_RIGHT_MENUS);
	String sysMessage = "";
	if (tsysMenues == null) {
		sysMessage = "系统警告：会话交互失败！";
	} else if (tsysMenues.isEmpty()) {
		sysMessage = "用户没有被分配菜单，或者权限被禁用！"; 
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
		<base href="<%=basePath%>clientui/">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--框架必需start-->
<script type="text/javascript" src="./js/jquery-1.4.js"></script>
<script type="text/javascript" src="./js/framework.js"></script>
<link href="./css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin" prePath="./"/>
<!--框架必需end-->
<script type="text/javascript" src="./js/nav/ddaccordion.js"></script>
<script type="text/javascript" src="./js/text/text-overflow.js"></script>
<script type="text/javascript" src="../resources/js/common/myutil.js"></script>
<script type="text/javascript">
	$(function(){
		if (broswerFlag == "IE6") { //IE6菜单超出最大高度时显示滚动条
			$("#scrollContent").css({width:"100%"});
		}
		$("ul li").click(function(){
			$("#curr_menuid").val($(this).attr("id"));
			//点击菜单时清空勾选信息
			document.cookie = $(this).attr("id")+"=;";
			window.parent.document.getElementById('frmright').contentWindow.document.cookie = $(this).attr("id")+"=;";
		});
	})
	function gotodit(url){
		parent.window.frames["frmright"].window.location.href = url;
	}
</script>
<style>
a {
	behavior:url(./js/method/focus.htc)
}
.categoryitems span{
	width:160px;
}
</style>
</script>
<body leftFrame="true">
<input type="hidden" name="curr_menuid" id="curr_menuid"/>
	<div id="scrollContent">
		<div class="arrowlistmenu">
			<!--Code for menu starts here-->
			<%
				for (int i = 0; i < tsysMenues.size(); i++) {
					TSysMenu tsysMemu = (TSysMenu) tsysMenues.get(i);
					if (tsysMemu.getDepth().intValue() == 2 ) {
						String firstMemuId = tsysMemu.getMenuid();
						String imgpath = "";
						String ditpath = "";
						if( StringUtils.isBlank(tsysMemu.getMenupath()) ){
							imgpath = "icons/png/71.png";
						}else if( tsysMemu.getMenupath().indexOf(".action")!=-1){
							ditpath = tsysMemu.getMenupath();
							imgpath = "icons/png/71.png";
						}else{
							imgpath = tsysMemu.getMenupath();
						}
			%>
			<div class="menuheader expandable" style="text-indent: 1px;padding-left: 4px" id="<%=tsysMemu.getMenuid() %>" <%="".equals(ditpath)?"":"onclick=\"gotodit('"+ditpath+"')\"" %>><img src="<%=imgpath %>" width="14" height="14" style="margin-right: 2px;padding-left: 0"/><%=tsysMemu.getMenuname()%></div>
			<ul class="categoryitems">
				<%
					for (int k = 0; k < tsysMenues.size(); k++) {
						TSysMenu tsysMemu2 = (TSysMenu) tsysMenues.get(k);
						String secondMemuId = tsysMemu2.getMenuid();
						if (firstMemuId.equals(tsysMemu2.getUpmenuid()) && tsysMemu2.getChildMenuCount() == 0) {
				%>
				<li id="<%=tsysMemu2.getMenuid() %>"><a target="frmright" href="../<%=tsysMemu2.getMenupath()%>" style="padding-left: 10px"><span class="text_slice"><%=tsysMemu2.getMenuname()%></span></a></li>
				<%
						} else if (firstMemuId.equals(tsysMemu2.getUpmenuid()) ) {
				%>
				<li id="<%=tsysMemu2.getMenuid() %>">
					<a target="frmright" <%if(StringUtils.isNotBlank(tsysMemu2.getMenupath())){ %> href="../<%=tsysMemu2.getMenupath()%>" <%} %> style="padding-left: 10px">
						<span class="text_slice"><%=tsysMemu2.getMenuname()%></span> </a>
					<ul style="margin-bottom: 0">
						<%
							for (int j = 0; j < tsysMenues.size(); j++) {
								TSysMenu tsysMemu3 = (TSysMenu) tsysMenues.get(j);
								String thirdMemuId = tsysMemu3.getMenuid();
								if (secondMemuId.equals(tsysMemu3.getUpmenuid()) && tsysMemu3.getChildMenuCount() == 0) {
						%>
						<li id="<%=tsysMemu3.getMenuid() %>"><a target="frmright" href="../<%=tsysMemu3.getMenupath()%>" style="padding-left: 10px"><span class="text_slice"><%=tsysMemu3.getMenuname()%></span></a></li>
						<%
								}else if(secondMemuId.equals(tsysMemu3.getUpmenuid()) ){
						%>
						<li id="<%=tsysMemu3.getMenuid() %>">
							<a target="frmright" <%if(StringUtils.isNotBlank(tsysMemu3.getMenupath())){ %> href="../<%=tsysMemu3.getMenupath()%>" <%} %> style="padding-left: 10px">
								<span class="text_slice"><%=tsysMemu3.getMenuname()%></span> </a>
							<ul style="margin-bottom: 0">
								<%
									for (int m = 0; m < tsysMenues.size(); m++) {
										TSysMenu tsysMemu4 = (TSysMenu) tsysMenues.get(m);
										if (thirdMemuId.equals(tsysMemu4.getUpmenuid()) ){
								%>
								<li id="<%=tsysMemu4.getMenuid() %>"><a target="frmright" href="../<%=tsysMemu4.getMenupath()%>"  style="padding-left: 10px">
									<span class="text_slice"><%=tsysMemu4.getMenuname()%></span></a></li>
								<%		
										}
									} 
								%>
							</ul>
						</li>
						<% 
								}
							}
						%>
					</ul>
				</li>
				<%
						}
					}
				%>
			</ul>
			<%
				}
			}
			%>
			<%=sysMessage.equals("") ? "" : sysMessage + "<br/>"%>
			<!--Code for menu ends here-->
		</div>
	</div>
</body>
</html>