<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ page import="net.ysen.tree.*,net.ysen.tree.entitybean.*" %>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.yszoe.framework.identity.IdConstants"%>
<%@ page import="com.yszoe.framework.identity.entity.TSysUser"%>
<%@ page import="com.yszoe.framework.identity.entity.TSysDepart"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

TSysUser tsysUser = (TSysUser) session.getAttribute(IdConstants.SESSION_USER);
TSysDepart tdepart =tsysUser.getDepart();
String nodeid=tdepart.getDepartid();
java.util.List list = com.yszoe.sys.service.impl.AreaTreeSupport.QueryTreeData( nodeid );
ITree treeVO = TreeFactory.getInstance("com.yszoe.sys.service.impl.AreaTreeSupport",true);

TreeBean.setShowCheckBox(false);
String treebody = "null data";
try{
	TreeBean tree = treeVO.loadTreeData(list);
	treebody = treeVO.getTreeExpressCode(tree, Consts.ExpressCodeType.HTML);
}catch(NullPointerException e){
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>component/ystree/">
    <title>选择单位</title>
    <script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/zxdk.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/myutil.js"></script>
	<script type="text/javascript" src="resource/js/ysframework.js"></script>
	<script type="text/javascript" src="resource/js/ystreecontrol.js"></script>
	
	<script type="text/javascript">
	on_off_actionWhenClickText = true;
	on_off_usedForEditTree = false;
	var todepartid=null;
	var mergeDepart='<%=request.getParameter("departid")%>';
	function clickingText(obj){
		if(on_off_actionWhenClickText == true){
			//var allPathNodeText = findAllPathText(obj);
			var allPathNodeText = obj.innerText;
			var queryid = obj.id.replace("label_","");
			if(mergeDepart.substring(0,mergeDepart.length-3)==queryid.substring(0,queryid.length-3)){
				todepartid=queryid;
			}else{
				alert('所选择的单位必须为同一父节点下的同级节点');
			}
			//window.parent.document.getElementById('menuContentFrame').src='/system/depart-input.c?tsysDepart.departid='+queryid;
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
	displaySecondNode(2);
	$(document).ready(function(){
			detailPageStyle();
		}
	);	
	function unite(){
		if(todepartid==null){
			alert('请选择合并单位！');
			return;
		}
		if(todepartid==mergeDepart){
			alert('合并单位不可以为同一单位！');
			return;
		}
		if(confirm('是否合并该单位？合并的同时将会删除该单位！')){
			ajaxService.mergeDepart(todepartid,mergeDepart,'<%=nodeid%>',function(res){
				if(res=='1'){
					alert('操作成功！');
					window.dialogArguments.document.getElementById('menuContentFrame').src='';
					window.dialogArguments.document.getElementById('menuFrame').src='<s:property value="basePath"/>/system/depart-areaTree.c';				
					window.close();					
				}
				else
				{
					alert('发生错误！');
				}
			});			
		}
	}	
	</script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/resources/css/zxdk.css">
  </head>
  
  <body class="framestyle" style="width:98%;padding: 0pt 10pt 10pt 10pt;">
 <fieldset> 
　 <legend>选择单位</legend>
  <table width="100%" border="0" align="center">   
    <tr>      
      <td align="left">
 <%=treebody %>      
      </td>
    </tr>     
  </table>
  </fieldset>    
	  <table width="100%" border="0" align="center">
	    <tr> 
	      <td colspan="7">&nbsp;</td>
	    </tr>
	  <tr align="center" valign="middle"> 
	    <td height="30" colspan="7">
	    <input type="button" value=" 确定 " onclick="unite()"/>
	    <input type="button" value=" 关闭 " onclick="window.close()"/>
	    </td>
	  </tr>
	  </table>
  </body>
</html>
