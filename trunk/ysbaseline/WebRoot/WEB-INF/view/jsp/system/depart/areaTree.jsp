<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<jsp:directive.page import="com.yszoe.framework.identity.IdConstants"/>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.yszoe.framework.identity.entity.LoginUserVO"%>
<%@ page import="com.yszoe.framework.identity.entity.TSysDepart"%>
<%@ page import="com.yszoe.sys.service.impl.AreaTreeSupport"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String showCheckBox__ = (String)request.getAttribute("showCheckBox");
boolean showCheckBox = showCheckBox__==null?false:Boolean.valueOf(showCheckBox__).booleanValue();

LoginUserVO tsysUser = (LoginUserVO) session.getAttribute(IdConstants.SESSION_USER);
TSysDepart tdepart =tsysUser.getDepart();
String nodeid=tdepart.getDepartid();
String type=tdepart.getDeparttype();

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
	<link rel="stylesheet" type="text/css" href="resource/css/ystree.css">
	<script type="text/javascript" src="resource/js/ystree.pack.js"></script>
	
	   <script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	   <script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	   <script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	
	<script type="text/javascript">
      //树对象句柄
      var ystree = new YsTree('ystree');
      ystree.config.useCookies = false;
      ystree.config.showCheckBox = <%=showCheckBox %>;//是否启用checkbox
      //点击节点文字触发的事件
      function nodeText_clicked(nodeid){
      	if(!ystree.config.showCheckBox){
			if(nodeid.indexOf('<%=nodeid%>')>=0){
				window.parent.document.getElementById('menuContentFrame').src='<%=basePath%>system/depart-input.c?tsysDepart.departid='+nodeid;
			}
      	}
      }
	//隐藏上级市县和高校节点
	window.onload=function(){
		if(<%=type.equals("7")%>){//市
			ystree.aNodes[0].id=ystree.aNodes[1].id;
			ystree.aNodes.remove(2);
	  }else{
		if(<%=nodeid.length()==3%>){//省
			ystree.aNodes[0].id=ystree.aNodes[3].id;
			ystree.aNodes.remove(1);
			ystree.aNodes.remove(3);
		}else{//高校
			ystree.aNodes[0].id=ystree.aNodes[3].id;
			ystree.aNodes.remove(1);
			ystree.aNodes.remove(3);
		}
	  }
		writeTreeCode();
		
		for(var i=0;i<ystree.aNodes.length;i++){
			ystree.closeAllChildren(ystree.aNodes[i]);
		}
		
		if(ystree.config.showCheckBox){
			initMenuChecked();
		}
		
	}
	</script>
	<script>
        //用ajax查询子节点
      function loaddata(nodeid,index){
       var ishave=false;
	  for(var i=0;i<ystree.aNodes.length;i++){
		  if(ystree.aNodes[i].pid==nodeid&&ystree.aNodes[i].name=="加载中"){
			  ystree.aNodes[i].name = "";//aNodes.remove(i)删除数据有问题
			  ishave=true;
			  break;
		    }
	    }
	    if(ishave){//alert("in");
             ajaxService.loadchildzzjgwh(nodeid,function(treedata){
              
            	 ystree.createChildNode(treedata, index);
               //为多选框的情况,要放在ajax执行完的后面.为了全部加载完后再选中.
    	       if(ystree.config.showCheckBox){
    				initMenuChecked();
    			}
   			
              });
          }
          
      }
</script>
	<style type="text/css">
	body{
		background-color:#eeeee2;
	}
	</style>
  </head>
  
  <body style="padding-top:1%;padding-left:7%">
  <div id="ystreeDiv" class="ystree"></div>
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
