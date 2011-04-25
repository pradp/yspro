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

//上报高校审核
function doconfim(){
	var slength = 0;
    var a = document.getElementsByName("selectNode");
    for (var i = 0; i < a.length; i++) {
        if (a[i].checked) {
            slength += 1;
        }
    }
    if (slength >= 1) { 
    
        var ids = CropCheckBoxValueAsString("selectNode");//获取选中的wid   	  
    	var yxid=document.getElementById('yxid').value;  
    	var conf = window.confirm("您确定要提交高校审核吗?");
		if(conf==true){
				ajaxService.do_pkskDq_sh(ids,yxid,ajaxBackString);
	    	}
  		function ajaxBackString(result){   
			if(result=="1"){
				alert("审核状态必须是草稿或退出！");
			}else if(result=="2"){
				alert("上报高校审核成功！");
			}else if(result=="3"){
				alert("上报高校审核超出高校比列");
			}
			document.forms[0].submit();
		}
	 
    }
    else {
        alert("请勾选记录!");
    }
}

//审核退回
function doShenheTH(){
	var slength = 0;
    var a = document.getElementsByName("selectNode");
    for (var i = 0; i < a.length; i++) {
        if (a[i].checked) {
            slength += 1;
        }
    }
    if (slength >= 1) {     
        var ids = CropCheckBoxValueAsString("selectNode");//获取选中的wid   	  
    	var conf = window.confirm("您确定要审核退回吗?");
		if(conf==true){
				ajaxService.doUpdate_PkskDq_shzt(ids,"3",ajaxBackString);
	    	}
  		function ajaxBackString(result){   
			alert(result);
			document.forms[0].submit();
		}
	 
    }
    else {
        alert("请勾选记录!");
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
    	<s:hidden name="pager.formname" value="theform"/>
    
    			<table id="searchForm" border="0" align="center" cellspacing="3"
					cellpadding="0" width="100%" class="maginB">
					<tr align="center">

					</tr>
				</table>
				<table id="buttonTable" border="0" cellspacing="3" cellpadding="0"
					width="100%">
					<tr>
					 <td height="30px" colspan="10">
						<ul class="btn_gn">
							<li><a href="#" title="新增" onclick="input()"><span>新增 </span></a></li>
							<li><a href="#" title="修改" onClick="modifySelected()"><span>修改</span></a></li>
							<li><a href="#" title="删除" onClick="submitRemove()"><span>删除 </span></a></li>
						</ul>
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
    		<thead id="listHead"  >
    		<tr>
    		    <th><s:checkbox name="selectAll" onclick="doSelectAll()"/></th>   		   
    		    <th nowrap="nowrap">开放时间规则</th> 
    		    <th nowrap="nowrap">状态</th>
    		    <th nowrap="nowrap">操作</th>	
    		</tr>
    		</thead>
    		<tbody id="listData">
    	    <s:iterator value="resultData" status="stuts">
    	     <tr>
    	        <td class=""><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>   	       
    		    <td>&nbsp;
    		    <s:if test="cycleType=='每月'">
    		    <s:property value="cycleType" />， <s:property value="cycleStart" />号至<s:property value="cycleEnd" />号
    		    </s:if>
    		    <s:if test="cycleType=='每天'">
    		    <s:property value="cycleType" />， <s:property value="cycleStart" /> 至 <s:property value="cycleEnd" />
    		    </s:if>
    		    <s:if test="cycleType=='每年'">
    		    <s:property value="cycleType" />， <s:property value="cycleStart" />日至<s:property value="cycleEnd" />日
    		    </s:if></td>   
    		    <td><s:if test="state==0">禁用</s:if>
			<s:else>可用</s:else></td>   		  
    		   <td>
    		     &nbsp;<a href="javascript:input('<s:property value="wid"/>',false)" ><FONT color="blue">编辑</FONT></a> 		   
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
