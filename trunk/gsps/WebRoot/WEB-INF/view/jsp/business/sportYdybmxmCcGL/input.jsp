<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title><s:property value="xm"/> 一次报名设置 </title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.bgiframe.min.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.ajaxQueue.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/thickbox-compressed.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
	<script type="text/javascript">
		detailPageStyle();
		jQuery(document).ready(function(){
			$(":checkbox").each(function(i){
				if(i%5==4){
					$(this).before("<br />");
				}else{
					//$(this).before("</td><td>");
				}
			});
		});


		function doreset()
		{	
			document.getElementById("dxmmc").value="";
			document.getElementById("zb").value="";
			document.getElementById("xbz").value="";	
		}
		
		var i =0;
		function getzy1(){
			i=1;
			document.getElementById("zb_later").value="";	
			document.getElementById("xbz_later").value="";
//			document.getElementById("xxmmc_later").value="";		
			getzy();
		}
		function getzy(){
			var dxmmc=document.getElementById("dxmmc").value;
			if(dxmmc!=""){
		   		changeSelectHtml(dxmmc);
		   	}
		}
		function changeSelectHtml(obj){
				ajaxService.getSelectZb(obj,cd);
				ajaxService.getSelectXbz(obj,cf);
//				ajaxService.getSelectxxmmc(obj,cb);
		}
		function cd(result){
			var changeSelectId = "zb";
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			jQuery("#zbContainer").html('<select name="tsportYdybmxmCc.zb" id="zb"></select>');
			DWRUtil.addOptions( changeSelectId, result );
			var obj = document.getElementById("zb_later");
			if(obj.value != '' && i==0){
				DWRUtil.setValue(changeSelectId,obj.value);
				}
			$ = jQuery;
		}
		function cf(result){
			var changeSelectId = "xbz";
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			jQuery("#xbzContainer").html('<select name="tsportYdybmxmCc.xbz" id="xbz"></select>');
			DWRUtil.addOptions( changeSelectId, result );
			var obj = document.getElementById("xbz_later");
			if(obj.value != '' && i==0){
				DWRUtil.setValue(changeSelectId,obj.value);
			}
			$ = jQuery;
		}

		/**
		 * 提交列表页面上的查询
		 * 提交前重置页码值。避免翻页后，修改查询条件，界面没有数据显示出来
		 * @param {Object} resetUrl 是否重置url为list.c。
		 */
		function super_doSearch( resetUrl ){

		    if (actionName == null || actionName == "") {
		        actionName = getActionName();
		    }
		    if(document.getElementById('pager_currentPageno')){
		    	document.getElementById('pager_currentPageno').value=1;
		    }
		    if (resetUrl) {
		    	document.forms[0].action = actionName + "-input." + uri_suffix + "?wid=1&reqtime="+(new Date()).getTime();
			}
		    document.forms[0].submit();
		}
	</script>
	
  	<base target="_self">
  </head>
  
<body style="text-align:center;" >
<!-- header start -->
<s:if test="actionErrors.size()> 0 || actionMessages.size()>0 || fieldErrors.size()>0">
<div id="SystemErrorMessage">
<s:actionerror />
<s:actionmessage />
<s:fielderror />
</div>
</s:if>
<!-- header end -->

<div class="framestyle" style="width:90%;padding: 0pt 10pt 10pt 10pt;">
<s:form name="theform" method="post" theme="simple" >
<s:hidden name="wid"></s:hidden>
<s:hidden name="xm"></s:hidden>
<s:hidden name="tsportYdybmxmCc.ydywid"></s:hidden>
<s:hidden name="tsportYdybmxmCc.zb"></s:hidden>
<s:hidden name="tsportYdybmxmCc.zbbm"></s:hidden>
<s:hidden name="tsportYdybmxmCc.xb"></s:hidden>
<s:hidden name="tsportYdybmxmCc.xbbm"></s:hidden>
<s:hidden name="tsportYdybmxmCc.bsxmwid1"></s:hidden>

    	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleft">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
								<tr align="center">
									<td align="right" nowrap="nowrap" class="" width="10%">&nbsp;项目：</td>
									<td align="left" nowrap="nowrap"  width="10%">
										<s:select name="tsportYdybmxmCc.dxmmc" id ="dxmmc" list="getMyDxmmc()" listKey="id" onchange="getzy1()" listValue="caption"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;组别：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield name="tsportYdybmxmCc.zb" id="zb" disabled="true" size="10" maxlength="8" ></s:textfield>
										 <%--<s:select name="tsportYdybmxmCc.zb" id ="zb" list="#{}" listKey="id" listValue="caption"/>id="zbContainer"id="xbzContainer"
									--%></td>
									<td align="right" nowrap="nowrap" class="">&nbsp;性别：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield name="tsportYdybmxmCc.xb" id="xb" disabled="true" size="2" maxlength="2"></s:textfield>
									</td>
								 </tr>
							</table>
						</td>
						<td width="15" height="75" class="chaxunright">
							&nbsp;
						</td>
					</tr>
				</table></td></tr></table>
<fieldset>
<legend>小项目列表</legend>
  <table width="100%" border="0">
  		<tr><td>
  		<s:if test="#vallist==null">
  		 	 该运动员未参加一次报名。
  		</s:if><s:elseif test="tsportYdybmxmCc.zb==null||tsportYdybmxmCc.zb==''">
  			该运动员一次报名没有报组别
  		</s:elseif>
  		<s:else>
  		  <s:checkboxlist list="getAllXxmmcMap()" name="se" value="%{#vallist}" ></s:checkboxlist>
  		</s:else>
  		</td></tr>
  </table>
</fieldset>
 <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%" class="maginB">
			<tr height="25" align="left">
				<td colspan="10">&nbsp;&nbsp;&nbsp;
				<b>说明：</b>勾选的项目为一次报名项目
				</td>
			</tr>
	</table>
  <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle">	   
	    <td height="30" colspan="7">
	    	    
<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="26%"><tr><td height="30px" width="440px">
	<ul class="btn_gn">	
		<li>
			<a href="#" title="保存" onClick="submitForm();" id="sendMsgButton"><span>保存<s:property value="display" /></span> </a>
		</li>
		<li>
			<a href="#" title="关闭" onClick="parent.closeInputWindow();" id="sendMsgButton"><span>关闭</span> </a>
		</li>																															
	</ul>
</td></tr></table>

			</td>
	  </tr>
  </table>
</s:form>
</div>
</body>
</html>
