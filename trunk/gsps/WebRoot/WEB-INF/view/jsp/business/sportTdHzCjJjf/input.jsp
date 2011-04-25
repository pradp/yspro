<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>代表团加减分明细维护</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/idcard.js"></script>
	<script type="text/javascript">
	    detailPageStyle();
/*	    $(document).ready(function(){
			if(document.getElementById("jjf").value == '')
				document.getElementById('jjf').value = 0;
			if(document.getElementById("jjjps").value == '')
				document.getElementById('jjjps').value = 0;
			if(document.getElementById("jjyps").value == '')
				document.getElementById('jjyps').value = 0;
			if(document.getElementById("jjtps").value == '')
				document.getElementById('jjtps').value = 0;
		});
		validate_required_fields = [ 
		   	{fieldId: "jjf",  message:"加减分不能为空！", mustMatch: true},
		    {fieldId:"jjjps", message:"金牌数不能为空！", mustMatch: true}, 
		    {fieldId:"jjyps", message:"银牌数不能为空！", mustMatch: true},
		    {fieldId:"jjtps", message:"铜牌数不能为空！", mustMatch: true}
		     ];
*/	     
		function dosave(){
			if(isValidateForm()){
				if(checkLength()){
					submitForm();
				}
			}
		}
		function checkLength(){
			var val = $("#bz").val();
			
			var lengths = getLength(val);
			if(lengths>600){
				alert('输入的字符超过 600!');
//				$("#bz").val(val.substring(0,600));//截取前200个字符
				return false;
			}
			return true;
		}

		//创建一行加减分、加减金牌数、加减银牌数、加减铜牌数
		   function createJtxx(){
		       var id = (new Date()).getTime() + "";
		       var maxNum = getPersonMaxNum();
		       var newnum = parseInt(maxNum) + 1;
		     //alert(newnum);
		       var newTag = "tsportCjJjfMx[" + newnum + "]";
		       jQuery.noConflict();
		       var cellFuncs = [function(data){
		           return "<input type='hidden' name='tsportCjJjfMx["+newnum+"].wid'/><input name='" + newTag + ".jjf' type='text' align='center' maxlength='5' size='10' onkeypress='NumberText(event,true,true)' cssStyle='ime-mode:disabled'/>";
		       }, function(data){
		    	   return "<input name='" + newTag + ".jjjps' type='text' align='center' maxlength='5' size='10' onkeypress='NumberText(event,true,true)' cssStyle='ime-mode:disabled'/>";
		       }, function(data){
		    	   return "<input name='" + newTag + ".jjyps' type='text' align='center' maxlength='5' size='10' onkeypress='NumberText(event,true,true)' cssStyle='ime-mode:disabled'/>";
		       }, function(data){
		    	   return "<input name='" + newTag + ".jjtps' type='text' align='center' maxlength='5' size='10' onkeypress='NumberText(event,true,true)' cssStyle='ime-mode:disabled'/>";
		       }, function(data){
		    	   return "<input name='" + newTag + ".bz' type='text' align='center' maxlength='30' size='50' onkeyup='checkLength(this.id)'/>";
		       }, function(data){
		           return "<input id='" + id + "' type='button'  value='删除' onclick='removeThisRow(this)'/>";
		       }
		   ];
		       DWRUtil.addRows("tsportCjJjfMx1", [id], cellFuncs, {
		           escapeHtml: false
		       });
		       $ = jQuery;
		       $("#tsportCjJjfMx1 td").each(function(i){
		    	   $(this).attr("align","center");
		       });
		       ///rebundstyle();
		   }

		   function getPersonMaxNum(){
			    var num = 0;
			    var ryInput = $("input[@name*=tsportCjJjfMx]").each(function(i){
			        if (this.name.indexOf(".wid") != -1) {
			            var thisIndexStr = this.name;
			            var end = thisIndexStr.substring("tsportCjJjfMx[".length);
			            var thisIndex = end.substring(0, end.indexOf("].wid"));
			            //alert(thisIndex);
			            if (thisIndex > num) 
			                num = thisIndex;
			        }
			    });
			    return num;
			}
			
			//删除一行加减分、加减金牌数、加减银牌数、加减铜牌数
		   function removeThisRow(obj){
		       $("#" + obj.id).parent().parent().remove();
		   }
		   
	</script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/resources/css/webface.css">
  	<base target="_self">
  </head>
  
  <body style="text-align:center;">
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" style="top: 20px">
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>

