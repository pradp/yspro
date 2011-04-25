<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
	<script type="text/javascript">
	listPageStyle();
	$(document).ready(function(){
		jQuery("#listTable").unbind("click");
	});
	var objid = parent.tem_valueObjid;
	var objname = parent.tem_nameObjid;
	function doRefreshSysProp(){
		ajaxService.refreshSysProp(ajaxBackString);
	}
	function doreset()
	{	
		document.getElementById("dxmmc").value="";
		document.getElementById("bmstate").value="";
		document.getElementById("dbd").value="";
	}
	</script>
  </head>
<body> 
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" >
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>
   <div id="listC" style="text-align:center;">
    <s:form theme="simple" name="theform">
    <s:hidden name="pager.formname" value="theform"/>
  		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="70%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleft">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="80%">
								<tr align="center">
								<s:if test="getDepartID().length()==3">
									<td align="right" nowrap="nowrap" class="">代表团：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="tsportBsxm.dbd" id ="dbd" list="getDbdMc()" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td></s:if>
									<td align="right" nowrap="nowrap" class="">&nbsp;项目：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="tsportBsxm.dxmmc" id="dxmmc" list="getAllDxmmc()" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--" />
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;状态：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="tsportBsxm.bmstate" id ="bmstate" list="#{'未开始':'未开始','在报名中':'在报名中','报名结束':'报名结束'}" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="center" rowspan="2" nowrap="nowrap"><ul class="btn_gn">
										<li>
											<a href="#" title="查询" onClick="super_doSearch()"
												id="searchButton" name="btn3"><span> 查询 </span>
											</a>
										</li>
										<li>
											<a href="#" title="重置" onClick="doreset()"
												id="searchButton2" name="btn4"><span> 重置 </span>
											</a>
										</li>
									</ul></td>
								</tr>
							</table>
						</td>
						<td width="15" height="75" class="chaxunright">
							&nbsp;
						</td>
					</tr>
				</table></td></tr></table>

    <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%" class="maginB">
			<tr height="25" align="left">
				<td colspan="10">&nbsp;&nbsp;&nbsp;<b>统计：</b>
				<s:if test="getDepartID().length()==3">
					<s:if test="%{(tsportBsxm.dbd!=null && tsportBsxm.dbd!='')|| (tsportBsxm.dxmmc!=null && tsportBsxm.dxmmc!='')}">
					</s:if>
					<s:else>已报代表团<s:property value="#countDbts" />个，未报代表团<s:property value="#countDbts_wb" />个，
					</s:else>
				</s:if>
				<s:if test="tsportBsxm.dxmmc!=null&&tsportBsxm.dxmmc!=''">
				项目<s:property value="#dxmmc" /> 一次已报名<s:property value="#countYcbmxx" />小项，二次已报名<s:property value="#countRcbmxx"/>小项
				</s:if><s:else>
				一次已报名<s:property value="#countYcbm" />大项，二次已报名<s:property value="#countRcbm"/>大项
				</s:else>
				</td>
			</tr>
	</table>
    	<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%">
    		<tr>
    		</tr>
    	</table>
    	
    	
  	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB" >
	  <tr>
	    <td class="infomainbg">
		
		
		<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>
			
    	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
    		<thead id="listHead">
  				<tr>
  				<s:if test="tsportBsxm.dxmmc!=null&&tsportBsxm.dxmmc!=''">
    			<th width="6%">赛（级）别</th>
  				</s:if><s:else>
    			<th width="6%">代表团</th></s:else>
    			<th width="6%">状态</th>
    			<th width="6%">一次报名人数</th>
    			<th width="6%">二次报名人数</th>
  				<s:if test="#dxmmc==null||#dxmmc==''">
    			<th width="6%">一次报名大项目数</th>
    			<th width="6%">二次已报大项目数</th>
    			</s:if>
    			</tr>
    		</thead>
    		<tbody id="listData">
    		<s:iterator value="resultData" status="status">
		    		<tr>
     			  		 <td>&nbsp;<s:property value="resultData[#status.index][0]" /></td>
                         <td>&nbsp;<s:property value="resultData[#status.index][1]" /></td>
                         <td>&nbsp;<s:property value="resultData[#status.index][2]" />人</td>
                         <td>&nbsp;<s:property value="resultData[#status.index][3]" />人</td>
  						<s:if test="#dxmmc==null||#dxmmc==''">
                         <td>&nbsp;<s:property value="resultData[#status.index][4]" />项</td>
                         <td>&nbsp;<s:property value="resultData[#status.index][5]" />项</td>
                        </s:if>
	    			</tr>
    			</s:iterator>
    		 </tbody>
    	</table>
    	    	</td>
	        </tr>
	    </table>
		
		</td>
	    <td width="10" class="infomainright">&nbsp;</td>
	  </tr>
	  <tr>
	    <td height="20" class="infobottomleft"></td>
	    <td width="10" class="infobottomright"></td>
	  </tr>
	</table>
	
    	<table border="0" cellspacing="0" cellpadding="0" width="100%">
  		   <tr>
    			<td colspan="10" align="right">
    			<s:property value="pager.postToolBar" escape="false"/>
    			</td>
    		</tr>
    	</table>
    	</s:form>
    </div>
  </body>
</html>

