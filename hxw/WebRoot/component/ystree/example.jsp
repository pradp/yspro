<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.List" %>
<jsp:directive.page import="net.ysen.tree.test.ExampleTreeSupport;"/>
<%
ExampleTreeSupport s = new ExampleTreeSupport();        
List list = ExampleTreeSupport.QueryDepartData();
final String treebody = s.writeTree(list);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title> - Example Tree - </title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">

      <script type="text/javascript" src="resource/js/ystree.js"></script>
      <script type="text/javascript">
      var ystree = new YsTree('ystree');//树对象句柄
      ystree.config.showCheckBox = false;//是否启用checkbox
      //点击节点文字触发的事件
      function nodeText_clicked(nodeid){
      	alert(nodeid);
      }
      </script>
  </head>
  
  <body>
    <input id="ystreenodeid" type="hidden" name="ystreenodeid">
    <%=treebody %>
    <p>
    	注意数据源，根节点ID是空，不是-1.
    </p>
  </body>

</html>
