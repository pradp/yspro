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
	<script type="text/javascript">
	listPageStyle();
	var objid = parent.tem_valueObjid;
	var objname = parent.tem_nameObjid;
	function doRefreshSysProp(){
		ajaxService.refreshSysProp(ajaxBackString);
	}
	function doreset()
	{	
		document.getElementById("dbtmc").value="";
		document.getElementById("yddmc").value="";		
	}
	var clicked = false;
	//发布
	function fbcj(){
		if(clicked==false){
			$("#btn_fbcj").addClass("btn_gn_disable");
			ajaxService.fbjscj(function(data){
				alert(data);
				$("#btn_fbcj").removeClass("btn_gn_disable");
				clicked = false;
				return false;
			});
		}
		clicked = true;
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
    <s:hidden name="type"  value="%{#type}" />
    	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleft">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
								<tr align="center">
								<s:if test="#type=='sx'">
									<td align="right" nowrap="nowrap" class="">&nbsp;运动队名称：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield id="yddmc" name="tsportCjSxHzYl.yddmc" maxlength="20" size="20"/>
									</td>
								</s:if>
								<s:if test="#type=='td'">
								    <td align="right" nowrap="nowrap" class="">&nbsp;&nbsp;&nbsp;代表团名称：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield name="tsportCjTdHzYl.dbtmc" id="dbtmc" maxlength="20" size="20" />
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;&nbsp;&nbsp;汇总类型：</td>
									<td align="left" nowrap="nowrap">
										<s:select name="tsportCjTdHzYl.hzlx" id ="hzlx" list="getSysCode('CJ_HZLX')" listKey="id" listValue="caption"  headerKey="" headerValue="--请选择--"/>
									</td>
								</s:if>
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
    			<%--<th height="20px" width="5%"><s:checkbox name="selectAll" onclick="doSelectAll()" /></th>--%>
    			<s:if test="#type=='sx'"><th width="10%">运动队名称</th></s:if>
    			<s:if test="#type=='td'"><th width="10%">代表团名称</th></s:if>
    			<th width="6%">成绩</th>
    			<th width="6%">金牌数</th>
    			<th width="6%">银牌数</th>
    			<th width="6%">铜牌数</th>
    			<th width="6%">合计奖牌数</th>
    			<th width="6%">名次</th>
    			<th width="10%">汇总类型</th>
    			<%--<th width="15%">操作</th>
    		--%></tr>
    		</thead>
    		<tbody id="listData">
    		<s:if test="#type=='sx'">
 	         	<s:iterator value="resultData">
		    		<tr>
		     			<%--<td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
		    			<td><s:property value="dbtmc" />&nbsp;&nbsp;</td>
		    			--%>
		    			<td><s:property value="yddmc" />&nbsp;&nbsp;</td>
		    			<td><s:property value="df"/>&nbsp;&nbsp;</td>
		    			<td><s:property value="jps"/>&nbsp;&nbsp;</td>
		    			<td><s:property value="yps"/>&nbsp;&nbsp;</td>
		    			<td><s:property value="tps"/>&nbsp;&nbsp;</td>
		    			<td><s:property value="hjjps"/>&nbsp;&nbsp;</td>
		    			<td><s:property value="mc"/>&nbsp;&nbsp;</td>
		    			<td><s:property value="hzlx"/>&nbsp;&nbsp;</td>
		    			<%--<td><s:if test="hzlx==1">金牌榜</s:if><s:elseif test="hzlx==2">奖牌榜</s:elseif><s:elseif test="hzlx==3">得分榜</s:elseif>&nbsp;&nbsp;</td>
		    			<td nowrap="nowrap">
							<a href="javascript:input('<s:property value="wid"/>',false)">
							<FONT color="blue">编辑</FONT></a>
						</td>
		    		--%></tr>
    			</s:iterator>
    		</s:if>
    		<s:if test="#type=='td'">
    		<s:iterator value="resultData">
		    		<tr>
		     			<td><s:property value="dbtmc" />&nbsp;&nbsp;</td>
		    			<td><s:property value="df"/>&nbsp;&nbsp;</td>
		    			<td><s:property value="jps"/>&nbsp;&nbsp;</td>
		    			<td><s:property value="yps"/>&nbsp;&nbsp;</td>
		    			<td><s:property value="tps"/>&nbsp;&nbsp;</td>
		    			<td><s:property value="hjjps"/>&nbsp;&nbsp;</td>
		    			<td><s:property value="mc"/>&nbsp;&nbsp;</td>
		    			<td><s:property value="hzlx"/>&nbsp;&nbsp;</td>
		    			</tr>
    			</s:iterator>
    		</s:if>
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

