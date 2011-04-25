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
		document.getElementById("bssj").value="";
		document.getElementById("dxmmc").value="";
		document.getElementById("xxmmc").value="";	
		document.getElementById("xbz").value="";	
		document.getElementById("zb").value="";
		document.getElementById("ydyxm").value="";
		document.getElementById("dbd").value="";
	}
	
	var i =0;
	function getzy1(){
		i=1;
		document.getElementById("xxmmc_later").value="";	
		document.getElementById("zb_later").value="";	
		document.getElementById("xbz_later").value="";	
		getzy();
	}
	
	function getzy(){
		var dxmmc=document.getElementById("dxmmc").value;
		if(dxmmc!=""){
	   		changeSelectHtml(dxmmc);
	   	}
	}

	function changeSelectHtml(obj){
			ajaxService.getSelectXxmmc(obj,cb);
			ajaxService.getSelectZb(obj,cd);
			ajaxService.getSelectXbz(obj,cf);
	}

	function cb(result){
		var changeSelectId = "xxmmc";
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		DWRUtil.removeAllOptions('xxmmc');
		DWRUtil.addOptions( changeSelectId, result,'id','caption');
		var obj = document.getElementById("xxmmc_later");
		if(obj.value != '' && i==0){
			DWRUtil.setValue(changeSelectId,obj.value);
		}
		$ = jQuery;
	}
	function cd(result){
		var changeSelectId = "zb";
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		jQuery("#zbContainer").html('<select name="tsportCjYdy.zb" id="zb"><option value="">--请选择--</option></select>');
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
		jQuery("#xbzContainer").html('<select name="tsportCjYdy.xbz" id="xbz"><option value="">--请选择--</option></select>');
		DWRUtil.addOptions( changeSelectId, result );
		var obj = document.getElementById("xbz_later");
		if(obj.value != '' && i==0){
			DWRUtil.setValue(changeSelectId,obj.value);
		}
		$ = jQuery;
	}
	</script>
  </head>
