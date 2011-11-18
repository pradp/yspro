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
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/idcard.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.bgiframe.min.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.ajaxQueue.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/thickbox-compressed.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.css">
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/lib/thickbox.css">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>	
	<script type="text/javascript">
	var isSave=false;
	function L(ID){
		return document.getElementById(ID);
	}
	function getTempAmplyInfo(){		
		L('setup').src='excelImportAdminSetup-input.c?tempID='+L('template').value;
		isSave=true;		
	}
	function submitBtn(){
		if(isSave){
			frames['setup'].submitForm();
		}else{
			alert("你还没有选择并浏览设置模板!");
		}
	}
	function setAddInfo(imp,cla){
		L('import').value=imp;
		L('className').value=cla;
	}
	</script>
  </head>
  
<body> 
  <s:form theme="simple" name="theform">    
			<div id="listC" style="pptext-align:center;z-index: -100;width:100%height:100%">
				<table style="width:100%;height:95%" border="0" cellpadding="0" cellspacing="0"	class="maginB">
					<tr>
						<td style="padding-left: 17px">
							<table width="45%" border="0" align="left" cellpadding="0"
								cellspacing="0" class="maginB" >
								<tr>
									<td class="chaxunleft">
										<table id="searchForm" border="0" align="center" cellspacing="1" cellpadding="0" width="100%">
											<tr align="left">
												<td align="right" nowrap="nowrap">
													&nbsp;&nbsp;导入模板：
												</td>
												<td align="left" nowrap="nowrap">
													&nbsp;&nbsp;&nbsp;&nbsp;<s:select id="template" list="temp" listKey="wid" listValue="tempName" headerKey="0" headerValue="-- 选择导入模板 --" />
												</td>
												<td align="center" nowrap="nowrap">
													<ul class="btn_gn">
														<li>
															<a href="#" onClick="getTempAmplyInfo();" id="searchButton" name="btn3"><span>&nbsp;浏&nbsp;&nbsp;览&nbsp;</span></a>															
														</li>
													</ul>
												</td>
											</tr>
										</table>
									</td>
									<td width="15" height="49" class="chaxunright">
										&nbsp;
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td style="padding-left: 17px">
							<table id="buttonTable" border="0" cellspacing="3"
								cellpadding="0" width="100%">
								<tr>
									<td height="30px" width="440px">
										<ul class="btn_gn">
										<s:if test="getButton(@com.imchooser.infoms.Constants@BUTTON_TYPE_ADD)">
											<li>
												<a href="#" title="保存" onClick="submitBtn();"
													id="sendMsgButton"><span>保存模板</span> </a>
											</li>
										</s:if>
											<li>
												<a href="#" title="取消"
													onclick=""><span>取消</span>
												</a>
											</li>											
										</ul>
									</td>
										<td id="inp" style="display:none" align="left" width="160px">
									
										</td>
										<td>
											
										</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr style="width:100%;height:100%">
						<td valign="top" style="padding-left: 17px">
							<!--  -->
						
							<table  style="width:100%;height:100%" border="0" align="center"  cellpadding="0" cellspacing="0" class="maginB">
	  <tr>
	    <td class="infomainbg" style="width:97%;height:100%;padding-left: 10px">		
		<table class="middle" style="width:100%;height:100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td style="width:100%;height:100%">
	        
	        <table id="listTable" border="0" cellspacing="0" cellpadding="0" style="width:100%;height:100%">
    		<thead id="listHead">
    		<tr>    			
    			<th style="width:4%;height:3px;text-align: right">导入</th>
    			<th style="width:10%;text-align: left">&nbsp;&nbsp;&nbsp;&nbsp;字段名称</th>
    			<th style="width:10%;text-align: left">标题名称</th>
    			<th style="width:59%">数字字典转换</th>
    			<!-- th style="width:9%;text-align: right">唯一</th-->
    			<th style="width:10%">排列顺序</th>
    		</tr>
    		</thead>
    		<tbody id="listData">
	        <tr><td style="width:100%;herght:97%" colspan="6">
	        
	      	<iframe id="setup" src="excelImportAdminSetup-input.c" frameborder="0" style="width:100%;height:100%"></iframe>
	         
	         </td></tr>
	         </tbody>         
	         </table>
	         
	        </td>	        
	        </tr>
	    </table>		
		</td>
	    <td width="2px" class="infomainright">&nbsp;</td>
	  </tr>
	  <tr>
	    <td height="20" class="infobottomleft"></td>
		<td width="10" class="infobottomright"></td>
	  </tr>
	</table>							  
						</td>
					</tr>				
				</table>
				
		
	<table id="">
		<tr>
			<td style="padding-left: 17px">导入从第几行开始：</td>
			<td><s:textfield id="import" value="" size="5" onkeypress="NumberText(event,false,false);"/></td>
			<td style="padding-left: 10px">设置处理服务类：</td>
			<td><s:textfield id="className" value="" size="50"/></td>
		</tr>
	</table>
				
		</div>
		</s:form>

  </body>
</html>
