<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  
    <title>list</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0"> 
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
	<script type="text/javascript">
	listPageStyle();
	function toInit(wid,sc,cjdw,obj){
	
		var objs = document.getElementById("dxmmcHidden_id");
		if(objs.value !=null && objs.value != ''){
			getSelectXxmmc(objs);
		}
	
		var iframe = document.getElementById("ydycjdj");
		var index_wid = document.getElementById("index_wid");
		var index_sc = document.getElementById("index_sc");
		var type = document.getElementById("type_id");
		var indwx_cjdw = document.getElementById("index_dw");
		var forwardType = document.getElementById("forwardType");
		
		//alert(cjdw.value);
		//传入的是赛程的wid  wid 为空值时，说明是 页面加载默认显示 第一个分组的 人员
		if(wid==null || sc==null || wid=='' || sc==''){
		
				if(forwardType.value=='td')
				{
				  iframe.src="../business/sportSxMxYL-input.c?scbm="+index_wid.value+"&sc="+index_sc.value+"&cjdw="+indwx_cjdw.value+"&type="+type.value+"&wid=&type=td";
				}else if(forwardType.value=='sx'){
				  iframe.src="../business/sportSxMxYL-input.c?scbm="+index_wid.value+"&sc="+index_sc.value+"&cjdw="+indwx_cjdw.value+"&type="+type.value+"&wid=&type=sx";
				}
				
		
		}else{
			var listData_size = document.getElementById("listData_size").value;
			if(listData_size != ''){
				var lenght = parseInt(listData_size);
				for(i=0;i<lenght;i++){
					document.getElementById("tr_"+i).style.backgroundColor="#F1F3F4";
				}
				obj.style.backgroundColor="#BCD4EC";
				
				if(forwardType.value=='td')
				{
				  iframe.src="../business/sportSxMxYL-input.c?scbm="+wid+"&sc="+index_sc.value+"&cjdw="+indwx_cjdw.value+"&type="+type.value+"&wid=&type=td";
				}else if(forwardType.value=='sx'){
				  iframe.src="../business/sportSxMxYL-input.c?scbm="+wid+"&sc="+index_sc.value+"&cjdw="+indwx_cjdw.value+"&type="+type.value+"&wid=&type=sx";
				}
				
			}
			
		}
	
	}
	function listPageStyle(){
		MM_preloadImages('<s:property value="basePath"/>/resources/images/vista/btn_goact.png',
		'<s:property value="basePath"/>/resources/images/vista/refresh_act.png',
		'<s:property value="basePath"/>/resources/images/vista/windowtop.png',
		'<s:property value="basePath"/>/resources/images/loading.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/ico.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/win_l.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/win_r.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/title_bg_left.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/title_bg_center.jpg',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/title_bg_right.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/win_b.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/win_rb.gif',
		'<s:property value="basePath"/>/component/ymprompt/skin/infoms/images/win_lb.gif');
		jQuery.noConflict();
		jQuery(document).ready(function(){
			//load css,put here fix ie6 bug
			jQuery('<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/ymprompt/skin/infoms/ymPrompt.css">').appendTo("head");

			jQuery("#listData tr").mouseover(function(){
						jQuery(this).addClass("over");
					})
					.mouseout(function(){
						jQuery(this).removeClass("over");
				})
			//jQuery("#listData tr:even").addClass("alt");
			jQuery("#listTable").click(function(event){
				sortColumn(event);
			});

			jQuery("#listHead th").each(function(i){
					jQuery(this).html( "<font class='sortfont'>"+jQuery(this).html()+"</font>" );
			});
			$("#listData tr td:last").addClass("rightborder");
		});
		$ = jQuery;
	}
	function getSelectXxmmclFirst(obj){
		getSelectXxmmc(obj);
		//清除 项目 隐藏域的值
		document.getElementById("dxmmcHidden_id").value='';
	}
	function getSelectXxmmc(obj){
		ajaxService.getSelectXxmmc(obj.value,function (data){
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		DWRUtil.removeAllOptions('xxmmc_id');
		DWRUtil.addOptions( 'xxmmc_id', data,'id','caption');
		var obj1 = document.getElementById("xxmmcHidden_id");
		if(obj1.value!=null && obj1.value!=''){
			DWRUtil.setValue('xxmmc_id',obj1.value);
		}
		$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
	});
	ajaxService.getBsxmZb(obj.value,function (data){
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		DWRUtil.removeAllOptions('zb_id');
		DWRUtil.addOptions( 'zb_id', data,'id','caption');
		var obj2 = document.getElementById("zbHidden_id");
		if(obj2.value!=null && obj2.value!=''){
			DWRUtil.setValue('zb_id',obj2.value);
		}
		$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
		});
		ajaxService.getBsxmXbz(obj.value,function (data){
		jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
		DWRUtil.removeAllOptions('xbz_id');
		DWRUtil.addOptions( 'xbz_id', data,'id','caption');
		var obj3 = document.getElementById("xbzHidden_id");
		if(obj3.value!=null && obj3.value!=''){
			DWRUtil.setValue('xbz_id',obj3.value);
		}
		$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
		});
	}
	
	function doreset2(){
		document.getElementById("dxmmc_id").value="";
		document.getElementById("xxmmc_id").value="";
		document.getElementById("sc_id").value="";	
		document.getElementById("zb_id").value="";
		document.getElementById("csz_id").value="";
		document.getElementById("xbz_id").value="";
		document.getElementById("st_id").value="";
		document.getElementById("et_id").value="";
		document.getElementById("shzt_id").value="";
	}	
	var clicked = false;
	
	</script>
	<style>
 li {
list-style-type: none;
display: inline;
}
	
	</style>
  </head>
  
