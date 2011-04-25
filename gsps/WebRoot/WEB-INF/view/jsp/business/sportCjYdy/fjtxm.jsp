	<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/plugins/jquery.maskedinput-1.2.2.js" charset="UTF-8"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$("input[id^='cj_']").each(function(i){
			var ids = 'dw_'+$(this).attr('id');
			var dw = parseInt(document.getElementById(ids).value);
			var ms = ''; //成绩格式
			if(dw==1){
				ms = "999";
			}else if(dw==2){
				ms = "999.999";
			}else if(dw==3){
				ms = "99:99:99.999";
			}else if(dw==4){
				ms = "99:99.999";
			}else if(dw==5){
				ms = "99.999";
			}else if(dw==6){
				ms = "999.999";
			}else if(dw==7){
				//ms = "9999";
				$(this).attr("maxlength","4");
			}else if(dw==8){
				ms = "9999.9";
			}else if(dw==9){
				ms = "99.99";
			}else if(dw==10){
				ms = "9999.99";
			}
			if(dw!='0'){
				var value = $(this).val();  //取成绩
				
				if(value!=null && value!=''&& ms!=''){ 
					//成绩格式化
					$(this).val(formatValue(value,ms));
				}
				//输入框格式化
				if(ms!=''){
					$(this).mask(ms); 
				}
			}
		
			
		});
	  });
	//格式化成绩 num为成绩 myformat为格式
	function formatValue(num,myformat){
		if(myformat.indexOf(':') == -1 && myformat.indexOf('.') == -1){ //整数成绩
			return formatNum(num,3,1);
		}else if(myformat.indexOf(':') == -1){ //带小数的成绩
			var tf = myformat.split('.');
			var zscd = tf[0].length;  //整数部分长度
			var n = num.split('.');
			return formatNum(n[0],zscd,'1')+"."+xsbf(num,myformat);
		}else{ //时间成绩
		//	var n = num.split('.');
		//	var tf = myformat.split('.');
		//	return timebf(n[0],tf[0])+"."+xsbf(num,myformat);
		}
	}
	//小数部分补0
	function xsbf(num,myformat){
		var tf = myformat.split('.');
		var xscd = tf[1].length;  //小数部分长度
		if(num.indexOf('.')==-1){
			return formatNum(0,xscd,'0');
		}else{
			var n = num.split('.');
			return formatNum(n[1],xscd,'0');
		}
	}
	//时间补0
	function timebf(num,myformat){
		var tf = myformat.split(':');
		var mytime = '00:00:';
		if(num.indexOf(':')==-1){
			mytime += formatNum(num,2,'1');
		}else{
			var n = num.split(':');
			for(var i=0;i<n.size();i++){
				mytime += formatNum(n[i],2,'1');
				if(i!=n.size()-1) 
					mytime += ":"; 
			}
		}
		return mytime.substr(mytime.length-myformat.length,myformat.length);
	}
	//num为整数,length为格式化的尾数,type为类型1为整数0为小数
	function formatNum(num,leng,type){ 
		if(type=='1'){ //整数
			return ('000'+num).substr(('000'+num).length-leng,leng);
		}else{ //小数
			return (num+'000').substring(0,leng);
		}
	}  	 
	/**
	 * obj: select 本身 
	 * id : select  的 隐藏值的 id
	 * radioHidden : radio(是否本届成绩) 隐藏值
	 */
		function pdsfcf(obj,id,radioHidden){
			var nas = document.getElementById(radioHidden);
			//alert(document.getElementById(id).value);
			if(obj!=null && obj.value!='' && obj.value!='0' && nas.value=='1'){
				var objs =  document.getElementsByTagName("input");
				var array = new Array();
				for(i=0;i<objs.length;i++){
					if(objs[i].id=="wid" && objs[i].value+"_mc"!=obj.id){
						array[array.length]= objs[i].value;
					}
				}
				//小于自己名次的数量
				var count = 0;
				//等于自己名次的数量
				var count2 = 0;
				//用于 名次相等的判断
				var bool = false;
				for(j=0;j<array.length;j++){
					var mcval = document.getElementById(array[j]+"_mc");
					var radiotemp = document.getElementById(array[j]+"_sfbj");
					if(parseInt(mcval.value)<parseInt(obj.value) && nas.value==radiotemp.value && obj.value!='0' && mcval.value!='0'){
						count++;
					}
					if(parseInt(mcval.value)==parseInt(obj.value) && nas.value==radiotemp.value && obj.value!='0' && mcval.value!='0'){
						count2++;
					}
				}
				
				if(count2>0){
					for(j=0;j<array.length;j++){
						var mcval = document.getElementById(array[j]+"_mc");
						var radiotemp = document.getElementById(array[j]+"_sfbj");
						if(parseInt(mcval.value)<(parseInt(obj.value)+count2+1) &&  parseInt(mcval.value)>parseInt(obj.value) && nas.value==radiotemp.value && obj.value!='0'){
							bool = true;
						}
					}
				}
			//	alert("count - "+count +" count2 - "+count2 +" bool - "+ bool+" obj.value - "+obj.value);
				//验证名次是否漏掉 
				if(count<parseInt(obj.value)-1){
					//var mc = parseInt(obj.value)-1;
					alert(obj.value+'名次以上的高名次未报满！');
					if(document.getElementById(id).value==''){
						obj.value='0';
					}else{
						obj.value=document.getElementById(id).value;
					}
					return false;
				}
				if((count>=parseInt(obj.value)&& count!=0 )|| bool){
					alert('本名次已被高名次取代，请选择其他名次！');
					if(document.getElementById(id).value==''){
						obj.value='0';
					}else{
						obj.value=document.getElementById(id).value;
					}
					return false;
				}
				document.getElementById(id).value=obj.value;
			}else{
				document.getElementById(id).value=obj.value;
			}
		}
	/**
	 * selectId: select 的 id
	 * radioName : radio(是否本届成绩) 的 name
	 * radioHidden : radio(是否本届成绩) 隐藏值
	 */
	function pdsfcf2(selectId,radioName,radioHidden){
		var nas = document.getElementsByName(radioName);
		var stat = '';
		for(k=0;k<nas.length;k++){
			if(nas[k].checked){
				stat = nas[k].value;
			}
		}
		var obj = document.getElementById(selectId);
		if(obj!=null && obj.value!='' && obj.value!='0' && stat=='1'){
			var objs =  document.getElementsByTagName("input");
			var array = new Array();
			for(i=0;i<objs.length;i++){
				if(objs[i].id=="wid" && objs[i].value+"_mc"!=obj.id){
					array[array.length]= objs[i].value;
				}
			}

			//小于自己名次的数量
			var count = 0;
			//等于自己名次的数量
			var count2 = 0;
			//用于 名次相等的判断
			var bool = false;
			for(j=0;j<array.length;j++){
				var mcval = document.getElementById(array[j]+"_mc");
				var radiotemp = document.getElementById(array[j]+"_sfbj");
				if(parseInt(mcval.value)<parseInt(obj.value) && stat==radiotemp.value && obj.value!='0' && mcval.value!='0'){
					count++;
				}
				if(parseInt(mcval.value)==parseInt(obj.value) && stat==radiotemp.value && obj.value!='0' && mcval.value!='0'){
					count2++;
				}
			}
			if(count2>0){
				//防止选择的名次占用已用的名次
				for(j=0;j<array.length;j++){
					var mcval = document.getElementById(array[j]+"_mc");
					var radiotemp = document.getElementById(array[j]+"_sfbj");
					if(parseInt(mcval.value)<(parseInt(obj.value)+count2+1) &&  parseInt(mcval.value)>parseInt(obj.value) && stat==radiotemp.value && obj.value!='0'){
						bool = true;
					}
				}
			}

			//验证名次是否漏掉 
			if(count<parseInt(obj.value)-1){
				var mc = parseInt(obj.value)-1;
				alert(obj.value+'名次以上的高名次未报满！');
				var nas = document.getElementsByName(radioName);
				//恢复选项 操作
				for(k=0;k<nas.length;k++){
					if(nas[k].value=='1'){
						nas[k].checked=false;
					}else{
						nas[k].checked=true;
					}
				}
				return false;
			}
			if((count>=parseInt(obj.value)&& count!=0 )|| bool){
				alert('本名次已被高名次取代，请选择其他名次！');
				var nas = document.getElementsByName(radioName);
				//恢复选项 操作
				for(k=0;k<nas.length;k++){
					if(nas[k].value=='1'){
						nas[k].checked=false;
					}else{
						nas[k].checked=true;
					}
				}
				return false;
			}else{
				document.getElementById(radioHidden).value='1';
			}
	}else{
		document.getElementById(radioHidden).value='0';
	}
}

		function checkCj(){
			$("input[id^='cj_']").each(function(i){
				var ids = 'dw_'+$(this).attr('id');
				if(document.getElementById(ids).value!='0'){
					var value = $(this).val();  //取成绩
					value = value.replaceAll('\\.','').replaceAll(':','').replaceAll('0','');
		        	if(value == ''){
		        		$(this).val('');
		        	}
				}
			});
		}
