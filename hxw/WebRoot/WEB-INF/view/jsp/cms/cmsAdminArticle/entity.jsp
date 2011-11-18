<%@ page language="java" pageEncoding="UTF-8"%>
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
	
    	<title>文章详细信息</title>
	<script type="text/javascript" src="../clientui/js/pic/bubbleup.js"></script>

	<script type="text/javascript">
	detailPageStyle();
	$(function(){
		checkWzlx();
		$(".imgBubble img").bubbleup({tooltip: true, scale:120});
	});
	validate_length_range_fields = [
	        {fieldId:"bt", minLen:1, maxLen:90, message:"标题必填，且长度在1-30个汉字之间！", ignoreIfEmpty: false},
	        {fieldId:"zy", minLen:0, maxLen:600, message:"摘要必填，且长度在0-200汉字之间！", ignoreIfEmpty: true},
	        {fieldId:"gjz", minLen:1, maxLen:60, message:"关键字必填，且长度在1-20汉字之间！", ignoreIfEmpty: false},
	        {fieldId:"bturl", minLen:0, maxLen:150, message:"标题超链接地址必填，且长度在0-15个汉字之间！", ignoreIfEmpty: true},
	        {fieldId:"ly", minLen:1, maxLen:50, message:"来源必填，且长度在1-15汉字之间！", ignoreIfEmpty: false}
	                    	    ];
	function doSave(){
		if(document.getElementById("wzlx").value=="2" && document.getElementById("bturl").value==""){
			//文章类型
			alert("标题新闻的标题超链接地址是必须要填写的！");
			document.getElementById("bturl").focus();
			return false;
		}
		if(document.getElementById("sfsyxs").value=="1" && document.getElementById("zy").value==""){
			alert("首页重点推荐文章的摘要信息必须要填写！");
			document.getElementById("zy").focus();
			return false;
		}
		var nr = getEditorHtml('nr');
		document.getElementById("nr").value = nr;//获取编辑器内容
		super_doSave(false);
	}

	function checkWzlx(){
		if(document.getElementById("wzlx").value=="1"){//普通新闻
			$("#tr_bturl").hide();
			$("#tr_nr").show();
			$("#tr_syydt").hide();
		}else if(document.getElementById("wzlx").value=="2"){//标题新闻
			$("#tr_bturl").show();
			$("#tr_nr").hide();
			$("#tr_syydt").hide();
		}else if(document.getElementById("wzlx").value=="3"){//图片导读新闻
			$("#tr_bturl").hide();
			$("#tr_nr").show();
			$("#tr_syydt").show();
		}
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
			var wid = '<s:property value="txxfbWz.wid"/>';
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
  <s:hidden name="txxfbWz.wid"/>
  <table width="100%" border="0" align="center">
    <tr> 
      <td width="15%" align="right">标题：</td>
      <td width="85%" align="left" colspan="3">
        <s:textfield name="txxfbWz.bt" id="bt" maxlength="50" cssStyle="width:60%"/> <label style="color:red">*</label>
      </td>
	</tr>
    <tr> 
      <td align="right">副标题：</td>
	  <td align="left" colspan="3">
	    <s:textfield name="txxfbWz.fbt" id="fbt" maxlength="50" cssStyle="width:60%"/>
	  </td>
	</tr>
    <tr> 
      <td align="right">摘要：</td>
	  <td align="left" colspan="3">
	    <textarea id="zy" name="txxfbWz.zy" style="width:550px;height:50px;">${txxfbWz.zy }</textarea>
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
	    <s:select name="txxfbWz.lmwid" list="getCmsSort()" listKey="id" listValue="caption"/> <label style="color:red">*</label></td>
      <td align="right" width="13%">类型：</td>
	  <td align="left">
	    <span class="float_left"><s:select id="wzlx" name="txxfbWz.wzlx" list="getSysCode('xxfb_wzlx')" listKey="id" listValue="caption" onchange="checkWzlx()"/> <label style="color:red">*</label></span>
	    <span class="img_light" style="height:22px;" title="标题新闻指标题直接外部超链接；图片导读新闻需要上传图片，填写摘要，会在首页显示图片。"></span>
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
				<s:if test="txxfbWz.syydt!=null">
			    <td width="100" class="shydtYulan">
				    <ul class="imgBubble">
				    	<li><a href="../${txxfbWz.syydt }" target="_blank"><img id="syydt_img" src="../${txxfbWz.syydt }" alt="点击查看原图" border="1"/></a></li>
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
    <tr id="tr_bturl" style="display:none"> 
      <td align="right">标题超链接地址：</td>
	  <td align="left" colspan="3">
	    <s:textfield name="txxfbWz.bturl" id="bturl" maxlength="50" size="20" cssStyle="width:60%;"/> <label style="color:red">*</label>
	  </td>
	</tr>
   
    <tr> 
      <td align="right">文章来源：</td>
	  <td align="left">
	  	<s:textfield name="txxfbWz.ly" id="ly" maxlength="50" size="20" value="%{txxfbWz==null?'北京种畜禽遗传资源网':txxfbWz.ly}"/> <label style="color:red">*</label>
	  </td>
      <td align="right">关键字：</td>
	  <td align="left">
	    <span class="float_left"><s:textfield name="txxfbWz.gjz" id="gjz" /> <label style="color:red">*</label></span>
	    <span class="img_light" style="height:22px;" title="用于相关新闻推荐。多个关键字用空格隔开，最多20个字。"></span>
	  </td>
	</tr>
    <tr> 
      <td align="right" width="15%">首页头条新闻：</td>
	  <td align="left" width="30%">
	    <span class="float_left"><s:select id="sfsyxs" name="txxfbWz.sfsyxs" list="getSysCode('BOOLEAN')" listKey="id" listValue="caption" value="txxfbWz==null?'0':txxfbWz.sfsyxs"/> <label style="color:red">*</label></span>
	    <span class="img_light" style="height:22px;" title="显示在首页偏上区域重点推荐，主要要填写文章摘要。"></span>
	  </td>
      <td align="right" width="15%">是否推荐：</td>
	  <td align="left">
	    <s:select name="txxfbWz.sftj" list="getSysCode('BOOLEAN')" listKey="id" listValue="caption"/> <label style="color:red">*</label>
	  </td>
	</tr>
    <tr> 
      <td align="right" width="15%">是否允许评论：</td>
	  <td align="left" width="30%">
	    <s:select name="txxfbWz.sfpl" list="getSysCode('xxfb_plqx')" listKey="id" listValue="caption"/> <label style="color:red">*</label>
	  </td>
      <td align="right">文章状态：</td>
	  <td align="left">
	    <s:select name="txxfbWz.state" list="getSysCode('xxfb_wzzt')" listKey="id" listValue="caption" value="txxfbWz==null?'2':txxfbWz.state"/> <label style="color:red">*</label>
	  </td>
	</tr>
    <tr> 
      <td align="right" width="15%">置顶：</td>
	  <td align="left">
	    <s:select name="txxfbWz.ordernum" list="getSysCode('xxfb_wzzd')" listKey="id" listValue="caption" value="txxfbWz==null?0:txxfbWz.ordernum"/> <label style="color:red">*</label>
	  </td>
      <td align="right" width="10%">&nbsp;</td>
	  <td align="left">
	    
	  </td>
	</tr>
	<s:if test="txxfbWz!=null">
    <tr> 
      <td align="right" width="15%">创建日期：</td>
	  <td align="left" width="30%"><s:hidden name="txxfbWz.cjrq"></s:hidden>
	    <s:date name="txxfbWz.cjrq" format="yyyy-MM-dd HH:mm"/>
	  </td>
      <td align="right">最后编辑日期：</td>
	  <td align="left"><s:hidden name="txxfbWz.zhxgrq"></s:hidden>
	    <s:date name="txxfbWz.zhxgrq" format="yyyy-MM-dd HH:mm"/>
	  </td>
	</tr>
	</s:if>
	<s:if test="txxfbWz!=null && txxfbWz.cjrName!=null">
    <tr> 
      <td align="right" width="15%">创建人：</td>
	  <td align="left" width="30%"><s:hidden name="txxfbWz.cjrName"></s:hidden>
	    <s:property value="txxfbWz.cjrName"/>
	  </td>
      <td align="right">&nbsp;</td>
	  <td align="left">
	  </td>
	</tr>
	</s:if>
	<s:if test="txxfbWz!=null && txxfbWz.shyj!=null">
    <tr> 
      <td align="right" width="15%">审核意见：</td>
	  <td align="left" width="80%" colspan="3">
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
