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
	<script type="text/javascript">

	listPageStyle();

	
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
    <s:hidden name="pager.formname" value="theform"/>
    	
    		<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
		<tr><td>	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunleft">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
								<tr align="center">
									<td align="right" nowrap="nowrap" class="">
										运动队名称：
									</td>
									<td align="left">
										<s:textfield name="tsportDrcjb.yddbm" id="yddbm" maxlength="25" size="25" />
									</td>
									
									<td><ul class="btn_gn">
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

    	<table  border="0" cellspacing="3" cellpadding="0" width="100%">
          <tr>
		   <td height="30px" colspan="10">
		    <ul class="btn_gn">
			    <li><a href="#" title="添加到贫困生库" onClick="to_Add()" name="create"><span> 添加到贫困生库 </span></a></li>		    	     
    		</ul> </td>
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
			
    	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="99%" class="middle">
    		<thead id="listHead">   	
			<tr>
			   <th height="20px" width="5%"  rowspan="2">编号</th>
			   <th rowspan="2">第几届运动会</th>
			   <th rowspan="2">赛程编码</th>
			   <th rowspan="2">运动队名称</th>
			    <th colspan="4">奥运带入成绩</th>
			    <th colspan="4">全运带入成绩</th>
			    <th colspan="4">输送折算带入</th>
			    <th colspan="4">总计带入成绩</th>
			  </tr>
			  <tr>
			    <th>金牌</th>
			    <th>银牌</th>
			    <th>铜牌</th>
			    <th>总分</th>
			    <th>金牌</th>
			    <th>银牌</th>
			    <th>铜牌</th>
			    <th>总分</th>
			    <th>金牌</th>
			    <th>银牌</th>
			    <th>铜牌</th>
			    <th>总分</th>
			    <th>金牌</th>
			    <th>银牌</th>
			    <th>铜牌</th>
			    <th>总分</th>
			 </tr>
		
    		</thead>
    		<tbody id="listData">
    	<s:iterator value="resultData">
    		<tr>
    			<td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
    			
    			<td>&nbsp;<s:property value="djjydh"/></td>
    			<td>&nbsp;<s:property value="scbm"/></td>
    			<td >&nbsp;<s:property value="yddbm"/></td>
    			
    			<td>&nbsp;<s:property value="aydrjps"/></td>
    			<td>&nbsp;<s:property value="aydryps"/></td>
    			<td >&nbsp;<s:property value="aydrtps"/></td>    			
    			<td>&nbsp;<s:property value="aydrzf"/></td>
    			
    			<td>&nbsp;<s:property value="qydrjps"/></td>
    			<td >&nbsp;<s:property value="qydryps"/></td>
    			<td>&nbsp;<s:property value="qydrtps"/></td>
    			<td>&nbsp;<s:property value="qydrzf"/></td>
    			
    			<td >&nbsp;<s:property value="sszsdrjps"/></td>
    			<td >&nbsp;<s:property value="sszsdryps"/></td>
    			<td>&nbsp;<s:property value="sszsdrtbs"/></td>
    			<td>&nbsp;<s:property value="sszsdrzf"/></td>
    			
    			<td >&nbsp;<s:property value="zjdrjps"/></td>
    			<td >&nbsp;<s:property value="zjdryps"/></td>
    			<td >&nbsp;<s:property value="zjdrtps"/></td>
    			<td>&nbsp;<s:property value="zjdrzf"/></td>
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
