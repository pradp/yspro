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
	//数值的加运算
	function accAdd(arg1,arg2){
	    var r1,r2,m;
	    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
	    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
	    m=Math.pow(10,Math.max(r1,r2))
	    return (arg1*m+arg2*m)/m
	}
	//数值的减运算
	function accMinutes(arg1,arg2){
	    var r1,r2,m;
	    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
	    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
	    m=Math.pow(10,Math.max(r1,r2))
	    return (arg1*m-arg2*m)/m
	}
	//数值转换
	function accMinutesBefore (id1,id2,id3){
		var lastval = accMinutes($("#"+id1).html(),$("#"+id2).html());
		if(lastval==null || lastval==''){
			lastval = "0";
		}
		$("#"+id3).html(lastval);
	}

	// 奖牌新增折算 计算
	function jptj (i,id){
		var cxd_jp = 0;
		var cxd_yp = 0;
		var cxd_tp = 0;
		var yjd_jp = 0;
		var yjd_yp = 0;
		var yjd_tp = 0;
		var yzcd_jp = 0;
		var yzcd_yp = 0;
		var yzcd_tp = 0;
		if(document.getElementById(i+"_cxd_jp") && document.getElementById(i+"_cxd_yp") && document.getElementById(i+"_cxd_tp")){
			 cxd_jp = $("#"+i+"_cxd_jp").val();
			 cxd_yp = $("#"+i+"_cxd_yp").val();
			 cxd_tp = $("#"+i+"_cxd_tp").val();
			if(cxd_jp==null || cxd_jp==''){
				cxd_jp = 0;
			}
			if(cxd_yp==null || cxd_yp==''){
				cxd_yp = 0;
			}
			if(cxd_tp==null || cxd_tp==''){
				cxd_tp = 0;
			}
		}
		if(document.getElementById(i+"_yjd_jp") && document.getElementById(i+"_yjd_yp") && document.getElementById(i+"_yjd_tp")){
			 yjd_jp = $("#"+i+"_yjd_jp").val();
			 yjd_yp = $("#"+i+"_yjd_yp").val();
			 yjd_tp = $("#"+i+"_yjd_tp").val();
			if(yjd_jp==null || yjd_jp==''){
				yjd_jp = 0;
			}
			if(yjd_yp==null || yjd_yp==''){
				yjd_yp = 0;
			}
			if(yjd_tp==null || yjd_tp==''){
				yjd_tp = 0;
			}
		}
		if(document.getElementById(i+"_yzcd_jp") && document.getElementById(i+"_yzcd_yp") && document.getElementById(i+"_yzcd_tp")){
			 yzcd_jp = $("#"+i+"_yzcd_jp").val();
			 yzcd_yp = $("#"+i+"_yzcd_yp").val();
			 yzcd_tp = $("#"+i+"_yzcd_tp").val();
			if(yzcd_jp==null || yzcd_jp==''){
				yzcd_jp = 0;
			}
			if(yzcd_yp==null || yzcd_yp==''){
				yzcd_yp = 0;
			}
			if(yzcd_tp==null || yzcd_tp==''){
				yzcd_tp = 0;
			}
		}
		var total_jp = accAdd(accAdd(cxd_jp,yjd_jp),yzcd_jp);
		var total_yp = accAdd(accAdd(cxd_yp,yjd_yp),yzcd_yp);
		var total_tp = accAdd(accAdd(cxd_tp,yjd_tp),yzcd_tp);
		
		var result = "";
		if(total_jp!=0){
			result = result+total_jp+"金   ";
		}
		if(total_yp!=0){
			result = result+total_yp+"银   ";
		}
		if(total_tp!=0){
			result = result+total_tp+"铜   ";
		}
		if(result!=''){
			$("#"+id).html(result);
			return false;
		}
		$("#"+id).html('--');
	}
	// 得分新增折算 计算
	function dftj (i,id){
		var cxd_df = 0;
		var yjd_df = 0;
		var yzcd_df = 0;
		if(document.getElementById(i+"_yjd_df")){
			yjd_df = $("#"+i+"_yjd_df").val();
			if(yjd_df==null || yjd_df==''){
				yjd_df = 0;
			}
		}
		if(document.getElementById(i+"_cxd_df")){
			cxd_df =$("#"+i+"_cxd_df").val();
			if(cxd_df==null || cxd_df==''){
				cxd_df = 0;
			}
		}
		if(document.getElementById(i+"_yzcd_df")){
			yzcd_df = $("#"+i+"_yzcd_df").val();
			if(yzcd_df==null || yzcd_df==''){
				yzcd_df = 0;
			}
		}
		var total_df =  accAdd(yzcd_df,accAdd(cxd_df,yjd_df));
		if(total_df!=0){
			$("#"+id).html(total_df);
			return false;
		}
		$("#"+id).html('--');
	}
	//注册地奖牌统计
	function zcdjptj(i,id){
		if(document.getElementById(i+"_zcd_jp") && document.getElementById(i+"_zcd_yp") && document.getElementById(i+"_zcd_tp")){
			
			if(document.getElementById(i+"_yzcd_jp") && document.getElementById(i+"_yzcd_yp") && document.getElementById(i+"_yzcd_tp")){
				var jp = accMinutes($("#"+i+"_zcd_jp").val(),$("#"+i+"_yzcd_jp").val());
				var yp = accMinutes($("#"+i+"_zcd_yp").val(),$("#"+i+"_yzcd_yp").val());
				var tp = accMinutes($("#"+i+"_zcd_tp").val(),$("#"+i+"_yzcd_tp").val());
				var result = "";
				if(jp!=0){
					result = result+jp+"金   ";
				}
				if(yp!=0){
					result = result+yp+"银   ";
				}
				if(tp!=0){
					result = result+tp+"铜   ";
				}
		
				if(result!=''){
					$("#"+id).html(result);
					return false;
				}
			}	
			var result = "";
			var jp = $("#"+i+"_zcd_jp").val();
			var yp = $("#"+i+"_zcd_yp").val();
			var tp = $("#"+i+"_zcd_tp").val();
			if(jp!='0'){
				result = result+jp+"金   ";
			}
			if(yp!='0'){
				result = result+yp+"银   ";
			}
			if(tp!='0'){
				result = result+tp+"铜   ";
			}
			if(result!=''){
				$("#"+id).html(result);
				return false;
			}
		}
		$("#"+id).html('--');
	}
	//注册地 得分统计
	function zcddftj(i,id){
		if(document.getElementById(i+"_zcd_df")){
			
			if(document.getElementById(i+"_yzcd_df")){
				var df = accMinutes($("#"+i+"_zcd_df").val(),$("#"+i+"_yzcd_df").val());
				if(df!=0){
					$("#"+id).html(df+"");
					return false;
				}
			}
			$("#"+id).html($("#"+i+"_zcd_df").val()+"");
			return false;
		}
		$("#"+id).html('--');
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
	<input type="hidden" value="<s:property value="lx" />" id="lx" name="lx" />
  		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunlefts">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
								<tr align="center">
									<td align="right" nowrap="nowrap" class="">&nbsp;&nbsp;&nbsp;比赛时间：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield name="bssj" id="bssj" maxlength="20" size="20" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:false})"  />
									</td>
									<td align="right" nowrap="nowrap" class="" colspan="1" width="10%">&nbsp;项目：</td>
									<td align="left" nowrap="nowrap" colspan="1"  width="15%">
										 <s:select name="tsportCjYdy.dxmmc" id ="dxmmc" list="getAllDxmmc()" listKey="id" onchange="getzy1()" listValue="caption" headerKey="" headerValue="--请选择--"/>
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
									<s:if test="getDepartID()==320">
										<td align="right" nowrap="nowrap" class="">代表团：</td>
										<td align="left" nowrap="nowrap" >
											<s:select name="tsportCjYdy.dbd" id ="dbd" list="getDbtmc2()" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
										</td>
									</s:if>
									<s:else>
										<td></td><td><s:hidden name="tsportCjYdy.dbd"></s:hidden></td>
										
									</s:else>
									
									<td align="center" rowspan="2" nowrap="nowrap"><ul class="btn_gn">
										<li>
											<a href="#" title="查询" onClick="$('#lx').val('');super_doSearch()"
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
								<tr>	
									<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;有承训地：</td>
									<td align="left" nowrap="nowrap" id="zbContainer" colspan="1">
										 <s:select name="iscxd" id ="iscxd" list="#{'0':'否','1':'是'}"  headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="">有原注册地：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="isyzcd" id="isyzcd" list="#{'0':'否','1':'是'}" headerKey="" headerValue="--请选择--" />
									</td>
									<td align="right" nowrap="nowrap" class="">有原籍：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="isyj" id ="isyj" list="#{'0':'否','1':'是'}" headerKey="" headerValue="--请选择--"/>
									</td>
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
						<td width="15" height="85" class="chaxunrights">
							&nbsp;
						</td>
					</tr>
				</table></td></tr>
				<tr height="25" align="left">
			        <td colspan="10"><b>&nbsp;&nbsp;&nbsp;本次查询结果为：</b> 
				        <s:iterator value="#sjData">
				       	      实际产生金牌：<span id="sj_j"><s:property value="#sjData[0][0]" /></span>，
					                 银牌：<span id="sj_y"><s:property value="#sjData[0][1]" /></span>，
					                 铜牌：<span id="sj_t"><s:property value="#sjData[0][2]" /></span>，
					                 得分：<span id="sj_d"><s:property value="#sjData[0][3]" /></span>
				        </s:iterator>
			        </td>
			    </tr>
			    <tr>
			    	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				        <s:iterator value="#zsData">
				       	       折算计分金牌：<span id="zs_j"><s:property value="#zsData[0][0]" /></span>，
					                 银牌：<span id="zs_y"><s:property value="#zsData[0][1]" /></span>，
					                 铜牌：<span id="zs_t"><s:property value="#zsData[0][2]" /></span>，
					                 得分：<span id="zs_d"><s:property value="#zsData[0][3]" /></span>
				        </s:iterator>
			        </td>
			    </tr>
			    <tr>
			    	<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			    	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				       	      折算新增金牌：<span id="res_j"></span><SCRIPT type="text/javascript">accMinutesBefore('zs_j','sj_j','res_j')</SCRIPT>，
					                 银牌：<span id="res_y"></span><SCRIPT type="text/javascript">accMinutesBefore('zs_y','sj_y','res_y')</SCRIPT>，
					                 铜牌：<span id="res_t"></span><SCRIPT type="text/javascript">accMinutesBefore('zs_t','sj_t','res_t')</SCRIPT>，
					                 得分：<span id="res_d"></span><SCRIPT type="text/javascript">accMinutesBefore('zs_d','sj_d','res_d')</SCRIPT>
			        </td>
	 			</tr>
			    <tr>
			    	<td style="color: red; font-size: 12px;">
			    	<s:if test="%{#departname!=null && #departname!=''}">
			    	&nbsp;&nbsp;&nbsp;本次查询结果为折算到&nbsp;<s:property value="departname" />&nbsp;代表团的明细，
			    	</s:if>
			    	  &nbsp;折算新增= 承训地+原籍+原注册地</td>
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
    			<th width="5%">比赛时间</th>
    			<th width="11%">级（赛）别</th>
    			<th width="4%">运动员</th>
    			<th width="5%">代表团</th>
    			<th width="2%">名次</th>
    			<th width="3%">得牌</th>
    			<th width="3%">得分</th>
    			<th width="5%">&nbsp;</th>
    			<th width="6%">承训地</th>
    			<th width="6%">注册地</th>
    			<th width="6%">原注册地</th>
    			<th width="6%">原注册地区县</th>
    			<th width="6%">原籍</th>
    			<th width="6%">折算新增</th>
    			</tr>
    		</thead>
    		<tbody id="listData">
    		<s:iterator value="resultData" status="status">
    		   <s:set name="ydyxxb" value="resultData[#status.index][8].split('_')"/>
    		   <s:set name="zsb" value="resultData[#status.index][9].split('_')"/>
    		   <s:set name="sxzs" value="resultData[#status.index][11].split('_')"/>
		    		<tr>
     			  		 <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][0]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][1]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][2]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][3]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][10]" /></td>
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
						       
						      <s:if test="#zsb[0].toString()=='承训地'" >
						      	<tr><td><s:if test="%{#zsb[1]==null||#zsb[1].toString()==''}">--</s:if>
						      	 <s:else>&nbsp;<s:property value="#zsb[1]" /></s:else></td></tr>
						     	 <tr><td><span style="display : none;"><s:textfield id="%{#status.index}_cxd_jp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[2]==0 ? 0:#zsb[2]-1)}"></s:textfield><s:textfield id="%{#status.index}_cxd_yp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[3]==0 ? 0:#zsb[3]-1)}"></s:textfield><s:textfield id="%{#status.index}_cxd_tp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[4]==0 ? 0:#zsb[4]-1)}"></s:textfield></span>
						     		 <s:if test="%{#zsb[2].toString()!=null&&#zsb[2].toString()!=''&&#zsb[2]-1!='0'.toString()&&#zsb[2]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[2]-1)" />金
                         			</s:if><s:elseif test="%{#zsb[3].toString()!=null&&#zsb[3].toString()!=''&&#zsb[3]-1!='0'.toString()&&#zsb[3]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[3]-1)" />银
                         			</s:elseif><s:elseif test="%{#zsb[4].toString()!=null&&#zsb[4].toString()!=''&&#zsb[4]-1!='0'.toString()&&#zsb[4]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[4]-1)" />铜
                        			</s:elseif><s:else>--</s:else></td>
                        		</tr>
						      	<tr><td>
						      	<span style="display : none;"><s:textfield id="%{#status.index}_cxd_df" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[5]==0 ? 0:#zsb[5]-1)}"></s:textfield></span>
						      	<s:if test="%{#zsb[5].toString()!=null&&#zsb[5].toString()!=''&&#zsb[5]-1!='0'.toString()&&#zsb[5]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[5]-1)" />
                         			</s:if><s:else>--</s:else></td></tr>
						      </s:if>
						      <s:else>
							      	<tr><td>--</td></tr>
							      	<tr><td>--</td></tr>
							        <tr><td>--</td></tr>
						      </s:else>
						    </table></td>
                         <td><table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
						      	<tr><td><s:property value="resultData[#status.index][3]" /></td></tr>
						     	<tr>
						     	 	<td>
						     	 	<span style="display : none;"><s:textfield id="%{#status.index}_zcd_jp" value="%{@com.imchooser.util.NumberUtil@formatPoint(resultData[#status.index][4]==0 ? 0:resultData[#status.index][4])}"></s:textfield><s:textfield id="%{#status.index}_zcd_yp" value="%{@com.imchooser.util.NumberUtil@formatPoint(resultData[#status.index][5]==0 ? 0:resultData[#status.index][5])}"></s:textfield><s:textfield id="%{#status.index}_zcd_tp" value="%{@com.imchooser.util.NumberUtil@formatPoint(resultData[#status.index][6]==0 ? 0:resultData[#status.index][6])}"></s:textfield></span>
						     		<span id="<s:property value="%{#status.index}"/>_zcd_all_jp">&nbsp;</span>
                         			</td>
                        		</tr>
						      	<tr><td>
						      	<span style="display : none;"><s:textfield id="%{#status.index}_zcd_df" value="%{@com.imchooser.util.NumberUtil@formatPoint(resultData[#status.index][7]==0 ? 0:resultData[#status.index][7])}"></s:textfield></span>
						      	<span id="<s:property value="%{#status.index}"/>_zcd_all_df">&nbsp;</span>
                        			</td>
                        		</tr>
						    </table></td>
                         <td><table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
						      <s:if test="#zsb[0].toString()=='原注册地'" >
						      	<tr><td><s:if test="%{#zsb[1]==null||#zsb[1].toString()==''}">--</s:if>
						      	 <s:else>&nbsp;<s:property value="#zsb[1]" /></s:else></td></tr>
						     	 <tr><td>
						     	  <span style="display : none;"><s:textfield id="%{#status.index}_yzcd_jp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[2]==0 ? 0:#zsb[2]-1)}"></s:textfield><s:textfield id="%{#status.index}_yzcd_yp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[3]==0 ? 0:#zsb[3]-1)}"></s:textfield><s:textfield id="%{#status.index}_yzcd_tp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[4]==0 ? 0:#zsb[4]-1)}"></s:textfield></span>
						     		 <s:if test="%{#zsb[2].toString()!=null&&#zsb[2].toString()!=''&&#zsb[2]-1!='0'.toString()&&#zsb[2]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[2]-1)" />金
                         			</s:if><s:elseif test="%{#zsb[3].toString()!=null&&#zsb[3].toString()!=''&&#zsb[3]-1!='0'.toString()&&#zsb[3]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[3]-1)" />银
                         			</s:elseif><s:elseif test="%{#zsb[4].toString()!=null&&#zsb[4].toString()!=''&&#zsb[4]-1!='0'.toString()&&#zsb[4]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[4]-1)" />铜
                        			</s:elseif><s:else>--</s:else></td>
                        		</tr>
						      	<tr><td>
						      	<span style="display : none;"><s:textfield id="%{#status.index}_yzcd_df" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[5]-1==0 ? 0:#zsb[5]-1)}"></s:textfield></span>
						     	<s:if test="%{#zsb[5].toString()!=null&&#zsb[5].toString()!=''&&#zsb[5]-1!='0'.toString()&&#zsb[5]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[5]-1)" />
                         			</s:if><s:else>--</s:else></td></tr>
						      </s:if>
						      <s:elseif test="#zsb[6].toString()=='原注册地'">
							      <tr><td><s:if test="%{#zsb[7]==null||#zsb[7].toString()==''}">--</s:if>
							      	 <s:else>&nbsp;<s:property value="#zsb[7]" /></s:else></td></tr>
							     	 <tr><td>
							     	 <span style="display : none;"><s:textfield id="%{#status.index}_yzcd_jp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[8]-1==0 ? 0:#zsb[8]-1)}"></s:textfield><s:textfield id="%{#status.index}_yzcd_yp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[9]-1==0 ? 0:#zsb[9]-1)}"></s:textfield><s:textfield id="%{#status.index}_yzcd_tp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[10]-1==0 ? 0:#zsb[10]-1)}"></s:textfield></span>
						     		 <s:if test="%{#zsb[8].toString()!=null&&#zsb[8].toString()!=''&&#zsb[8]-1!='0'.toString()&&#zsb[8]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[8]-1)" />金
	                         			</s:if><s:elseif test="%{#zsb[9].toString()!=null&&#zsb[9].toString()!=''&&#zsb[9]-1!='0'.toString()&&#zsb[9]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[9]-1)" />银
	                         			</s:elseif><s:elseif test="%{#zsb[10].toString()!=null&&#zsb[10].toString()!=''&&#zsb[10]-1!='0'.toString()&&#zsb[10]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[10]-1)" />铜
	                        			</s:elseif><s:else>--</s:else></td>
	                        		</tr>
							      	<tr><td>
							      	<span style="display : none;"><s:textfield id="%{#status.index}_yzcd_df" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[11]-1==0 ? 0:#zsb[11]-1)}"></s:textfield></span>
							      	<s:if test="%{#zsb[11].toString()!=null&&#zsb[11].toString()!=''&&#zsb[11]-1!='0'.toString()&&#zsb[11]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[11]-1)" />
	                         			</s:if><s:else>--</s:else></td></tr>
						      </s:elseif>
						      <s:elseif test="#zsb[12].toString()=='原注册地'">
							      <tr><td><s:if test="%{#zsb[13]==null||#zsb[13].toString()==''}">--</s:if>
							      	 <s:else>&nbsp;<s:property value="#zsb[13]" /></s:else></td></tr>
							     	 <tr><td>
							     	 <span style="display : none;"><s:textfield id="%{#status.index}_yzcd_jp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[14]-1==0 ? 0:#zsb[14]-1)}"></s:textfield><s:textfield id="%{#status.index}_yzcd_yp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[15]-1==0 ? 0:#zsb[15]-1)}"></s:textfield><s:textfield id="%{#status.index}_yzcd_tp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[16]-1==0 ? 0:#zsb[16]-1)}"></s:textfield></span>
						     			<s:if test="%{#zsb[14].toString()!=null&&#zsb[14].toString()!=''&&#zsb[14]-1!='0'.toString()&&#zsb[14]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[14]-1)" />金
	                         			</s:if><s:elseif test="%{#zsb[15].toString()!=null&&#zsb[15].toString()!=''&&#zsb[15]-1!='0'.toString()&&#zsb[15]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[15]-1)" />银
	                         			</s:elseif><s:elseif test="%{#zsb[16].toString()!=null&&#zsb[16].toString()!=''&&#zsb[16]-1!='0'.toString()&&#zsb[16]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[16]-1)" />铜
	                        			</s:elseif><s:else>--</s:else></td>
	                        		</tr>
							      	<tr><td>
							      	<span style="display : none;"><s:textfield id="%{#status.index}_yzcd_df" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[17]-1==0 ? 0:#zsb[17]-1)}"></s:textfield></span>
							      	<s:if test="%{#zsb[17].toString()!=null&&#zsb[17].toString()!=''&&#zsb[17]-1!='0'.toString()&&#zsb[17]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[17]-1)" />
	                         			</s:if><s:else>--</s:else></td></tr>
						      </s:elseif>
						      <s:else>
						      <tr><td>--</td></tr>
						       <tr><td>
						        <span style="display : none;"><s:textfield id="%{#status.index}_yzcd_jp" value="0"></s:textfield><s:textfield id="%{#status.index}_yzcd_yp" value="0"></s:textfield><s:textfield id="%{#status.index}_yzcd_tp" value="0"></s:textfield></span>
						       --</td></tr>
						        <tr><td>
						        <span style="display : none;"><s:textfield id="%{#status.index}_yzcd_df" value="0"></s:textfield></span>
						        --</td></tr>
						      </s:else>
						    </table>
						    <script>zcdjptj('<s:property value="#status.index" />','<s:property value="#status.index" />_zcd_all_jp')</script>
						    <script>zcddftj('<s:property value="#status.index" />','<s:property value="#status.index" />_zcd_all_df')</script>
                         </td>
                          <td>
                        	 <table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
                        	 	<s:if test="%{#sxzs[0].toString()!='none'}">
                        	 	<tr><td><s:property value="#sxzs[0]" /></td></tr>
                        	 	<tr><td>
	                        	 	<% int i=0; %>
	                        	 	<s:if test="%{#sxzs[1]-1!=0}" ><s:property value="#sxzs[1]" />金<% i++;%></s:if>
	                        	 	<s:if test="%{#sxzs[2]-1!=0}" ><s:property value="#sxzs[2]" />银<% i++;%></s:if>
	                        	 	<s:if test="%{#sxzs[3]-1!=0}" ><s:property value="#sxzs[3]" />铜<% i++;%></s:if>
	                        	 	<%if(i==0){%>--<%} %>
                        	 	</td></tr>
                        	 	<tr><td><s:if test="%{#sxzs[4]-1!=0}"><s:property value="#sxzs[4]" /></s:if><s:else>--</s:else></td></tr>
                        	 	</s:if>
                        	 	<s:else>
                        	 	<tr><td>--</td></tr>
                        	 	<tr><td>--</td></tr>
                        	 	<tr><td>--</td></tr>
                        	 	</s:else>
                         	 </table>
                         </td>
                         <td><table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
						        <s:if test="#zsb[0].toString()=='原籍地'" >
						      	<tr><td><s:if test="%{#zsb[1]==null||#zsb[1].toString()==''}">--</s:if>
						      	 <s:else>&nbsp;<s:property value="#zsb[1]" /></s:else></td></tr>
						     	 <tr><td>
						     	 <span style="display : none;"><s:textfield id="%{#status.index}_yjd_jp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[2]==0 ? 0:#zsb[2]-1)}"></s:textfield><s:textfield id="%{#status.index}_yjd_yp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[3]==0 ? 0:#zsb[3]-1)}"></s:textfield><s:textfield id="%{#status.index}_yjd_tp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[4]==0 ? 0:#zsb[4]-1)}"></s:textfield></span>
						     		 <s:if test="%{#zsb[2].toString()!=null&&#zsb[2].toString()!=''&&#zsb[2]-1!='0'.toString()&&#zsb[2]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[2]-1)" />金
                         			</s:if><s:elseif test="%{#zsb[3].toString()!=null&&#zsb[3].toString()!=''&&#zsb[3]-1!='0'.toString()&&#zsb[3]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[3]-1)" />银
                         			</s:elseif><s:elseif test="%{#zsb[4].toString()!=null&&#zsb[4].toString()!=''&&#zsb[4]-1!='0'.toString()&&#zsb[4]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[4]-1)" />铜
                        			</s:elseif><s:else>--</s:else></td>
                        		</tr>
						      	<tr><td>
						      	<span style="display : none;"><s:textfield id="%{#status.index}_yjd_df" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[5]==0 ? 0:#zsb[5]-1)}"></s:textfield></span>
						      	<s:if test="%{#zsb[5].toString()!=null&&#zsb[5].toString()!=''&&#zsb[5]-1!='0'.toString()&&#zsb[5]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[5]-1)" />
                         			</s:if><s:else>--</s:else></td></tr>
						      </s:if>
						      <s:elseif test="#zsb[6].toString()=='原籍地'">
							      <tr><td ><s:if test="%{#zsb[7]==null||#zsb[7].toString()==''}">--</s:if>
								      	 <s:else>&nbsp;<s:property value="#zsb[7]" /></s:else></td></tr>
								     	 <tr><td>
								     	  <span style="display : none;"><s:textfield id="%{#status.index}_yjd_jp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[8]==0 ? 0:#zsb[8]-1)}"></s:textfield><s:textfield id="%{#status.index}_yjd_yp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[9]==0 ? 0:#zsb[9]-1)}"></s:textfield><s:textfield id="%{#status.index}_yjd_tp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[10]==0 ? 0:#zsb[10]-1)}"></s:textfield></span>
								     		 <s:if test="%{#zsb[8].toString()!=null&&#zsb[8].toString()!=''&&#zsb[8]-1!='0'.toString()&&#zsb[8]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[8]-1)" />金
		                         			</s:if><s:elseif test="%{#zsb[9].toString()!=null&&#zsb[9].toString()!=''&&#zsb[9]-1!='0'.toString()&&#zsb[9]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[9]-1)" />银
		                         			</s:elseif><s:elseif test="%{#zsb[10].toString()!=null&&#zsb[10].toString()!=''&&#zsb[10]-1!='0'.toString()&&#zsb[10]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[10]-1)" />铜
		                        			</s:elseif><s:else>--</s:else></td>
		                        		</tr>
								      	<tr><td>
								      	<span style="display : none;"><s:textfield id="%{#status.index}_yjd_df" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[11]==0 ? 0:#zsb[11]-1)}"></s:textfield></span>
						      				<s:if test="%{#zsb[11].toString()!=null&&#zsb[11].toString()!=''&&#zsb[11]-1!='0'.toString()&&#zsb[11]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[11]-1)" />
		                         			</s:if><s:else>--</s:else></td></tr>
						      </s:elseif>
						      <s:elseif test="#zsb[12].toString()=='原籍地'">
							      <tr><td><s:if test="%{#zsb[13]==null||#zsb[13].toString()==''}">--</s:if>
								      	 <s:else>&nbsp;<s:property value="#zsb[13]" /></s:else></td></tr>
								     	 <tr><td>
								     		  <span style="display : none;"><s:textfield id="%{#status.index}_yjd_jp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[14]==0 ? 0:#zsb[14]-1)}"></s:textfield><s:textfield id="%{#status.index}_yjd_yp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[15]==0 ? 0:#zsb[15]-1)}"></s:textfield><s:textfield id="%{#status.index}_yjd_tp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[16]==0 ? 0:#zsb[16]-1)}"></s:textfield></span>
								     		<s:if test="%{#zsb[14].toString()!=null&&#zsb[14].toString()!=''&&#zsb[14]-1!='0'.toString()&&#zsb[14]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[14]-1)" />金
		                         			</s:if><s:elseif test="%{#zsb[15].toString()!=null&&#zsb[15].toString()!=''&&#zsb[15]-1!='0'.toString()&&#zsb[15]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[15]-1)" />银
		                         			</s:elseif><s:elseif test="%{#zsb[16].toString()!=null&&#zsb[16].toString()!=''&&#zsb[16]-1!='0'.toString()&&#zsb[16]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[16]-1)" />铜
		                        			</s:elseif><s:else>--</s:else></td>
		                        		</tr>
								      	<tr><td>
								      	<span style="display : none;"><s:textfield id="%{#status.index}_yjd_df" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[17]==0 ? 0:#zsb[17]-1)}"></s:textfield></span>
						      				<s:if test="%{#zsb[17].toString()!=null&&#zsb[17].toString()!=''&&#zsb[17]-1!='0'.toString()&&#zsb[17]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[17]-1)" />
		                         			</s:if><s:else>--</s:else></td></tr>
						      </s:elseif>
						      <s:elseif test="#zsb[18].toString()=='原籍地'">
							      <tr><td><s:if test="%{#zsb[19]==null||#zsb[19].toString()==''}">--</s:if>
									      	 <s:else>&nbsp;<s:property value="#zsb[19]" /></s:else></td></tr>
									     	 <tr><td>
									     	 <span style="display : none;"><s:textfield id="%{#status.index}_yjd_jp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[20]==0 ? 0:#zsb[20]-1)}"></s:textfield><s:textfield id="%{#status.index}_yjd_yp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[21]==0 ? 0:#zsb[21]-1)}"></s:textfield><s:textfield id="%{#status.index}_yjd_tp" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[22]==0 ? 0:#zsb[22]-1)}"></s:textfield></span>
									     		 <s:if test="%{#zsb[20].toString()!=null&&#zsb[20].toString()!=''&&#zsb[20]-1!='0'.toString()&&#zsb[20]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[20]-1)" />金
			                         			</s:if><s:elseif test="%{#zsb[21].toString()!=null&&#zsb[21].toString()!=''&&#zsb[21]-1!='0'.toString()&&#zsb[21]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[21]-1)" />银
			                         			</s:elseif><s:elseif test="%{#zsb[22].toString()!=null&&#zsb[22].toString()!=''&&#zsb[22]-1!='0'.toString()&&#zsb[22]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[22]-1)" />铜
			                        			</s:elseif><s:else>--</s:else></td>
			                        		</tr>
									      	<tr><td>
									      		<span style="display : none;"><s:textfield id="%{#status.index}_yjd_df" value="%{@com.imchooser.util.NumberUtil@formatPoint(#zsb[23]==0 ? 0:#zsb[23]-1)}"></s:textfield></span>
									      	<s:if test="%{#zsb[23].toString()!=null&&#zsb[23].toString()!=''&&#zsb[23]-1!='0'.toString()&&#zsb[23]-1!='0.0'.toString()}"><s:property value="@com.imchooser.util.NumberUtil@formatPoint(#zsb[23]-1)" />
			                         			</s:if><s:else>--</s:else></td></tr>
						      </s:elseif>
						      <s:else>
						      	<tr><td>--</td></tr>
						       	<tr><td>--</td></tr>
						        <tr><td>--</td></tr>
						      </s:else>
						    </table>
                         </td>
                         <td>
                        	 <table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
                        	 	<tr><td>--</td></tr>
                        	 	<tr><td><span id="<s:property value="#status.index" />_jp"></span><script>jptj('<s:property value="#status.index" />','<s:property value="#status.index" />_jp')</script></td></tr>
                        	 	<tr><td><span id="<s:property value="#status.index" />_df"></span><script>dftj('<s:property value="#status.index" />','<s:property value="#status.index" />_df')</script></td></tr>
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

