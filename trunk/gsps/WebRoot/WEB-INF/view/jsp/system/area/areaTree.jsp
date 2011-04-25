<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="com.imchooser.infoms.service.sys.impl.AreaTreeSupport"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	String isEditSelf_ = (String)request.getParameter("isEditSelf");//是否是维护树的功能
	boolean isEditSelf = isEditSelf_==null?false:true;
	
	String showCheckBox__ = (String)request.getParameter("showCheckBox");
	boolean showCheckBox = showCheckBox__==null?false:Boolean.valueOf(showCheckBox__).booleanValue();
	
	AreaTreeSupport s = new AreaTreeSupport();        
	java.util.List list = AreaTreeSupport.QueryAreaData( );
	final String treebody = s.writeTree(list, false, "ystree");
	//注意数据源，根节点的ID是空字符串，不是-1.
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>component/ystree/">
    <title>tree</title>

	<script type="text/javascript" src="resource/js/ystree.pack.js"></script>
	<script type="text/javascript" src="<%=basePath%>resources/js/common/myutil.js"></script>
	<link rel="stylesheet" type="text/css" href="resource/css/ystree.css">
	
	<script type="text/javascript">
    //树对象句柄
    var ystree = new YsTree('ystree');
    ystree.config.showCheckBox = <%=showCheckBox %>;//是否启用checkbox
    var isEditSelf = <%=isEditSelf %>;//是否是维护树的功能
	//隐藏上级市县和高校节点
	window.onload=function(){
    		var n = 0;
		for (n; n < ystree.aNodes.length; n++) {
    			if (ystree.aNodes[n].id.length > 6) {
    				ystree.aNodes[n]._io = true;
    			}else{
    				ystree.aNodes[n]._io = false;
    			}
		}
		writeTreeCode();
	}
      //点击节点文字触发的事件
      function nodeText_clicked(nodeid, index){
        	if(isEditSelf){
        		window.parent.document.getElementById('menuContentFrame').src='<%=basePath%>system/area-input.c?tsysArea.areaid='+nodeid;
          	}else{
    			//var allPathNodeText = findAllPathText(obj);
    			/*
    			if(ystree.aNodes[index].pid.length<9){
    				alert("请选择具体区县！");
    				return;
    			}
    			*/
    			var allPathNodeText = document.getElementById("node_"+nodeid).innerText;
    			var tem_valueObjid = window.dialogArguments.tem_valueObjid;
    			var tem_nameObjid = window.dialogArguments.tem_nameObjid;
    			setParentWindowValue(tem_valueObjid, nodeid);
    			setParentWindowValue(tem_nameObjid, allPathNodeText);
    			window.close();
          	}
      }
	//为当前节点找祖先节点的名称
	function findAllPathText(obj){
		var textHtml = "";
		$("label").each(function(i){
			var cuid = this.id;
			if( obj.id.indexOf(cuid)!==-1 ){
				textHtml = $.trim($(this).text()) + "|" + textHtml;
			}
		});
		var nodes = textHtml.split("|");
		textHtml = "";
		for(var i=nodes.length-1;i>=0;i--){
			textHtml = textHtml+nodes[i];
		}
		return textHtml;
	}
	//displaySecondNode(2);
	</script>
	<style type="text/css">
	body{
		background-color:#eeeee2;
	}
	</style>
  </head>
  
  <body style="padding-top:3%;padding-left:7%">
    <%=treebody %>
    <form name="menuForm">
    	<input type="hidden" id="nodeid" name="nodeid">
    </form>
  </body>
</html>
