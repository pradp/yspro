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
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
	<script type="text/javascript">
	listPageStyle();
	var objid = parent.tem_valueObjid1;
	var objname = parent.tem_nameObjid1;
	function doRefreshSysProp(){
		ajaxService.refreshSysProp(ajaxBackString);
	}
	function doreset()
	{	
			document.getElementById("xmdj").value="";
			document.getElementById("dxmmc").value="";	
			document.getElementById("xxmmc").value="";	
			document.getElementById("zb").value="";
			document.getElementById("xbz").value="";
			document.getElementById("scbm").value=""
			document.getElementById("startTime").value=""
			document.getElementById("endTime").value=""
	}
	
	function postSxysc(){
		var slength = 0;
		var objidValue="";
		var a = document.getElementsByName("selectNode");
		for (var i = 0; i < a.length; i++) {
			if (a[i].checked) {
				slength += 1;
			}
		}
		if(slength==1){
			var id = CropCheckBoxValueAsString("selectNode");
			objidValue = id;
			parent.document.getElementById(objid).value=objidValue;
			parent.document.getElementById(objname).value=document.getElementById("xxmmc_"+id).innerHTML+ ""+
														  document.getElementById("zb_"+id).innerHTML+""+
														  document.getElementById("xbz_"+id).innerHTML+"("+
														  document.getElementById("bssj_"+id).innerHTML+")";
			parent.closeInputWindow();
		}else{
			alert("请勾选一条记录!");
		}

	}
	
	var i =0;
	function getzy2(){
		i=1;
		document.getElementById("dxmmc_later").value="";
		getzyy();
	}
	
	function getzy1(){
		i=1;
		document.getElementById("xxmmc_later").value="";
		document.getElementById("zb_later").value="";	
		document.getElementById("xbz_later").value="";		
		getzy();
	}
	function getzyy(){
		var xmdj=document.getElementById("xmdj").value;
		if(xmdj!=""){
	   		changeSelectHtml1(xmdj);
	   	}
	}
	function getzy(){
		var dxmmc=document.getElementById("dxmmc").value;
		if(dxmmc!=""){
	   		changeSelectHtml(dxmmc);
	   	}
	}

	function changeSelectHtml1(obj){
		ajaxService.getSelectXmdj(obj,ce);
		
	}
	function changeSelectHtml(obj){
			ajaxService.getSelectXxmmc(obj,cb);
			ajaxService.getSelectZb(obj,cd);
			ajaxService.getSelectXbz(obj,cf);
	}
	function ce(result){
		var changeSelectId = "dxmmc";
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		jQuery("#dxmmcContainer").html('<select name="tsportSsrc.dxmmc" id="dxmmc" onchange="getzy1()" ><option value="" >--请选择--</option></select>');
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
		jQuery("#zbContainer").html('<select name="tsportSsrc.zb" id="zb"><option value="">--请选择--</option></select>');
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
		jQuery("#xbzContainer").html('<select name="tsportSsrc.xbz" id="xbz"><option value="">--请选择--</option></select>');
		DWRUtil.addOptions( changeSelectId, result );
		var obj = document.getElementById("xbz_later");
		if(obj.value != '' && i==0){
			DWRUtil.setValue(changeSelectId,obj.value);
		}
		$ = jQuery;
	}
	function xmjdsz(){
		input("","","","xmjdsz");
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
    <s:hidden name="pager.formname" value="theform"/>
     <s:hidden name="cd" value="%{#parameters.cd[0]}" id="cd"/>
    <input type="hidden" value="<s:property value="tsportSsrc.xxmmc" />" id="xxmmc_later" />
    <input type="hidden" value="<s:property value="tsportSsrc.dxmmc" />" id="dxmmc_later" />
    <input type="hidden" value="<s:property value="tsportSsrc.zb" />" id="zb_later" />
	<input type="hidden" value="<s:property value="tsportSsrc.xbz" />" id="xbz_later" />
    	   	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunlefts">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="95%">
								<tr align="center">
									<td align="right" nowrap="nowrap" class="" width="10%">&nbsp;项目等级：</td>
									<td align="left" nowrap="nowrap"  width="15%">
										<s:select name="tsportSsrc.xmdj" id ="xmdj" list="getXmdjList()" listKey="id"  listValue="caption" onchange="getzy2()" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="" width="10%">&nbsp;项目：</td>
									<td align="left" nowrap="nowrap" id="dxmmcContainer" width="15%">
										<s:select name="tsportSsrc.dxmmc" id ="dxmmc" list="getAllDxmmc()" listKey="caption" onchange="getzy1()" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="" width="10%">&nbsp;级（赛）别：</td>
									<td align="left" nowrap="nowrap" id="xxmmcContainer" width="35%">
										 <s:select name="tsportSsrc.xxmmc" id ="xxmmc" list="#{}" listKey="caption" listValue="caption" headerKey="" headerValue="-------请选择-------"/>
									</td>
								</tr>
								<tr>
									<td align="right" nowrap="nowrap" class="">&nbsp;组别：</td>
									<td align="left" nowrap="nowrap" id="zbContainer">
										 <s:select name="tsportSsrc.zb" id ="zb" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;性别组：</td>
									<td align="left" nowrap="nowrap" id="xbzContainer">
										 <s:select name="tsportSsrc.xbz" id ="xbz" list="#{}" listKey="caption" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									 <td align="right" nowrap="nowrap" class="">赛次：</td>
								     <td align="left" nowrap="nowrap">
								       	<s:select name="tsportSsrc.scbm" id ="scbm" list="getSysCode('SSRC_SCBM')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
								     </td>
							     </tr>
							     <tr>
									<td align="right" nowrap="nowrap">起始时间：</td>
										<td align="left" id="span_rq">
   									 			<span id="span_2" ><s:textfield id="rq_2" name="startTime" size="13" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})" /></span>
									 	</td>
									<td align="right" nowrap="nowrap">结束时间：</td>
										<td align="left" id="span_rq2">
   									 			<span id="span_4" ><s:textfield id="rq_4" name="endTime" size="13" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})" /></span>
  									 	</td>
  									 <td></td>
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
						<td width="15" height="85" class="chaxunrights">
							&nbsp;
						</td>
					</tr>
				</table></td></tr></table>

   
    	<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%">
    	<s:if test="#parameters.cd[0]==1">
    		<tr>
			    <td height="30px">
				   <ul class="btn_gn">
					<li><a href="#" title=" 确定" onClick="postSxysc()"><span> 确定</span></a></li>
					<li ><a href="#" title="取消" onClick="parent.closeInputWindow()"><span>取消</span></a></li>		 
				   </ul>
			     </td>    
			 </tr>
    	</s:if>
    	<s:else>
    		<tr>
    			<td height="30px" colspan="10">
    			<ul class="btn_gn">
			    <li><a href="#" title="新增赛事日程" onClick="input();" name="create0"><span>新增赛事日程</span></a></li>
			    <li><a href="#" title="修改赛事日程" onClick="modifySelected()"  name="modifyStudent"><span>修改赛事日程</span></a></li>
			    <li><a href="#" title="删除赛事日程" onClick="submitRemove()" name="removeRows"><span>删除赛事日程</span></a></li>
			    <li><a href="#" title="批量修改赛程信息" onClick="xmjdsz()" name="xmjdsz0"><span>批量修改赛程信息</span></a></li>
			</ul>
    	     </td>
    		</tr>
    	</s:else>
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
    			<th height="20px" width="5%"></th>
    			<th width="8%">比赛时间</th>
 		        <th width="8%">项目</th>
    			<th width="10%">级（赛）别</th>
    			<th width="5%">组别</th>
    			<th width="5%">性别组</th>  			
    			<th width="5%">编排分组</th>
    			<th width="5%">赛次</th>
    			<th width="10%">比赛场馆</th>
    			<th width="8%">项目等级</th>
    			<th width="5%">发布状态</th>
    		</tr>
    		</thead>
    		<tbody id="listData">
 	  <s:iterator value="resultData">
    		<tr>
     			<td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td> 
     			<td>&nbsp;
     			<a href="javascript:input('<s:property value="wid"/>','type=0')"><font color="blue"><span id="bssj_<s:property value='wid'/>" >
     			<s:date name="bssj" format="yyyy-MM-dd HH:mm"/></span></font></a></td>
     			<td id="dxmmc_<s:property value='wid'/>"><s:property value="dxmmc"/></td>
     			<td id="xxmmc_<s:property value='wid'/>"><s:property value="xxmmc"/></td>
     			<td id="zb_<s:property value='wid'/>"><s:property value="zb"/></td>
     			<td id="xbz_<s:property value='wid'/>"><s:property value="xbz"/></td>
	   			<td id="bpfz_<s:property value='wid'/>">&nbsp;&nbsp;<s:property value="bpfz"/></td>
	   			<td id="scbm_<s:property value='wid'/>"><s:property value="scbm"/></td>
	   			<td id="bscd_<s:property value='wid'/>"><s:property value="bscd"/>
	   			
	   			</td>
	   			<td id="xmdj_<s:property value='wid'/>"><s:property value="xmdj"/></td>
	   			<td id="fbzt_<s:property value='wid'/>">&nbsp;<s:property value="fbzt"/></td>
    			<%--<s:if test="fbzt==0">未发布</s:if><s:elseif test="fbzt==1">汇总到团队明细</s:elseif>
    			<s:elseif test="fbzt==2">汇总到团队汇总</s:elseif><s:elseif test="fbzt==3">确认对外发布</s:elseif>
    		    --%>
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

