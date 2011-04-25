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
	function ce(result){
		var changeSelectId = "dxmmc";
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		jQuery("#dxmmcContainer").html('<select name="tsportBsxm.dxmmc" id="dxmmc" onchange="getzy1()" ><option value="" >--请选择--</option></select>');
		DWRUtil.addOptions( changeSelectId, result );
		var obj = document.getElementById("dxmmc_later");
		if(obj.value != '' && i==0){
			DWRUtil.setValue(changeSelectId,obj.value);
		}
		$ = jQuery;
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
		jQuery("#zbContainer").html('<select name="tsportBsxm.zb" id="zb"><option value="">--请选择--</option></select>');
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
		jQuery("#xbzContainer").html('<select name="tsportBsxm.xbz" id="xbz"><option value="">--请选择--</option></select>');
		DWRUtil.addOptions( changeSelectId, result );
		var obj = document.getElementById("xbz_later");
		if(obj.value != '' && i==0){
			DWRUtil.setValue(changeSelectId,obj.value);
		}
		$ = jQuery;
	}
	</script>
  </head>
<body onload="getzy()" > 
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" >
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>
   <div id="listC" style="text-align:center;">
    <s:form theme="simple" name="theform">
  <s:hidden name="cd" value="%{#parameters.cd[0]}" id="cd" />
    <s:hidden name="pager.formname" value="theform"/>
    <input type="hidden" value="<s:property value="tsportBsxm.xxmmc" />" id="xxmmc_later" />
    <input type="hidden" value="<s:property value="tsportBsxm.dxmmc" />" id="dxmmc_later" />
    <input type="hidden" value="<s:property value="tsportBsxm.zb" />" id="zb_later" />
	<input type="hidden" value="<s:property value="tsportBsxm.xbz" />" id="xbz_later" />
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
										 <s:select name="tsportBsxm.dxmmc" id ="dxmmc" list="getAllDxmmc()" listKey="caption" onchange="getzy1()" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="" colspan="1" width="10%">&nbsp;级（赛）别：</td>
									<td align="left" nowrap="nowrap" id="xxmmcContainer" colspan="1" width="40%">
										 <s:select name="tsportBsxm.xxmmc" id ="xxmmc" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="-------请选择-------"/>
									</td>
									<td align="left"  nowrap="nowrap" colspan="1"><ul class="btn_gn">
										<li>
											<a href="#" title="查询" onClick="super_doSearch()"
												id="searchButton" name="btn3"><span> 查询 </span>
											</a>
										</li></ul></td>
								</tr>
								<tr>	
									<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;性别组：</td>
									<td align="left" nowrap="nowrap" id="xbzContainer" colspan="1">
										 <s:select name="tsportBsxm.xbz" id ="xbz" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;组别：</td>
									<td align="left" nowrap="nowrap" id="zbContainer" colspan="1">
										 <s:select name="tsportBsxm.zb" id ="zb" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td>&nbsp;</td>
									<td>&nbsp;</td>
									<td align="left" nowrap="nowrap" colspan="1"><ul class="btn_gn">
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
    			&nbsp;说明：得牌得分这列是折算前的，得牌、得分两列显示的是折算后的！
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
	 		        <th width="15%">比赛时间</th>
	    			<th width="20%">级（赛）别</th>
	    			<th width="7%">原籍地</th>
	    			<th width="13%">得牌</th>
	    			<th width="9%">得分</th>
	    			<th width="11%">运动员</th>
	    			<th width="14%">得牌得分</th>
	    			<th width="11%">折算表原籍地</th>
	    		</tr>
    		</thead>
    		<tbody id="listData">
	    		<s:iterator value="resultData" status="stat_xm">
	    			  <tr>
						    <td width="15%" style="vertical-align:middle">&nbsp;<s:property value="resultData[#stat_xm.index][0]"/></td>
						    <td width="20%" style="vertical-align:middle">&nbsp;<s:property value="resultData[#stat_xm.index][1]"/></td>
						    <td colspan="6" width="65%">
								<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0">
									<s:iterator value="listdq" status="stat_dq">
										<s:if test="resultData[#stat_xm.index][2]==#listdq[#stat_dq.index][0]">
											<tr>
												<td  width="10%" style="vertical-align:middle">
													&nbsp;<s:property value="#listdq[#stat_dq.index][1]"/>
												</td>
												<td width="20%" style="vertical-align:middle">
													&nbsp;
													<s:if test="#listdq[#stat_dq.index][2]!='0'.toString()">
											    		<s:if test="#listdq[#stat_dq.index][2]=='.5'.toString()">
											    			0.5金
											    		</s:if>
											    		<s:else>
											    			<s:property value="#listdq[#stat_dq.index][2]"/>金
											    		</s:else>
											    	</s:if>
											    	<s:elseif test="#listdq[#stat_dq.index][3]!='0'.toString()">
											    		<s:if test="#listdq[#stat_dq.index][3]=='.5'.toString()">
											    			0.5银
											    		</s:if>
											    		<s:else>
											    			<s:property value="#listdq[#stat_dq.index][3]"/>银
											    		</s:else>
											    	</s:elseif>
											    	<s:elseif test="#listdq[#stat_dq.index][4]!='0'.toString()">
											    		<s:if test="#listdq[#stat_dq.index][4]=='.5'.toString()">
											    			0.5铜
											    		</s:if>
											    		<s:else>
											    			<s:property value="#listdq[#stat_dq.index][4]"/>铜
											    		</s:else>
											    	</s:elseif>
											    	<s:else>
											    		--
											    	</s:else>
												 </td>
												 <td width="15%" style="vertical-align:middle">
													 &nbsp;<s:property value="#listdq[#stat_dq.index][5]"/>分
												 </td>
												 <td width="55%">
												 	<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0">
												 		<s:iterator value="list" status="stat_qb" >
												 		
												 			<s:if test="#listdq[#stat_dq.index][0]==#list[#stat_qb.index][1] && #listdq[#stat_dq.index][1]==#list[#stat_qb.index][3]">
    															<s:set name="mcs" value="#list[#stat_qb.index][4].split(',')"/>
														 		<s:iterator value="#mcs"  status="stat1">
    															<s:set name="mcs1" value="#mcs[#stat1.index].split('_')"/>
														 		<tr>
														 			<td width="30%">
														 				&nbsp;<s:property value="#mcs1[0]"/>
														 			</td>
														 			<td width="40%">
														 				&nbsp;
														 				<s:if test="#mcs1[2]!='0'.toString()">
																    		<s:if test="#mcs1[2]=='.5'.toString()">
																    			0.5金
																    		</s:if>
																    		<s:else>
																    			<s:property value="#mcs1[2]"/>金
																    		</s:else>
																    	</s:if>
																    	<s:elseif test="#mcs1[3]!='0'.toString()">
																    		<s:if test="#mcs1[3]=='.5'.toString()">
																    			0.5银
																    		</s:if>
																    		<s:else>
																    			<s:property value="#mcs1[3]"/>银
																    		</s:else>
																    	</s:elseif>
																    	<s:elseif test="#mcs1[4]!='0'.toString()">
																    		<s:if test="#mcs1[4]=='.5'.toString()">
																    			0.5铜
																    		</s:if>
																    		<s:else>
																    			<s:property value="#mcs1[4]"/>铜
																    		</s:else>
																    	</s:elseif>
																    	<s:elseif test="#mcs1[5]!='0'.toString()">
																    		<s:if test="#mcs1[5]=='.5'.toString()">
																    			0.5分
																    		</s:if>
																    		<s:else>
																    			<s:property value="#mcs1[5]"/>分
																    		</s:else>
																    	</s:elseif>
																    	<s:else>
																    		--
																    	</s:else>
														 			</td>
														 			<td width="30%">
														 				&nbsp;<s:property value="#mcs1[1]"/>
														 			</td>
														 		</tr>
														 		</s:iterator>
														 	</s:if>	
												 		</s:iterator>
												 	</table>
												 </td>
											</tr>
										</s:if>
									</s:iterator>
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

