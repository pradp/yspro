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
	function doreset(){
		$("#time").val("");
		$("#dbtmc").val("");
		$("#dxmmc").val("");
		$("#xxmmc").val("");
	}
	function getAllDbtTime(){

		ajaxService.getAllDbtTime2($("#departid").val(),$("#dxmmc").val(),function (data){
			getSelectedText();
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			DWRUtil.removeAllOptions('time');
			DWRUtil.addOptions( 'time', data,'id','caption');
			var obj1 = document.getElementById("hidden_time");
			if(obj1.value!=null && obj1.value!=''){
				DWRUtil.setValue('time',obj1.value);
				obj1.value='';
			}
			$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
		});

	} 
	//获取下拉列表选中项的文本
	function getSelectedText(){
		obj = $("#departid");
		for(i=0;i<obj.length;i++){
	  	 	if(obj[i].selected==true){
	    		$("#dbtmc").val(obj[i].innerText);      //关键是通过option对象的innerText属性获取到选项文本
	  	 	}
		}
	
	}
	
	function getDxmmcByTimeAndDbt(){

		ajaxService.getDxmmcByTimeAndDbt2($("#departid").val(),function (data){
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			DWRUtil.removeAllOptions('dxmmc');
			DWRUtil.addOptions( 'dxmmc', data,'id','caption');
			var obj1 = document.getElementById("hidden_dxmmc");
			if(obj1.value!=null && obj1.value!=''){
				DWRUtil.setValue('dxmmc',obj1.value);
				obj1.value='';
			}
			$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
			getAllDbtTime();
		});
		//调用算差值
		toVal();
	}

	function openPage2(uri){
		openWindow(uri,850,450);
	}

	function lookCare(type,param,val){
		if(type==1){
			var uri = '../business/sportScDpHd-list.c?sportBsxm.dpType='+param+'&sportBsxm.val='+val;
			openPage2(uri);
		}else if(type==2){
			var uri = '../business/sportCjCxZsMx-list.c?lx='+param;
			openPage2(uri);
		}else if(type==3){
			type = 'rsZs';
			
			input('1','','&param='+param,type);
		}
		
	}
	
	//数值的减运算
	function accMinutes(arg1,arg2){
	    var r1,r2,m;
	    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
	    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
	    m=Math.pow(10,Math.max(r1,r2))
	    return (arg1*m-arg2*m)/m
	}
	function toVal(){
		var ssrc_jp = $("#ssrc_jp").html();
		var ssrc_yp = $("#ssrc_yp").html();
		var ssrc_tp = $("#ssrc_tp").html();
		var ssrc_df = $("#ssrc_df").html();

		var sj_jp = $("#sj_jp").html();
		var sj_yp = $("#sj_yp").html();
		var sj_tp = $("#sj_tp").html();
		var sj_df = $("#sj_df").html();

		var zs_jp = $("#zs_jp").html();
		var zs_yp = $("#zs_yp").html();
		var zs_tp = $("#zs_tp").html();
		var zs_df = $("#zs_df").html();

		var sj_rs_jp = $("#sj_rs_jp").html();
		var sj_rs_yp = $("#sj_rs_yp").html();
		var sj_rs_tp = $("#sj_rs_tp").html();
		var sj_rs_df = $("#sj_rs_df").html();
		
	//	var zs_rs_jp = $("#zs_rs_jp").html();
	//	var zs_rs_yp = $("#zs_rs_yp").html();
	//	var zs_rs_tp = $("#zs_rs_tp").html();
	//	var zs_rs_df = $("#zs_rs_df").html();
		

		var  sj_ssrc_jp = accMinutes(sj_jp,ssrc_jp);
		var  zs_sj_jp = accMinutes(zs_jp,sj_jp);
	//	var  sj_zs_rs_jp = accMinutes(zs_rs_jp,sj_rs_jp);
		
		var link_ssrc_zs = "<span style='cursor: pointer; color: blue;text-decoration: underline; ' onclick='lookCare(1,";
		
		var link_zs_sj_jp = "<span style='cursor: pointer;color: blue; text-decoration: underline;' onclick='lookCare(2,1)'>";
		var link_zs_sj_yp = "<span style='cursor: pointer;color: blue; text-decoration: underline;' onclick='lookCare(2,2)'>";
		var link_zs_sj_tp = "<span style='cursor: pointer;color: blue; text-decoration: underline;' onclick='lookCare(2,3)'>";
		var link_zs_sj_df = "<span style='cursor: pointer;color: blue; text-decoration: underline;' onclick='lookCare(2,4)'>";
		
		var link_zs_sj_rs_jp = "<span style='cursor: pointer;color: blue; text-decoration: underline;' onclick='lookCare(3,1)'>";
		var link_zs_sj_rs_yp = "<span style='cursor: pointer;color: blue; text-decoration: underline;' onclick='lookCare(3,2)'>";
		var link_zs_sj_rs_tp = "<span style='cursor: pointer;color: blue; text-decoration: underline;' onclick='lookCare(3,3)'>";
		var link_zs_sj_rs_df = "<span style='cursor: pointer;color: blue; text-decoration: underline;' onclick='lookCare(3,4)'>";

		if(sj_ssrc_jp!=0){
			sj_ssrc_jp = link_ssrc_zs+1+","+sj_ssrc_jp+")' >"+sj_ssrc_jp+"</span>";
		}
		if(zs_sj_jp!=0){
			zs_sj_jp = link_zs_sj_jp+zs_sj_jp+"</span>";
		}
	//	if(sj_zs_rs_jp!=0){
	//		sj_zs_rs_jp = link_zs_sj_rs_jp+sj_zs_rs_jp+"</span>";
	//	}
		
		$("#sj_ssrc_jp").html(sj_ssrc_jp+"");
		$("#zs_sj_jp").html(zs_sj_jp+"");
	//	$("#sj_zs_rs_jp").html(sj_zs_rs_jp+"");

		var  sj_ssrc_yp = accMinutes(sj_yp,ssrc_yp);
		var  zs_sj_yp = accMinutes(zs_yp,sj_yp);
	//	var  sj_zs_rs_yp = accMinutes(zs_rs_yp,sj_rs_yp);

		if(sj_ssrc_yp!=0){
			//sj_ssrc_yp = link_ssrc_zs+sj_ssrc_yp+"</span>";
			sj_ssrc_yp = link_ssrc_zs+2+","+sj_ssrc_yp+")' >"+sj_ssrc_yp+"</span>";
		}
		if(zs_sj_yp!=0){
			zs_sj_yp = link_zs_sj_yp+zs_sj_yp+"</span>";
		}
		
	//	if(sj_zs_rs_yp!=0){
	//		sj_zs_rs_yp = link_zs_sj_rs_yp+sj_zs_rs_yp+"</span>";
	//	}
		
		$("#sj_ssrc_yp").html(sj_ssrc_yp+"");
		$("#zs_sj_yp").html(zs_sj_yp+"");
	//	$("#sj_zs_rs_yp").html(sj_zs_rs_yp+"");

		var  sj_ssrc_tp = accMinutes(sj_tp,ssrc_tp);
		var  zs_sj_tp = accMinutes(zs_tp,sj_tp); 
	//	var  sj_zs_rs_tp = accMinutes(zs_rs_tp,sj_rs_tp);

		if(sj_ssrc_tp!=0){
		//	sj_ssrc_tp = link_ssrc_zs+sj_ssrc_tp+"</span>";
			sj_ssrc_tp = link_ssrc_zs+3+","+sj_ssrc_tp+")' >"+sj_ssrc_tp+"</span>";
			
		}
		if(zs_sj_tp!=0){
			zs_sj_tp = link_zs_sj_tp+zs_sj_tp+"</span>";
		}
	//	if(sj_zs_rs_tp!=0){
	//		sj_zs_rs_tp = link_zs_sj_rs_tp+sj_zs_rs_tp+"</span>";
	//	}
		
		$("#sj_ssrc_tp").html(sj_ssrc_tp+"");
		$("#zs_sj_tp").html(zs_sj_tp+"");
	//	$("#sj_zs_rs_tp").html(sj_zs_rs_tp+"");
		
		var  sj_ssrc_df = accMinutes(sj_df,ssrc_df);
		var  zs_sj_df = accMinutes(zs_df,sj_df); 
	//	var  sj_zs_rs_df = accMinutes(zs_rs_df,sj_rs_df);

		if(sj_ssrc_df!=0){
			//sj_ssrc_df = link_ssrc_zs+sj_ssrc_df+"</span>";
			sj_ssrc_df = link_ssrc_zs+4+","+sj_ssrc_df+")' >"+sj_ssrc_df+"</span>";
		}
		if(zs_sj_df!=0){
			zs_sj_df = link_zs_sj_df+zs_sj_df+"</span>";
		}
	//	if(sj_zs_rs_df!=0){
	//		sj_zs_rs_df = link_zs_sj_rs_df+sj_zs_rs_df+"</span>";
	//	}
		$("#sj_ssrc_df").html(sj_ssrc_df+"");
		$("#zs_sj_df").html(zs_sj_df+"");
	//	$("#sj_zs_rs_df").html(sj_zs_rs_df+"");
		
	}
	</script>
	<style type="text/css">
		#paipang{
			display: none;
		}
		#printDate{
			display: none;
		}
		.mytext{
			text-align: center;
		}
	</style>
	<style type="text/css" media="print">
		#searchForm{
			display: none;
		}
		#buttonTable{
			display: none;
		}
		#nop{
			display: none;
		}
		#paipang{
			display: block;
		}
		#fsearch{
			display: none;
		}
		#printstyle{
			font-size: 30px; 
			text-align: center; 
			font-family: 黑体; 
			line-height: 30px; 
		}
		#printDate{
			display: block;
			font-size: 12px; 
			text-align: center; 
		}
	</style>
	
  </head>
