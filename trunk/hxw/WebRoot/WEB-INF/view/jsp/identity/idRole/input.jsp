<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
	
  		<title>维护角色</title>
	
	<script type="text/javascript">
	var left_index = 0;
	var right_index = 0;
	var size = parseInt('<s:property value="listMenuDepth2.size()"/>');
	$(document).ready(function(){
		//第一个二级菜单选中
		$("li[id='ulli_0']").addClass("current");
		if($.browser.mozilla || ($.browser.msie && $.browser.version > 8)){
			setTimeout("showButtonList()",500);
		}else{
			showButtonList();
		}
		
		//只读模式
		var url = location.href;
		var readOnly = false;
		if(url.indexOf("readOnlyPage")!=-1){
			var readOnlyPage_value_index = url.indexOf("readOnlyPage")+"readOnlyPage=".length;
			readOnly = url.substr(readOnlyPage_value_index,4)=='true';
		}
		if(readOnly){
			$("li a[href*='idMenuButton-list.action']").each(function(i){
				var href = $(this).attr("href");
				$(this).attr("href",href+"&readOnlyPage=true");
			});
			$("div iframe[src*='idMenuButton-list.action']").each(function(i){
				var href = $(this).attr("src");
				$(this).attr("src",href+"&readOnlyPage=true");
			});
		}
	});
	
	detailPageStyle();
	
	var menues_init = '<s:property value="menues"/>';

	function doSave(){
		
		if( !checkInput("rolename","名称不能为空！") ){
			return false;
		}

		return super_doSave();
		
	}
	/**
	 * 调整权限菜单按钮格式 
	 * @memberOf {TypeName} 
	 */
	function showButtonList(){
		var buttons_width = '';
		$("li[id^='ulli_']").each(function(i){
			if(i!=0) buttons_width += ';';
			buttons_width += i + ":" + $("#ulli_"+i).width()+":"+$(this).find("span").html();
		})
		var width_document = document.body.clientWidth;
		var ws = buttons_width.split(";");
		var wis = 0;
		for(var i=0;i<ws.length;i++){
			wis +=	parseInt(ws[i].split(':')[1]);
			right_index = i;
			if(wis>width_document-240){
				break;
			}
		}
		if(right_index < size-1){
			for(var j=right_index+1;j<size;j++){
				$("#ulli_"+j).hide();
			}
			$(".simpleTab_top").prepend("<li id='left_button' style='width:20px'><a onclick='javascript: trunleftorright(0)' target='frmrightChild' style='width:20px'>"
				+"<span class='' style='width:16px;padding: 0 0 0 0;color:green'>《</span></a></li>");
			$(".simpleTab_top").append("<li id='right_button' style='width:20px'><a onclick='javascript: trunleftorright(1)' target='frmrightChild' style='width:20px'>"
				+"<span class='' style='width:16px;padding: 0 0 0 0;color:green'>》</span></a></li>");
			$("#left_button span").addClass("icon_btn_left");
		}
		changeTurnButton();
	}
	function trunleftorright(obj){
		if(obj==0){
			if(left_index!=0){
				left_index -= 1;
				right_index -= 1;
			}
		}else{
			if(right_index!=size-1){
				left_index += 1;
				right_index += 1;
			}
		}
		for(var i=0;i<size;i++){
			if(i<left_index || i>right_index){
				$("#ulli_"+i).hide();
			}else{
				$("#ulli_"+i).show();
			}
		}
		var current_index = parseInt($("li[id^='ulli_'][class='current']").attr("id").substr(5));
		if(current_index<left_index || current_index>right_index){
			$("li[id='ulli_"+current_index+"']").removeClass("current");
			$("li[id='ulli_"+left_index+"']").addClass("current");
			$("li[id='ulli_"+left_index+"'] a span").click();
		}
		changeTurnButton();
	}
	function changeTurnButton(){
		if(left_index!=0){
			$("#left_button").show();
		}else{
			$("#left_button").hide();
		}
		if(right_index!=size-1){
			$("#right_button").show();
		}else{
			$("#right_button").hide();
		}
	}
	</script>
  </head>
  
  <body>

<div id="scrollContent">
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="tsysRole.roleid" />
  <s:hidden id="menues" name="menues"/>
  <s:hidden id="menuebuttons" name="menuebuttons" />
	<div class="box1" panelWidth="100%" >
		<table class="tableStyle" transMode="true" footer="normal">
			<tr> 
				<td width="10%" align="right">角色名称：</td>
				<td width="20%" align="left" nowrap="nowrap"><s:textfield id="rolename" name="tsysRole.rolename" maxlength="15" cssClass="validate[required,length[1,15]]"/> <label style="color:red">*</label></td>
				<td width="13%" align="right">状态：</td>
				<td width="20%" align="left"><s:select name="tsysRole.state" list="#{'1':'启用','0':'禁用'}" listKey="key" listValue="value"/><label style="color:red">*</label></td>
				<td width="37%">&nbsp;</td>
			</tr>
		    <tr> 
		      <td align="right" nowrap="nowrap">描述：</td>
		      <td colspan="4" align="left">
		      	<span class="float_left">
					<s:textarea name="tsysRole.memo" id="memo" cssStyle="width:400px;" cssClass="validate[length[0,50]]"></s:textarea>
				</span>
				<span class="img_light" style="height:80px;" title="限制在50字以内" id="light_id"></span> </td>
		   </tr> 
		   <tr> 
			  <td align="left" width="100%" nowrap="nowrap" colspan="5">
					  <div class="box1" panelWidth="600" align="left">
						<div class="simpleTab" iframeMode="true">
							<ul class="simpleTab_top">
				  				<s:iterator value="listMenuDepth2" status="stuts">
									<li id='ulli_<s:property value="%{#stuts.index}"/>'><a href="./idMenuButton-list.action?roleid=<s:property value='tsysRole.roleid'/>&upmenuid=<s:property value='id'/>" target="frmrightChild">
									<span><s:property value="caption" /></span></a></li>
								</s:iterator>
							</ul>
							<div class="simpleTab_con">
								<IFRAME scrolling="no" width="100%" frameBorder=0 id=frmrightChild 
								name=frmrightChild onload="iframeHeight('frmrightChild')" 
								src="./idMenuButton-list.action?roleid=<s:property value='tsysRole.roleid'/>&upmenuid=<s:property value='defaultMenuid'/>"  allowTransparency="true"></IFRAME>
							</div>
						</div>
					 </div>
			  </td>
		   </tr>
	  </table>
	</div>
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
</div>
  </body>
</html>
