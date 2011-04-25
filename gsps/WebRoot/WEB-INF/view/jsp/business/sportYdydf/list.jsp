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
	function toInit(wid,sc,obj){
		var iframe = document.getElementById("ydycjdj");
		var index_wid = document.getElementById("index_wid");
		var index_sc = document.getElementById("index_sc");
		var type = document.getElementById("type_id");
		//传入的是赛程的wid  wid 为空值时，说明是 页面加载默认显示 第一个分组的 人员
		if(wid==null || sc==null || wid=='' || sc==''){
			iframe.src="../business/sportCjYdy-input.c?scbm="+index_wid.value+"&sc="+index_sc.value+"&type="+type.value+"&wid=";
		}else{
			var listData_size = document.getElementById("listData_size").value;
			
			if(listData_size != ''){
				var lenght = parseInt(listData_size);
				for(i=0;i<lenght;i++){
					document.getElementById("tr_"+i).style.backgroundColor="#F1F3F4";
				}
				obj.style.backgroundColor="#BCD4EC";
				iframe.src="../business/sportCjYdy-input.c?scbm="+wid+"&sc="+sc+"&type="+type.value+"&wid=";
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
	</script>
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
    		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleftt">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="95%">
								<tr align="center">
								<td align="right" nowrap="nowrap" class="">
										比赛项目：
								</td>
									<td align="left">
										<s:select name="sportBsxm.xxmmc" id="zb_id"  list="getBsxmByName()" listKey="id" listValue="caption" headerKey="" headerValue="请选择" />
									</td>
									<td align="right" nowrap="nowrap" class="">
										赛次：
									</td>
									<td align="left">
										<s:select name="sportBsxm.sc" id="zb_sc"  list="getBsxmSc()" listKey="id" listValue="caption" headerKey="" headerValue="请选择" />
									</td>
									<td align="right" nowrap="nowrap" class="">
										组别：
									</td>
									<td align="left">
										<s:select name="sportBsxm.zb" id="zb_id"  list="getBsxmZb()" listKey="id" listValue="caption" headerKey="" headerValue="请选择" />
									</td>
									
									<td><ul class="btn_gn">
										<li>
											<a href="#" title="查询" onClick="super_doSearch()"
												id="searchButton" name="btn3"><span> 查询 </span>
											</a>
										</li>
									</ul></td>
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
										<s:textfield name="sportBsxm.startTime" size="13"  onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"  />
									</td>
									<td align="right" nowrap="nowrap" class="">
										结束时间：
									</td>
									<td align="left">
										<s:textfield name="sportBsxm.endTime"  size="13"  onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"  />
									</td>
									<td><ul class="btn_gn">
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
						</td>
					</tr>
				</table></td></tr></table>
	<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%" class="maginB">
			<tr align="center">
				
			</tr>
	</table>

    	<table  border="0" cellspacing="3" cellpadding="0" width="100%">
          <tr>
		   
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
			   <!-- <th height="20px" width="3%"><s:checkbox name="selectAll" onclick="doSelectAll()" /></th> -->
			  
			   <th rowspan="2">性别组</th>
			    <th rowspan="2">组别</th>
			   <th rowspan="2">比赛项目</th>
			   <th rowspan="2">赛次</th>
			   <th rowspan="2">比赛时间</th>
			  </tr>
    		</thead>
    		<tbody id="listData">
    	
    	<s:iterator value="resultData" status="status">
    	<tr>
    	<s:if test="#status.index==0" >
    		<tr id="tr_<s:property value="#status.index" />" style="cursor: pointer; background-color: #BCD4EC; " onclick="toInit('<s:property value="wid" />','<s:property value="sc" />',this)"></tr>
    	</s:if>
    	<s:else>
    		<tr id="tr_<s:property value="#status.index" />" style="cursor: pointer;" onclick="toInit('<s:property value="wid" />','<s:property value="sc" />',this)"></tr>
    	</s:else>
    			<!-- <td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td> -->
    			<s:if test="#status.index==0">
    				<input type="hidden" name="index_wid" id="index_wid" value="<s:property value="wid" />" />
    				<input type="hidden" name="index_sc" id="index_sc" value="<s:property value="sc" />" />
    			</s:if>
    			<td>&nbsp;<s:if test="xbz==1">男子</s:if><s:elseif test="xbz==2" >女子</s:elseif><s:elseif test="xbz==3">男女混合</s:elseif></td>
    			<td>&nbsp;<s:property value="zbcn"/></td>
    			<td>&nbsp;<s:property value="xxmmc"/></td>
    			<td>&nbsp;<s:if test="sc==1">预赛</s:if></td>
    			<s:elseif test="sc==2" >决赛</s:elseif>
    			<td style="border-right:1px #D7D8D9 solid" >&nbsp;<s:date name="bssj" format="yyyy-MM-dd HH:mm" /></td>
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
   <iframe  id="ydycjdj" height="350" marginwidth="0"  width="100%"  marginwidth="0" marginheight="0"  frameborder="0" ></iframe>
  	
  </body>
</html>
