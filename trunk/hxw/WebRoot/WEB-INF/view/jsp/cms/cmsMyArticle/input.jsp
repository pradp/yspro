<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="net.fckeditor.*" %>
<%@ page import="com.opensymphony.xwork2.*"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<%@ page import="com.yszoe.cms.entity.TXxfbWz"%>
<%
TXxfbWz wz = (TXxfbWz)ActionContext.getContext().getValueStack().findValue("txxfbWz");
FCKeditor fckEditor = new FCKeditor(request, "nr", "txxfbWz.nr");
if(wz!=null && wz.getNr()!=null){
	fckEditor.setValue(wz.getNr());//为FCK编辑器赋值
}
//fckEditor.setToolbarSet("Basic");//决定工具条内容的。参考FCKCONFIG.JS,默认值是Default。
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
	
    	<title>详细内容维护</title>
	<script type="text/javascript">
	detailPageStyle();

	validate_length_range_fields = [
	        {fieldId:"bt", minLen:1, maxLen:90, message:"标题必填，且长度在1-30个汉字之间！", ignoreIfEmpty: false}
	    ];
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
<%//下面的div不能用样式，会导致fck和uur脚本冲突 %>
<div class="">
  <s:form name="theform" method="post" theme="simple" enctype="multipart/form-data">
  <s:hidden name="txxfbWz.wid"/>
  <s:hidden name="txxfbWz.wzlx" value="1"/>
  <table width="100%" border="0" align="center">
    <tr> 
      <td width="17%" align="right">标题：</td>
      <td align="left" colspan="3">
        <s:textfield name="txxfbWz.bt" id="bt" maxlength="50" cssStyle="width:60%"/> <label style="color:red">*</label>
      </td>
	</tr>
    <tr id="tr_nr"> 
      <td align="right">内容：</td>
	  <td align="left" colspan="3">
	    <% out.println(fckEditor); %>
	  </td>
	</tr>
    <tr> 
      <td align="right" width="17%">栏目：</td>
	  <td align="left" width="35%">
	    <s:select name="txxfbWz.lmwid" list="getCmsSortAllowFeeds()" listKey="id" listValue="caption"/> <label style="color:red">*</label></td>
      <td align="right" width="13%"></td>
	  <td align="left">
	  </td>
	</tr>
	<s:if test="txxfbWz!=null">
    <tr> 
      <td align="right">创建日期：</td>
	  <td align="left"><s:hidden name="txxfbWz.cjrq"></s:hidden>
	    <s:date name="txxfbWz.cjrq" format="yyyy-MM-dd HH:mm"/>
	  </td>
      <td align="right">最后编辑日期：</td>
	  <td align="left"><s:hidden name="txxfbWz.zhxgrq"></s:hidden>
	    <s:date name="txxfbWz.zhxgrq" format="yyyy-MM-dd HH:mm"/>
	  </td>
	</tr>
	</s:if>
	
	<s:if test="txxfbWz!=null && txxfbWz.shyj!=null">
    <tr> 
      <td align="right">审核意见：</td>
	  <td align="left" colspan="3">
	    <s:property value="txxfbWz.shyj"/>
	  </td>
	</tr>
	</s:if>
  </table>
</s:form>
</div>

<div class="padding_top10">
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">
					<s:if test="txxfbWz==null || txxfbWz.state==0 || txxfbWz.state==-1">
					<input type="button" id="ysSaveButton" value=" 保 存 " onclick="doSave()"/>
					</s:if>
					<input type="button" value=" 关 闭 " onclick="parent.closeEntityWindow()"/>
					<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
						<span id="SystemErrorMessage" style="top: 20px">
							<s:actionerror cssStyle="color:red"/>
							<s:actionmessage cssStyle="color:blue"/>
							<s:fielderror/>
						</span>
					</s:if>
				</td>
			</tr>
		</table>
</div> 
  </body>
</html>
