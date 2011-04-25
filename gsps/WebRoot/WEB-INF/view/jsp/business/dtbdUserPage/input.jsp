<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title><s:if test="#request.update_wid==null">新增</s:if><s:else>修改</s:else><s:property value="#session.tableChineseName" />数据</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/resources/css/webface.css">
	<script type="text/javascript">
		detailPageStyle();
	function submitForm(){
		if(isValidateForm()){
			
				super_submitForm();
					
		}
	}
	function getLengthData(obj,data){
		var val = obj.value;
		var val_length = getLength(val);
		if(val_length>data){
			alert('您输入的内容已超过'+data+'字节');
			val = val.substring(0,350);
			obj.value= val;
			return false;
		}
	}
	</script>
	
  	<base target="_self">
  </head>
  
<body style="text-align:center;">
<SCRIPT type="text/javascript">
		<s:property value="validate_required_fields" />
	</SCRIPT>
<!-- header start -->
<s:if test="actionErrors.size()> 0 || actionMessages.size()>0 || fieldErrors.size()>0">
<div id="SystemErrorMessage">
<s:actionerror />
<s:actionmessage />
<s:fielderror />
</div>
</s:if>
<!-- header end -->

<div class="framestyle" style="width:90%;padding: 0pt 10pt 10pt 10pt;">
<s:form name="theform" method="post" theme="simple" >
<s:hidden name="wid" value="%{#request.update_wid}"/>
<s:hidden name="servicestate" value="%{#request.servicestate}"/>
<s:hidden name="tableName" />
<s:hidden name="bbnd" />
<fieldset>
<legend><s:if test="#request.update_wid==null">新增</s:if><s:else>修改</s:else><s:property value="#session.tableChineseName" />数据</legend>
  <table width="100%" border="0" align="center">
  	<s:if test="getList_DTBDFieldInfo_Select()==null || getList_DTBDFieldInfo_Select().size()==0">
  	<td><b>此表没有可填写数据！</b></td>
  	</s:if>
  	<s:else>
  	<s:iterator value="getList_DTBDFieldInfo_Select()" status="stuts">
  	<s:if test="#stuts.index%2==0">
  		<tr>
  	</s:if>
  		  <td align="right" width="15%"><s:property value="fieldDisplayName"/>：</td>
  		  <td align="left" width="35%">
  			<s:if test="fieldType==0" >
  				<s:if test="fieldLength<300">
  					<input type="text" id="table_<s:property value='fieldName' />" name="<s:property value='fieldName' />"  value="<s:property value='view_data' />" maxlength="<s:property value="fieldLength" />" size="50"/>
  				</s:if>
  				<s:else>
  					<textarea id="table_<s:property value='fieldName' />" name="<s:property value='fieldName' />" cols="32" onkeyup="getLengthData(this,<s:property value="fieldLength" />)"  ><s:property value='view_data' /></textarea>
  				</s:else>				
  			</s:if>
  			<s:elseif test="fieldType==1">
  				<s:if test="fieldLength<300">
  					<input type="text" id="table_<s:property value='fieldName' />" name="<s:property value='fieldName' />"  value="<s:property value='view_data' />" onkeypress="NumberText(event,false,false);" style="ime-mode:disabled" maxlength="<s:property value="fieldLength" />" size="50"/>
  				</s:if>
  				<s:else>
  					<textarea id="table_<s:property value='fieldName' />" name="<s:property value='fieldName' />" cols="32" onkeypress="NumberText(event,false,false);" style="ime-mode:disabled"  onkeyup="getLengthData(this,<s:property value="fieldLength" />)"  ><s:property value='view_data' /></textarea>
  				</s:else>	
  			</s:elseif>
  			<s:elseif test="fieldType==2">
  				<select id="table_<s:property value='fieldName' />" name="<s:property value='fieldName' />" style="width:280px">
    				<option value="">--请选择--</option>
    				<s:iterator value="%{getSysCode(fieldDefine)}"  status="stuts" id="p">
  						<s:if test="view_data == id">
    						<option value="<s:property value='id' />" selected="selected"><s:property value='caption' /></option>
  						</s:if>
  						<s:else>
    						<option value="<s:property value='id' />"><s:property value='caption' /></option>
    					</s:else>
  					</s:iterator>
  				</select>
  			</s:elseif>
  			<s:elseif test="fieldType==3">
    			<s:iterator value="%{getSysCode(fieldDefine)}"  status="stuts" id="p">
	        		<s:checkbox name="<s:property value='fieldName' />" value="<s:property value='id' />"></s:checkbox><label> <s:property value='caption' /></label>
	        	</s:iterator> 
  			</s:elseif>
  			<s:elseif test="fieldType==4">
    			<s:textfield id="table_<s:property value='fieldName' />" name="<s:property value='fieldName' />" maxlength="20" size="50" onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})"/>
  			</s:elseif>
  			<s:elseif test="fieldType==5">
    			<s:textfield id="table_<s:property value='fieldName' />" name="<s:property value='fieldName' />" maxlength="20" size="50" onfocus="WdatePicker({startDate:'%y-%M-%d 00:00',dateFmt:'yyyy-MM-dd HH:mm',alwaysUseStartDate:true})"/>
  			</s:elseif>
  			<s:if test="isMustIn==1" >
  				<label style="color:red">*</label>
  			</s:if>  
  		  </td>
  		<s:if test="#stuts.index%2!=0">
  			</tr>
  		</s:if>
  	</s:iterator>
  	</s:else>
 
  </table>
</fieldset>

  <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle">	   
	    <td height="30" colspan="7">
	    	    
<table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="26%"><tr><td height="30px" width="440px">
	<ul class="btn_gn">	
	<s:if test="getList_DTBDFieldInfo_Select()!=null || getList_DTBDFieldInfo_Select().size()>0">			
		<s:if test="#save_display==1">
			<li>
				<a href="#" title="保存" onClick="submitForm();" id="sendMsgButton"><span>保存<s:property value="display" /></span> </a>
			</li>
		</s:if>
		
								
		
	</s:if>
		<li>
			<a href="#" title="关闭" onClick="parent.closeInputWindow();" id="sendMsgButton"><span>关闭</span> </a>
		</li>																															
	</ul>
</td></tr></table>

			</td>
	  </tr>
  </table>
</s:form>
</div>
</body>
</html>
