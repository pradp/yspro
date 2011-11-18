<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
	
    	<title>修改评论内容</title>
<link rel="stylesheet" type="text/css" href="../clientui/js/form/CLEditor/jquery.cleditor.css" />
<script type="text/javascript" src="../clientui/js/form/CLEditor/jquery.cleditor.js"></script>
<script type="text/javascript" src="../clientui/js/form/CLEditor/jquery.cleditor.table.js"></script>
<script type="text/javascript" src="../clientui/js/form/CLEditor/jquery.cleditor.icon.js"></script>
<script type="text/javascript" src="../clientui/js/pic/bubbleup.js"></script>
	<script type="text/javascript">
	detailPageStyle();

	function doSave(){
		if(isValidateForm()){
			super_doSave();
		}
	}
	
	</script>
	
  </head>
  
  <body>

<div class="box1">

  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="txxfbPl.wid"/>
  <table width="100%" border="0" align="center">
    <tr id="tr_nr"> 
      <td align="right">评论内容：</td>
	  <td align="left" colspan="3">
	    <textarea id="plnr" name="txxfbPl.plnr" mode="full" editorWidth="650" editorHeight="280" class="rich">${txxfbPl.plnr }</textarea>
	  </td>
	</tr>
  </table>
</s:form>
  
</div>

<div class="padding_top10">
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">
					<input type="button" id="ysSaveButton" value=" 保 存 " onclick="doSave()"/>
					<input type="button" value=" 关 闭 " onclick="parent.closeEntityWindow()"/>
					<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
						<span id="SystemErrorMessage" style="top: 20px">
							<s:actionerror cssStyle="color:red"/>
							<s:actionmessage cssStyle="color:blue"/>
							<s:fielderror/>
						</span>
					</s:if>
				</td>
			</tr>
		</table>
</div> 
  </body>
</html>
