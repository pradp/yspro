<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
	
    	<title>维护类型</title>

	<script type="text/javascript">
		detailPageStyle();
	</script>
	
	
  </head>
  
  <body style="text-align:center;">

<div id="scrollContent">
<div class="box1" panelWidth="100%">
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="tcsLx.wid" id="wid"/>
  <s:hidden name="sfxz" id="sfxz" />

 <fieldset> 
　 <legend>类型信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" nowrap="nowrap" width="40%">类型：</td>
      <td align="left" width="60%">
      	<s:textfield id="lx" name="tcsLx.lx" maxlength="10" onblur="checkDuplicate('TCsLx','lx')"/>
      	 <label style="color:red">*</label>
      </td>
    </tr>
    <tr> 
	  <td align="right">状态：</td>
	  <td align="left"><s:select name="tcsLx.state" list="#{'1':'启用','0':'禁用'}"/> <label style="color:red">*</label></td>
    </tr>
    <tr> 
      <td align="right">简介：</td>
      <td align="left">
		 <span class="float_left"><s:textarea name="tcsLx.jj" id="jj" maxNum="100"
		  cssStyle="width:300px;" cssClass="validate[length[0,100]]"/></span>
		 <span class="img_light" style="height:80px;" title="限制在100字以内"></span> 
	  </td>
    </tr>
  </table>
 </fieldset>
  
</s:form>
<div class="padding_top10">
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">
					<input type="button" id="ysSaveButton" value=" 保 存 " onclick="doSave()"/>
					<input type="button" id="" value=" 保存并新增 " onclick="dosavenew()"/>
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
</div>
</div>
  </body>
</html>
