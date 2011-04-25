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
    			&nbsp;说明：斜体的“本届竞赛全项成绩”不计入汇总应有值，汇总应有值=带入成绩+本届竞赛前21项成绩+本团加减分！
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
	    			<th width="10%">&nbsp;</th>
	    			<th width="25%">&nbsp;</th>
	    			<th width="10%">金</th>
	    			<th width="10%">银</th>
	    			<th width="10%">铜</th>
	    			<th width="10%">奖牌</th>
	    			<th width="10%">总分</th>
	    		</tr>
    		</thead>
    		<tbody id="listData">
	    			<tr>
					    <td rowspan="6" style="vertical-align:middle">&nbsp;<s:property value="#listDrcj[0]"/></td>
					    <td rowspan="5" style="vertical-align:middle"><div align="center"><strong>明细表</strong></div></td>
					    <td><div align="center">带入成绩</div></td>
					    <td>&nbsp;<s:property value="#listDrcj[1]"/></td>
					    <td>&nbsp;<s:property value="#listDrcj[2]"/></td>
					    <td>&nbsp;<s:property value="#listDrcj[3]"/></td>
					    <td>&nbsp;<s:property value="#listDrcj[4]"/></td>
					    <td>&nbsp;<s:property value="#listDrcj[5]"/></td>
					 </tr>
				  <tr>
				    <td><div align="center"><em><font color="blue">本届竞赛全项成绩</font></em></div></td>
				    <td>&nbsp;<em><font color="blue"><s:property value="#listQxcj[0]"/></font></em></td>
				    <td>&nbsp;<em><font color="blue"><s:property value="#listQxcj[1]"/></font></em></td>
				    <td>&nbsp;<em><font color="blue"><s:property value="#listQxcj[2]"/></font></em></td>
				    <td>&nbsp;<em><font color="blue"><s:property value="#listQxcj[3]"/></font></em></td>
				    <td>&nbsp;<em><font color="blue"><s:property value="#listQxcj[4]"/></font></em></td>
				  </tr>
				  <tr>
				    <td><div align="center">本届竞赛前21项成绩</div></td>
				    <td>&nbsp;<s:property value="#listHz21[0]"/></td>
				    <td>&nbsp;<s:property value="#listHz21[1]"/></td>
				    <td>&nbsp;<s:property value="#listHz21[2]"/></td>
				    <td>&nbsp;<s:property value="#listHz21[3]"/></td>
				    <td>&nbsp;<s:property value="#listHz21[4]"/></td>
				  </tr>
				  <tr>
				    <td><div align="center">本团加减分</div></td>
				    <td>&nbsp;<s:property value="#listHzjj[1]"/></td>
				    <td>&nbsp;<s:property value="#listHzjj[2]"/></td>
				    <td>&nbsp;<s:property value="#listHzjj[3]"/></td>
				    <td>&nbsp;<s:property value="#listHzjj[4]"/></td>
				    <td>&nbsp;<s:property value="#listHzjj[5]"/></td>
				  </tr>
				  <tr>
				    <td><div align="center">汇总应有值</div></td>
				    <td>&nbsp;<s:property value="#listlj[0]"/></td>
				    <td>&nbsp;<s:property value="#listlj[1]"/></td>
				    <td>&nbsp;<s:property value="#listlj[2]"/></td>
				    <td>&nbsp;<s:property value="#listlj[3]"/></td>
				    <td>&nbsp;<s:property value="#listlj[4]"/></td>
				  </tr>
				  <tr>
				    <td><div align="center"><strong>汇总表</strong></div></td>
				    <td><div align="center">实际发布值</div></td>
				    <td>&nbsp;<s:property value="#listHzsj[0]"/></td>
				    <td>&nbsp;<s:property value="#listHzsj[1]"/></td>
				    <td>&nbsp;<s:property value="#listHzsj[2]"/></td>
				    <td>&nbsp;<s:property value="#listHzsj[3]"/></td>
				    <td>&nbsp;<s:property value="#listHzsj[4]"/></td>
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
    			<s:property value="pager.getSimpleToolBar" escape="false"/>
    			</td>
    		</tr>
    	</table>
    	</s:form>
    </div>
  </body>
</html>