</script>
	<thead id="listHead">	
    		<tr>
			   		 <th height="20px"><s:checkbox name="selectAll" id="mainCheck" onclick="changeQXHF(doSelectAll())" /></th>
			  		 <th><nobr>序号</nobr></th>
			  		 <th><nobr>参赛者</nobr></th>
			  		 <th><nobr>所属运动队[注册号]</nobr></th>
			  		 <s:if test="%{#departid==null || #departid==''}">
			  		 <th><nobr>成绩</nobr></th>
			  		 </s:if>
			  		 <s:if test="%{#sc==2&&(#departid==null || #departid=='')}">
			  		 <th><nobr>名次</nobr></th>
			  		 </s:if>
			  		 <th><nobr>编排序号</nobr></th>
			  		 <s:if test="%{#sc==2&&(#departid==null || #departid=='')}">
			  		 <th><nobr>得分</nobr></th>
			  		 </s:if>
			  		 <s:if test="%{#departid==null || #departid==''}">
			   		 <th><nobr>破纪录类型</nobr></th>
			  		 <th><nobr>原记录</nobr></th>
			  		 </s:if>
			  		 	<%
    				//xsshzt 为空时 是 非集体项目登记 个人
    				//不为空是  集体姓名  代表团 或代表队  登记个人， 不显示 审核状态
    			%>
			  		 <s:if test="#xsshzt==null || #xsshzt=='' ">
			  		 	<th><nobr>审核状态</nobr></th>
			  		 </s:if>
			  		 <th><nobr>备注</nobr></th>
			  		 <s:if test="%{#departid==null || #departid==''}">
			  		  <th><nobr>本届成绩/非个人</nobr></th>
			  		 </s:if>
			  		
			  		 
			 	</tr>
    		</thead>
    		<tbody id="listData">
    		<s:hidden name="sc" id="sc" value="%{#sc}" />
    		<s:hidden name="scbm" id="scbm" value="%{#scbm}" />
    		<s:hidden name="listSportYdydf_size" id="listSportYdydf_size" value="%{listSportCjYdy.size()}" />
    		
    		<s:iterator value="listSportCjYdy" status="status">
    		<s:hidden name="listSportCjYdy[%{#status.index}].dxmmc" value="%{listSportCjYdy[#status.index].dxmmc}" />
    		<s:hidden name="listSportCjYdy[%{#status.index}].xxmmc" value="%{listSportCjYdy[#status.index].xxmmc}" />
    		<input type="hidden" id="shzt<s:property value="%{listSportCjYdy[#status.index].wid}" />" value="<s:property value="%{listSportCjYdy[#status.index].shzt}" />" />
    		<s:if test="listSportCjYdy[#status.index].shzt!=-1 && listSportCjYdy[#status.index].shzt!=0" >
    			<tr>
    			<td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}" onclick="changeQXHF()"/></td>
    			<td><nobr>&nbsp;<s:property value="#status.index+1" /></nobr> <s:hidden name="listSportCjYdy[%{#status.index}].wid" id="wid" value="%{listSportCjYdy[#status.index].wid}" /></td>
    			<td><nobr>&nbsp;<s:property value="listSportCjYdy[#status.index].ydyxm"  /></nobr> <s:hidden name="listSportCjYdy[%{#status.index}].mc" value="%{listSportCjYdy[#status.index].mc}" /></td>
    			<td><nobr>&nbsp;<s:property value="listSportCjYdy[#status.index].ssydy" />&nbsp;[<s:property value="listSportCjYdy[#status.index].zch" />]</nobr></td>

    			<s:if test="%{#departid==null || #departid==''}">
    			<td>&nbsp;<s:textfield id="cj_id" size="5" disabled="true" value="%{listSportCjYdy[#status.index].cj}" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,true);" onchange="checkCj()"/><s:hidden name="listSportCjYdy[%{#status.index}].cj" value="%{listSportCjYdy[#status.index].cj}" /> </td>
    			</s:if>
    			<s:else>
    				<s:hidden name="listSportCjYdy[%{#status.index}].cj" value="%{listSportCjYdy[#status.index].cj}" /> 
    			</s:else>
			<s:if test="%{#sc==2&&(#departid==null || #departid=='')}">
					<s:if test="%{listSportCjYdy[#status.index].dxmmc=='击剑'}">
						<td>&nbsp;<s:select id="mc_id" list="getSysCode('SCDFGZ_PMJB_JJ')" disabled="true" listKey="id" listValue="caption" value="%{listSportCjYdy[#status.index].mc}" /><s:hidden name="listSportCjYdy[%{#status.index}].mc" value="%{listSportCjYdy[#status.index].mc}" /> </td>
					</s:if>
					<s:else>
						<td>&nbsp;<s:select id="mc_id" list="getSysCode('SCDFGZ_PMJB')" disabled="true" listKey="id" listValue="caption" value="%{listSportCjYdy[#status.index].mc}" /><s:hidden name="listSportCjYdy[%{#status.index}].mc" value="%{listSportCjYdy[#status.index].mc}" /> </td>
					</s:else>
    				
    		</s:if>
    			<s:else>
    			  <s:hidden name="listSportCjYdy[%{#status.index}].mc" value="0" /> 
    			</s:else>
    			<td>&nbsp;<s:textfield  id="bpxh_id" size="8"  disabled="true"  value="%{listSportCjYdy[#status.index].bpxh}" /><s:hidden name="listSportCjYdy[%{#status.index}].bpxh" value="%{listSportCjYdy[#status.index].bpxh}" /></td>
    			
    			<s:if test="#sc==2 &&(#departid==null || #departid=='')" >
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].df" id="df_id" size="5" disabled="true" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,false);" value="%{listSportCjYdy[#status.index].df}" /><s:hidden name="listSportCjYdy[%{#status.index}].df" id="df_id"  value="%{listSportCjYdy[#status.index].df}" /></td>
    			</s:if>
    			<s:if test="%{#departid==null || #departid==''}">
    			 	<td>&nbsp;<s:select name="listSportCjYdy[%{#status.index}].pjllx" list="getSysCode('YDY_PJLLX')" listKey="id" listValue="caption" disabled="true" value="%{listSportCjYdy[#status.index].pjllx}" onchange="changeYjlcl('yjlcl_id%{#status.index}',this)" /> <s:hidden name="listSportCjYdy[%{#status.index}].pjllx" value="%{listSportCjYdy[#status.index].pjllx}"/></td>
    				<s:if test="%{listSportCjYdy[#status.index].pjllx==1 || listSportCjYdy[#status.index].pjllx==2 || listSportCjYdy[#status.index].pjllx==3 }">
    					<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].yjlcj" id="yjlcl_id%{#status.index}"size="5" disabled="true" value="%{listSportCjYdy[#status.index].yjlcj}" /> <s:hidden name="listSportCjYdy[%{#status.index}].yjlcj" value="%{listSportCjYdy[#status.index].yjlcj}"/></td>
    				</s:if>
    				<s:else>
    					<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].yjlcj" id="yjlcl_id%{#status.index}"size="5"  disabled="true"  value="%{listSportCjYdy[#status.index].yjlcj}"  /> <s:hidden name="listSportCjYdy[%{#status.index}].yjlcj" value="%{listSportCjYdy[#status.index].yjlcj}"/></td>
    				</s:else>
    			 </s:if>
    			
    				<%
    				//xsshzt 为空时 是 非集体项目登记 个人
    				//不为空是  集体姓名  代表团 或代表队  登记个人， 不显示 审核状态
    			%>
    			<s:if test="#xsshzt==null || #xsshzt=='' ">
			  		 	<td><nobr>&nbsp;<s:property value="listSportCjYdy[#status.index].shztCn"/></nobr><s:hidden  id="shzt_id%{#status.index}"value="%{listSportCjYdy[#status.index].shzt}"/></td>
			  		 </s:if>
    			<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].bz" id="bz_id" disabled="true" size="15" maxlength="15" value="%{listSportCjYdy[#status.index].bz}" /> <s:hidden name="listSportCjYdy[%{#status.index}].bz" value="%{listSportCjYdy[#status.index].bz}"/></td>
    			 <s:if test="%{#departid==null || #departid==''}">
    				 <td style="border-right:1px #D7D8D9 solid"><nobr>&nbsp;<s:radio name="listSportCjYdy[%{#status.index}].sfbjydhcj" disabled="true" list="#{'1':'是','0':'否'}" value="%{listSportCjYdy[#status.index].sfbjydhcj}" /><s:hidden name="listSportCjYdy[%{#status.index}].sfbjydhcj" value="%{listSportCjYdy[#status.index].sfbjydhcj}"/></nobr></td>
    			 </s:if>
    			</tr>
    		</s:if>
    		<s:else>
    	
    			<tr>
    			<td ><s:checkbox id="%{wid}" name="selectNode" fieldValue="%{wid}" onclick="changeQXHF()"/><s:hidden value="%{listSportCjYdy[#status.index].cjdw}" id="dw_cj_%{wid}"/></td>
    			<td><nobr>&nbsp;<s:property value="#status.index+1" /></nobr> <s:hidden name="listSportCjYdy[%{#status.index}].scbm" id="scbm_id" value="%{listSportCjYdy[#status.index].scbm}" /></td>
    			<td><nobr>&nbsp;<s:property value="listSportCjYdy[#status.index].ydyxm" /></nobr> <s:hidden name="listSportCjYdy[%{#status.index}].wid" id="wid" value="%{listSportCjYdy[#status.index].wid}" /></td>
    			<td><nobr>&nbsp;<s:property value="listSportCjYdy[#status.index].ssydy" />&nbsp;[<s:property value="listSportCjYdy[#status.index].zch" />]</nobr></td>

    			<s:if test="%{#departid==null || #departid==''}">
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].cj" id="cj_%{wid}" size="6" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,true);" maxLength="50" value="%{listSportCjYdy[#status.index].cj}"  onchange="checkCj()"  /></td>
    			</s:if>
    			<s:if test="%{#sc==2 &&(#departid==null || #departid=='')}">
		    		<s:if test="%{listSportCjYdy[#status.index].dxmmc=='击剑'}">
						<td>&nbsp;<s:select name="listSportCjYdy[%{#status.index}].mc" id="%{listSportCjYdy[#status.index].wid}_mc"  list="getSysCode('SCDFGZ_PMJB_JJ')" listKey="id" listValue="caption" />
		    				<input type="hidden" id="<s:property value='%{listSportCjYdy[#status.index].wid}' />_mc2" value="<s:property value='%{listSportCjYdy[#status.index].mc}'/>" />
		    			</td>
					</s:if>
					<s:else>
						<td>&nbsp;<s:select name="listSportCjYdy[%{#status.index}].mc" id="%{listSportCjYdy[#status.index].wid}_mc"  list="getSysCode('SCDFGZ_PMJB')" listKey="id" listValue="caption" />
		    			<input type="hidden" id="<s:property value='%{listSportCjYdy[#status.index].wid}' />_mc2" value="<s:property value='%{listSportCjYdy[#status.index].mc}'/>" />
		    			</td>						
					</s:else>
		    		
		    			
    			</s:if>
    			<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].bpxh" id="bpxh_id" size="8"   maxLength="50" value="%{listSportCjYdy[#status.index].bpxh}" />
    				<s:if test="%{#sc==2 &&(#departid==null || #departid=='')}"></s:if>
    				<s:else>
    					<s:hidden name="listSportCjYdy[%{#status.index}].mc" value="%{listSportCjYdy[#status.index].mc}" />
    				</s:else>
    				<s:if test="%{(#departid==null || #departid=='')}"></s:if>
    				<s:else>
    					<s:hidden name="listSportCjYdy[%{#status.index}].cj" value="%{listSportCjYdy[#status.index].cj}" /> 
    				</s:else>
    			</td>
    			<s:if test="%{#sc==2 &&(#departid==null || #departid=='')}" >
    				<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].df" id="df_id" size="5" disabled="true" cssStyle="ime-mode:disabled" onkeypress="NumberText(event,false,true);" value="%{listSportCjYdy[#status.index].df}" /><s:hidden name="listSportCjYdy[%{#status.index}].df" id="df_id"  value="%{listSportCjYdy[#status.index].df}" /></td>
    			</s:if>
    			<s:if test="%{#departid==null || #departid==''}" >
    				<td>&nbsp;<s:select name="listSportCjYdy[%{#status.index}].pjllx" list="getSysCode('YDY_PJLLX')" listKey="id" listValue="caption" value="%{listSportCjYdy[#status.index].pjllx}" onchange="changeYjlcl('yjlcl_id%{#status.index}',this)" /></td>
    				<s:if test="%{listSportCjYdy[#status.index].pjllx>0}">
    					<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].yjlcj" id="yjlcl_id%{#status.index}"size="5"  maxLength="50" value="%{listSportCjYdy[#status.index].yjlcj}" /></td>
    				</s:if>
    				<s:else>
    					<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].yjlcj" id="yjlcl_id%{#status.index}"size="5"  disabled="true"  maxLength="50" value="%{listSportCjYdy[#status.index].yjlcj}"  /></td>
    				</s:else>
    			</s:if>
    				<%
    				//xsshzt 为空时 是 非集体项目登记 个人
    				//不为空是  集体姓名  代表团 或代表队  登记个人， 不显示 审核状态
    			%>
    				<s:if test="#xsshzt==null || #xsshzt=='' ">
			  		 	<td><nobr>&nbsp;<s:property value="listSportCjYdy[#status.index].shztCn"/></nobr><s:hidden  id="shzt_id%{#status.index}" value="%{listSportCjYdy[#status.index].shzt}"/></td>
			  		 </s:if>
    			<td>&nbsp;<s:textfield name="listSportCjYdy[%{#status.index}].bz" id="bz_id" size="15" maxlength="15" value="%{listSportCjYdy[#status.index].bz}" /></td>
    			 <s:if test="%{#departid==null || #departid==''}">
    			 	<td style="border-right:1px #D7D8D9 solid"><nobr>&nbsp;<s:radio name="listSportCjYdy[%{#status.index}].sfbjydhcj"   list="#{'1':'是','0':'否'}" value="%{listSportCjYdy[#status.index].sfbjydhcj}"  /></nobr>
    					<input type="hidden" id="<s:property value='%{listSportCjYdy[#status.index].wid}' />_sfbj" value="<s:property value='%{listSportCjYdy[#status.index].sfbjydhcj}'/>" />
    				</td>
    			 </s:if>
    			</tr>
    		</s:else>
    	</s:iterator>