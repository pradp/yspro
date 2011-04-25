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
	$(document).ready(function(){
		jQuery("#listTable").unbind("click");
		jQuery("font[@id^=pp1_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("pp1_","pp_");
			$("#"+tmp_id).css("color","blue");
		});
		jQuery("font[@id^=pp2_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("pp2_","pp_");
			$("#"+tmp_id).css("color","red");
		});
		jQuery("font[@id^=jj1_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("jj1_","jj_");
			$("#"+tmp_id).css("color","blue");
		});
		jQuery("font[@id^=jj2_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("jj2_","jj_");
			$("#"+tmp_id).css("color","red");
		});
		jQuery("font[@id^=pppp1_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("pppp1_","pppp_");
			$("#"+tmp_id).css("color","blue");
		});
		jQuery("font[@id^=a1_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("a1_","a_");
			$("#"+tmp_id).css("color","blue");
		});
		jQuery("font[@id^=a2_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("a2_","a_");
			$("#"+tmp_id).css("color","red");
		});
		jQuery("font[@id^=b1_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("b1_","b_");
			$("#"+tmp_id).css("color","blue");
		});
		jQuery("font[@id^=b2_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("b2_","b_");
			$("#"+tmp_id).css("color","red");
		});
		jQuery("font[@id^=c1_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("c1_","c_");
			$("#"+tmp_id).css("color","blue");
		});
		jQuery("font[@id^=d1_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("d1_","d_");
			$("#"+tmp_id).css("color","blue");
		});
		jQuery("font[@id^=d2_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("d2_","d_");
			$("#"+tmp_id).css("color","red");
		});
		jQuery("font[@id^=e1_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("e1_","e_");
			$("#"+tmp_id).css("color","blue");
		});
		jQuery("font[@id^=e2_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("e2_","e_");
			$("#"+tmp_id).css("color","red");
		});
		jQuery("font[@id^=f1_]").each(function(i){
			var tmp_id = this.id;
			tmp_id = tmp_id.replaceAll("f1_","f_");
			$("#"+tmp_id).css("color","blue");
		});
	});
	var objid = parent.tem_valueObjid;
	var objname = parent.tem_nameObjid;
	function doRefreshSysProp(){
		ajaxService.refreshSysProp(ajaxBackString);
	}
	function doreset()
	{	
		document.getElementById("xm").value="";	
		document.getElementById("sfzh").value="";	
		document.getElementById("yddbm").value="";	
	}

	function csh(xm_span, wid_xm){
		if(wid_xm!=""){
			var wid_xms = wid_xm.split(",");//wid_xm,wid_xm....
			var uri = '';
			for(i=0;i<wid_xms.length;i++){
				uri = uri + " <td>"+wid_xms[0]+"</td> ";
			}
			document.getElementById(xm_span).innerHTML=""+uri;
		}
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
  <s:hidden name="cd" value="%{#parameters.cd[0]}" id="cd" />
    <s:hidden name="pager.formname" value="theform"/>
    	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="40%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleft">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
								<tr align="center">
									<td align="right" nowrap="nowrap" class="">&nbsp;&nbsp;&nbsp;代表团：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="dbd" id ="dbd" list="getDbdName()" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
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
    			&nbsp;说明：蓝色标记为直接算入项目，红色标记为与其他项目混合排序后算入项目！
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
	 		        <th width="15%">代表团</th>
	 		        <th width="15%">汇总类型</th>
	    			<th width="15%">&nbsp;</th>
	    			<th width="70%">参赛项目及算分项目</th>
	    		</tr>
    		</thead>
    		<tbody id="listData">
		    		  <tr>
						    <td rowspan="15" style="vertical-align:middle">&nbsp;<s:property value="#listDrcj[0]"/></td>
						    <td rowspan="5" style="vertical-align:middle">&nbsp;金牌榜</td>
						    <td><div align="center">一类项目</div></td>
						    <td>
								 <s:iterator value="xmdj" status="stat1">
									  <s:if test="#xmdj[#stat1.index][1]=='1'.toString() ">
										  <s:set name="mcs" value="#xmdj[#stat1.index][0].split('、')"/>
										  
											 <s:iterator value="#mcs" status="stat2">
											    &nbsp;<font id="pp_<s:property value='#stat1.index'/>_<s:property value='#stat2.index'/>" ><s:property value="#mcs[#stat2.index]"/></font>
					    							<s:iterator value="jrpmxm" status="stat_jrpmxm">
					    								<s:if test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==1 && #jrpmxm[#stat_jrpmxm.index][1]==1">
												   			<font id="pp1_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="blue" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][2]"/>金)</font>
														</s:if>
														<s:elseif test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==1 && #jrpmxm[#stat_jrpmxm.index][1]==3 ">
												   			<font id="pp2_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="red" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][2]"/>金)</font>
														</s:elseif>
											    	</s:iterator>
											    	
													<s:iterator value="fjrxm" status="stat_fjrxm">	
															<s:if test=" #fjrxm[#stat_fjrxm.index][0]==#mcs[#stat2.index] ">
													   			(<s:property value="#fjrxm[#stat_fjrxm.index][1]"/>金)
															</s:if>
													</s:iterator>	
										</s:iterator>
									  </s:if>
								  </s:iterator>
				              </td>
					  </tr>
					  <tr>
					    	<td><div align="center">二类项目</div></td>
						    <td>
								 <s:iterator value="xmdj" status="stat1">
									  <s:if test="#xmdj[#stat1.index][1]=='2'.toString() ">
										  <s:set name="mcs" value="#xmdj[#stat1.index][0].split('、')"/>
										  <s:iterator value="#mcs" status="stat2">
										    &nbsp;<font id="jj_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" ><s:property value="#mcs[#stat2.index]"/></font>
				    							<s:iterator value="jrpmxm" status="stat_jrpmxm">
				    								<s:if test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==1 && #jrpmxm[#stat_jrpmxm.index][1]==2 ">
											   			<font id="jj1_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="blue" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][2]"/>金)</font>
													</s:if>
													<s:if test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==1 && #jrpmxm[#stat_jrpmxm.index][1]==3 ">
											   			<font id="jj2_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="red" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][2]"/>金)</font>
													</s:if>
										    	</s:iterator>
										  <s:iterator value="fjrxm" status="stat_fjrxm">	
															<s:if test=" #fjrxm[#stat_fjrxm.index][0]==#mcs[#stat2.index] ">
													   			(<s:property value="#fjrxm[#stat_fjrxm.index][1]"/>金)
															</s:if>
										  </s:iterator>
										  </s:iterator>
									  </s:if>
								  </s:iterator>
				              </td>
					  </tr>
					  <tr>
					    	<td><div align="center">其他项目</div></td>
						    <td>
								 <s:iterator value="xmdj" status="stat1">
									  <s:if test="#xmdj[#stat1.index][1]=='3'.toString() ">
										  <s:set name="mcs" value="#xmdj[#stat1.index][0].split('、')"/>
										  <s:iterator value="#mcs" status="stat2">
										    &nbsp;<font id="pppp_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" ><s:property value="#mcs[#stat2.index]"/></font>
				    							<s:iterator value="jrpmxm" status="stat_jrpmxm">
				    								<s:if test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==1 ">
											   			<font id="pppp1_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="blue" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][2]"/>金)</font>
													</s:if>
										    	</s:iterator>
										    	
												  <s:iterator value="fjrxm" status="stat_fjrxm">	
														<s:if test=" #fjrxm[#stat_fjrxm.index][0]== #mcs[#stat2.index] ">
															(<s:property value="#fjrxm[#stat_fjrxm.index][1]"/>金)
														</s:if>
												  </s:iterator>
										  </s:iterator>
									  </s:if>
								  </s:iterator>
				              </td>
					  </tr>
					  <tr>
					    	<td><div align="center">带入项目</div></td>
						    <td>
								<s:iterator value="sxdr" status="stat_sxdr">
									<s:if test="#stat_sxdr.index<#count7">
										<font color="blue"><s:property value="#sxdr[#stat_sxdr.index][2]"/>(<s:property value="#sxdr[#stat_sxdr.index][0]"/>金)&nbsp;</font>
									</s:if>
									<s:else>
										<s:property value="#sxdr[#stat_sxdr.index][2]"/>(<s:property value="#sxdr[#stat_sxdr.index][0]"/>金)&nbsp;
									</s:else>	
										
								</s:iterator>
							</td>
					  </tr>
					  <tr>
					    	<td><div align="center">合计：</div></td>
						    <td>&nbsp;共有<s:property  value="#count1"/>+<s:property  value="#count7"/>项计入排名</td>
					  </tr>
				  <tr>
					    <td rowspan="5" style="vertical-align:middle">&nbsp;奖牌榜</td>
					    <td><div align="center">一类项目</div></td>
					    <td>
								 <s:iterator value="xmdj" status="stat1">
									  <s:if test="#xmdj[#stat1.index][1]=='1'.toString() ">
										  <s:set name="mcs" value="#xmdj[#stat1.index][0].split('、')"/>
										  <s:iterator value="#mcs" status="stat2">
										    &nbsp;<font id="a_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" ><s:property value="#mcs[#stat2.index]"/></font>
				    							<s:iterator value="jrpmxm" status="stat_jrpmxm">
				    								<s:if test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==2  && #jrpmxm[#stat_jrpmxm.index][1]==1">
											   			<font id="a1_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="blue" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][6]"/>枚)</font>
													</s:if>
													<s:if test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==2  && #jrpmxm[#stat_jrpmxm.index][1]==3">
											   			<font id="a2_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="red" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][6]"/>枚)</font>
													</s:if>
										    	</s:iterator>
										    	
										  <s:iterator value="fjrxm" status="stat_fjrxm">	
															<s:if test=" #fjrxm[#stat_fjrxm.index][0]==#mcs[#stat2.index] ">
													   			(<s:property value="#fjrxm[#stat_fjrxm.index][2]"/>枚)
															</s:if>
										</s:iterator>	
										  </s:iterator>
									  </s:if>
								  </s:iterator>
				         </td>
				  </tr>
				  <tr>
				    	<td><div align="center">二类项目</div></td>
					    <td>
								 <s:iterator value="xmdj" status="stat1">
									  <s:if test="#xmdj[#stat1.index][1]=='2'.toString() ">
										  <s:set name="mcs" value="#xmdj[#stat1.index][0].split('、')"/>
										  <s:iterator value="#mcs" status="stat2">
										    &nbsp;<font id="b_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" ><s:property value="#mcs[#stat2.index]"/></font>
				    							<s:iterator value="jrpmxm" status="stat_jrpmxm">
				    								<s:if test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==2  && #jrpmxm[#stat_jrpmxm.index][1]==2">
											   			<font id="b1_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="blue" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][6]"/>枚)</font>
													</s:if>
													<s:if test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==2  && #jrpmxm[#stat_jrpmxm.index][1]==3">
											   			<font id="b2_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="red" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][6]"/>枚)</font>
													</s:if>
										    	</s:iterator>
										    	<s:iterator value="fjrxm" status="stat_fjrxm">	
															<s:if test=" #fjrxm[#stat_fjrxm.index][0]==#mcs[#stat2.index] ">
													   			(<s:property value="#fjrxm[#stat_fjrxm.index][2]"/>枚)
															</s:if>
										</s:iterator>	
										  </s:iterator>
									  </s:if>
								  </s:iterator>
				              </td>
				  </tr>
				  <tr>
				    	<td><div align="center">其他项目</div></td>
					    <td>
								 <s:iterator value="xmdj" status="stat1">
									  <s:if test="#xmdj[#stat1.index][1]=='3'.toString() ">
										  <s:set name="mcs" value="#xmdj[#stat1.index][0].split('、')"/>
										  <s:iterator value="#mcs" status="stat2">
										    &nbsp;<font id="c_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" ><s:property value="#mcs[#stat2.index]"/></font>
				    							<s:iterator value="jrpmxm" status="stat_jrpmxm">
				    								<s:if test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==2 ">
											   			<font id="c1_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="blue" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][6]"/>枚)</font>
													</s:if>
										    	</s:iterator>
										    	<s:iterator value="fjrxm" status="stat_fjrxm">	
															<s:if test=" #fjrxm[#stat_fjrxm.index][0]==#mcs[#stat2.index] ">
													   			(<s:property value="#fjrxm[#stat_fjrxm.index][2]"/>枚)
															</s:if>
										</s:iterator>	
										  </s:iterator>
									  </s:if>
								  </s:iterator>
				              </td>
				  </tr>
				  <tr>
				    	<td><div align="center">带入项目</div></td>
					    <td>
								<s:iterator value="sxdr" status="stat_sxdr">
									<s:if test="#stat_sxdr.index<#count8">
										<font color="blue"><s:property value="#sxdr[#stat_sxdr.index][2]"/>(<s:property value="#sxdr[#stat_sxdr.index][0]"/>枚)&nbsp;</font>
									</s:if>
									<s:else>
										<s:property value="#sxdr[#stat_sxdr.index][2]"/>(<s:property value="#sxdr[#stat_sxdr.index][0]"/>枚)&nbsp;
									</s:else>	
								</s:iterator>
							</td>
				  </tr>
				  <tr>
				    	<td><div align="center">合计：</div></td>
					    <td>&nbsp;共有<s:property  value="#count2"/>+<s:property  value="#count7"/>项计入排名</td>
				  </tr>
    		  <tr>
					    <td rowspan="5" style="vertical-align:middle">&nbsp;总分榜</td>
					    <td><div align="center">一类项目</div></td>
					    <td>
								 <s:iterator value="xmdj" status="stat1">
									  <s:if test="#xmdj[#stat1.index][1]=='1'.toString() ">
										  <s:set name="mcs" value="#xmdj[#stat1.index][0].split('、')"/>
										  <s:iterator value="#mcs" status="stat2">
										    &nbsp;<font id="d_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" ><s:property value="#mcs[#stat2.index]"/></font>
				    							<s:iterator value="jrpmxm" status="stat_jrpmxm">
				    								<s:if test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==3 && #jrpmxm[#stat_jrpmxm.index][1]==1">
											   			<font id="d1_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="blue" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][5]"/>分)</font>
													</s:if>
													<s:if test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==3 && #jrpmxm[#stat_jrpmxm.index][1]==3">
											   			<font id="d2_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="red" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][5]"/>分)</font>
													</s:if>
										    	</s:iterator>
										    	
										  <s:iterator value="fjrxm" status="stat_fjrxm">	
															<s:if test=" #fjrxm[#stat_fjrxm.index][0]==#mcs[#stat2.index] ">
													   			(<s:property value="#fjrxm[#stat_fjrxm.index][3]"/>分)
															</s:if>
										</s:iterator>	
										  </s:iterator>
									  </s:if>
								  </s:iterator>
				              </td>
				  </tr>
				  <tr>
				    	<td><div align="center">二类项目</div></td>
					    <td>
								 <s:iterator value="xmdj" status="stat1">
									  <s:if test="#xmdj[#stat1.index][1]=='2'.toString() ">
										  <s:set name="mcs" value="#xmdj[#stat1.index][0].split('、')"/>
										  <s:iterator value="#mcs" status="stat2">
										    &nbsp;<font id="e_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" ><s:property value="#mcs[#stat2.index]"/></font>
				    							<s:iterator value="jrpmxm" status="stat_jrpmxm">
				    								<s:if test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==3 && #jrpmxm[#stat_jrpmxm.index][1]==2 ">
											   			<font id="e1_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="blue" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][5]"/>分)</font>
													</s:if>
													<s:if test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==3 && #jrpmxm[#stat_jrpmxm.index][1]==3 ">
											   			<font id="e2_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="red" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][5]"/>分)</font>
													</s:if>
										    	</s:iterator>
										    	
										  <s:iterator value="fjrxm" status="stat_fjrxm">	
															<s:if test=" #fjrxm[#stat_fjrxm.index][0]==#mcs[#stat2.index] ">
													   			(<s:property value="#fjrxm[#stat_fjrxm.index][3]"/>分)
															</s:if>
										</s:iterator>	
										  </s:iterator>
									  </s:if>
								  </s:iterator>
				              </td>
				  </tr>
				  <tr>
				    	<td><div align="center">其他项目</div></td>
					    <td>
								 <s:iterator value="xmdj" status="stat1">
									  <s:if test="#xmdj[#stat1.index][1]=='3'.toString() ">
										  <s:set name="mcs" value="#xmdj[#stat1.index][0].split('、')"/>
										  <s:iterator value="#mcs" status="stat2">
										    &nbsp;<font id="f_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" ><s:property value="#mcs[#stat2.index]"/></font>
				    							<s:iterator value="jrpmxm" status="stat_jrpmxm">
				    								<s:if test="#jrpmxm[#stat_jrpmxm.index][0]==#mcs[#stat2.index] && #jrpmxm[#stat_jrpmxm.index][7]==3 ">
											   			<font id="f1_<s:property value="#stat1.index"/>_<s:property value="#stat2.index"/>" color="blue" >(<s:property value="#jrpmxm[#stat_jrpmxm.index][5]"/>分)</font>
													</s:if>
										    	</s:iterator>
										    	
										  <s:iterator value="fjrxm" status="stat_fjrxm">	
															<s:if test=" #fjrxm[#stat_fjrxm.index][0]==#mcs[#stat2.index] ">
													   			(<s:property value="#fjrxm[#stat_fjrxm.index][3]"/>分)
															</s:if>
										</s:iterator>	
										  </s:iterator>
									  </s:if>
								  </s:iterator>
				              </td>
				  </tr>
				  <tr>
				    	<td><div align="center">带入项目</div></td>
					    <td>
								<s:iterator value="sxdr" status="stat_sxdr">
									<s:if test="#stat_sxdr.index<#count9">
										<font color="blue"><s:property value="#sxdr[#stat_sxdr.index][2]"/>(<s:property value="#sxdr[#stat_sxdr.index][1]"/>分)&nbsp;</font>
									</s:if>
									<s:else>
										<s:property value="#sxdr[#stat_sxdr.index][2]"/>(<s:property value="#sxdr[#stat_sxdr.index][1]"/>分)&nbsp;
									</s:else>	
								</s:iterator>
							</td>
				  </tr>
				  <tr>
				    	<td><div align="center">合计：</div></td>
					    <td>&nbsp;共有<s:property  value="#count3"/>+<s:property  value="#count7"/>项计入排名</td>
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

