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
	<input type="hidden" name="param" value="<s:property value="param" />"/>
    <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%" class="maginB">
			<tr align="center">
				
			</tr>
	</table>
    	<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%">
    		<tr>
    			<td height="30px" colspan="10">
    			&nbsp;说明：左侧为运动员表,右侧为折算明细表！
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
    			<th width="6%">比赛时间</th>
    			<th width="12%">级（赛）别</th>
    			<th width="6%">运动员</th>
    			<th width="6%">代表地</th>
    			<th width="6%">得牌</th>
    			<th width="6%">得分</th>
    			<th width="8%">&nbsp;</th>
    			<th width="6%">承训地</th>
    			<th width="6%">注册地</th>
    			<th width="6%">原注册地</th>
    			<th width="6%">原籍</th>
    			</tr>
    		</thead>
    		<tbody id="listData">
    		<s:iterator value="resultData" status="status">
    		   <s:set name="ydyxxb" value="resultData[#status.index][8].split('_')"/>
    		   <s:set name="zsb" value="resultData[#status.index][9].split('_')"/>
		    		<tr>
     			  		 <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][0]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][1]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][2]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][3]" /></td>
                         <td style="vertical-align:middle">&nbsp;
                         <s:if test="%{resultData[#status.index][4].toString()!=null&&resultData[#status.index][4].toString()!=''&&resultData[#status.index][4]!='0'.toString()}"><s:property value="resultData[#status.index][4]" />金
                         </s:if><s:elseif test="%{resultData[#status.index][5].toString()!=null&&resultData[#status.index][5].toString()!=''&&resultData[#status.index][5]!='0'.toString()}"><s:property value="resultData[#status.index][5]" />银
                         </s:elseif><s:elseif test="%{resultData[#status.index][6].toString()!=null&&resultData[#status.index][6].toString()!=''&&resultData[#status.index][6]!='0'.toString()}"><s:property value="resultData[#status.index][6]" />铜
                         </s:elseif><s:else>--</s:else></td>
                         <td style="vertical-align:middle">&nbsp;
                         <s:if test="%{resultData[#status.index][7].toString()!=null&&resultData[#status.index][7].toString()!=''&&resultData[#status.index][7]!='0'.toString()}"><s:property value="resultData[#status.index][7]" /></s:if>
                         <s:else>--</s:else></td>
                         <td><table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
						      <tr>
						        <td scope="row"><strong>信息表地区</strong></td>
						      </tr>
						      <tr>
						        <td scope="row"><strong>折算地区</strong></td>
						      </tr>
						      <tr>
						        <td scope="row"><strong>奖牌</strong></td>
						      </tr>
						      <tr>
						        <td scope="row"><strong>得分</strong></td>
						      </tr>
						    </table></td>
                         <td><table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
						       <tr><td>
						       <s:if test="%{#ydyxxb[0]!=null&&#ydyxxb[0].toString()!=''}">&nbsp;<s:property value="#ydyxxb[0]" /></s:if>
						       <s:else>--</s:else></td>
						      </tr>
						      <s:if test="#zsb[0].toString()=='承训地'" >
						      	<tr><td><s:if test="%{#zsb[1]==null||#zsb[1].toString()==''}">--</s:if>
						      	 <s:else>&nbsp;<s:property value="#zsb[1]" /></s:else></td></tr>
						     	 <tr><td>
						     		 <s:if test="%{#zsb[2].toString()!=null&&#zsb[2].toString()!=''&&#zsb[2]-1!='0'.toString()&&#zsb[2]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[2]-1)" />金
                         			</s:if><s:elseif test="%{#zsb[3].toString()!=null&&#zsb[3].toString()!=''&&#zsb[3]-1!='0'.toString()&&#zsb[3]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[3]-1)" />银
                         			</s:elseif><s:elseif test="%{#zsb[4].toString()!=null&&#zsb[4].toString()!=''&&#zsb[4]-1!='0'.toString()&&#zsb[4]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[4]-1)" />铜
                        			</s:elseif><s:else>--</s:else></td>
                        		</tr>
						      	<tr><td><s:if test="%{#zsb[5].toString()!=null&&#zsb[5].toString()!=''&&#zsb[5]-1!='0'.toString()&&#zsb[5]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[5]-1)" />
                         			</s:if><s:else>--</s:else></td></tr>
						      </s:if>
						      <s:else>
						      <tr><td>--</td></tr>
						       <tr><td>--</td></tr>
						        <tr><td>--</td></tr>
						      </s:else>
						    </table></td>
                         <td><table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
						      <tr><td>
						       <s:if test="%{#ydyxxb[1]!=null&&#ydyxxb[1].toString()!=''}">&nbsp;<s:property value="#ydyxxb[1]" /></s:if>
						       <s:else>--</s:else></td>
						      </tr>
						      <s:if test="#zsb[0].toString()=='注册地'" >
						      	<tr><td><s:if test="%{#zsb[1]==null||#zsb[1].toString()==''}">--</s:if>
						      	 <s:else>&nbsp;<s:property value="#zsb[1]" /></s:else></td></tr>
						     	 <tr><td>
						     		 <s:if test="%{#zsb[2].toString()!=null&&#zsb[2].toString()!=''&&#zsb[2]-1!='0'.toString()&&#zsb[2]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[2]-1)" />金
                         			</s:if><s:elseif test="%{#zsb[3].toString()!=null&&#zsb[3].toString()!=''&&#zsb[3]-1!='0'.toString()&&#zsb[3]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[3]-1)" />银
                         			</s:elseif><s:elseif test="%{#zsb[4].toString()!=null&&#zsb[4].toString()!=''&&#zsb[4]-1!='0'.toString()&&#zsb[4]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[4]-1)" />铜
                        			</s:elseif><s:else>--</s:else></td>
                        		</tr>
						      	<tr><td><s:if test="%{#zsb[5].toString()!=null&&#zsb[5].toString()!=''&&#zsb[5]-1!='0'.toString()&&#zsb[5]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[5]-1)" />
                         			</s:if><s:else>--</s:else></td></tr>
						      </s:if>
						      <s:elseif test="#zsb[6].toString()=='注册地'">
							      <tr><td><s:if test="%{#zsb[7]==null||#zsb[7].toString()==''}">--</s:if>
							      	 <s:else>&nbsp;<s:property value="#zsb[7]" /></s:else></td></tr>
							     	 <tr><td>
							     		 <s:if test="%{#zsb[8].toString()!=null&&#zsb[8].toString()!=''&&#zsb[8]-1!='0'.toString()&&#zsb[8]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[8]-1)" />金
	                         			</s:if><s:elseif test="%{#zsb[9].toString()!=null&&#zsb[9].toString()!=''&&#zsb[9]-1!='0'.toString()&&#zsb[9]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[9]-1)" />银
	                         			</s:elseif><s:elseif test="%{#zsb[10].toString()!=null&&#zsb[10].toString()!=''&&#zsb[10]-1!='0'.toString()&&#zsb[10]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[10]-1)" />铜
	                        			</s:elseif><s:else>--</s:else></td>
	                        		</tr>
							      	<tr><td><s:if test="%{#zsb[11].toString()!=null&&#zsb[11].toString()!=''&&#zsb[11]-1!='0'.toString()&&#zsb[11]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[11]-1)" />
	                         			</s:if><s:else>--</s:else></td></tr>
						      </s:elseif>
						      <s:else>
						      <tr><td>--</td></tr>
						       <tr><td>--</td></tr>
						        <tr><td>--</td></tr>
						      </s:else>
						    </table></td>
                         <td><table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
						       <tr><td>
						       <s:if test="%{#ydyxxb[2]!=null&&#ydyxxb[2].toString()!=''}">&nbsp;<s:property value="#ydyxxb[2]" /></s:if>
						       <s:else>--</s:else></td>
						      </tr>
						      <s:if test="#zsb[0].toString()=='原注册地'" >
						      	<tr><td><s:if test="%{#zsb[1]==null||#zsb[1].toString()==''}">--</s:if>
						      	 <s:else>&nbsp;<s:property value="#zsb[1]" /></s:else></td></tr>
						     	 <tr><td>
						     		 <s:if test="%{#zsb[2].toString()!=null&&#zsb[2].toString()!=''&&#zsb[2]-1!='0'.toString()&&#zsb[2]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[2]-1)" />金
                         			</s:if><s:elseif test="%{#zsb[3].toString()!=null&&#zsb[3].toString()!=''&&#zsb[3]-1!='0'.toString()&&#zsb[3]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[3]-1)" />银
                         			</s:elseif><s:elseif test="%{#zsb[4].toString()!=null&&#zsb[4].toString()!=''&&#zsb[4]-1!='0'.toString()&&#zsb[4]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[4]-1)" />铜
                        			</s:elseif><s:else>--</s:else></td>
                        		</tr>
						      	<tr><td><s:if test="%{#zsb[5].toString()!=null&&#zsb[5].toString()!=''&&#zsb[5]-1!='0'.toString()&&#zsb[5]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[5]-1)" />
                         			</s:if><s:else>--</s:else></td></tr>
						      </s:if>
						      <s:elseif test="#zsb[6].toString()=='原注册地'">
							      <tr><td><s:if test="%{#zsb[7]==null||#zsb[7].toString()==''}">--</s:if>
							      	 <s:else>&nbsp;<s:property value="#zsb[7]" /></s:else></td></tr>
							     	 <tr><td>
							     		 <s:if test="%{#zsb[8].toString()!=null&&#zsb[8].toString()!=''&&#zsb[8]-1!='0'.toString()&&#zsb[8]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[8]-1)" />金
	                         			</s:if><s:elseif test="%{#zsb[9].toString()!=null&&#zsb[9].toString()!=''&&#zsb[9]-1!='0'.toString()&&#zsb[9]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[9]-1)" />银
	                         			</s:elseif><s:elseif test="%{#zsb[10].toString()!=null&&#zsb[10].toString()!=''&&#zsb[10]-1!='0'.toString()&&#zsb[10]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[10]-1)" />铜
	                        			</s:elseif><s:else>--</s:else></td>
	                        		</tr>
							      	<tr><td><s:if test="%{#zsb[11].toString()!=null&&#zsb[11].toString()!=''&&#zsb[11]-1!='0'.toString()&&#zsb[11]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[11]-1)" />
	                         			</s:if><s:else>--</s:else></td></tr>
						      </s:elseif>
						      <s:elseif test="#zsb[12].toString()=='原注册地'">
							      <tr><td><s:if test="%{#zsb[13]==null||#zsb[13].toString()==''}">--</s:if>
							      	 <s:else>&nbsp;<s:property value="#zsb[13]" /></s:else></td></tr>
							     	 <tr><td>
							     		 <s:if test="%{#zsb[14].toString()!=null&&#zsb[14].toString()!=''&&#zsb[14]-1!='0'.toString()&&#zsb[14]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[14]-1)" />金
	                         			</s:if><s:elseif test="%{#zsb[15].toString()!=null&&#zsb[15].toString()!=''&&#zsb[15]-1!='0'.toString()&&#zsb[15]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[15]-1)" />银
	                         			</s:elseif><s:elseif test="%{#zsb[16].toString()!=null&&#zsb[16].toString()!=''&&#zsb[16]-1!='0'.toString()&&#zsb[16]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[16]-1)" />铜
	                        			</s:elseif><s:else>--</s:else></td>
	                        		</tr>
							      	<tr><td><s:if test="%{#zsb[17].toString()!=null&&#zsb[17].toString()!=''&&#zsb[17]-1!='0'.toString()&&#zsb[17]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[17]-1)" />
	                         			</s:if><s:else>--</s:else></td></tr>
						      </s:elseif>
						      <s:else>
						      <tr><td>--</td></tr>
						       <tr><td>--</td></tr>
						        <tr><td>--</td></tr>
						      </s:else>
						    </table>
                         </td>
                         <td><table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
						        <tr><td>
						       <s:if test="%{#ydyxxb[3]!=null&&#ydyxxb[3].toString()!=''}">&nbsp;<s:property value="#ydyxxb[3]" /></s:if>
						       <s:else>--</s:else></td>
						      </tr>
						      <s:if test="#zsb[0].toString()=='原籍地'" >
						      	<tr><td><s:if test="%{#zsb[1]==null||#zsb[1].toString()==''}">--</s:if>
						      	 <s:else>&nbsp;<s:property value="#zsb[1]" /></s:else></td></tr>
						     	 <tr><td>
						     		 <s:if test="%{#zsb[2].toString()!=null&&#zsb[2].toString()!=''&&#zsb[2]-1!='0'.toString()&&#zsb[2]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[2]-1)" />金
                         			</s:if><s:elseif test="%{#zsb[3].toString()!=null&&#zsb[3].toString()!=''&&#zsb[3]-1!='0'.toString()&&#zsb[3]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[3]-1)" />银
                         			</s:elseif><s:elseif test="%{#zsb[4].toString()!=null&&#zsb[4].toString()!=''&&#zsb[4]-1!='0'.toString()&&#zsb[4]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[4]-1)" />铜
                        			</s:elseif><s:else>--</s:else></td>
                        		</tr>
						      	<tr><td><s:if test="%{#zsb[5].toString()!=null&&#zsb[5].toString()!=''&&#zsb[5]-1!='0'.toString()&&#zsb[5]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[5]-1)" />
                         			</s:if><s:else>--</s:else></td></tr>
						      </s:if>
						      <s:elseif test="#zsb[6].toString()=='原籍地'">
							      <tr><td><s:if test="%{#zsb[7]==null||#zsb[7].toString()==''}">--</s:if>
								      	 <s:else>&nbsp;<s:property value="#zsb[7]" /></s:else></td></tr>
								     	 <tr><td>
								     		 <s:if test="%{#zsb[8].toString()!=null&&#zsb[8].toString()!=''&&#zsb[8]-1!='0'.toString()&&#zsb[8]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[8]-1)" />金
		                         			</s:if><s:elseif test="%{#zsb[9].toString()!=null&&#zsb[9].toString()!=''&&#zsb[9]-1!='0'.toString()&&#zsb[9]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[9]-1)" />银
		                         			</s:elseif><s:elseif test="%{#zsb[10].toString()!=null&&#zsb[10].toString()!=''&&#zsb[10]-1!='0'.toString()&&#zsb[10]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[10]-1)" />铜
		                        			</s:elseif><s:else>--</s:else></td>
		                        		</tr>
								      	<tr><td><s:if test="%{#zsb[11].toString()!=null&&#zsb[11].toString()!=''&&#zsb[11]-1!='0'.toString()&&#zsb[11]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[11]-1)" />
		                         			</s:if><s:else>--</s:else></td></tr>
						      </s:elseif>
						      <s:elseif test="#zsb[12].toString()=='原籍地'">
							      <tr><td><s:if test="%{#zsb[13]==null||#zsb[13].toString()==''}">--</s:if>
								      	 <s:else>&nbsp;<s:property value="#zsb[13]" /></s:else></td></tr>
								     	 <tr><td>
								     		 <s:if test="%{#zsb[14].toString()!=null&&#zsb[14].toString()!=''&&#zsb[14]-1!='0'.toString()&&#zsb[14]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[14]-1)" />金
		                         			</s:if><s:elseif test="%{#zsb[15].toString()!=null&&#zsb[15].toString()!=''&&#zsb[15]-1!='0'.toString()&&#zsb[15]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[15]-1)" />银
		                         			</s:elseif><s:elseif test="%{#zsb[16].toString()!=null&&#zsb[16].toString()!=''&&#zsb[16]-1!='0'.toString()&&#zsb[16]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[16]-1)" />铜
		                        			</s:elseif><s:else>--</s:else></td>
		                        		</tr>
								      	<tr><td><s:if test="%{#zsb[17].toString()!=null&&#zsb[17].toString()!=''&&#zsb[17]-1!='0'.toString()&&#zsb[17]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[17]-1)" />
		                         			</s:if><s:else>--</s:else></td></tr>
						      </s:elseif>
						      <s:elseif test="#zsb[18].toString()=='原籍地'">
							      <tr><td><s:if test="%{#zsb[19]==null||#zsb[19].toString()==''}">--</s:if>
									      	 <s:else>&nbsp;<s:property value="#zsb[19]" /></s:else></td></tr>
									     	 <tr><td>
									     		 <s:if test="%{#zsb[20].toString()!=null&&#zsb[20].toString()!=''&&#zsb[20]-1!='0'.toString()&&#zsb[20]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[20]-1)" />金
			                         			</s:if><s:elseif test="%{#zsb[21].toString()!=null&&#zsb[21].toString()!=''&&#zsb[21]-1!='0'.toString()&&#zsb[21]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[21]-1)" />银
			                         			</s:elseif><s:elseif test="%{#zsb[22].toString()!=null&&#zsb[22].toString()!=''&&#zsb[22]-1!='0'.toString()&&#zsb[22]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[22]-1)" />铜
			                        			</s:elseif><s:else>--</s:else></td>
			                        		</tr>
									      	<tr><td><s:if test="%{#zsb[23].toString()!=null&&#zsb[23].toString()!=''&&#zsb[23]-1!='0'.toString()&&#zsb[23]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[23]-1)" />
			                         			</s:if><s:else>--</s:else></td></tr>
						      </s:elseif>
						      <s:else>
						      	<tr><td>--</td></tr>
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