<body onload="getzy()"> 
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
    <input type="hidden" value="<s:property value="tsportCjYdy.xxmmc" />" id="xxmmc_later" />
	<input type="hidden" value="<s:property value="tsportCjYdy.zb" />" id="zb_later" />
	<input type="hidden" value="<s:property value="tsportCjYdy.xbz" />" id="xbz_later" />
  		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleftt">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
								<tr align="center">
									<td align="right" nowrap="nowrap" class="">&nbsp;&nbsp;&nbsp;比赛时间：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield name="bssj" id="bssj" maxlength="20" size="20" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"  />
									</td>
									<td align="right" nowrap="nowrap" class="" colspan="1" width="10%">&nbsp;项目：</td>
									<td align="left" nowrap="nowrap" colspan="1"  width="15%">
										 <s:select name="tsportCjYdy.dxmmc" id ="dxmmc" list="getAllDxmmc()" listKey="caption" onchange="getzy1()" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="" colspan="1" width="10%">&nbsp;级（赛）别：</td>
									<td align="left" nowrap="nowrap" id="xxmmcContainer" colspan="1" width="40%">
										 <s:select name="tsportCjYdy.xxmmc" id ="xxmmc" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="-------请选择-------"/>
									</td>
									<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;性别组：</td>
									<td align="left" nowrap="nowrap" id="xbzContainer" colspan="1">
										 <s:select name="tsportCjYdy.xbz" id ="xbz" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
								</tr>
								<tr>	
									<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;组别：</td>
									<td align="left" nowrap="nowrap" id="zbContainer" colspan="1">
										 <s:select name="tsportCjYdy.zb" id ="zb" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="">运动员：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield name="tsportCjYdy.ydyxm" id="ydyxm" maxlength="20" size="20" />
									</td>
									<td align="right" nowrap="nowrap" class="">代表地：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="tsportCjYdy.dbd" id ="dbd" list="getDbdName()" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="center" rowspan="2" nowrap="nowrap"><ul class="btn_gn">
										<li>
											<a href="#" title="查询" onClick="super_doSearch()"
												id="searchButton" name="btn3"><span> 查询 </span>
											</a>
										</li></ul></td>
									<td align="center" rowspan="2" nowrap="nowrap"><ul class="btn_gn">
										<li>
											<a href="#" title="重置" onClick="doreset()"
												id="searchButton2" name="btn4"><span> 重置 </span>
											</a>
										</li>
									</ul></td>
								</tr>
							</table>
						</td>
						<td width="15" height="75" class="chaxunrightt">
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
    			&nbsp;说明：区县只计算金牌！   &nbsp;<b>本次查询结果为</b>：运动员基本信息表汇总值：<s:property value="%{@com.imchooser.util.NumberUtil@formatPoint(pager.totalRows*0.5)}" />，实际折算汇总值：<s:property value="%{@com.imchooser.util.NumberUtil@formatPoint(#hz_jps)}" />   
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
    			<th width="8%">比赛时间</th>
    			<th width="12%">级（赛）别</th>
    			<th width="8%">运动员</th>
    			<th width="8%">代表地区县</th>
    			<th width="8%">得牌</th>
    			<th width="8%">得分</th>
    			<th width="8%">&nbsp;</th>
    			<th width="8%">注册地区县</th>
    			<th width="8%">原注册地区县</th>
    			</tr>
    		</thead>
    		<tbody id="listData">
    		<s:iterator value="resultData" status="status">
    		   <s:set name="ydyxxb" value="resultData[#status.index][6].split('_')"/>
    		   <s:set name="zsb" value="resultData[#status.index][7].split('_')"/>
		    		<tr>
     			  		 <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][0]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][1]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][2]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][3]" /></td>
                         <td style="vertical-align:middle">&nbsp;
                         <s:if test="%{resultData[#status.index][4].toString()!=null&&resultData[#status.index][4].toString()!=''&&resultData[#status.index][4]!='0'.toString()}"><s:property value="resultData[#status.index][4]" />金
                         </s:if><s:else>--</s:else></td>
                         <td style="vertical-align:middle">&nbsp;
                         <s:if test="%{resultData[#status.index][5].toString()!=null&&resultData[#status.index][5].toString()!=''&&resultData[#status.index][5]!='0'.toString()}"><s:property value="resultData[#status.index][5]" /></s:if>
                         <s:else>--</s:else></td>
                         <td><table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
						      <tr><td scope="row"><strong>信息表地区</strong></td></tr>
						      <tr><td scope="row"><strong>折算地区</strong></td></tr>
						      <tr><td scope="row"><strong>奖牌</strong></td></tr>
						    </table></td>
                         <td><table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
						      <tr><td>
						       <s:if test="%{#ydyxxb[0]==null||#ydyxxb[0].toString()==''}">--</s:if>
						       <s:else>&nbsp;<s:property value="#ydyxxb[0]" /></s:else></td>
						      </tr>
						      <s:if test="#zsb[0].toString()=='注册地'" >
						      	<tr><td><s:if test="%{#zsb[1]==null||#zsb[1].toString()==''}">--</s:if>
						      	 <s:else>&nbsp;<s:property value="#zsb[1]" /></s:else></td></tr>
						     	 <tr><td>
						     		 <s:if test="%{#zsb[2].toString()!=null&&#zsb[2].toString()!=''&&#zsb[2]-1!='0'.toString()&&#zsb[2]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[2]-1)" />金
                         			</s:if><s:else>--</s:else></td>
                        		</tr>
						      </s:if>
						      <s:else>
						      <tr><td>--</td></tr>
						       <tr><td>--</td></tr>
						      </s:else>
						    </table></td>
                         <td><table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
						       <tr><td>
						       <s:if test="%{#ydyxxb[1]==null||#ydyxxb[1].toString()==''}">--</s:if>
						       <s:else>&nbsp;<s:property value="#ydyxxb[1]" /></s:else></td>
						      </tr>
						      <s:if test="#zsb[0].toString()=='原注册地'" >
						      	<tr><td><s:if test="%{#zsb[1]==null||#zsb[1].toString()==''}">--</s:if>
						      	 <s:else>&nbsp;<s:property value="#zsb[1]" /></s:else></td></tr>
						     	 <tr><td>
						     		 <s:if test="%{#zsb[2].toString()!=null&&#zsb[2].toString()!=''&&#zsb[2]-1!='0'.toString()&&#zsb[2]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[2]-1)" />金
                         			</s:if><s:else>--</s:else></td></tr>
						      </s:if>
						      <s:elseif test="#zsb[4].toString()=='原注册地'">
							      <tr><td><s:if test="%{#zsb[5]==null||#zsb[5].toString()==''}">--</s:if>
							      	 <s:else>&nbsp;<s:property value="#zsb[5]" /></s:else></td></tr>
							     	 <tr><td>
							     		 <s:if test="%{#zsb[6].toString()!=null&&#zsb[6].toString()!=''&&#zsb[6]-1!='0'.toString()&&#zsb[6]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[6]-1)" />金
	                         			</s:if><s:else>--</s:else></td></tr>
						      </s:elseif>
						      <s:else>
						      <tr><td>--</td></tr>
						       <tr><td>--</td></tr>
						      </s:else>
						    </table>
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

