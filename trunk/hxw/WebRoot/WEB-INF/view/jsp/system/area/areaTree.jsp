<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ page import="com.yszoe.identity.service.impl.TreeSupport"%>
<%@ page import="com.yszoe.biz.service.impl.BizTreeSupport"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	String isEditSelf_ = (String)request.getParameter("isEditSelf");//是否是维护树的功能
	boolean isEditSelf = isEditSelf_==null?false:true;
	
	String showCheckBox__ = (String)request.getParameter("showCheckBox");
	boolean showCheckBox = showCheckBox__==null?false:Boolean.valueOf(showCheckBox__).booleanValue();

	String dutyid = (String)request.getParameter("dutyid");
	String jcxl = (String)request.getParameter("jcxl");
	TreeSupport s = new TreeSupport();        
	List list = new ArrayList();
	if(StringUtils.isBlank(dutyid)){
		list = TreeSupport.QueryTreeData("2","");
	}else{
		list = BizTreeSupport.QueryAreaTreeData(dutyid,jcxl);
	}
	final String treebody = s.writeTree(list, false, "ystree",false);
	//注意数据源，根节点的ID是空字符串，不是-1.

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>component/ystree/">
    <title>tree</title>

	<script type="text/javascript" src="../../resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="resource/js/ystree.pack.js"></script>
	<script type="text/javascript" src="resource/js/ysframework.js"></script>
	<link rel="stylesheet" type="text/css" href="resource/css/ystree.css">
	<script type="text/javascript">
    //树对象句柄
    var ystree = new YsTree('ystree');
    ystree.config.useCookies = false;
    ystree.config.showCheckBox = <%=showCheckBox %>;//是否启用checkbox
    var isEditSelf = <%=isEditSelf %>;//是否是维护树的功能
	
    $(document).ready(function(){
		for(var i=0;i<ystree.aNodes.length;i++){
			if(ystree.aNodes[i].id.length==6){
				ystree.aNodes[i]._io = false;
			}
		}
		ystreecheckboxname = 'menuContentFrame';
		document.getElementById("ystreeDivPerant").innerHTML = ystree;
		
		doInit();
		var dutyid = '<%=dutyid==null?"":dutyid %>';
		if(dutyid != ''){
			if(ystree.aNodes.length <2){
				alert("该任务无监测区域！");
			}
		}
	});
    
      //点击节点文字触发的事件
      function nodeText_clicked(nodeid, index){
        	if(isEditSelf){
        		if(window.parent.document.getElementById('menuContentFrame'))
        			window.parent.document.getElementById('menuContentFrame').src='<%=basePath%>system/area-input.action?tsysArea.areaid='+nodeid+'&isEditSelf='+isEditSelf;
          	}else{
          		if(nodeid.length != 3){
	    			var allPathNodeText = document.getElementById("node_"+nodeid).innerHTML;
	    			var tem_valueObjid = window.dialogArguments.tem_valueObjid;
	    			var tem_nameObjid = window.dialogArguments.tem_nameObjid;
	    			window.dialogArguments.document.getElementById(tem_valueObjid).value = nodeid;
	    			window.dialogArguments.document.getElementById(tem_nameObjid).value = allPathNodeText;
	    			//setParentWindowValue(tem_valueObjid, nodeid);
	    			//setParentWindowValue(tem_nameObjid, allPathNodeText);
	    			window.close();
    			}else{
    				alert("不能选择北京市！");
    			}
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
			$.getJSON(url, {param: nodeid, treeType:"2" }, function(data){
		    	//data = eval("("+data+")");
		    	var treedata = data.datamap.treedata;
				ystree.createChildNode(treedata, index);
			});
		}
	}
	</script>
	<style type="text/css">
		body{
			background-color:#eeeee2;
		}
		button {
		    background: url("../../clientui/skins/sky/form/btn_bg.jpg") repeat scroll 0 0 transparent;
		    border: 1px solid #83B1F2;
		    font-size: 12px;
		    height: 22px;
		    line-height: 20px;
		    padding-left: 5px;
		    margin-left: 5px;
    		width: 66px;
		}
		button span {
			padding: 0 5px 0 18px;
			text-align: center;
			display: block;
			style-float: left;
			cursor: pointer;
		}
		#qdButton {
			background-image: "url('../../clientui/icons/ok.gif')";
			background-position: 0 40%;
			background-repeat: no-repeat;
		}
		#qxButton {
			background-image: "url('../../clientui/icons/delete.gif')";
			background-position: 0 40%;
			background-repeat: no-repeat;
		}
	</style>
  </head>
  
  <body style="padding-top:1%;padding-left:7%">
    <div id="ystreeDivPerant"></div>
		<%=treebody%>
		<form name="menuForm">
			<input type="hidden" id="nodeid" name="nodeid">

		</form>
		<% if(StringUtils.isNotBlank(dutyid)){ %>
		<div style="margin-bottom: 10px"><font color="#AOAOAO" size="2px">注释：只显示参加监测的区域，没有监测区域的只显示根节点。</font></div>
		<% }
		   if(showCheckBox){ %>
			<div>
				<button onclick="doClickEnter(1)">
					 <span id="qdButton">确定</span></button>
				<button onclick="window.close()">
					<span id="qxButton">取消</span></button>
			</div>
		<% } %>
  </body>
</html>
