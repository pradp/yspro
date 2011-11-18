﻿<%@ page language="java" pageEncoding="UTF-8"%>
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
		document.getElementById("zch").value="";
		document.getElementById("xyjfdqName3").value="";
		document.getElementById("xyjfdqName7").value="";
		document.getElementById("xyjfdqName2").value="";
		document.getElementById("xyjfdqName4").value="";
		document.getElementById("xyjfdqName5").value="";
		document.getElementById("xyjfdq3isorno").value="";
//		document.getElementById("xyjfdq7isorno").value="";
		document.getElementById("xyjfdq2isorno").value="";
		document.getElementById("xyjfdq4isorno").value="";
		document.getElementById("xyjfdq5isorno").value="";		
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
		<tr><td>	<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
					<tr>
						<td class="chaxunlefts">
							<table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
								<tr align="center">
									<td align="right" nowrap="nowrap" class="">&nbsp;姓名：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield name="tsportYdyxx.xm" id="xm" maxlength="20" size="20" />
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;身份证号：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield id="sfzh" name="tsportYdyxx.sfzh" maxlength="20" size="20"/>
									</td>
									<td align="right" nowrap="nowrap" class="">注册号：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield name="tsportYdyxx.zch" id="zch" maxlength="20" size="20" />
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;代表地：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield id="yddbm" name="tsportYdyxx.yddbm" maxlength="20" size="20"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;承训地：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield id="xyjfdqName3" name="tsportYdyxx.xyjfdqName3" maxlength="20" size="20"/>
									</td>
								 </tr>
								 <tr>
									<td align="right" nowrap="nowrap" class="">&nbsp;注册地：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield id="xyjfdqName7" name="tsportYdyxx.xyjfdqName7" maxlength="20" size="20"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;原注册地：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield id="xyjfdqName2" name="tsportYdyxx.xyjfdqName2" maxlength="20" size="20"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;原注册地区县：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield id="xyjfdqName5" name="tsportYdyxx.xyjfdqName5" maxlength="20" size="20"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;原籍：</td>
									<td align="left" nowrap="nowrap" >
										<s:textfield id="xyjfdqName4" name="tsportYdyxx.xyjfdqName4" maxlength="20" size="20"/>
									</td>
								</tr>
								<tr>
									<td align="right" nowrap="nowrap" class="">&nbsp;有承训地：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="tsportYdyxx.xyjfdq3isorno" id ="xyjfdq3isorno" list="#{'0':'否','1':'是'}" headerKey="" headerValue="--请选择--"/>
									</td>
									<%--<td align="right" nowrap="nowrap" class="">&nbsp;有注册地：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="tsportYdyxx.xyjfdq7isorno" id ="xyjfdq7isorno" list="#{'0':'否','1':'是'}" headerKey="" headerValue="--请选择--"/>
									</td>
									--%><td align="right" nowrap="nowrap" class="">&nbsp;有原注册地：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="tsportYdyxx.xyjfdq2isorno" id ="xyjfdq2isorno" list="#{'0':'否','1':'是'}" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;有原注册区县：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="tsportYdyxx.xyjfdq5isorno" id ="xyjfdq5isorno" list="#{'0':'否','1':'是'}" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="right" nowrap="nowrap" class="">&nbsp;有原籍：</td>
									<td align="left" nowrap="nowrap" >
										<s:select name="tsportYdyxx.xyjfdq4isorno" id ="xyjfdq4isorno" list="#{'0':'否','1':'是'}" headerKey="" headerValue="--请选择--"/>
									</td>
									<td align="center" rowspan="2" nowrap="nowrap"><ul class="btn_gn">
										<li>
											<a href="#" title="查询" onClick="super_doSearch()"
												id="searchButton" name="btn3"><span> 查询 </span>
											</a>
										</li>
										</ul>
									</td>
									<td align="center" rowspan="2" nowrap="nowrap"><ul class="btn_gn">
										<li>
											<a href="#" title="重置" onClick="doreset()"
												id="searchButton2" name="btn4"><span> 重置 </span>
											</a>
										</li>
									</ul></td>
								</tr>
							</table>
						</td>
						<td width="20" height="90" class="chaxunrights">
							&nbsp;
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
			
    	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
    		<thead id="listHead">
  				<tr>
    			<th height="20px" width="5%"><s:checkbox name="selectAll" onclick="doSelectAll()" /></th>
    			<th width="5%">姓名</th>
    			<th width="12%">身份证号</th>
    			<th width="10%">所属运动队</th>
    			<th width="8%">注册号</th>
    			<th width="8%">代表地</th>
    			<th width="8%">承训地</th>
    			<th width="8%">注册地</th>
    			<th width="8%">原注册地</th>
    			<th width="10%">原注册地区县</th>
    			<th width="8%">原籍</th>
    			<th width="10%">操作</th>
    		</tr>
    		</thead>
    		<tbody id="listData">
 	<s:iterator value="resultData">
    		<tr>
     			<td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
      			<td><s:property value="xm" /></td>
      			<td><s:property value="sfzh" /></td>     		   			       			    		    
    			<td><s:property value="yddbm" /></td>
    			<td><s:property value="zch" /></td>
    			<s:if test="xyjfdqName1==null||xyjfdqName1==''"><td>--</td></s:if>
    			<s:else><td><s:property value="xyjfdqName1" />&nbsp;</td></s:else>
    			
    			<s:if test="(xyjfdqName3!=null)&&(xyjfdqName7==null)">
    			<td><s:property value="xyjfdqName3" />&nbsp;</td>
    			<td><s:property value="xyjfdqName1" />&nbsp;</td>
    			</s:if>
    			<s:elseif test="(xyjfdqName3==null)&&(xyjfdqName7!=null)">
    			<td><s:property value="xyjfdqName1" />&nbsp;</td>
    			<td><s:property value="xyjfdqName7" />&nbsp;</td>
    			</s:elseif>
    			<s:else><td>--</td><td>--</td>
    			</s:else>
    			<s:if test="xyjfdqName7!=null"><td><s:property value="xyjfdqName2" />&nbsp;</td></s:if>
    			<s:else><td>--</td></s:else>
    			
    			<s:if test="xyjfdqName5==null||xyjfdqName5==''"><td>--</td></s:if>
    			<s:else><td><s:property value="xyjfdqName5" />&nbsp;</td></s:else>
    			<s:if test="xyjfdqName4==null||xyjfdqName4==''"><td>--</td></s:if>
    			<s:else><td><s:property value="xyjfdqName4" />&nbsp;</td></s:else>
    			<td nowrap="nowrap">
					<a href="javascript:input('<s:property value="wid"/>')">
					<FONT color="blue">查看</FONT></a>
				</td>
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
