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
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<style type="text/css">
	body{background: #f1f1f1 repeat-x left top;}
	</style>
	<script type="text/javascript">
	listPageStyle();
	function dosave(){
		var i = 0;
		var cd = document.getElementsByTagName("input");
		var size = document.getElementById("listSportYdydf_size").value;
		for(var i=0; i<cd.length; i++){
			if(cd[i].type=="radio"){
				if(cd[i].checked){
					i++;
				}
			}
		}
		if(size != '' && size != '0'){
			if(i<parseInt(size)){
				alert('请选择是否进入下一轮！');
			}else{
				super_submitForm();
				
			}
		}else{
			return false;
		}
		
	}
	function document.onkeydown(){ 
		var e = window.event; 
		if(e.keyCode==13 && e.srcElement.type != 'button'){ 
		e.keyCode = 9; 
		return; 
		} 
	} 

	//通过
	function shtg(){
		//0草稿、1审批通过、-1取消审批
		var conf = window.confirm("您确定将你选择的信息审批通过?");
		if(conf==true){
			var a = document.getElementsByName("selectNode");
			//两层数据标识
			var tt = []; 
			for(var i=0; i<a.length; i++){
					if(a[i].checked){
					var shzt_nameVal =document.getElementById("shzt_id"+i).value; 
					if(shzt_nameVal == "0" || shzt_nameVal == "-1"){
						tt[tt.length]= a[i].value; 
					}else{
						alert("其中包含审批通过 的数据，不允许提交审批！");
						return false;
					}
				}
			}
		if(tt.length==0){
			alert('请勾选一条数据！');
			return false;
		}else{
			ajaxService.ydydfTg(tt,function (data){
				alert(data);
				var scbm = document.getElementById("scbm").value;
				var sc = document.getElementById("sc").value;
				var type = document.getElementById("type_id").value;
				 window.location.href="../business/sportCjYdy-input.c?scbm="+scbm+"&sc="+sc+"&type="+type+"&wid=";
				return false;
			});

		}
	}
	}

	//退回
	function shth(){
		//0草稿、1审批通过、-1取消审批
		var conf = window.confirm("您确定将你选择的信息取消审批?");
		if(conf==true){
			var a = document.getElementsByName("selectNode");
			//两层数据标识
			var tt = []; 
			for(var i=0; i<a.length; i++){
				if(a[i].checked){
				var shzt_nameVal =document.getElementById("shzt_id"+i).value; 
				if(shzt_nameVal == "1"){
					tt[tt.length]= a[i].value; 
				}else{
					alert("其中包含取消审批 的数据，不允许取消审批！");
					return false;
				}
			}
		}
		if(tt.length==0){
			alert('请勾选一条数据！');
			return false;
		}else{
			ajaxService.ydydfTh(tt,function (data){
				alert(data);
				var scbm = document.getElementById("scbm").value;
				var sc = document.getElementById("sc").value;
				var type = document.getElementById("type_id").value;
				 window.location.href="../business/sportCjYdy-input.c?scbm="+scbm+"&sc="+sc+"&type="+type+"&wid=";
				return false;
			});

		}
	}
	}
	
	//改变破纪录输入框的状态
	function changeYjlcl(id,obj){
		var yjlcl = document.getElementById(id);
		if(obj.value != '0'){
			yjlcl.disabled=false
		}else{
			yjlcl.disabled=true;
		}
		
		
			
	}
	</script>
  </head>
  
<body topmargin="0" leftmargin="0" onload="loading();"> 


    <div id="listC" style="text-align:center;">
     <s:hidden name="listSportYdydf_size" id="listSportYdydf_size" value="%{listSportCjYdy.size()}" />
    <s:form theme="simple" name="theform">
    <s:hidden name="type" id="type_id" value="%{#type}" />
    <table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="90%"  align="left">
    		<tr>
    			<td height="30px" colspan="10">
    			 <s:if test="#type=='sp'.toString()" >
    				<ul class="btn_gn">
		    			<li><a href="#" title="审批通过" onclick="shtg()"><span>审批通过</span></a></li>
		    			<li><a href="#" title="取消审批" onclick="shth()"><span>取消审批</span></a></li>
		    		</ul>
		    	</s:if>
    			</td>
    		</tr>
    </table>
    <br />
    <br />
    <br />
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB"  align="left">
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
			   		 <th height="20px" width="3%"><s:checkbox name="selectAll" onclick="doSelectAll()" /></th>
			  		 <th>注册号</th>
			  		 <th>参赛者</th>
			  		 <th>成绩</th>
			  		 <th>名次</th>
			  		 <th>编排序号</th>
			  		 <s:if test="#sc==2">
			  		 <th>加减金牌</th>
			 		 <th>加减银牌</th>
			  		 <th>加减铜牌</th>
			  		 <th>加减分</th>
			  		 </s:if>
			  		 <th>进入下一轮</th>
			   		 <th>破纪录类型</th>
			  		 <th>原记录</th>
			   		 <th>审核状态</th>
			  		 <th>备注</th>
			 	</tr>
    		</thead>
    		<tbody id="listData">
    		<s:hidden name="sc" id="sc" value="%{#sc}" />
    		<s:hidden name="scbm" id="scbm" value="%{#scbm}" />
    		
    		<s:iterator value="listSportCjYdy" status="status">
    		<s:hidden name="listSportCjYdy[%{#status.index}].wid" id="wid" value="%{listSportCjYdy[#status.index].wid}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].ydybm" id="ydybm_id"  value="%{listSportCjYdy[#status.index].ydybm}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].djjydh" id="djjydh_id"  value="%{listSportCjYdy[#status.index].djjydh}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].dxmmc" id="dxmmc_id" value="%{listSportCjYdy[#status.index].dxmmc}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].xxmmc" id="dxmmc_id" value="%{listSportCjYdy[#status.index].xxmmc}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].scbm" id="csbm_id"  value="%{listSportCjYdy[#status.index].scbm}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].df" id="df_id"  value="%{listSportCjYdy[#status.index].df}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].dbd" id="dbd_id" value="%{listSportCjYdy[#status.index].dbd}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].sfjs" id="sfjs_id" value="%{listSportCjYdy[#status.index].sfjs}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].sfjtxm" id="sfjtxm_id" value="%{listSportCjYdy[#status.index].sfjtxm}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].jps" id="jps_id" value="%{listSportCjYdy[#status.index].jps}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].yps" id="yps_id" value="%{listSportCjYdy[#status.index].yps}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].tps" id="tps_id" value="%{listSportCjYdy[#status.index].tps}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].createtime" id="createtime_id" value="%{listSportCjYdy[#status.index].createtime}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].shzt" id="shzt_id%{#status.index}" value="%{listSportCjYdy[#status.index].shzt}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].zch" id="shzt_zch" value="%{listSportCjYdy[#status.index].zch}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].csz" id="shzt_csz" value="%{listSportCjYdy[#status.index].csz}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].shztCn" id="shzt_id" value="%{listSportCjYdy[#status.index].shztCn}" />
    		
    		<s:if test="listSportCjYdy[#status.index].shzt==1" >
    			<tr>
    			<td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
    			<td>&nbsp;<s:property value="listSportCjYdy[#status.index].zch"/></td>
    			<td>&nbsp;<s:property value="listSportCjYdy[#status.index].csz"/></td>
    			<td>&nbsp;<s:textfield id="cj_id" size="5" disabled="true" value="%{listSportCjYdy[#status.index].cj}" /><s:hidden name="listSportCjYdy[%{#status.index}].cj" value="%{listSportCjYdy[#status.index].cj}" /> </td>
    			<td>&nbsp;<s:select id="mc_id" list="#{'0':'0','1':'1','2':'2','3':'3','4':'4','5':'5','6':'6','7':'7','8':'8'}" disabled="true" value="%{listSportCjYdy[#status.index].mc}" /><s:hidden name="listSportCjYdy[%{#status.index}].mc" value="%{listSportCjYdy[#status.index].mc}" /> </td>
    			<td>&nbsp;<s:textfield  id="bpxh_id" size="5" cssStyle="ime-mode:disabled" disabled="true" onkeypress="NumberText(event,false,false);" value="%{listSportCjYdy[#status.index].bpxh}" /><s:hidden name="listSportCjYdy[%{#status.index}].bpxh" value="%{listSportCjYdy[#status.index].bpxh}" /></td>
    			<s:if test="#sc==1">
    				<s:hidden name="listSportCjYdy[%{#status.index}].jjjps" id="jjjps_id" value="%{listSportCjYdy[#status.index].jjjps}" /> 			
    				<s:hidden name="listSportCjYdy[%{#status.index}].jjyps" id="jjyps_id" value="%{listSportCjYdy[#status.index].jjyps}" />
    				<s:hidden name="listSportCjYdy[%{#status.index}].jjtps" id="jjtps_id" value="%{listSportCjYdy[#status.index].jjtps}" />
    				<s:hidden name="listSportCjYdy[%{#status.index}].jjf" id="jjf_id" value="%{listSportCjYdy[#status.index].jjf}" />
    			</s:if>
    			<s:elseif test="#sc==2" >
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].jjjps" id="jjjps_id" size="5" disabled="true" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);" value="%{listSportCjYdy[#status.index].jjjps}" /><s:hidden name="listSportCjYdy[%{#status.index}].jjjps" value="%{listSportCjYdy[#status.index].jjjps}" /></td>    			
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].jjyps" id="jjyps_id" size="5" disabled="true" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);" value="%{listSportCjYdy[#status.index].jjyps}" /><s:hidden name="listSportCjYdy[%{#status.index}].jjyps" value="%{listSportCjYdy[#status.index].jjyps}" /></td>
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].jjtps" id="jjtps_id" size="5" disabled="true" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);" value="%{listSportCjYdy[#status.index].jjtps}" /><s:hidden name="listSportCjYdy[%{#status.index}].jjtps" value="%{listSportCjYdy[#status.index].jjtps}" /></td>
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].jjf" id="jjf_id" size="5" disabled="true" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);" value="%{listSportCjYdy[#status.index].jjf}" /><s:hidden name="listSportCjYdy[%{#status.index}].jjf" value="%{listSportCjYdy[#status.index].jjf}" /></td>
    			</s:elseif>
    			<td>&nbsp;<s:radio name="listSportCjYdy[%{#status.index}].sfjrxyl"  list="#{'0':'是','1':'否'}" disabled="true" value="%{listSportCjYdy[#status.index].sfjrxyl}" /><s:hidden name="listSportCjYdy[%{#status.index}].sfjrxyl" value="%{listSportCjYdy[#status.index].sfjrxyl}"/></td>
    			<td>&nbsp;<s:select name="listSportCjYdy[%{#status.index}].pjllx" list="#{'0':'未破','1':'全国','2':'亚洲','3':'世界'}" disabled="true" value="%{listSportCjYdy[#status.index].pjllx}" onchange="changeYjlcl('yjlcl_id%{#status.index}',this)" /> <s:hidden name="listSportCjYdy[%{#status.index}].pjllx" value="%{listSportCjYdy[#status.index].pjllx}"/></td>
    			<s:if test="%{listSportCjYdy[#status.index].pjllx==1 || listSportCjYdy[#status.index].pjllx==2 || listSportCjYdy[#status.index].pjllx==3 }">
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].yjlcj" id="yjlcl_id%{#status.index}"size="5" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);" disabled="true" value="%{listSportCjYdy[#status.index].yjlcj}" /> <s:hidden name="listSportCjYdy[%{#status.index}].yjlcj" value="%{listSportCjYdy[#status.index].yjlcj}"/></td>
    			</s:if>
    			<s:else>
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].yjlcj" id="yjlcl_id%{#status.index}"size="5" cssStyle="ime-mode:disabled" disabled="true" onkeypress="NumberText(event,false,false);" value="%{listSportCjYdy[#status.index].yjlcj}"  /> <s:hidden name="listSportCjYdy[%{#status.index}].yjlcj" value="%{listSportCjYdy[#status.index].yjlcj}"/></td>
    			</s:else>
    			
    			<td>&nbsp;<s:property value="listSportCjYdy[#status.index].shztCn"/></td>
    			<td style="border-right:1px #D7D8D9 solid">&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].bz" id="bz_id" disabled="true" size="15" maxlength="15" value="%{listSportCjYdy[#status.index].bz}" /> <s:hidden name="listSportCjYdy[%{#status.index}].bz" value="%{listSportCjYdy[#status.index].bz}"/></td>
    			</tr>
    		</s:if>
    		<s:else>
    		<tr>
    			<td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}"/></td>
    			<td>&nbsp;<s:property value="listSportCjYdy[#status.index].zch"/></td>
    			<td>&nbsp;<s:property value="listSportCjYdy[#status.index].csz"/></td>
    			<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].cj" id="cj_id" size="5" value="%{listSportCjYdy[#status.index].cj}" /></td>
    			<td>&nbsp;<s:select name="listSportCjYdy[%{#status.index}].mc" id="mc_id" list="#{'0':'0','1':'1','2':'2','3':'3','4':'4','5':'5','6':'6','7':'7','8':'8'}" value="%{listSportCjYdy[#status.index].mc}" /></td>
    			<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].bpxh" id="bpxh_id" size="5" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);" value="%{listSportCjYdy[#status.index].bpxh}" /></td>
    			<s:if test="#sc==1">
    				<s:hidden name="listSportCjYdy[%{#status.index}].jjjps" id="jjjps_id" value="%{listSportCjYdy[#status.index].jjjps}" /> 			
    				<s:hidden name="listSportCjYdy[%{#status.index}].jjyps" id="jjyps_id" value="%{listSportCjYdy[#status.index].jjyps}" />
    				<s:hidden name="listSportCjYdy[%{#status.index}].jjtps" id="jjtps_id" value="%{listSportCjYdy[#status.index].jjtps}" />
    				<s:hidden name="listSportCjYdy[%{#status.index}].jjf" id="jjf_id" value="%{listSportCjYdy[#status.index].jjf}" />
    			</s:if>
    			<s:elseif test="#sc==2" >
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].jjjps" id="jjjps_id" size="5" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);" value="%{listSportCjYdy[#status.index].jjjps}" /></td>    			
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].jjyps" id="jjyps_id" size="5" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);" value="%{listSportCjYdy[#status.index].jjyps}" /></td>
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].jjtps" id="jjtps_id" size="5" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);" value="%{listSportCjYdy[#status.index].jjtps}" /></td>
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].jjf" id="jjf_id"size="5" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);" value="%{listSportCjYdy[#status.index].jjf}" /></td>
    			</s:elseif>
    			<td>&nbsp;<s:radio name="listSportCjYdy[%{#status.index}].sfjrxyl"  list="#{'0':'是','1':'否'}" value="%{listSportCjYdy[#status.index].sfjrxyl}" /></td>
    			<td>&nbsp;<s:select name="listSportCjYdy[%{#status.index}].pjllx" list="#{'0':'未破','1':'全国','2':'亚洲','3':'世界'}" value="%{listSportCjYdy[#status.index].pjllx}" onchange="changeYjlcl('yjlcl_id%{#status.index}',this)" /></td>
    			<s:if test="%{listSportCjYdy[#status.index].pjllx==1 || listSportCjYdy[#status.index].pjllx==2 || listSportCjYdy[#status.index].pjllx==3 }">
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].yjlcj" id="yjlcl_id%{#status.index}"size="5" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);" value="%{listSportCjYdy[#status.index].yjlcj}" /></td>
    			</s:if>
    			<s:else>
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].yjlcj" id="yjlcl_id%{#status.index}"size="5" cssStyle="ime-mode:disabled;" disabled="true" onkeypress="NumberText(event,false,false);" value="%{listSportCjYdy[#status.index].yjlcj}"  /></td>
    			</s:else>
    			
    			<td>&nbsp;<s:property value="listSportCjYdy[#status.index].shztCn"/></td>
    			<td style="border-right:1px #D7D8D9 solid">&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].bz" id="bz_id" size="15" maxlength="15" value="%{listSportCjYdy[#status.index].bz}" /></td>
    			</tr>
    		</s:else>
    		
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
    	<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			<div id="SystemErrorMessage" style=" float:  left">
				<s:actionerror />
				<s:actionmessage />
				<s:fielderror />
			</div>
	</s:if>
    	
		<table width="60%" border="0" align="right">
					<tr>
						<td colspan="7">
							&nbsp;
						</td>
					</tr>
				 <s:if test="#type=='dj'.toString()" >
					<tr align="center" valign="middle">
						<td height="30" colspan="7">
						<ul class="btn_gn">
		    				<li><a href="#" title="保存" onclick="dosave()"><span>保存</span></a></li>
		    				</ul>
						</td>
					</tr>
				 </s:if>
				</table>
    	</s:form>
    	 
    </div>
   
  </body>
</html>
