<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
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
   
    <script type="text/javascript">
  //$(document).ready(function(){
	///
	///});
	listPageStyle();
function ending(miwid){
 if(confirm('是否进行相关操作？')){
	ajaxService.ending(miwid,function(result){
	    if(result==1){
		alert('会议已被置为结束！');
		document.forms[0].submit();
		}else{
		alert(result);
		}
	});
   }
  }
function meetingOperation(flag){
	var ids=CropCheckBoxValueAsString("selectNode");
	if(ids==''){
		alert('请选择会议！');
	}else if(confirm('是否进行相关操作？')){
		ajaxService.meeting_operation(ids,flag,function(res){
			if(typeof res=='object'){
				alert(res['message']);
				if(res['isReload']=='1')
					document.forms[0].submit();
			}else{
				alert('操作失败！');
			}
		})						
	}
}
function departInfo(departid){

	openWindow('<s:property value="basePath"/>/system/depart-departdetail.c?tsysDepart.departid='+departid+'&readOnlyPage=true');
}
function departInput(departid){

	openWindow('<s:property value="basePath"/>/system/depart-input.c?tsysDepart.departid='+departid);
}

</script>
  </head>
	<body > 
		<div id="listC" style="width:98%;margin:10px auto">
			<s:form theme="simple" name="theform">
				<s:hidden name="pager.formname" value="theform" />
				
				
				
				   <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
	  <tr>
	    <td class="chaxunleft">
				<table id="searchForm" border="0" align="left" cellspacing="3" cellpadding="0" width="100%">
					<tr> 
						<td align="right" nowrap="nowrap">&nbsp;部门名称： </td>
						<td align="left" nowrap="nowrap"><s:textfield name="tsysDepart.departname" maxlength="50" size="15" /></td> 						
						<td align="right" nowrap="nowrap">&nbsp;用户组： </td>
						<td align="left" nowrap="nowrap"><s:select name="tsysDepart.departtype" id="detype" list="#{'':'-------请选择-------','1':'管理员','3':'市县/高校管理员','6':'高校','9':'院系','7':'市县','8':'中学'}" onchange="changeYhz()"/></td> 
						<td align="right" nowrap="nowrap">办学层次：</td>
						<td align="left"><s:select name="txtDwxxb.bxcc" id="bxcc" list="getSysCode('bxcc')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/></td>
						<td align="right" nowrap="nowrap">隶属关系：</td>
						<td align="left"><s:select name="txtDwxxb.gxlb2" id="gxlb2" list="getSysCode('xxlb2')" listKey="id" listValue="caption" headerKey="" headerValue="---请选择---"/></td>
						<td align="right" nowrap="nowrap">办学类型：</td>
						<td align="left"><s:select name="txtDwxxb.gxlxJs" id="gxlxJs" list="getSysCode('gxlx')" listKey="id" listValue="caption" headerKey="" headerValue="------请选择------"/></td>
						<td align="center" rowspan="2" nowrap="nowrap">
						    <ul class="btn_gn">
			    <li><a href="#" title="查询" onclick="document.getElementById('pager_currentPageno').value='1';document.forms[0].submit();" id="searchButton" name="btn3"><span> 查询 </span></a></li>
			  </ul>
							</td>
					</tr>
				</table>
						</td>
	    <td width="15" height="49" class="chaxunright">&nbsp;</td>
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
							<td width="15%">部门名称</td>
							<td width="15%">上级部门名称</td>
							<td width="10%">联系人</td>
							<td width="10%">联系电话</td>
							<td width="10%">email</td>
							<td width="10%">传真</td>
							<td width="10%">编辑</td>
						</tr>
					</thead>
					<tbody id="listData">
						<s:iterator value="resultData" status="stuts">
						    <tr>
						 		<td><a href="javascript:departInfo('<s:property value="resultData[#stuts.index][0]"/>')">
						 	<font color="blue">	<s:property value="resultData[#stuts.index][1]" /></font></a></td>
								<td><s:property value="resultData[#stuts.index][2]" />&nbsp;</td>
								<td><s:property value="resultData[#stuts.index][3]" />&nbsp;</td>	
								<td><s:property value="resultData[#stuts.index][4]" />&nbsp;</td>
								<td><s:property value="resultData[#stuts.index][5]" />&nbsp;</td>
								<td><s:property value="resultData[#stuts.index][6]" />&nbsp;</td>
								<td><a href="javascript:departInput('<s:property value="resultData[#stuts.index][0]" />')"><font color="blue">编辑</font></a></td>						
							
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
					     <td colspan="10" align="right"><s:property value="pager.postToolBar" escape="false" /></td>
					</tr>
				</table>
			</s:form>
		</div>
	</body>
</html>

