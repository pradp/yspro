<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<jsp:directive.page import="com.imchooser.framework.identity.IdConstants"/>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.imchooser.framework.identity.entity.LoginUserVO"%>
<%@ page import="com.imchooser.framework.identity.entity.TSysDepart"%>
<%@ page import="com.imchooser.infoms.service.sys.impl.AreaTreeSupport"%>
<%@ page import="com.imchooser.infoms.service.sys.Constants"%>
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
	
	AreaTreeSupport s = new AreaTreeSupport();        
	List list = AreaTreeSupport.QueryTreeData( nodeid );
	final String treebody = s.writeTree(list, false, "ystree");
	
	String _nodeid_ = "2";
	if(nodeid!=null && nodeid.length()>6){
		_nodeid_ = nodeid.substring(5,6);
	}
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
      //点击节点文字触发的事件
      function nodeText_clicked(nodeid){
      	if(isEditSelf){
			if(nodeid.indexOf('<%=nodeid%>')>=0){
				window.parent.document.getElementById('menuContentFrame').src='<%=basePath%>system/depart-input.c?tsysDepart.departid='+nodeid;
			}
      	}else{
			var allPathNodeText = document.getElementById("node_"+nodeid).innerText;
			var tem_valueObjid = window.dialogArguments.tem_valueObjid;
			var tem_nameObjid = window.dialogArguments.tem_nameObjid;
			setParentWindowValue(tem_valueObjid, nodeid);
			setParentWindowValue(tem_nameObjid, allPathNodeText);
			window.close();
      	}
      }
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
	</script>
	<style type="text/css">
	body{
		background-color:#eeeee2;
	}
	</style>
  </head>
  
  <body style="padding-top:1%;padding-left:7%">
    <%=treebody %>
    <%
    String mergedepart=request.getParameter("departid");
    if(StringUtils.isNotBlank(mergedepart)){
    %>
    <form name="menuForm">
	  <table width="100%" border="0" align="center">
	    <tr> 
	      <td colspan="7">&nbsp;</td>
	    </tr>
	  <tr align="center" valign="middle"> 
	    <td height="30" colspan="7">
	    <input type="button" value=" 确定 " onclick="addSub()"/>
	    <input type="button" value=" 关闭 " onclick="saveDepart()"/>
	    </td>
	  </tr>
	  </table>
    </form>
    <%} %>
  </body>
</html>
