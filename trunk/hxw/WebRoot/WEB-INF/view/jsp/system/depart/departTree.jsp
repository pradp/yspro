<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<jsp:directive.page import="com.yszoe.identity.IdConstants"/>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.yszoe.identity.entity.LoginUserVO"%>
<%@ page import="com.yszoe.identity.entity.TSysDepart"%>
<%@ page import="com.yszoe.identity.service.impl.TreeSupport"%>
<%@ page import="com.yszoe.biz.service.impl.BizTreeSupport"%>
<%@ page import="com.yszoe.biz.Constants"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

	String isEditSelf_ = (String)request.getParameter("isEditSelf");//是否是维护树的功能
	boolean isEditSelf = isEditSelf_==null?false:true;
	
	String showCheckBox__ = (String)request.getParameter("showCheckBox");
	boolean showCheckBox = showCheckBox__==null?false:Boolean.valueOf(showCheckBox__).booleanValue();
	
	LoginUserVO tsysUser = (LoginUserVO) session.getAttribute(IdConstants.SESSION_USER);
	TSysDepart tdepart =tsysUser.getDepart();
	String nodeid=tdepart.getDepartid();
	
	String type = (String)request.getParameter("type");
	if(Constants.DEPARTTYPE_AREA.equals(tdepart.getDeparttype()) && "0".equals(type)){	
		type = "1";	
	}
	List list = new ArrayList();
	String state = (String)request.getParameter("state");
	String dutyid = (String)request.getParameter("dutyid");
	String onlyCompany = (String)request.getParameter("onlyCompany");
	String jcxl = (String)request.getParameter("jcxl");
	String treebody = null;
	if(StringUtils.isNotBlank(state)){  
		list = BizTreeSupport.QueryDepartTreeData( nodeid ,type, state, dutyid, onlyCompany, jcxl);
		BizTreeSupport s = new BizTreeSupport();      
		treebody = s.writeTree(list, false, "ystree",false);
	}else{
		list = TreeSupport.QueryTreeData( type, nodeid );
		TreeSupport s = new TreeSupport();      
		treebody = s.writeTree(list, false, "ystree",false);
	}
	
	String _nodeid_ = "2";
	if(nodeid!=null && nodeid.length()>6){
		_nodeid_ = nodeid.substring(5,6);
	}

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>component/ystree/">

	<script type="text/javascript" src="../../resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="resource/js/ysframework.js"></script>
	<script type="text/javascript" src="resource/js/ystree.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="resource/css/ystree.css">
	
	<script type="text/javascript">
	  var type = '<%=type%>';
      //树对象句柄
      var ystree = new YsTree('ystree');
      ystree.config.useCookies = false;
      ystree.config.showCheckBox = <%=showCheckBox %>;//是否启用checkbox
      var isEditSelf = <%=isEditSelf %>;//是否是维护树的功能
      
		$(function(){
			var state = '<%=state %>';
			document.bgColor = '#eeeee2';
			document.getElementById("ystreeDivPerant").innerHTML = ystree;
			doInit();
			var dutyid = '<%=dutyid==null?"":dutyid %>';
			var onlyCompany = '<%=onlyCompany==null?"":onlyCompany %>';
			if(dutyid != ''){
				if(ystree.aNodes.length <2){
					if(onlyCompany == ''){
						alert("该任务无监测场！");
					}else{
						alert("该任务无监测公司！");
					}
				}
			}
		})
      //点击节点文字触发的事件
      function nodeText_clicked(nodeid){
      	if(isEditSelf){
			if(nodeid.indexOf('<%=nodeid%>')>=0){
				window.parent.document.getElementById('menuContentFrame').src='<%=basePath%>system/depart-input.action?wid='+nodeid+'&type='+type;
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
	
      function resetValue(obj,type){
    	  super_resetValue(obj);
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
		var level = getLevel(nodeid);
		if (ishave) {//alert("in");
			var state = '<%=state %>';
			var dutyid = '<%=dutyid==null?"":dutyid %>';
			var treeType = '<%=type %>';
			var jcxl = '<%=jcxl %>';
			if(state=='1'){
				var url = "<%=basePath%>jsonVisitor/ajaxBiz-loadTreeChild.action?"+(new Date()).getTime();
				$.getJSON(url, {param: nodeid, treeType:treeType+"_"+dutyid+"_"+jcxl}, function(data){
			    	//data = eval("("+data+")");
			    	var treedata = data.datamap.treedata;
					ystree.createChildNode(treedata, index, level);
					
					$("input[@type='checkbox']").each(function(){
						if(this.value == nodeid && this.checked){
							for ( var j = 0; j < ystree.aNodes.length; j++) {
								if(ystree.aNodes[j].pid == nodeid){
									$("input[@type='checkbox']").each(function(){
										if($(this).val()==ystree.aNodes[j].id){
											$(this).attr("checked","checked");
										}
									});
								}
							}
						}
					});
					doInit();
				});
			}else{
				var url = "<%=basePath%>jsonVisitor/ajaxSys-loadTreeChild.action?"+(new Date()).getTime();
				$.getJSON(url, {param: nodeid, treeType:treeType}, function(data){
			    	//data = eval("("+data+")");
			    	var treedata = data.datamap.treedata;
					ystree.createChildNode(treedata, index, level);
					doInit();
				});
			}
		}
	}
	</script>
	<style>
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
  
  <body style="padding-top:1%;padding-left:7%;">
    <div id="ystreeDivPerant"></div>
		<%=treebody%>
		<form name="menuForm">
			<input type="hidden" id="nodeid" name="nodeid">

		</form>
		<% if(StringUtils.isNotBlank(dutyid)){ %>
		<div style="margin-bottom: 10px"><font color="#AOAOAO" size="2px">注释：只显示参加监测的区域、公司或场，没有监测单位的只显示根节点。<%if(StringUtils.isBlank(onlyCompany)){ %>选择监测场必须展开其所在公司或区域的节点！<%} %></font></div>
		<%}
			if(showCheckBox){ %>
			<div>
				<button onclick="doClickEnter(2)">
					 <span id="qdButton">确定</span></button>
				<button onclick="window.close()">
					<span id="qxButton">取消</span></button>
			</div>
		<% } %>
  </body>
</html>
