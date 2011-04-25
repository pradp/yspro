<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	<script type="text/javascript">
	
	function openPage(uri){
		openWindow(uri,1000,600);
	}
	function openPage1(uri){
		window.open(uri);
	}
	function changeStyle(obj){
		obj.style.color="#7CFC00";
	}
	function changeStyle2(obj){
		obj.style.color="#000000";
	}
	function getDxmmc(obj){
		if(obj.value != ''){
			var bssj = document.getElementById("bssj_hidden").value;
			var cssS = document.getElementById("cssS").value;
			var uri = "../visitor/sportCjcxRc-list.c?dxmmc="+obj.value+"&bssj="+bssj+"&cssS="+cssS+"departid=<s:property value='areaid'/>&cssS=<s:property value='%{#parameters.cssS[0]}'/>";
			location.href=uri;
		}
	}
	function getDxmmcWithOutTime(){
		var obj = document.getElementById("dxmmc_hidden").value;
		var cssS = document.getElementById("cssS").value;
			var uri = "../visitor/sportCjcxRc-list.c?dxmmc="+obj+"&cssS="+cssS+"departid=<s:property value='areaid'/>&cssS=<s:property value='%{#parameters.cssS[0]}'/>&mi=<s:property value='mi' />";
			location.href=uri;
	}
	function tofind(state){
		var obj = document.getElementById("dxmmc_hidden").value;
		var xxm = document.getElementById("xxm").value;
		var zb = document.getElementById("zb").value;
		var xbz = document.getElementById("xbz").value;
		var bssj = document.getElementById("bssj_hidden").value;
		var bssj1 = document.getElementById("bssj").value;
		var cssS = document.getElementById("cssS").value;
		var sfjsbs = document.getElementById("kindJS").value;
		var paixu = document.getElementById("paixu").value;
		if((bssj1!=null && bssj1!='')&&state!='1'){
			bssj = bssj1;
			var uri = "../visitor/sportCjcxRc-list.c?dxmmc="+obj+"&cssS="+cssS+"departid=<s:property value='areaid'/>&cssS=<s:property value='%{#parameters.cssS[0]}'/>&mi=<s:property value='mi' />&sportSsrc.xxmmc="+xxm+"&sportSsrc.zb="+zb+"&sportSsrc.xbz="+xbz+"&bssj="+bssj+"&sfjsbs="+sfjsbs+"&paixu="+paixu;
	        location.href=uri;
		}else if((bssj1==null || bssj1=='')&& state!='1'){
			getDxmmcWithOutTime();
		}else if(state=='1'){
			var uri = "../visitor/sportCjcxRc-list.c?dxmmc="+obj+"&cssS="+cssS+"departid=<s:property value='areaid'/>&cssS=<s:property value='%{#parameters.cssS[0]}'/>&mi=<s:property value='mi' />&sportSsrc.xxmmc="+xxm+"&sportSsrc.zb="+zb+"&sportSsrc.xbz="+xbz+"&bssj="+bssj+"&sfjsbs="+sfjsbs+"&paixu="+paixu;
	        location.href=uri;
		}
	}

	function changeColor(obj){
		obj.style.color="red";
	}
	function changeColor2(obj){
		obj.style.color="blue";
	}
	
	function getZbByTime (){

		if(document.getElementById("zb")){
		ajaxService.getBsxmZbByTime($("#dxmmc_hidden").val(),$("#bssj").val(),function (data){
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			DWRUtil.removeAllOptions('zb');
			DWRUtil.addOptions( 'zb', data,'id','caption');
			var obj1 = document.getElementById("zb_jq");
			if(obj1.value!=null && obj1.value!=''){
				DWRUtil.setValue('zb',obj1.value);
				obj1.value='';
			}
			$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
				getXbzByTimeZb();
		});

		}

	}
	function getXbzByTimeZb (){

		if(document.getElementById("zb")){
		ajaxService.getXbzByTimeZb($("#dxmmc_hidden").val(),$("#bssj").val(),$("#zb").val(),function (data){
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			DWRUtil.removeAllOptions('xbz');
			DWRUtil.addOptions( 'xbz', data,'id','caption');
			var obj1 = document.getElementById("xbz_jq");
			if(obj1.value!=null && obj1.value!=''){
				DWRUtil.setValue('xbz',obj1.value);
				obj1.value='';
			}
			$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
				getXxmmcByTimeZbXbz();
		});

		}

	}
	
	function getXxmmcByTimeZbXbz (){

		if(document.getElementById("zb")){
		ajaxService.getXxmmcByTimeZbXbz($("#dxmmc_hidden").val(),$("#bssj").val(),$("#zb").val(),$("#xbz").val(),function (data){
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			DWRUtil.removeAllOptions('xxm');
			DWRUtil.addOptions( 'xxm', data,'id','caption');
			var obj1 = document.getElementById("xxm_jq");
			if(obj1.value!=null && obj1.value!=''){
				DWRUtil.setValue('xxm',obj1.value);
				obj1.value='';
			}
			$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
			
		});

		}

	}

	//展开
		function openhidden(id){
			
			var str = "#picss_"+id;
			$("tr[id^='display_"+id+"_']").each(function(){
				$(this).toggle();
			});
			var imgsorce = "<img  style='cursor: pointer;'  src='"+$("#basePath").val()+"/resources/images/minus.gif' onclick='closehidden("+id+")' />";
			$(str).html(imgsorce);
		}
	//关闭
		function closehidden(id){
			var str = "#picss_"+id;
			$("tr[id^='display_"+id+"_']").each(function(){
				$(this).toggle();
			});
			var imgsorce = "<img  style='cursor: pointer;'  src='"+$("#basePath").val()+"/resources/images/add.gif' onclick='openhidden("+id+")' />";
			$(str).html(imgsorce);
		}
		function leftTooltipScroll(){   
			document.getElementById("leftTooltip").style.top=((document.documentElement.scrollTop+470))+"px";   
		}
		window.onscroll=leftTooltipScroll;
	</script>
	
	<div id="leftTooltip" style="position:absolute; top:530px; left:20px;">
		<img src="<s:property value="basePath"/>/resources/images/pages/2left.png" alt="" />
	</div>
   <div class="grid_12 alpha" style="width:100%;">
    <input type="hidden" id="cssS" value="<s:property value='#parameters.cssS[0]' />" />
    <input type="hidden" id="zb_jq" value="<s:property value='sportSsrc.zb' />" />
    <input type="hidden" id="xbz_jq" value="<s:property value='sportSsrc.xbz' />" />
    <input type="hidden" id="xxm_jq" value="<s:property value='sportSsrc.xxmmc' />" />
    <input type="hidden" id="basePath" value="<s:property value='basePath' />" />
    <%int i=1; %>
   <s:if test="#dxmmcList.size()>0" >
   <div><span style="color: gray;">以上用</span> * <span style="color: gray;">标记的项目为当日比赛项目，用</span><span style="color: #FF9700;">橙色</span><span style="color: gray;">标记表示当前查询的项目</span></div>
   </s:if>
    <s:if test="#dxmmc!=null && #dxmmc!=''" >
	<table>
		<tr>
		<td style="background: white;" >
		<s:select  list="getBssjList()"  id="bssj" listKey="id" listValue="caption" headerKey="all" headerValue="请选择%{#dxmmc}比赛时间" name="bssj" onchange="getZbByTime()" ></s:select></td><td  style="background: white;">
		</td><s:if test="#dxmmc!=null && #dxmmc!='' "><td style="background: white;" >
		<s:select  list="#{}" id="zb"  listKey="id" listValue="caption" headerKey="" headerValue="--请选择 组别--" name="sportSsrc.zb" onchange="getXbzByTimeZb()" ></s:select></td><td  style="background: white;">
		<s:select  list="#{}" id="xbz" listKey="id" headerKey="" headerValue="--请选择 性别组--" listValue="caption" name="sportSsrc.xbz" onchange="getXxmmcByTimeZbXbz()"></s:select></td><td  style="background: white; ">
		<s:select  list="#{}" id="xxm" listKey="id" listValue="caption" headerKey="" headerValue="--请选择 级（赛）别--" name="sportSsrc.xxmmc"></s:select></td><td  style="background: white; ">
		<s:select  list="getBsLx()" id="kindJS"  headerKey="" headerValue="--是否结束--" name="sfjsbs"></s:select></td><td  style="background: white;" valign="baseline">
		<img src="<s:property value="basePath"/>/resources/images/gif-0083.gif" style=" cursor: pointer;vertical-align: -5px;  "  onclick="tofind()" title="查询" /></td>
		</s:if></tr>
		<s:if test="#dxmmc!=null && #dxmmc!='' "><td style="background: white;" >
		<tr>
			<td style="background: white; font-size: 12px;" ><s:textfield name="paixu" id="paixu" cssStyle="display: none;"></s:textfield>
				<s:if test="paixu==0"><b>按时间排列</b>&nbsp;&nbsp;|&nbsp;&nbsp;<span style="cursor: pointer;text-decoration:underline;" onclick="$('#paixu').val('1');tofind('1');">按小项排列</span></s:if><s:elseif test="paixu==1"><span onclick="$('#paixu').val('0');tofind('1'); " style="cursor: pointer; text-decoration: underline;">按时间排列</span>&nbsp;&nbsp;|&nbsp;&nbsp;<b>按小项排列</b></s:elseif>
			</td>
		</tr>
		</s:if>
	</table></s:if>
   <s:hidden id="bssj_hidden" name="bssj"/>
   <input type="hidden" id="dxmmc_hidden"  value="<s:property value="dxmmc" />"/>
   <s:if test="paixu==0">
   <s:if test="resultData!=null && resultData.size()>0">
   <s:iterator value="resultData" status="status">
       <table class="subTab" id="mainTable" summary="成绩单" width="100%">
         <tr>
           <th colspan="10" abbr="日期" class="matchDate"><s:property value="resultData[#status.index].caption" /></th>
         </tr>
         <tr>
         <th scope="col" abbr="序号" class="ccmd" width="10%" >序号</th>
           <th scope="col" abbr="时间" class="ccmd" width="10%" >时间</th>
           <th scope="col" abbr="项目" class="ccmd" width="15%">项目</th>
           <th scope="col" abbr="组别" class="ccmd" width="15%">组别</th>
           <th scope="col" abbr="性别" class="ccmd" width="10%">性别</th>
           <th scope="col" abbr="级（赛）别" class="ccmd" width="40%" >级（赛）别</th>
         </tr>
    	<s:iterator value="#xmfz" status="stts">
      	<s:if test="%{resultData[#status.index].id==#xmfz[#stts.index][5].toString()}" >
    		<tr>
	           	<td><span id="picss_<%=i %>"><img  style="cursor: pointer;"  src="<s:property value="basePath" />/resources/images/add.gif" onclick="openhidden(<%=i %>)" /></span>&nbsp;<%=i %></td>
	    	    <td><s:property value="#xmfz[#stts.index][0].toString()" /></td>
	    	    <td><s:property value="#xmfz[#stts.index][1].toString()" /></td>
	    	    <td><s:property value="#xmfz[#stts.index][2].toString()" /></td>
	    	    <td><s:property value="#xmfz[#stts.index][3].toString()" /></td>
	    	    <td>&nbsp;<s:property value="#xmfz[#stts.index][4].toString()" /></td>
        	</tr>
        	<s:iterator value="#listData" status="st">
    		<s:if test="%{#xmfz[#stts.index][5].toString()==#listData[#st.index][10].toString() && #xmfz[#stts.index][6].toString()==#listData[#st.index][#listData[#st.index].length-2].toString()}" >
        <tr id="display_<%=i %>_<s:property value='#st.index' />" style="display: none">
        		<td style="border: none; border-left: 1px #CCDBDB solid; border-bottom: 1px #CCDBDB solid;  text-align: right;" colspan="2"><s:property value="#listData[#st.index][0].toString()" /></td>
				<td style="border: none; border-bottom: 1px #CCDBDB solid;" colspan="2"><s:property  value="#listData[#st.index][16].toString()" /> </td>
				<td style="border: none; border-bottom: 1px #CCDBDB solid;" ><s:property value="#listData[#st.index][1].toString()" /></td>
    	    	<td style="text-align: center; border: none; border-right: 1px #CCDBDB solid; border-bottom: 1px #CCDBDB solid;" colspan="2">
    				<s:if test="#listData[#st.index][1].toString()=='决赛'" >
    	 			 <s:if test="#listData[#st.index][8]==null || #listData[#st.index][8].toString()!=3 " >
    	 				 <s:if test="#listData[#st.index][14]!=1 && #listData[#st.index][19]!=null "><s:property value="#listData[#st.index][19].toString()" /></s:if><s:else>---</s:else>
    	 			 </s:if>
			    	  <s:else>
			    		<a href="../visitor/sportCjcxRc-input.c?dxmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" />&scbm=<s:property value="#listData[#st.index][9].toString()" />&type=jscj&xmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" />&sfjs=1&wid=&bssj=<s:property value="#bssj2" />&mi=<s:property value="getMi(#bssj2.toString())" />&cssS=<s:property value='%{#parameters.cssS[0]}'/>&sfdzxm=<s:property value='#listData[#st.index][11].toString()'/>&sfxnsc=<s:property value='#listData[#st.index][14].toString()'/>&sfjtxm=<s:property value='#listData[#st.index][17]' />&totalXm=<s:property value='#listData[#st.index][10]' />+<s:property value="#listData[#st.index][0].toString()" />+<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][2].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][3].toString(),'utf-8')" /><s:if test="%{#listData[#st.index][3]!=null && #listData[#st.index][3]!=''}" ><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /></s:if><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][1].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][16].toString(),'utf-8')" />" target="_blank">名次公告</a>
			    	  </s:else>
			    	</s:if>
			    	<s:else>
			          <s:if test="#listData[#st.index][11].toString()==1" >
			    		<s:if test="(#listData[#st.index][6]==null || #listData[#st.index][6].toString()=='')&& #listData[#st.index][8].toString()!=3 " >
			    			<s:property value="#listData[#st.index][19].toString()" />
			    		</s:if>
			    		<s:elseif test="#listData[#st.index][8].toString()==3 && #listData[#st.index][14].toString()==0 && #listData[#st.index][17].toString()==0" >
			    			 <a href="../visitor/sportCjcxRc-input.c?dxmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" />&scbm=<s:property value='#listData[#st.index][9].toString()' />&type=cj&xmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" />&wid=&bssj=<s:property value="#bssj2" />&mi=<s:property value="getMi(#bssj2.toString())" />&cssS=<s:property value='%{#parameters.cssS[0]}'/>&sfdzxm=<s:property value='#listData[#st.index][11].toString()'/>&sfxnsc=<s:property value='#listData[#st.index][14].toString()'/>&sfjtxm=<s:property value='#listData[#st.index][17]' />&totalXm=<s:property value='#listData[#st.index][10]' />+<s:property value="#listData[#st.index][0].toString()" />+<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][2].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][3].toString(),'utf-8')" /><s:if test="%{#listData[#st.index][3]!=null && #listData[#st.index][3]!=''}" ><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /></s:if><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][1].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][16].toString(),'utf-8')" />" target="_blank">成绩公告</a>
			    		</s:elseif>
			    		<s:else>
			    		  <a href="../visitor/sportCjcxRc-input.c?dxmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" />&scbm=<s:property value='#listData[#st.index][9].toString()' />&type=cj&xmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" />&wid=&bssj=<s:property value="#bssj2" />&mi=<s:property value="getMi(#bssj2.toString())" />&cssS=<s:property value='%{#parameters.cssS[0]}'/>&sfdzxm=<s:property value='#listData[#st.index][11].toString()'/>&sfxnsc=<s:property value='#listData[#st.index][14].toString()'/>&sfjtxm=<s:property value='#listData[#st.index][17]' />&totalXm=<s:property value='#listData[#st.index][10]' />+<s:property value="#listData[#st.index][0].toString()" />+<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][2].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][3].toString(),'utf-8')" /><s:if test="%{#listData[#st.index][3]!=null && #listData[#st.index][3]!=''}" ><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /></s:if><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][1].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][16].toString(),'utf-8')" />" target="_blank"><s:property value="#listData[#st.index][6].toString()" /></a>
			    		</s:else>
			    	  </s:if>
			    	  <s:else>
			    	   <s:if test="#listData[#st.index][8].toString()!=3">---</s:if>
			    		<s:elseif test="#listData[#st.index][8].toString()==3">
			    		  <a href="../visitor/sportCjcxRc-input.c?dxmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" />&scbm=<s:property value="#listData[#st.index][9].toString()" />&type=cj&xmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" />&wid=&bssj=<s:property value="#bssj2" />&mi=<s:property value="getMi(#bssj2.toString())" />&cssS=<s:property value='%{#parameters.cssS[0]}'/>&sfdzxm=<s:property value='#listData[#st.index][11].toString()'/>&sfxnsc=<s:property value='#listData[#st.index][14].toString()'/>&sfjtxm=<s:property value='#listData[#st.index][17]' />&totalXm=<s:property value='#listData[#st.index][10]' />+<s:property value="#listData[#st.index][0].toString()" />+<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][2].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][3].toString(),'utf-8')" /><s:if test="%{#listData[#st.index][3]!=null && #listData[#st.index][3]!=''}" ><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /></s:if><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][1].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][16].toString(),'utf-8')" />" target="_blank">成绩公告</a>
			    		</s:elseif></s:else></s:else></td></tr></s:if></s:iterator><%i++; %></s:if>
			    		</s:iterator></table></s:iterator>
	</s:if>
	<s:else>
   		<table class="subTab" id="mainTable" summary="成绩单">
         <tr>
           <th colspan="10" abbr="日期" class="matchDate"><s:property value="bssj" /></th>
         </tr>
         <tr>
         <th scope="col" abbr="序号" class="ccmd" width="10%" >序号</th>
           <th scope="col" abbr="时间" class="ccmd" width="15%" >时间</th>
           <th scope="col" abbr="项目" class="ccmd" width="15%">项目</th>
           <th scope="col" abbr="组别" class="ccmd" width="15%">组别</th>
           <th scope="col" abbr="性别" class="ccmd" width="10%">性别</th>
           <th scope="col" abbr="级（赛）别" class="ccmd" width="40%" >级（赛）别</th>
         </tr>
         <tr>
           <td  colspan="10" abbr="说明"  class="matchDate">当日 “<s:property value="@java.net.URLDecoder@decode(dxmmc,'UTF-8')" />”项目无比赛，点击“查询”按钮查询其它时间段赛事！</td>
         </tr>
     </table>
   </s:else>
	</s:if>
	<s:elseif test="paixu=1">
		<s:if test="#xmfz!=null && #xmfz.size()>0">
       <table class="subTab" id="mainTable" summary="成绩单" width="100%">
         <tr>
         <th scope="col" abbr="序号" class="matchDate" width="15%" >序号</th>
           <th scope="col" abbr="项目" class="matchDate" width="20%">项目</th>
           <th scope="col" abbr="组别" class="matchDate" width="20%">组别</th>
           <th scope="col" abbr="性别" class="matchDate" width="10%">性别</th>
           <th scope="col" abbr="级（赛）别" class="matchDate" width="40%" >级（赛）别</th>
         </tr>
    	<s:iterator value="#xmfz" status="stts">
    		<tr>
	           	<td><span id="picss_<%=i %>"><img  style="cursor: pointer;"  src="<s:property value="basePath" />/resources/images/add.gif" onclick="openhidden(<%=i %>)" /></span>&nbsp;<%=i %></td>
	    	    <td><s:property value="#xmfz[#stts.index][1].toString()" /></td>
	    	    <td><s:property value="#xmfz[#stts.index][2].toString()" /></td>
	    	    <td><s:property value="#xmfz[#stts.index][3].toString()" /></td>
	    	    <td>&nbsp;<s:property value="#xmfz[#stts.index][4].toString()" /></td>
        	</tr>
        	<s:iterator value="#listData" status="st">
    		<s:if test="%{#xmfz[#stts.index][6].toString()==#listData[#st.index][#listData[#st.index].length-2].toString()}" >
        <tr id="display_<%=i %>_<s:property value='#st.index' />" style="display: none">
        		<td style="border: none; border-left: 1px #CCDBDB solid; border-bottom: 1px #CCDBDB solid;  text-align: right;" ><s:property value="#listData[#st.index][10].toString()" /> <s:property value="#listData[#st.index][0].toString()" /></td>
				<td style="border: none; border-bottom: 1px #CCDBDB solid;" colspan="2"><s:property  value="#listData[#st.index][16].toString()" /> </td>
				<td style="border: none; border-bottom: 1px #CCDBDB solid;" ><s:property value="#listData[#st.index][1].toString()" /></td>
    	    	<td style="text-align: center; border: none; border-right: 1px #CCDBDB solid; border-bottom: 1px #CCDBDB solid;" colspan="2">
    				<s:if test="#listData[#st.index][1].toString()=='决赛'" >
    	 			  <s:if test="#listData[#st.index][8]==null || #listData[#st.index][8].toString()!=3 " >
    	 				 <s:if test="#listData[#st.index][14]!=1 && #listData[#st.index][19]!=null "><s:property value="#listData[#st.index][19].toString()" /></s:if><s:else>---</s:else>
    	 			 </s:if>
			    	  <s:else>
			    		<a href="../visitor/sportCjcxRc-input.c?dxmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" />&scbm=<s:property value="#listData[#st.index][9].toString()" />&type=jscj&xmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" />&sfjs=1&wid=&bssj=<s:property value="#bssj2" />&mi=<s:property value="getMi(#bssj2.toString())" />&cssS=<s:property value='%{#parameters.cssS[0]}'/>&sfdzxm=<s:property value='#listData[#st.index][11].toString()'/>&sfxnsc=<s:property value='#listData[#st.index][14].toString()'/>&sfjtxm=<s:property value='#listData[#st.index][17]' />&totalXm=<s:property value='#listData[#st.index][10]' />+<s:property value="#listData[#st.index][0].toString()" />+<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][2].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][3].toString(),'utf-8')" /><s:if test="%{#listData[#st.index][3]!=null && #listData[#st.index][3]!=''}" ><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /></s:if><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][1].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][16].toString(),'utf-8')" />" target="_blank">名次公告</a>
			    	  </s:else>
			    	</s:if>
			    	<s:else>
			          <s:if test="#listData[#st.index][11].toString()==1" >
			    		<s:if test="(#listData[#st.index][6]==null || #listData[#st.index][6].toString()=='')&& #listData[#st.index][8].toString()!=3 " >
							<s:property value="#listData[#st.index][19].toString()" />
						</s:if>
			    		<s:elseif test="#listData[#st.index][8].toString()==3 && #listData[#st.index][14].toString()==0 && #listData[#st.index][17].toString()==0" >
			    			 <a href="../visitor/sportCjcxRc-input.c?dxmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" />&scbm=<s:property value='#listData[#st.index][9].toString()' />&type=cj&xmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" />&wid=&bssj=<s:property value="#bssj2" />&mi=<s:property value="getMi(#bssj2.toString())" />&cssS=<s:property value='%{#parameters.cssS[0]}'/>&sfdzxm=<s:property value='#listData[#st.index][11].toString()'/>&sfxnsc=<s:property value='#listData[#st.index][14].toString()'/>&sfjtxm=<s:property value='#listData[#st.index][17]' />&totalXm=<s:property value='#listData[#st.index][10]' />+<s:property value="#listData[#st.index][0].toString()" />+<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][2].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][3].toString(),'utf-8')" /><s:if test="%{#listData[#st.index][3]!=null && #listData[#st.index][3]!=''} " ><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /></s:if><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][1].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][16].toString(),'utf-8')" />" target="_blank">成绩公告</a>
			    		</s:elseif>
			    		<s:else>
			    		  <a href="../visitor/sportCjcxRc-input.c?dxmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" />&scbm=<s:property value='#listData[#st.index][9].toString()' />&type=cj&xmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" />&wid=&bssj=<s:property value="#bssj2" />&mi=<s:property value="getMi(#bssj2.toString())" />&cssS=<s:property value='%{#parameters.cssS[0]}'/>&sfdzxm=<s:property value='#listData[#st.index][11].toString()'/>&sfxnsc=<s:property value='#listData[#st.index][14].toString()'/>&sfjtxm=<s:property value='#listData[#st.index][17]' />&totalXm=<s:property value='#listData[#st.index][10]' />+<s:property value="#listData[#st.index][0].toString()" />+<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][2].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][3].toString(),'utf-8')" /><s:if test="%{#listData[#st.index][3]!=null && #listData[#st.index][3]!=''} " ><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /></s:if><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][1].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][16].toString(),'utf-8')" />" target="_blank"><s:property value="#listData[#st.index][6].toString()" /></a>
			    		</s:else>
			    	  </s:if>
			    	  <s:else>
			    	   <s:if test="#listData[#st.index][8].toString()!=3">---</s:if>
			    		<s:elseif test="#listData[#st.index][8].toString()==3">
			    		  <a href="../visitor/sportCjcxRc-input.c?dxmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" />&scbm=<s:property value="#listData[#st.index][9].toString()" />&type=cj&xmmc=<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" />&wid=&bssj=<s:property value="#bssj2" />&mi=<s:property value="getMi(#bssj2.toString())" />&cssS=<s:property value='%{#parameters.cssS[0]}'/>&sfdzxm=<s:property value='#listData[#st.index][11].toString()'/>&sfxnsc=<s:property value='#listData[#st.index][14].toString()'/>&sfjtxm=<s:property value='#listData[#st.index][17]' />&totalXm=<s:property value='#listData[#st.index][10]' />+<s:property value="#listData[#st.index][0].toString()" />+<s:property value="@java.net.URLEncoder@encode(#listData[#st.index][12].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][2].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][3].toString(),'utf-8')" /><s:if test="%{#listData[#st.index][3]!=null && #listData[#st.index][3]!=''} " ><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /></s:if><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][4].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][1].toString(),'utf-8')" /><s:property value="@java.net.URLEncoder@encode('、','utf-8')" /><s:property value="@java.net.URLEncoder@encode(#listData[#st.index][16].toString(),'utf-8')" />" target="_blank">成绩公告</a>
			    		</s:elseif></s:else></s:else></td></tr></s:if></s:iterator><%i++; %>
			    		</s:iterator></table>
		</s:if>
		<s:else>
			<table class="subTab" id="mainTable" summary="成绩单">
		         <tr>
		           <th scope="col" abbr="序号" class="matchDate" width="15%" >序号</th>
		           <th scope="col" abbr="项目" class="matchDate" width="20%">项目</th>
		           <th scope="col" abbr="组别" class="matchDate" width="20%">组别</th>
		           <th scope="col" abbr="性别" class="matchDate" width="10%">性别</th>
		           <th scope="col" abbr="级（赛）别" class="matchDate" width="40%" >级（赛）别</th>
		         </tr>
		         <tr>
		           <td  colspan="10" abbr="说明"  class="matchDate">当日 “<s:property value="@java.net.URLDecoder@decode(dxmmc,'UTF-8')" />”项目无比赛，点击“查询”按钮查询其它时间段赛事！</td>
		         </tr>
		     </table>
		</s:else>
	</s:elseif>
	
  
  </div>
<script>
		getZbByTime();
</script>
