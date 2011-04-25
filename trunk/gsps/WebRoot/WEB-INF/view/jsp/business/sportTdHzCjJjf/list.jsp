<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript">
	listPageStyle();
	var objid = parent.tem_valueObjid;
	var objname = parent.tem_nameObjid;
	function doRefreshSysProp(){
		ajaxService.refreshSysProp(ajaxBackString);
	}
	function doreset()
	{	
		document.getElementById("departidcx").value="";		
	}

	</script>
  </head>
<body > 
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
    <s:hidden name="departid" id="departid"/>
    <s:hidden name="type"  value="%{#type}" />
    	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="50%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleft">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
								<tr align="center">
									<td align="right" nowrap="nowrap" class="">&nbsp;&nbsp;&nbsp;地区：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield name="departidcx" id="departidcx" maxlength="20" size="20" />
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
						<td width="15" height="49" class="chaxunright">
							&nbsp;
						</td>
					</tr>
				</table></td></tr></table>

    <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%" class="maginB">
			<tr align="center">
				
			</tr>
	</table>
    	<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%">
    		<tr>
    			<td height="30px" colspan="10">
    			<ul class="btn_gn">
			    <li><a href="#" title="修改比赛项目" onClick="modifySelected()"  name="modifyStudent"><span>修改</span></a></li>
			</ul>
    	     </td>
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
    			<th height="20px" width="5%"><s:checkbox name="selectAll" onclick="doSelectAll()" /></th>
    			<th width="10%">地区</th>
    			<th width="8%">加减分</th>
    			<th width="8%">加减金牌数</th>
    			<th width="8%">加减银牌数</th>
    			<th width="8%">加减铜牌数</th>
    			<th width="8%">操作</th>
    		</tr>
    		</thead>
    		<tbody id="listData">
 	   <s:iterator value="resultData" status="stat">
    		<tr>
     			<td ><s:checkbox id="%{resultData[#stat.index][0]}" name="selectNode" fieldValue="%{resultData[#stat.index][0]}"/></td>
      			<td><s:property value="resultData[#stat.index][1]"/>&nbsp;&nbsp;</td>
      			<td><s:property value="resultData[#stat.index][2]"/>&nbsp;&nbsp;</td>
      			<td><s:property value="resultData[#stat.index][3]"/>&nbsp;&nbsp;</td>  
      			<td><s:property value="resultData[#stat.index][4]"/>&nbsp;&nbsp;</td>
    			<td><s:property value="resultData[#stat.index][5]"/>&nbsp;&nbsp;</td>
    			<%--<s:if test="resultData[#stat.index][6].length()>=15&&resultData[#stat.index][6].length()<=600">
    			<td>&nbsp;&nbsp;<s:property value="resultData[#stat.index][6].substring(0,15)+'...'"/></td>
    			</s:if><s:else><td>&nbsp;&nbsp;<s:property value="resultData[#stat.index][6]"/></td></s:else>
    			--%><td nowrap="nowrap">
					<a href="javascript:input('<s:property value="resultData[#stat.index][0]"/>',false)">
					<FONT color="blue">编辑</FONT></a>
				</td>
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

