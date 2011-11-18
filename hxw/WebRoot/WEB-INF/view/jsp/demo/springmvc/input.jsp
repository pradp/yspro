<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page import="net.fckeditor.*" %>
<%@ page import="com.yszoe.cms.entity.TXxfbWz"%>
<%
TXxfbWz wz = (TXxfbWz)request.getAttribute("entityBean");
FCKeditor fckEditor = new FCKeditor(request, "nr", "nr");
if(wz!=null && wz.getNr()!=null){
	fckEditor.setValue(wz.getNr());//为FCK编辑器赋值
}
//fckEditor.setToolbarSet("Basic");//决定工具条内容的。参考FCKCONFIG.JS,默认值是Default。
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>编辑明细</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=7" />
	<script type="text/javascript" src="../resources/jquery/jquery-1.6.2.min.js"></script>
	<script type="text/javascript" src="../resources/js/common/webutil.js"></script>
	<script type="text/javascript">
	function doSave(){
		var nr = getEditorHtml('nr');
		if(nr==''){
			alert("文章内容必填填写！");
			return false;
		}
		document.getElementById("nr").value = nr;//获取编辑器内容
		super_doSave(false);
	}

	function getEditorHtml(InstanceID){
		var oEditor = FCKeditorAPI.GetInstance(InstanceID);
		var Content = oEditor.GetXHTML(true);
		return Content;
	}

</script>
  </head>
  
  <body>

<div class="box1" >
<form name="ysform" method="post" >
<input type="hidden" name="wid" value="${entityBean.wid }"/>
 <fieldset> 
　 <legend>详细信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" nowrap="nowrap">标题：</td>
      <td align="left"><input id="bt" name="bt" maxlength="50" size="20" value="${entityBean.bt }"/> </td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap">内容：</td>
      <td align="left"><% out.println(fckEditor); %> </td>
    </tr>
  </table>
 </fieldset>
</form>
</div>
<div class="padding_top10">
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">
					<input type="button" id="ysSaveButton" value=" 保 存 " onclick="doSave()"/>
					<input type="button" value=" 关 闭 " onclick="parent.closeEntityWindow()"/>
				</td>
			</tr>
		</table>
</div> 
    
  </body>
</html>