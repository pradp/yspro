<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="com.yszoe.identity.service.impl.TreeSupport"%>
<%@ page import="com.yszoe.identity.entity.TSysMenu"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";

	String isEditSelf_ = (String)request.getParameter("isEditSelf");//是否是维护树的功能
	boolean isEditSelf = isEditSelf_==null?false:true;
	String showCheckBox__ = (String) request.getAttribute("showCheckBox");
	boolean showCheckBox = showCheckBox__ == null ? false : Boolean.valueOf(showCheckBox__).booleanValue();
	String menuid = request.getParameter("menuid");
	menuid = menuid == null ? "000" : menuid;

	java.util.List list = TreeSupport.QueryTreeData("3",menuid);

	TreeSupport s = new TreeSupport();
	final String treebody = s.writeTree(list, false, "ystree",false);
%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<base href="<%=basePath%>component/ystree/">
		<script type="text/javascript" src="resource/js/ysframework.js"></script>
		<script type="text/javascript" src="resource/js/ystree.pack.js"></script>
		<script type="text/javascript">
		var ystree = new YsTree("ystree");
		ystree.config.useCookies = false;
		ystree.config.showCheckBox = <%=showCheckBox%>;//是否启用checkbox
      	var isEditSelf = <%=isEditSelf %>;//是否是维护树的功能
      //点击节点文字触发的事件
      function nodeText_clicked(nodeid){
      	if(isEditSelf){
			if(nodeid.indexOf('000')>=0){
				window.parent.document.getElementById('menuContentFrame').src='<%=basePath%>id/idMenu-input.action?wid='+nodeid;
			}
      	}else{
			var allPathNodeText = document.getElementById("node_"+nodeid).innerHTML;
			var tem_valueObjid = window.dialogArguments.tem_valueObjid;
			var tem_nameObjid = window.dialogArguments.tem_nameObjid;
			window.dialogArguments.document.getElementById(tem_valueObjid).value = nodeid;
			window.dialogArguments.document.getElementById(tem_nameObjid).value = allPathNodeText;
			window.close();
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

	//用ajax查询子节点
	function loaddata(nodeid, index) {
		var ishave = false;//是否加载过此节点下数据
		for ( var i = 0; i < ystree.aNodes.length; i++) {
			if (ystree.aNodes[i].pid == nodeid && ystree.aNodes[i].name == "加载中") {
				ystree.aNodes[i].name = "";//aNodes.remove(i)删除数据有问题
				ishave = true;
				break;
			}
		}
		if (ishave) {//alert("in");
			var url = "<%=basePath%>jsonVisitor/ajaxSys-loadTreeChild.action?"+(new Date()).getTime();
			$.getJSON(url, {param: nodeid, treeType:"3" }, function(data){
		    	//data = eval("("+data+")");
		    	var treedata = data.datamap.treedata;
				ystree.createChildNode(treedata, index);
	
				//为多选框的情况,要放在ajax执行完的后面.为了全部加载完后再选中.
					if (ystree.config.showCheckBox) {
						initMenuChecked();
					}
	
				});
		}
	}
	</script>
		<link rel="stylesheet" type="text/css" href="resource/css/ystree.css">
	<style type="text/css">
	body {
		background-color:#eeeee2;
	}
	</style>
	</head>

	<body style="padding-top: 1%;">
		<div id="ystreeDivPerant"></div>
		<%=treebody%>
		<form name="menuForm">
			<input type="hidden" id="nodeid" name="nodeid">

		</form>
	</body>
</html>
