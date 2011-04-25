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
		$("#dxmmc").val("");
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
<body> 
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
     <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
    <tr><td id="fsearch">  <table width="35%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
	  <tr>
	    <td class="chaxunleft">
         <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
			    <tr>
					<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;大项目：</td>
					<td align="left" nowrap="nowrap" id="xbzContainer" colspan="1">
						 <s:select name="bsxm.dxmmc" id ="dxmmc" list="getAllDxmmc()" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
					</td>
					<td align="left" nowrap="nowrap"><ul class="btn_gn">
						<li>
							<a href="#" title="查询" onClick="super_doSearch()"
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
    <tr><td>
     <table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%">
    		<tr>
    			<td height="30px"  width="70" align="center">
    			<ul class="btn_gn">
					    <li><a href="#" title="打印" onClick="window.print();" name="create0"><span>打印</span></a></li>
			    </ul>
			   </td>   	
			   <td align="left"><span style="font-size :12px; color: red;">说明：代表团得牌为竞赛得牌，不含带入成绩。</span></td>	  
    		</tr>
    		<tr>
    			<td></td>
    			<td><b>本次查询结果为：</b>  金牌：<s:property value="#listHz[0][0]" />  银牌：<s:property value="#listHz[0][1]" />  铜牌：<s:property value="#listHz[0][2]" />  奖牌总数：<s:property value="#listHz[0][4]" />  总分：<s:property value="#listHz[0][3]" /></td>
    		</tr>
   </table>
    </td></tr>
    	<tr height="40" align="center" id="paipang">
   			<td align="center" id="printstyle">按<s:if test="#xmmc==null || #xmmc==''" >全部项目</s:if><s:else><s:property value="xmmc" /></s:else>查询成绩</td>
   		</tr>
    	<tr align="center" id="paipang">
   			<td align="center" id="printDate">打印时间：<s:property value="printDate" /></td>
   		</tr>
   <tr><td align="center">
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
    			<th width="12%">地区\项目</th>
    			<th width="12%">金牌</th>
    			<th width="8%">银牌</th>
    			<th width="8%">铜牌</th>
    			<th width="8%">总分</th>
    			<th width="8%">奖牌总数</th>
    			<th width="8%">金牌名次</th>
    			<th width="8%">奖牌名次</th>
    			<th width="8%">总分名次</th>
    			</tr>
    		</thead>
    		<tbody id="listData">
    		<s:iterator value="resultData" status="status">
		    		<tr>
     			  		 <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][0]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][1]==0 ? '--':resultData[#status.index][1]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][2]==0 ? '--':resultData[#status.index][2]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][3]==0 ? '--':resultData[#status.index][3]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][4]==0 ? '--':resultData[#status.index][4]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][5]==0 ? '--':resultData[#status.index][5]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][6]==0 ? '--':resultData[#status.index][6]" /></td>
                         <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][7]==0 ? '--':resultData[#status.index][7]" /></td>
                         <td style="vertical-align:middle; border-right: 1px #D7D8D9 solid; ">&nbsp;<s:property value="resultData[#status.index][8]==0 ? '--':resultData[#status.index][8]" /></td>
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
	</table></td></tr>
    </table> 	
    	
    	
    	</s:form>
    </div>
  </body>
</html>

