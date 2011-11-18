<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="../../common/Include_input_head.jsp" %>
	
    	<title>维护用户组</title>

	<script type="text/javascript">
	detailPageStyle();

	function doSave(){
		
		if( !checkInput("groupname","名称不能为空！") ){
			return false;
		}

		return super_doSave();
		
	}
	</script>

	
  </head>
  
  <body style="text-align:center;">


<div id="scrollContent">
	<div class="box1" panelWidth="100%" >
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="tsysGroup.groupid" />

  <table width="100%" border="0" align="center">
    <tr> 
      <td width="3%">&nbsp;</td>
      <td align="center" width="30%" nowrap="nowrap">组名称：<s:textfield id="groupname" name="tsysGroup.groupname" maxlength="15" size="20"/> <label style="color:red">*</label></td>
	  <td align="center">状态：
	    <s:select name="tsysGroup.state" list="#{'1':'启用','0':'禁用'}" listKey="key" listValue="value"/>
	  </td>
      <td width="3%">&nbsp;</td>
    </tr>
  </table>

 <table width="100%" border="0" align="center">
	<tr> 
        <td align="right" nowrap="nowrap">描述：</td>
        <td width="86%" align="left">
		<span class="float_left"><s:textarea name="tsysGroup.memo" id="memo" cssStyle="width:300px;" cssClass="validate[length[0,50]]"></s:textarea>
		</span>
		<span class="img_light" style="height:50px;" title="限制在50字以内" id="light_id"></span> 
		</td>
	</tr> 
  </table>
 
  <table width="96%" border="0" align="center">
    <tr>
    	<td height="1" style="background-color: silver"></td>
    </tr>
  </table>

 <table id="userRightCtrl_group" width="100%" border="0" align="center">
    <tr> 
      <td align="right">拥有角色：</td>
      <td width="81%" align="left">   <s:checkboxlist name="myRoles_id" value="%{myRoles_id}" list="getAllRoles()" listKey="id" listValue="caption"/></td>
      <td width="11%"></td>
    </tr>
  </table>
 
</s:form>
</div>
	<div class="padding_top10">
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">
					<input type="button" id="ysSaveButton" value=" 保 存 " onclick="doSave()"/>
					<input type="button" id="closeButton" value=" 关 闭 " onclick="parent.closeEntityWindow()"/>
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

  </body>
</html>
