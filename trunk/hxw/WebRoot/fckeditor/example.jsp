<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="net.fckeditor.*" %>
<%
FCKeditor fckEditor = new FCKeditor(request, "contentEditor");
//fckEditor.setToolbarSet("Basic");//决定工具条内容的。参考FCKCONFIG.JS,默认值是Default。
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
<script type="text/javascript">
function getEditorContent(){
	var oEditor = FCKeditorAPI.GetInstance("contentEditor");
	var Content = oEditor.GetXHTML(true);
	alert(Content);
}
</script>
  </head>

  <body>
    <% out.println(fckEditor); %>
<input type="button" value="aaaaaa" onclick="getEditorContent()">
  </body>
</html>
