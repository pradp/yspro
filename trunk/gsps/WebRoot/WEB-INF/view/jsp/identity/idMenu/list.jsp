<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="com.imchooser.framework.identity.service.impl.MenuTreeSupport"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String showCheckBox__ = (String)request.getAttribute("showCheckBox");
boolean showCheckBox = showCheckBox__==null?false:Boolean.valueOf(showCheckBox__).booleanValue();
String menuid = request.getParameter("menuid");
menuid = menuid==null?"000":menuid;

java.util.List list = MenuTreeSupport.QueryTreeData( menuid, showCheckBox );
MenuTreeSupport s = new MenuTreeSupport();
final String treebody = s.writeTree(list, false, "ystree");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>component/ystree/">
    <title>tree</title>

	<script type="text/javascript" src="resource/js/ysframework.js"></script>
	<script type="text/javascript" src="resource/js/ystree.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="resource/css/ystree.css">
	
	<script type="text/javascript">
      var ystree = new YsTree('ystree');
      ystree.config.showCheckBox = <%=showCheckBox %>;//是否启用checkbox
      //点击节点文字触发的事件
      function nodeText_clicked(nodeid){
      	if(!ystree.config.showCheckBox){
      		window.parent.document.getElementById("menuContentFrame").src=getActionName()+"-input.c?wid="+nodeid;
      	}
      }
      $(document).ready(function(){
		for(var i=0;i<ystree.aNodes.length;i++){
			if(ystree.aNodes[i].id.length==6){
				ystree.aNodes[i]._io = false;
			}
		}
		document.getElementById("ystreeDivPerant").innerHTML = ystree;
		if(ystree.config.showCheckBox){
			initMenuChecked();
		}
	});
	
	//初始化需要选中的菜单。权限菜单需求
	function initMenuChecked(){
		var c = document.getElementsByName(ystreecheckboxname);
		var menues = window.parent.document.getElementById("menues").value;
		for(var i=0;i<c.length;i++){
			var menuid = c[i].value;
			if(menuid=="000"){
				c[i].checked = true;
			}else{
				if(checkContain(menuid ,menues)){//以前选中的项里包含当前项
					c[i].checked = true;
				}else{
					c[i].checked = false;
				}
			}
		}
	}
	
	function checkContain(menuid ,menues){
		var mm = menues.split(",");
		for(var i=0;i<mm.length;i++){
			if(mm[i]==menuid){
				return true;
			}
		}
		return false;
	}
	
	</script>
	<style type="text/css">
	body{
		background-color:#eeeee2;
	}
	</style>
  </head>
  
  <body style="padding-top:1%;">
  <div id="ystreeDivPerant"></div>
    <%=treebody %>
    <form name="menuForm">
    	<input type="hidden" id="nodeid" name="nodeid">
    </form>
  </body>
</html>
