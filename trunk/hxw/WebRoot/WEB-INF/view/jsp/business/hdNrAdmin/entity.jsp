<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="net.fckeditor.*" %>
<%@ page import="com.opensymphony.xwork2.*"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<%@ page import="com.yszoe.biz.entity.*"%>

<%
THdNr wz = (THdNr)ActionContext.getContext().getValueStack().findValue("thdNr");
FCKeditor fckEditor = new FCKeditor(request, "nr", "thdNr.nr");
if(wz!=null && wz.getNr()!=null){
	fckEditor.setValue(wz.getNr());//为FCK编辑器赋值
}
//fckEditor.setToolbarSet("Basic");//决定工具条内容的。参考FCKCONFIG.JS,默认值是Default。
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
	
    	<title>详细信息</title>
	<script type="text/javascript" src="../clientui/js/pic/bubbleup.js"></script>

	<script type="text/javascript">
	detailPageStyle();
	$(function(){
		checkWzlx();
		$(".imgBubble img").bubbleup({tooltip: true, scale:120});
	});
	validate_length_range_fields = [
	        {fieldId:"bt", minLen:1, maxLen:90, message:"标题必填，且长度在1-30个汉字之间！", ignoreIfEmpty: false},
	        {fieldId:"hdsj", minLen:0, maxLen:300, message:"活动时间必填，且长度在1-300汉字之间！", ignoreIfEmpty: true}
	                    	    ];
	validate_required_fields = [
	        {fieldId:"jg", message:"活动价格不能为空！", mustMatch: true},
	        {fieldId:"nr", message:"活动介绍不能为空！", mustMatch: true}
	];
	function doSave(){
		
		var nr = getEditorHtml('nr');
		document.getElementById("nr").value = nr;//获取编辑器内容
		super_doSave(false);
	}

	function getEditorHtml(InstanceID){
		var oEditor = FCKeditorAPI.GetInstance(InstanceID);
		var Content = oEditor.GetXHTML(true);
		return Content;
	}
	function deletePic(){
		var conf = window.confirm("您确定要删除这个图片吗？");
		if (conf == true) {
			var url = actionName + "-removePic." + uri_suffix;
			var wid = '<s:property value="thdNr.wid"/>';
			$.post(url, { wid : wid, reqtime : (new Date()).getTime() }, function(data) {
				if( data=="ok" ){
					$(".shydtYulan").html("");
				}else{
					alert(data);
				}
			});
		}
	}
	</script>
	<style>  
.imgBubble{
	padding:0px 0 0 5px;
}  
.imgBubble li {
    padding: 0px;
    float: left;
    position: relative;
    margin-left: 5px;
    margin-right: 5px;
    width: 28px;
    height: 28px;
}
.imgBubble li a {
    position: absolute;
}
.imgBubble li img {
    position: absolute;
    width: 28px;
    top: 0px;
    left: 0px;
    padding: 0px;
    margin: 0 8px 0 0;
    border: none;
    overflow: hidden;
}
</style>
  </head>
  
  <body>

<%//下面的div不能用样式，会导致fck和uur脚本冲突 %>
<div class="">

  <s:form name="theform" method="post" theme="simple" enctype="multipart/form-data">
  <s:hidden name="thdNr.wid"/>
  <table width="100%" border="0" align="center">
    <tr> 
      <td width="15%" align="right">标题：</td>
      <td width="85%" align="left" colspan="3">
        <s:textfield name="thdNr.bt" id="bt" maxlength="50" cssStyle="width:60%"/> <label style="color:red">*</label>
      </td>
	</tr>
    <tr> 
      <td align="right">活动时间：</td>
	  <td align="left" colspan="3">
	    <s:textfield name="thdNr.hdsj" id="hdsj" maxlength="50" cssStyle="width:60%"/>
	  </td>
	</tr>
    <tr> 
      <td align="right">活动地点：</td>
	  <td align="left" colspan="3">
	    <s:textfield name="thdNr.hddd" id="hddd" maxlength="50" cssStyle="width:60%"/>
	  </td>
	</tr>
    <tr> 
      <td align="right">主办方资质：</td>
	  <td align="left" colspan="3">
	    <textarea id="zbfzz" name="thdNr.zbfzz" style="width:550px;height:50px;">${thdNr.zbfzz }</textarea>
	  </td>
	</tr>
    <tr id="tr_nr"> 
      <td align="right">活动介绍：</td>
	  <td align="left" colspan="3">
	    <% out.println(fckEditor); %>
	  </td>
	</tr>
    <tr id="tr_syydt" style="display:none"> 
      <td align="right">上传图片：</td>
	  <td align="left" colspan="3">
		  <table border="0" cellpadding="0">
		  	<tr>
			    <td>
			    	<span class="left"><input type="file" name="syydt" class="default" /> <label style="color:red">*</label></span>
			    </td>
				<s:if test="thdNr.syydt!=null">
			    <td width="100" class="shydtYulan">
				    <ul class="imgBubble">
				    	<li><a href="../${thdNr.syydt }" target="_blank"><img id="syydt_img" src="../${thdNr.syydt }" alt="点击查看原图" border="1"/></a></li>
				    </ul>
			    </td>
			    <td class="shydtYulan">
			    	<a href="javascript:deletePic()" title="删除图片"><img src="../clientui/icons/delete.gif" /> </a>
			    </td>
				</s:if>
		  	</tr>
		  </table>
	  </td>
	</tr>
   
    <tr> 
      <td align="right">最大人数：</td>
	  <td align="left">
	  	<s:textfield name="thdNr.zdrs" id="zdrs" maxlength="10" size="20" /> <label style="color:red">*</label>
	  </td>
      <td align="right">组织者：</td>
	  <td align="left">
	    <s:textfield name="thdNr.zzz" id="zzz" maxlength="50" size="20" /> 
	  </td>
	</tr>
    <tr> 
      <td align="right" width="15%">价格：</td>
	  <td align="left" width="30%">
	    <s:textfield name="thdNr.jg" id="jg" maxlength="50" size="20" /> <label style="color:red">*</label>
	  </td>
      <td align="right">状态：</td>
	  <td align="left">
	    <s:select name="thdNr.state" list="getSysCode('hd_state')" listKey="id" listValue="caption" value="thdNr==null?'2':thdNr.state"/> <label style="color:red">*</label>
	  </td>
	</tr>
	<s:if test="thdNr!=null">
    <tr> 
      <td align="right" width="15%">创建日期：</td>
	  <td align="left" width="30%"><s:hidden name="thdNr.cjrq"></s:hidden>
	    <s:date name="thdNr.cjrq" format="yyyy-MM-dd HH:mm"/>
	  </td>
      <td align="right">最后编辑日期：</td>
	  <td align="left"><s:hidden name="thdNr.zhxgrq"></s:hidden>
	    <s:date name="thdNr.zhxgrq" format="yyyy-MM-dd HH:mm"/>
	  </td>
	</tr>
	</s:if>
	<s:if test="thdNr!=null && thdNr.cjrName!=null">
    <tr> 
      <td align="right" width="15%">创建人：</td>
	  <td align="left" width="30%"><s:hidden name="thdNr.cjrName"></s:hidden>
	    <s:property value="thdNr.cjrName"/>
	  </td>
      <td align="right">&nbsp;</td>
	  <td align="left">
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
					<input type="button" id="ysSaveButton" value=" 保 存 " onclick="doSave()"/>
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
