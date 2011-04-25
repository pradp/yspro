<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="com.yszoe.sys.service.impl.AreaTreeSupport"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

String showCheckBox__ = (String)request.getAttribute("showCheckBox");
boolean showCheckBox = showCheckBox__==null?false:Boolean.valueOf(showCheckBox__).booleanValue();

AreaTreeSupport s = new AreaTreeSupport();        
java.util.List list = AreaTreeSupport.QueryAreaData( );
final String treebody = s.writeTree(list);
//注意数据源，根节点的ID是空字符串，不是-1.

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>component/ystree/" target="_self">
    <title>tree</title>

	<script type="text/javascript" src="resource/js/ysframework.js"></script>
	<script type="text/javascript" src="<%=basePath%>resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="resource/js/ystree.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="resource/css/ystree.css">
	
	 <script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	 <script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	 <script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	
	
	<script type="text/javascript">
      //树对象句柄
      var ystree = new YsTree('ystree');
      ystree.config.useCookies = false;
      ystree.config.showCheckBox = <%=showCheckBox %>;//是否启用checkbox
      //点击节点文字触发的事件
      function nodeText_clicked(nodeid, index){
      	if(!ystree.config.showCheckBox){
			//var allPathNodeText = findAllPathText(obj);
			if(ystree.aNodes[index].pid.length<9){
				alert("请选择具体区县！");
				return;
			}
			var allPathNodeText = document.getElementById("node_"+nodeid).innerText;
			var queryid = nodeid;
			var tem_valueObjid = window.dialogArguments.tem_valueObjid;
			var tem_nameObjid = window.dialogArguments.tem_nameObjid;
			setParentWindowValue(tem_valueObjid, queryid);
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
	
	 $(document).ready(function(){
		for(var i=0;i<ystree.aNodes.length;i++){
			ystree.closeAllChildren(ystree.aNodes[i]);
		}
		
		if(ystree.config.showCheckBox){
			initMenuChecked();
		}
	});
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
             ajaxService.loadchildjthjqx(nodeid,function(treedata){
              if(treedata!=null&&treedata!="[]"){
            	  var jsonarray=eval("("+treedata+")");
                   var node="";
                   var currentIndex = ystree.aNodes.length-1;
                   for(var i=0;i<jsonarray.length;i++){
                       var obj=jsonarray[i];
                       currentIndex += 1;
                        ystree.add(obj.id,obj.pid,obj.name,obj.url,true); 
                        var divinner="";
                        if(ystree.config.showCheckBox){
                        	divinner="<div class='ysTreeNode'><img src='resource/images/style1/line.gif'/>"
                                +"<img alt='' src='resource/images/style1/join.gif'/>"
                                +"<input id='checkbox_"+obj.id+"' type='checkbox' onclick='resetValue(this)' value='"+obj.id+"' name='ystreeCheckBoxName'/>"
                                +"<img id='iystree"+currentIndex+"' src='resource/images/style1/page.gif'/>"
                                +"<label id='node_"+obj.id+"' class='nodeSel' style='cursor: pointer;' onclick='ystree.s("+currentIndex+");' for='checkbox_"+obj.id+"'>"+obj.name+"</label>"
                                +"</div>";
                           
                        }else{
                        	divinner="<div class='ysTreeNode'><img src='resource/images/style1/line.gif'/>"
                                +"<img alt='' src='resource/images/style1/join.gif'/><img id='iystree"+currentIndex+"' src='resource/images/style1/page.gif'/>"
                                +"<a id='node_"+obj.id+"' class='node' href='javascript: ystree.s("+currentIndex+")';>"+obj.name+"</a>"
                                +"</div>";
                        }
                       
                      node =node+divinner;
                     }
                   document.getElementById("dystree"+index).innerHTML=node;
                 }else{
                    // alert("no data!");// 
                    var nd=ystree.aNodes[index];
                    var text="";
                    if(ystree.config.showCheckBox){
                        text="<img alt='' src='resource/images/style1/join.gif'/>"
                            +"<input id='checkbox_"+nd.id+"' type='checkbox' onclick='resetValue(this)' value='"+nd.id+"' name='ystreeCheckBoxName'/>"
                            +"<img id='iystree"+index+"' src='resource/images/style1/page.gif'/>"
                            +"<label id='node_"+nd.id+"' class='nodeSel' style='cursor: pointer;' onclick='ystree.s("+index+");' for='checkbox_"+nd.id+"'>"+nd.name+"</label>";
                        
                     }else{
                     text="<img alt='' src='resource/images/style1/join.gif'/>"
                         +"<img id='iystree"+index+"' src='resource/images/style1/page.gif'/>"
                         +"<a id='node_"+nd.id+"' class='nodeSel' href='javascript: ystree.s("+index+");'>"+nd.name+"</a>";
                     }
                     document.getElementById("iystree"+index).parentElement.innerHTML=text;//把文件夹变成文件的形式
                     //document.getElementById("dystree"+index).innerHTML="";此用法会使层拉开距离
                     document.getElementById("dystree"+index).style.display="none";
                    
                 }
              
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
  
  <body style="padding-top:3%;padding-left:7%">
    <%=treebody %>
    <form name="menuForm">
    	<input type="hidden" id="nodeid" name="nodeid">
    </form>
  </body>
</html>