<body onload=toVal() > 
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
    <s:hidden id="hidden_time" value="%{cjTdMx.createtime1}"/>
    <s:hidden id="hidden_dxmmc" value="%{cjTdMx.dxmmc}"/>
    <s:hidden id="hidden_dxmmc2" value="%{cjTdMx.dxmmc}"/>
    <s:hidden id="hidden_xxmmc" value="%{cjTdMx.xxmmc}"/>
    <s:hidden id="hidden_zb" value="%{cjTdMx.zb}"/>
    <s:hidden id="hidden_xbz" value="%{cjTdMx.xbz}"/>
    <s:hidden id="hidden_departid" value="%{cjTdMx.departid}"/>
     <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
    
    <tr><td id="fsearch"> 
     <!-- 
     <table width="95%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
	  <tr>
	    <td class="chaxunleft">
	    
         <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="98%">
			    <tr>
					<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;代表团：</td>
					<td align="left" nowrap="nowrap" id="xbzContainer" colspan="1">
						 <s:select name="cjTdMx.departid" id ="departid" list="getDbtmc2()" onchange="getDxmmcByTimeAndDbt()" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
						<s:textfield name="cjTdMx.dbtmc" id="dbtmc" cssStyle="display : none"></s:textfield>
					</td>
					<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;大项目：</td>
					<td align="left" nowrap="nowrap" id="xbzContainer" colspan="1">
						 <s:select name="cjTdMx.dxmmc" id ="dxmmc" list="#{}" onchange="getAllDbtTime()" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
					</td>
					<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;时间：</td>
					<td align="left" nowrap="nowrap" id="xbzContainer" colspan="1">
						 <s:select name="cjTdMx.createtime1" id ="time" list="#{}" listKey="id" onchange="getZbByTimeAndDxmmcAndXxmmc()" listValue="caption" headerKey="" headerValue="--请选择--"/>
					</td>
					<td align="left" nowrap="nowrap"><ul class="btn_gn">
						<li>
							<a href="#" title="查询" onClick="super_doSearch()"
								id="searchButton" name="btn3"><span> 查询 </span>
							</a>
							<a href="#" title="重置" onClick="doreset()"
								id="searchButton2" name="btn4"><span> 重置 </span>
							</a>
						</li>
					</ul></td>
				</tr>
		</table>
			
		</td>
	    <td width="15" height="70" class="chaxunright">&nbsp;</td>
	  </tr>
    </table>
     -->
    </td></tr>
    <tr><td>
     <table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%" >
     <tr>
     	<td>
     		<b>本次查询结果为：</b>应折算次数：<s:property value="#ll_cs_data[0][0]" />，
     		实际折算次数：<s:property value="#sj_cs_data[0][0]" />，
     		偏差：<s:if test="%{#ll_cs_data[0][0]-#sj_cs_data[0][0]!=0}"><a href="#" onclick="input('1','','','rsZs');" ><s:property value="%{#ll_cs_data[0][0]-#sj_cs_data[0][0]}" /></a></s:if>
     		<s:else>0</s:else>
     	</td>
     </tr>
    		<tr style="display: none;">
    			<td height="30px"  width="70" align="center">
    			<ul class="btn_gn">
					    <li><a href="#" title="打印" onClick="window.print();" name="create0" ><span>打印</span></a></li>
			    </ul>
			   </td>   	
			   <td align="left"><span style="font-size :12px; color: red;">说明：代表团得牌为竞赛得牌，不含带入成绩。</span></td>	  
    		</tr>
   </table>
    </td></tr>
    	<tr height="40" align="center" id="paipang">
   			<td align="center" id="printstyle"><s:property value="cjTdMx.dbtmc" />代表团<s:if test="%{#cxDxmmc!=null && #cxDxmmc!=''}" ><s:property value="cxDxmmc" /></s:if>成绩查询</td>
   		</tr>
    	<tr align="center" id="paipang">
   			<td align="center" id="printDate"> <s:if test="cjTdMx.createtime1=='all'">截止比赛时间：<s:property value="recentDate" /></s:if><s:else>比赛时间:<s:property value="cjTdMx.createtime1" /></s:else> &nbsp;&nbsp;&nbsp;&nbsp;打印时间：<s:property value="printDate" /></td>
   		</tr>
   <tr><td align="center">
    <table width="100%" border="0" height="100%" align="center" cellpadding="0" cellspacing="0" class="maginB" >
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
    			<th width="16%">类别\项目</th>
    			<th width="21%">金牌</th>
    			<th width="21%">银牌</th>
    			<th width="21%">铜牌</th>
    			<th width="21%">得分</th>
    			</tr>
    		</thead>
    		<tbody id="listData">
    			<tr>
    				<td style="vertical-align:middle; border-bottom: none;">
    					<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%"  style="height: 75;" class="middle">
    						<tr><td>赛程</td></tr>
    						<tr><td>实际</td></tr>
    						<tr><td>折算</td></tr>
    					
    					</table>
    				</td>
     			  	<td style="vertical-align:middle; border-left: none; border-bottom: none;">
     			  		 	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
     			  		 		<tr>
     			  		 			<td width="50%" style="border-bottom: none; border-left: none;">
     			  		 				<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
     			  		 					<tr><td id="ssrc_jp"><s:property value="#ssrcData[0][0]" /></td></tr>
     			  		 					<tr><td id="sj_jp"><s:property value="#sjData[0][0]" /></td></tr>
     			  		 					<tr><td id="zs_jp"><s:property value="#zsData[0][0]" /></td></tr>
     			  		 					
     			  		 				</table>
     			  		 			</td>
     			  		 			<td width="50%" style="border-bottom: none; border-left: none;">
     			  		 				<table  border="0" cellspacing="0" cellpadding="0" width="100%" style="height: 75;" class="middle">
     			  		 					<tr><td id="sj_ssrc_jp" style="vertical-align: middle;height: 37px;"></td></tr>
     			  		 					<tr><td id="zs_sj_jp" style="vertical-align: middle;height: 38px;"></td></tr>
     			  		 				</table>
     			  		 			</td>
     			  		 		</tr>
     			  		 	</table>
     			  		 </td>
                         <td style="vertical-align:middle; border-left: none; border-bottom: none;">
                         		<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
     			  		 		<tr>
     			  		 			<td width="50%" style="border-bottom: none; border-left: none;">
     			  		 				<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
     			  		 					<tr><td id="ssrc_yp"><s:property value="#ssrcData[0][1]" /></td></tr>
     			  		 					<tr><td id="sj_yp"><s:property value="#sjData[0][1]" /></td></tr>
     			  		 					<tr><td id="zs_yp"><s:property value="#zsData[0][1]" /></td></tr>
     			  		 				</table>
     			  		 			</td>
     			  		 			<td width="50%" style="border-bottom: none; border-left: none;">
     			  		 				<table  border="0" cellspacing="0" cellpadding="0" width="100%" style="height: 75;" class="middle">
     			  		 					<tr><td id="sj_ssrc_yp" style="vertical-align: middle;height: 37px;"></td></tr>
     			  		 					<tr><td id="zs_sj_yp" style="vertical-align: middle;height: 38px;"></td></tr>
     			  		 				</table>
     			  		 			</td>
     			  		 		</tr>
     			  		 	</table>
                         </td>
                         <td style="vertical-align:middle;  border-left: none;  border-right: 1px #D7D8D9 solid; border-bottom: none;" >
                         		<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
     			  		 		<tr>
     			  		 			<td width="50%" style="border-bottom: none; border-left: none;">
     			  		 				<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
     			  		 					<tr><td id="ssrc_tp"><s:property value="#ssrcData[0][2]" /></td></tr>
     			  		 					<tr><td id="sj_tp"><s:property value="#sjData[0][2]" /></td></tr>
     			  		 					<tr><td id="zs_tp"><s:property value="#zsData[0][2]" /></td></tr>
     			  		 				</table>
     			  		 			</td>
     			  		 			<td width="50%" style="border-bottom: none; border-left: none;">
     			  		 				<table  border="0" cellspacing="0" cellpadding="0" width="100%" style="height: 75;"  class="middle">
     			  		 					<tr><td id="sj_ssrc_tp" style="vertical-align: middle; border-right: none;height: 37px;" ></td></tr>
     			  		 					<tr><td id="zs_sj_tp" style="vertical-align: middle; border-right: none;height: 38px;" ></td></tr>
     			  		 				</table>
     			  		 			</td>
     			  		 		</tr>
     			  		 	</table>
                         </td>
                         <td style="vertical-align:middle;  border-left: none;  border-right: 1px #D7D8D9 solid; border-bottom: none;" >
                         		<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
     			  		 		<tr>
     			  		 			<td width="50%" style="border-bottom: none; border-left: none;">
     			  		 				<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
     			  		 					<tr><td id="ssrc_df"><s:property value="#ssrcData[0][3]" /></td></tr>
     			  		 					<tr><td id="sj_df"><s:property value="#sjData[0][3]" /></td></tr>
     			  		 					<tr><td id="zs_df"><s:property value="#zsData[0][3]" /></td></tr>
     			  		 				</table>
     			  		 			</td>
     			  		 			<td width="50%" style="border-bottom: none; border-left: none;">
     			  		 				<table  border="0" cellspacing="0" cellpadding="0" width="100%" style="height: 75;"  class="middle">
     			  		 					<tr><td id="sj_ssrc_df" style="vertical-align: middle; border-right: none;height: 37px;" ></td></tr>
     			  		 					<tr><td id="zs_sj_df" style="vertical-align: middle; border-right: none;height: 38px;" ></td></tr>
     			  		 				</table>
     			  		 			</td>
     			  		 		</tr>
     			  		 	</table>
                         </td>
	    			</tr>
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
	</table></td></tr>
	<tr><td style="color: gray;">&nbsp;&nbsp;&nbsp;&nbsp;赛程差值&nbsp;=&nbsp;实际值&nbsp;-&nbsp;赛程值；折算差值&nbsp;=&nbsp;折算值&nbsp;-&nbsp;实际值</td></tr>
    </table> 	
    	
    	
    	</s:form>
    </div>
  </body>
</html>

