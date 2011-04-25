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
	function doreset()
	{	
		document.getElementById("dxmmc").value="";
	}

	function doSearch(){
		var dxmmc = document.getElementById("dxmmc").value;
		var reportServer = document.getElementById("reportServer").value;
		var type = document.getElementById("type").value;
		// 默认 为田径项目
		var raq = "report_sport_cjc.raq";
		if(dxmmc==null||dxmmc==''){
			var url = reportServer+"?raq=/"+raq;
		}else{
			var url = reportServer+"?raq=/"+raq+"&dxmmc='"+dxmmc+"'";
		}
		var form = document.getElementById("ifr");
		form.src = url;
	}
	</script>
	<style type="text/css">
		#paipang{
			display: none;
		}
		#printDate{
			display: none;
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
<body onload="doSearch()"> 
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
  	<s:hidden  value="%{#type}" id="type" />
  	<s:hidden  value="%{#reportServer}" id="reportServer" />
     <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
    <tr><td id="fsearch">  <table width="35%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
	  <tr>
	    <td class="chaxunleft">
         <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
			    <tr>
					<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;大项目名称：</td>
					<td align="left" nowrap="nowrap" colspan="1">
						<s:select  list="getAllDxmmc()"  id="dxmmc" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--" name="dxmmc" >
						</s:select>
					</td>
					<td align="left" nowrap="nowrap"><ul class="btn_gn">
						<li>
							<a href="#" title="查询" onClick="doSearch()"
								id="searchButton" name="btn3"><span> 查询 </span>
							</a>
						</li></ul></td>
					<td align="left" nowrap="nowrap"><ul class="btn_gn">
						<li>
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
    </td></tr>
    
   <tr><td align="center">
   	<iframe src="" id="ifr" name="ifr" width="100%" height="1000" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe> 
    </td></tr>
    </table> 	
    	
    	
    	</s:form>
    </div>
  </body>
</html>