<body onload="toInit()"> 
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
    <s:hidden name="bsxm" id="bsxm_id" value="%{#bsxm}"></s:hidden>
    <s:hidden name="listData_size" id="listData_size" value="%{resultData.size()}" />
    <s:hidden name="type" id="type_id" value="%{#type}" />
    <input type="hidden" id="dxmmcHidden_id" value="<s:property value='sportBsxm.dxmmc' />" />
    <input type="hidden" id="xxmmcHidden_id" value="<s:property value='sportBsxm.xxmmc' />" />
    <input type="hidden" id="zbHidden_id" value="<s:property value='sportBsxm.zb' />" />
    <input type="hidden" id="xbzHidden_id" value="<s:property value='sportBsxm.xbz' />" />
    <input type="hidden" id="forwardType" value="<s:property value='type' />" />
    
    		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleftt">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="95%">
								<tr align="center">
									<td align="right" nowrap="nowrap" class="">
										项目：
									</td>
									<td align="left">
										<s:select name="sportBsxm.dxmmc" id="dxmmc_id"  list="getAllDxmmc()" onchange="getSelectXxmmclFirst(this)" listKey="id" listValue="caption" headerKey="" headerValue="请选择" />
									</td>
									<td align="right" nowrap="nowrap" class="">
										级（赛）别：
									</td>
									<td align="left">
											<s:select name="sportBsxm.xxmmc" id="xxmmc_id"  list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="请选择" />
									</td>
									<td align="right" nowrap="nowrap" class="">
										组别：
									</td>
									<td align="left">
										<s:select name="sportBsxm.zb" id="zb_id"  list="getBsxmZb()" listKey="id" listValue="caption" headerKey="" headerValue="请选择" />
									</td>
									<td align="right" nowrap="nowrap" class="">
										参赛者：
									</td>
									<td align="left" nowrap="nowrap" class="">
										<s:textfield name="sportBsxm.csz" size="13"  id="csz_id"/>
									</td>
									<td><ul class="btn_gn">
										<li>
											<a href="#" title="查询" onClick="super_doSearch()"id="searchButton" name="btn3"><span> 查询 </span></a>
										</li>
										</ul>
									</td>
								</tr>
								<tr>
									<td align="right" nowrap="nowrap" class="">
										性别组：
									</td>
									<td align="left">
										<s:select name="sportBsxm.xbz" id="xbz_id" list="getBsxmXbz()" listKey="id" listValue="caption"  headerKey="" headerValue="请选择" />
									</td>
									<td align="right" nowrap="nowrap" class="">
										起始时间：
									</td>
									<td align="left">
										<s:textfield name="sportBsxm.startTime" id="st_id" size="13"  onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"  />
									</td>
									<td align="right" nowrap="nowrap" class="">
										结束时间：
									</td>
									<td align="left">
										<s:textfield name="sportBsxm.endTime" id="et_id"  size="13"  onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"  />
									</td>
									<td align="right" nowrap="nowrap" class="">
										审核状态：
									</td>
									<td align="left">
										<s:select name="sportBsxm.shzt" id="shzt_id" list="getFbztList()" listKey="id" listValue="caption"  headerKey="" headerValue="-----------请选择-----------" />
										
									</td>
									<td><ul class="btn_gn">
										<li>
											<a href="#" title="重置" onClick="doreset2()" id="searchButton2" name="btn4"><span> 重置 </span></a>
										</li>
										</ul>
									</td>
								</tr>
							</table>
						</td>
						<td width="15" height="75" class="chaxunrightt">
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
			
    	<table id="listTable" border="0" style="float: left" cellspacing="0" cellpadding="0" width="99%" class="middle">
    		<thead id="listHead">   	
			<tr>
			   <th width="26%" nowrap="nowrap">比赛项目</th>
			   <th width="8%" nowrap="nowrap">赛次</th>
			   <th width="14%" nowrap="nowrap">组别</th>
			    <th width="8%" nowrap="nowrap">性别组</th>
			    <th width="8%" nowrap="nowrap">编排分组</th>
			   <th width="12%" nowrap="nowrap">比赛时间</th>
			   <th width="10%" nowrap="nowrap">是否集体项目</th>
			   <th width="12%" nowrap="nowrap">对战队(人)</th>
			  </tr>
    		</thead>
    		<tbody id="listData">
    	
    	<s:iterator value="resultData" status="status">
    	<s:if test="#status.index==0" >
    		<tr id="tr_<s:property value="#status.index" />" style="cursor: pointer; background-color: #BCD4EC; " onclick="toInit('<s:property value="wid" />','<s:property value="sc" />','<s:property value="cjdw" />',this)">
    	</s:if>
    	<s:else>
    		<tr id="tr_<s:property value="#status.index" />" style="cursor: pointer;" onclick="toInit('<s:property value="wid" />','<s:property value="sc" />','<s:property value="cjdw" />',this)">
    	</s:else>
  			<s:if test="#status.index==0">
  				<input type="hidden" name="index_wid" id="index_wid" value="<s:property value="wid" />" />
  				<input type="hidden" name="index_sc" id="index_sc" value="<s:property value="sc" />" />
  				<input type="hidden" name="index_dw" id="index_dw" value="<s:property value="cjdw" />" />
  			</s:if>
  			<td>&nbsp;【<s:property value="dxmmc"/>】<s:property value="xxmmc"/></td>
  			<td>&nbsp;<s:property value="scCn" /></td>
  			<td>&nbsp;<s:property value="zbcn"/></td>
  			<td>&nbsp;<s:if test="xbz==1">男子</s:if><s:elseif test="xbz==2" >女子</s:elseif><s:elseif test="xbz==3">男女混合</s:elseif></td>
  			<td>&nbsp;<s:property value="bpfz"/></td>
  			<td>&nbsp;<s:property value="startTime"/></td>
  			<td style="border-right:1px #D7D8D9 solid">&nbsp;<s:if test="sfjtxm==1">是</s:if><s:elseif test="sfjtxm==2">否</s:elseif></td>
  			<td style="border-right:1px #D7D8D9 solid">&nbsp;<s:property value="dzr" /></td>
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
    		<tr><td><iframe  id="ydycjdj" height="350" marginwidth="0"  width="100%"  marginwidth="0" marginheight="0"  frameborder="0" ></iframe>
    		</td></tr>
    </table>
    </s:form>
        </div>
  
  </body>
</html>
