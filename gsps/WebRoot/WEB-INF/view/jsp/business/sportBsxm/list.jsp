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
	<script type="text/javascript">
	listPageStyle();
	var objid = parent.tem_valueObjid;
	var objname = parent.tem_nameObjid;
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
	}

	function postBsxm(){
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
			parent.document.getElementById(objname).value=document.getElementById("dxmmc_"+id).innerHTML+ ""+
														  document.getElementById("xxmmc_"+id).innerHTML+""+
														  document.getElementById("zb_"+id).innerHTML+""+
														  document.getElementById("xbz_"+id).innerHTML+""+
														  document.getElementById("xmdj_"+id).innerHTML;
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
  <s:hidden name="cd" value="%{#parameters.cd[0]}" id="cd" />
    <s:hidden name="pager.formname" value="theform"/>
    <input type="hidden" value="<s:property value="tsportBsxm.xxmmc" />" id="xxmmc_later" />
	<input type="hidden" value="<s:property value="tsportBsxm.zb" />" id="zb_later" />
	<input type="hidden" value="<s:property value="tsportBsxm.xbz" />" id="xbz_later" />
	<input type="hidden" value="<s:property value="tsportBsxm.dxmmc" />" id="dxmmc_later" />
    	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleftt">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
								<tr align="center" colspan="6">
								 	<td align="right" nowrap="nowrap" class="" colspan="1" width="10%">&nbsp;项目等级：</td>
									<td align="left" nowrap="nowrap" colspan="1" width="15%">
										 <s:select name="tsportBsxm.xmdj" id ="xmdj" list="getXmdjList()" listKey="id" listValue="caption" onchange="getzy2()" headerKey="" headerValue="--请选择--"/>
									</td> 
									<td align="right" nowrap="nowrap" class="" colspan="1" width="10%">&nbsp;项目：</td>
									<td align="left" nowrap="nowrap" id="dxmmcContainer" colspan="1"  width="15%">
										 <s:select name="tsportBsxm.dxmmc" id ="dxmmc" list="getAllDxmmc()" listKey="caption" onchange="getzy1()" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="" colspan="1" width="10%">&nbsp;级（赛）别：</td>
									<td align="left" nowrap="nowrap" id="xxmmcContainer" colspan="1" width="40%">
										 <s:select name="tsportBsxm.xxmmc" id ="xxmmc" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="-------请选择-------"/>
									</td>
								</tr>
								<tr>
									<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;组别：</td>
									<td align="left" nowrap="nowrap" id="zbContainer" colspan="1">
										 <s:select name="tsportBsxm.zb" id ="zb" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;性别组：</td>
									<td align="left" nowrap="nowrap" id="xbzContainer" colspan="1">
										 <s:select name="tsportBsxm.xbz" id ="xbz" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
									</td>
									<td colspan="1"></td>
									<td align="right"  nowrap="nowrap" colspan="1"><ul class="btn_gn">
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
    	<s:if test="#parameters.cd[0]==1">
    		<tr>
			    <td height="30px">
				   <ul class="btn_gn">
					<li><a href="#" title=" 确定" onClick="postBsxm()"><span> 确定</span></a></li>
					<li ><a href="#" title="取消" onClick="parent.closeInputWindow()"><span>取消</span></a></li>		 
				   </ul>
			     </td>    
			 </tr>
    	</s:if>
    	<s:else>
    		<tr>
    			<td height="30px" colspan="10">
    			<ul class="btn_gn">
			    <li><a href="#" title="新增比赛项目" onClick="input();" name="create0"><span>新增比赛项目</span></a></li>
			    <li><a href="#" title="修改比赛项目" onClick="modifySelected()"  name="modifyStudent"><span>修改比赛项目</span></a></li>
			    <li><a href="#" title="删除比赛项目" onClick="submitRemove()" name="removeRows"><span>删除比赛项目</span></a></li>
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
 		        <th width="10%">项目</th>
 		        <th width="10%">性别组</th>
 		        <th width="10%">组别</th>
    			<th width="30%">级（赛）别</th>
    			<th width="10%">项目等级</th>
    			<th width="10%">是否集体项目</th>
    			<th width="10%">是否对战项目</th>
    			<th width="10%">排序号</th>
    		</tr>
    		</thead>
    		<tbody id="listData">
 			<s:iterator value="resultData">
    			<tr>
	     			<td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
	      			<td>
		      			<a href="javascript:input('<s:property value="wid"/>',false)"><font color="blue">
		      			<span id="dxmmc_<s:property value='wid'/>" >
		      			<s:property value="dxmmc" /></span></font></a>
		      		</td> 
	      			<td id="xbz_<s:property value='wid'/>"><s:property value="xbz"/></td> 
	      			<td id="zb_<s:property value='wid'/>"><s:property value="zb"/></td>
	      			<td id="xxmmc_<s:property value='wid'/>"><s:property value="xxmmc"/></td>       		   			       			    		    
	    			<td id="xmdj_<s:property value='wid'/>"><s:property value="xmdj"/></td>
	    			<td id="sfjtxm_<s:property value='wid'/>"><s:property value="sfjtxm"/></td>
	    			<td id="sfdzxm_<s:property value='wid'/>"><s:property value="sfdzxm"/></td>
	    			<td id="pxh_<s:property value='wid'/>"><s:property value="pxh" /></td> 
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