<div class="framestyle" style="width:98%;padding: 0pt 10pt 10pt 10pt;">
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="depart1" id="depart1" value="%{#depart1}"/>
  
 <fieldset> 
　 <legend>成绩更新</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="center" width="10%">加减分</td>
      <td align="center" width="10%">加减金牌数</td>
	  <td align="center" width="10%">加减银牌数</td>
      <td align="center" width="10%">加减铜牌数</td>
      <td align="center" width="10%">备注</td>
    </tr>
    <tbody id="tsportCjJjfMx1">
	  <s:if test="tsportCjJjfMx==null || tsportCjJjfMx.size==0">
       	<td align="center"><s:textfield name="tsportCjJjfMx[0].jjf" id="jjf" maxlength="5" size="10"/></td>
       	<td align="center"><s:textfield name="tsportCjJjfMx[0].jjjps" id="jjjps" maxlength="5" size="10"/></td>
       	<td align="center"><s:textfield name="tsportCjJjfMx[0].jjyps" id="jjyps" maxlength="5" size="10"/></td>
       	<td align="center"><s:textfield name="tsportCjJjfMx[0].jjtps" id="jjtps" maxlength="5" size="10"/></td>
       	<td align="center"><s:textfield name="tsportCjJjfMx[0].bz" id="bz" maxlength="30" size="50" onkeyup="checkLength(this.id)"/></td>
        <td align="center"><input type="button" value="添加" onclick="createJtxx()"/></td>
      </s:if>
      <s:else>
      		<s:iterator value="tsportCjJjfMx" status="stat">
			      <tr>
			      		
			      		<td align="center"><s:hidden name="tsportCjJjfMx[%{#stat.index}].wid"/>
			      		<s:textfield id="jjf" name="tsportCjJjfMx[%{#stat.index}].jjf" maxlength="5" size="10" onkeypress="NumberText(event,true,true);" cssStyle="ime-mode:disabled" /> 
			      		</td><td align="center">
			      		<s:textfield id="jjjps" name="tsportCjJjfMx[%{#stat.index}].jjjps" maxlength="5" size="10" onkeypress="NumberText(event,true,true);" cssStyle="ime-mode:disabled" /> 
			      		</td><td align="center">
			      		<s:textfield id="jjyps" name="tsportCjJjfMx[%{#stat.index}].jjyps" maxlength="5" size="10" onkeypress="NumberText(event,true,true);" cssStyle="ime-mode:disabled" /> 
			      		</td><td align="center">
			      		<s:textfield id="jjtps" name="tsportCjJjfMx[%{#stat.index}].jjtps" maxlength="5" size="10" onkeypress="NumberText(event,true,true);" cssStyle="ime-mode:disabled" /> 
					  	</td><td align="center" >
      	  				<s:textfield id="bz" name="tsportCjJjfMx[%{#stat.index}].bz"  maxlength="30" size="50" onkeyup="checkLength(this.id)"/>
     					</td>
					  	<s:if test="#stat.index==0">
							 <td align="center"><input type="button" value="添加" onclick="createJtxx()"/></td>
						</s:if>
						<s:else>
							 <td align="center"><input id="jtxx_<s:property value="#stat.index"/>" type="button" value="删除" onclick="removeThisRow(this)"/></td>		     
						</s:else>
				  </tr>
			</s:iterator>
      </s:else>
    </tbody>
  </table>
 </fieldset>
 
  <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle"> 
	  <td colspan="30">&nbsp;</td>
	    <td height="30" colspan="7">
	    
	      	<ul class="btn_gn">
	      		<li><a href="#" title="添加" onClick="createJtxx()"><span>添加</span></a></li>
    			<li><a href="#" title="保存" onClick="dosave()"><span>保存</span></a></li>
	    		<li><a href="#" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span></a></li>
	    	</ul>
	    	</td>
	  </tr>
  </table>
</s:form>
</div>
  </body>
</html>
