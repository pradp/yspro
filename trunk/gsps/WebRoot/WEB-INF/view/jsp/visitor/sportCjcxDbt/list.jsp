<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<% int i=0; %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" >

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="author" content="" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="robots" content="all" />
	<title>江苏省第十七届运动会综合成绩榜</title>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/960.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/reset.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/text.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/main.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/saicheng.css" type="text/css" media="all" />
	<script type="text/javascript">
	listPageStyle();
	
	function openPage(departid,sx){	
		var cssS = document.getElementById('cssS').value;
		window.location.href="../visitor/sportCjcxDbt-list.c?cssS="+cssS+"&departid="+departid+"&sx="+sx+"&reqtime="+(new Date());
		//window.open("../visitor/sportCjcxPjl-list.c?wid="+wid);
		//document.forms[0].action="../visitor/sportCjcxPjl-list.c?wid="+wid+"&reqtime="+(new Date());
		//alert(document.forms[0].action);
		//document.forms[0].submit();
	}

	function openPage(uri){
		openWindow(uri,850,450);
	}

	function openPage1(uri){
		window.open(uri);
	}

	function openPage2(uri){
		omvc = window.open(uri, 'newwindow', 'height=700, width=600, top=50, left=100, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
		omvc.focus();
	}
//计算总得牌得分
	function getzhFF(){
		var jp1 = 0;
		if(document.getElementById('Hz11')){
			jp1 = document.getElementById('Hz11').value; 
		}
		var jp2 = 0;
		if(document.getElementById('Drcj10')){
			jp2 = document.getElementById('Drcj10').value;
		}
		var jp3 = 0;
		if(document.getElementById('SxDrcj8')){
			jp3 = document.getElementById('SxDrcj8').value;
		}
		var jphz = parseFloat(jp1)+parseFloat(jp2)+parseFloat(jp3);
		var yp1 = 0;
		if(document.getElementById('Hz12')){
			yp1 = document.getElementById('Hz12').value; 
		}
		var yp2 = 0;
		if(document.getElementById('Drcj11')){
			yp2 = document.getElementById('Drcj11').value;
		}
		var yphz = parseFloat(yp1)+parseFloat(yp2);
		var tp1 = 0;
		if(document.getElementById('Hz13')){
			tp1 = document.getElementById('Hz13').value; 
		}
		var tp2 = 0;
		if(document.getElementById('Drcj12')){
			tp2 = document.getElementById('Drcj12').value;
		}
		var tphz = parseFloat(tp1)+parseFloat(tp2);
		var df1 = 0;
		if(document.getElementById('Hz10')){
			df1 = document.getElementById('Hz10').value; 
		}
		var df2 = 0;
		if(document.getElementById('Drcj13')){
			df2 = document.getElementById('Drcj13').value;
		}
		var df3 = 0;
		if(document.getElementById('SxDrcj9')){
			df3 = document.getElementById('SxDrcj9').value;
		}	
		var dfhz = parseFloat(df1)+parseFloat(df2)+parseFloat(df3);
		if(document.getElementById('hzjp')) document.getElementById('hzjp').innerHTML = jphz;
		if(document.getElementById('hzyp')) document.getElementById('hzyp').innerHTML = yphz;
		if(document.getElementById('hztp')) document.getElementById('hztp').innerHTML = tphz;
		if(document.getElementById('hzdf')) document.getElementById('hzdf').innerHTML = dfhz;
	}
	
	function csh(xm_span, wid_xm){
		if(wid_xm!=""){
			var wid_xms = wid_xm.split(",");//wid_xm,wid_xm....
			var uri = '';
			for(i=0;i<wid_xms.length;i++){
				var wm = wid_xms[i].split("_");//wid xm
				var url1 = "../visitor/sportCjcxYdyxx-input.c?wid=" + wm[0];
				uri = uri + " <a href='#' onclick=\"openPage2('"+url1+"')\" ><font color='blue'>"+wm[1]+"</font></a> ";
			}
			document.getElementById(xm_span).innerHTML=""+uri;
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
	//数值的加运算
	function accAdd(arg1,arg2){
	    var r1,r2,m;
	    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
	    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
	    m=Math.pow(10,Math.max(r1,r2))
	    return (arg1*m+arg2*m)/m
	}
	//数值转换
	function con (val,id){
		var lastval = accAdd(val,0);
		if(lastval==null || lastval==''){
			lastval = "0";
		}
		$("#"+id).html(lastval);
	}
	//判断是否显示new 图标
	function displayNewIcon(childDateId,childImgId,fatherId){
		//alert(childDateId+"~"+childImgId+"~"+fatherId);
		//if(document.getElementById(childDateId) && document.getElementById(childImgId) && document.getElementById(fatherId)){
		//	alert($("#"+childDateId).val()+" = "+$("#"+nowtime).val());
			if($("#"+childDateId).val()==$("#nowtime").val()){
				$("#"+fatherId).html("<img src='<s:property value='basePath' />/resources/images/member/new.gif' />");
				$("#"+childImgId).html("<img src='<s:property value='basePath' />/resources/images/member/new.gif' />");
			}
		//}
	}

	function toDisabled(index){
		document.getElementById("id_"+index).style.display = 'none';
	}
	
	window.onload=getzhFF;
	</script>
	
	<style type="text/css">
	
		#shi {
			border-bottom: 1px solid #3b9dca;
		}
	</style>
    
</head>
<body >


<div class="container_16">
		<!-- 导入head 区域  head.jsp-->
			<jsp:include page="../common/head.jsp" flush="true"></jsp:include>
		<!-- 导入head 区域-->
<div id="container" class="grid_16"><!-- container begin -->
   <input type="hidden" id="basePath" value="<s:property value='basePath' />" />
  	<s:hidden id="nowtime" value="%{@com.imchooser.util.DateUtil@currentDateString()}"></s:hidden>
  
	<!-- 主体内容区域  开始 -->
  <s:if test=" #sx=='1'.toString() && #departid!=null ">
  <div id="shi" class="grid_16 alpha omega">
 	<ul>
 		<s:iterator value="resultData"  status="i">
			 <li>
			 	<a href='../visitor/sportCjcxDbt-list.c?jp=3&departid=<s:property value="areaid"/>&sx=<s:property value="#sx"/>&cssS=<s:property value="%{#parameters.cssS[0]}"/>' <s:if test="areaid == #departid"> class="active" </s:if> <s:if test="areaid==#parameters.departid[0]"> class="active" </s:if> >
					<s:property value="areaname"/>
				</a>
			 </li>
		</s:iterator>
 		
	 </ul>
  </div>
   <div id="qu" class="grid_16 alpha omega" >
  	  <ul>
  	  	<s:iterator value="re"  status="stat">
	  	  	<li>
		  	  	<a href='../visitor/sportCjcxDbt-list.c?jp=3&departid=<s:property value="#re[#stat.index][0]"/>&sx=<s:property value="#sx"/>&cssS=<s:property value="%{#parameters.cssS[0]}"/>' <s:if test="#re[#stat.index][0]==#parameters.departid[0]"> class="active" </s:if> >
					<s:property value="#re[#stat.index][1]"/>
				</a>
			</li>
  	  	</s:iterator>
  	  </ul>
  </div>
  </s:if>
  <s:else>
  
 <div id="shi" class="grid_16 alpha omega">
 	<ul>
 		<s:iterator value="resultData"  status="i">
			 <li>
	 				<a href='<s:property value="@com.imchooser.infoms.util.GetDbtUrl@getUrl(areaid)" />' <s:if test="areaid == #departid"> class="active" </s:if><s:if test="areaid == #parameters.departid[0]"> class="active" </s:if> >
						<s:property value="areaname"/>
					</a>
			 </li>
		</s:iterator>
	 </ul>
  </div>
  <div>
  	&nbsp;
  </div>
  </s:else>
   
  <!-- 赛事日程 -->
  
  <div id="saichengxx" class="grid_16 alpha omega">
       <table class="subTab" id="mainTable" summary="今日赛程" style="width: 100%" >
         <tr class="top">
         	<th colspan="9" >
         	<s:if test=" #sx!='1'.toString() ">
	         	<s:if test="#parameters.jp[0] == 0"><s:iterator value="resultData"  status="i"><s:if test="areaid == #departid || areaid == #parameters.departid[0]"><s:property value="areaname" /></s:if></s:iterator>代表团决赛金牌合计：
	         	</s:if>
	         	<s:if test="#parameters.jp[0] == 1"><s:iterator value="resultData"  status="i"><s:if test="areaid == #departid || areaid == #parameters.departid[0]"><s:property value="areaname" /></s:if></s:iterator>代表团决赛银牌合计：
	         	</s:if>
	         	<s:if test="#parameters.jp[0] == 2"><s:iterator value="resultData"  status="i"><s:if test="areaid == #departid || areaid == #parameters.departid[0]"><s:property value="areaname" /></s:if></s:iterator>代表团决赛铜牌合计：
	         	</s:if>
	         	<s:if test="#parameters.jp[0] == 3 ||#parameters.jp[0] == 4"><s:iterator value="resultData"  status="i"><s:if test="areaid == #departid || areaid == #parameters.departid[0]"><s:property value="areaname"/></s:if></s:iterator>代表团决赛得牌得分合计：
	         	</s:if>
         	</s:if>
         	<s:elseif test=" #sx=='1'.toString() ">
         		<s:if test="#parameters.jp[0] == 0"><s:iterator value="resultData"  status="i"><s:if test="areaid == #departid || areaid == #parameters.departid[0]"><s:property value="areaname" /></s:if></s:iterator><s:iterator value="re"  status="stat"><s:if test="#re[#stat.index][0]==#parameters.departid[0]"><s:property value="#re[#stat.index][1]"/></s:if></s:iterator>决赛金牌合计：
	         	</s:if>
	         	<s:if test="#parameters.jp[0] == 1"><s:iterator value="resultData"  status="i"><s:if test="areaid == #departid || areaid == #parameters.departid[0]"><s:property value="areaname" /></s:if></s:iterator><s:iterator value="re"  status="stat"><s:if test="#re[#stat.index][0]==#parameters.departid[0]"><s:property value="#re[#stat.index][1]"/></s:if></s:iterator>决赛银牌合计：
	         	</s:if>
	         	<s:if test="#parameters.jp[0] == 2"><s:iterator value="resultData"  status="i"><s:if test="areaid == #departid || areaid == #parameters.departid[0]"><s:property value="areaname" /></s:if></s:iterator><s:iterator value="re"  status="stat"><s:if test="#re[#stat.index][0]==#parameters.departid[0]"><s:property value="#re[#stat.index][1]"/></s:if></s:iterator>决赛铜牌合计：
	         	</s:if>
	         	<s:if test="#parameters.jp[0] == 3 ||#parameters.jp[0] == 4"><s:iterator value="resultData"  status="i"><s:if test="areaid == #departid || areaid == #parameters.departid[0]"><s:property value="areaname" /></s:if></s:iterator><s:iterator value="re"  status="stat"><s:if test="#re[#stat.index][0]==#parameters.departid[0]"><s:property value="#re[#stat.index][1]"/></s:if></s:iterator>决赛得牌得分合计：
	         	</s:if>
         	</s:elseif>
         	<s:if test="#listHz1==null&&#parameters.jp==null">
	         	<img src="<s:property value="basePath"/>/resources/images/pages/g.png" style="margin-bottom:-5px;" />&nbsp;0&nbsp;
	         	<img src="<s:property value="basePath"/>/resources/images/pages/s.png" style="margin-bottom:-5px;" />&nbsp;0&nbsp;
	         	<img src="<s:property value="basePath"/>/resources/images/pages/b.png"  style="margin-bottom:-5px;" />&nbsp;0&nbsp;总分：0
         	</s:if>
         	<s:elseif test="#listHz1==null&&#parameters.jp!=null">
         		<s:if test="#parameters.jp[0] == 0 ||#parameters.jp[0] == 3">
         			<img src="<s:property value="basePath"/>/resources/images/pages/g.png" style="margin-bottom:-5px;" />&nbsp;<span id="hzjp"></span>&nbsp;
         		</s:if>
         		<s:if test="#parameters.jp[0] == 1 ||#parameters.jp[0] == 3">
	         		<img src="<s:property value="basePath"/>/resources/images/pages/s.png" style="margin-bottom:-5px;" />&nbsp;<span id="hzyp"></span>&nbsp;
	         	</s:if>
	         	<s:if test="#parameters.jp[0] == 2 ||#parameters.jp[0] == 3">
	         		<img src="<s:property value="basePath"/>/resources/images/pages/b.png"  style="margin-bottom:-5px;" />&nbsp;<span id="hztp"></span>&nbsp;
         		</s:if>
         		<s:if test="#parameters.jp[0] == 3 ||#parameters.jp[0] == 4">
         			总分：<span id="hzdf"></span>
         		</s:if>
         	</s:elseif>
         	<s:else>
	         	<s:if test="#parameters.jp[0] == 0 ||#parameters.jp[0] == 3">
	         	<img src="<s:property value="basePath"/>/resources/images/pages/g.png" style="margin-bottom:-5px;" />&nbsp;<span id="hzjp"></span>&nbsp;
	         	
	         	</s:if>
	         	<s:if test="#parameters.jp[0] == 1 ||#parameters.jp[0] == 3">
	         	<img src="<s:property value="basePath"/>/resources/images/pages/s.png" style="margin-bottom:-5px;" />&nbsp;<span id="hzyp"></span>&nbsp;
	         	
	         	</s:if>
	         	<s:if test="#parameters.jp[0] == 2 ||#parameters.jp[0] == 3">
	         	<img src="<s:property value="basePath"/>/resources/images/pages/b.png"  style="margin-bottom:-5px;" />&nbsp;<span id="hztp"></span>&nbsp;
	         	</s:if>
	         	<s:if test="#parameters.jp[0] == 3 ||#parameters.jp[0] == 4">
	         	总分：<span id="hzdf"></span>
	         	</s:if>
         	</s:else>
         	<div style="line-height: 5px;">&nbsp;</div>
         	<span>其中，本届赛会成绩：
         	<s:if test="#listHz1==null&&#parameters.jp==null"> 0&nbsp;金 <s:if test=" #sx!='1'.toString() "> 0&nbsp;银 0&nbsp;铜 </s:if> 0分；</s:if>
         	<s:elseif test="#listHz1==null&&#parameters.jp!=null">
         		<s:if test="#parameters.jp[0] == 0 ||#parameters.jp[0] == 3"> 0&nbsp;金 </s:if>
         		<s:if test=" #sx!='1'.toString() ">
	         		<s:if test="#parameters.jp[0] == 1 ||#parameters.jp[0] == 3"> 0&nbsp;银 </s:if>
		         	<s:if test="#parameters.jp[0] == 2 ||#parameters.jp[0] == 3"> 0&nbsp;铜 </s:if>
	         	</s:if>
         		<s:if test="#parameters.jp[0] == 3 ||#parameters.jp[0] == 4"> 0分； </s:if>
         	</s:elseif>
         	<s:else>
	         	<s:iterator value="listHz1" status="stat">
	         	<s:if test="#parameters.jp[0] == 0 ||#parameters.jp[0] == 3">
	         	<s:property value="#listHz1[#stat.index][1]"/>金
	         	<s:hidden name="Hz11" id="Hz11" value="%{#listHz1[#stat.index][1]}" />
	         	</s:if>
	         	<s:if test=" #sx!='1'.toString() ">
		         	<s:if test="#parameters.jp[0] == 1 ||#parameters.jp[0] == 3">
		         	<s:property value="#listHz1[#stat.index][2]"/>银
		         	<s:hidden name="Hz12" id="Hz12" value="%{#listHz1[#stat.index][2]}" />
		         	</s:if>
		         	<s:if test="#parameters.jp[0] == 2 ||#parameters.jp[0] == 3">
		         	<s:property value="#listHz1[#stat.index][3]"/>铜
		         	<s:hidden name="Hz13" id="Hz13" value="%{#listHz1[#stat.index][3]}" />
		         	</s:if>
		        </s:if>
	         	<s:if test="#parameters.jp[0] == 3 ||#parameters.jp[0] == 4">
	         	<s:property value="#listHz1[#stat.index][0]"/>分；
	         	<s:hidden name="Hz10" id="Hz10"  value="%{#listHz1[#stat.index][0]}" />
	         	</s:if>
	         	</s:iterator>
         	</s:else>
         		带入成绩：
	         	<s:iterator value="listDrcj" status="stat" >
	         	<s:if test="#parameters.jp[0] == 0 ||#parameters.jp[0] == 3">
	         	<s:property value="#listDrcj[#stat.index][10]"/>金
	         	<s:hidden name="Drcj10" id="Drcj10"  value="%{#listDrcj[#stat.index][10]}"/>
	         	</s:if>
	         	<s:if test="#parameters.jp[0] == 1 ||#parameters.jp[0] == 3">
	         	<s:property value="#listDrcj[#stat.index][11]"/>银
	         	<s:hidden name="Drcj11" id="Drcj11"  value="%{#listDrcj[#stat.index][11]}"/>
	         	</s:if>
	         	<s:if test="#parameters.jp[0] == 2 ||#parameters.jp[0] == 3">
	         	<s:property value="#listDrcj[#stat.index][12]"/>铜
	         	<s:hidden name="Drcj12" id="Drcj12"  value="%{#listDrcj[#stat.index][12]}"/>
	         	</s:if>
	         	<s:if test="#parameters.jp[0] == 3 ||#parameters.jp[0] == 4">
	         	<s:property value="#listDrcj[#stat.index][13]"/>分；
	         	<s:hidden name="Drcj13" id="Drcj13" value="%{#listDrcj[#stat.index][13]}"/>
	         	</s:if>
	         	</s:iterator>
	         	<s:if test=" #sx!='1'.toString() ">
	         	<s:if test="#parameters.jp[0] != 1 &&#parameters.jp[0] != 2">
	         	四项带入成绩：</s:if><s:iterator value="listDrcj" status="stat" >
	         	<s:if test="#parameters.jp[0] == 0 ||#parameters.jp[0] == 3">
	         	<s:property value="#listDrcj[#stat.index][23]"/>金&nbsp;
	         	<s:hidden name="SxDrcj8" id="SxDrcj8" value="%{#listDrcj[#stat.index][23]}"/>
	         	</s:if>
	         	<s:if test="#parameters.jp[0] == 3 ||#parameters.jp[0] == 4">
	         	<s:property value="#listDrcj[#stat.index][24]"/>分
	         	<s:hidden name="SxDrcj9" id="SxDrcj9" value="%{#listDrcj[#stat.index][24]}"/>
	         	</s:if>
	         	</s:iterator>
	         	</s:if>
         	</span> 
         	</th>
         	
         </tr>
         
         <tr>
           <th scope="col" abbr="序号"  class="matchDate" width="5%">序号</th>
           <th scope="col" abbr="项目"  class="matchDate" width="40%">项目</th>
           
           <s:if test="#parameters.jp[0] == 0 ||#parameters.jp[0] == 3">
           <th scope="col" abbr="金牌" class="matchDate" width="5%"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" style="margin-bottom:-5px;" /></th>
           </s:if>
           <s:if test=" #sx!='1'.toString() ">
	           <s:if test="#parameters.jp[0] == 1 ||#parameters.jp[0] == 3">
	           		<th scope="col" abbr="银牌" class="matchDate" width="5%"><img src="<s:property value="basePath"/>/resources/images/pages/s.png" alt="银牌" style="margin-bottom:-5px;" /></th>
	           </s:if>
	           <s:if test="#parameters.jp[0] == 2 ||#parameters.jp[0] == 3">
	           		<th scope="col" abbr="铜牌" class="matchDate" width="5%"><img src="<s:property value="basePath"/>/resources/images/pages/b.png" alt="铜牌" style="margin-bottom:-5px;" /></th>
	           </s:if>
	       </s:if>
           <s:if test="#parameters.jp[0] == 3 ||#parameters.jp[0] == 4">
           <th scope="col" abbr="总分" class="matchDate" width="5%">总分</th>
           <th scope="col" abbr="总分" class="matchDate" width="35%">得奖者</th>
           </s:if>
         </tr>
         <s:set name="i" value="0"/>
         
         <s:iterator value="dxmmcs" status="stt">
         	<tr id="id_<s:property value="#stt.index" />">
         <td style="text-align: center"> <span id="picss_<s:property value="%{#stt.index}" />"><img  style="cursor: pointer;" name="imgs"  src="<s:property value="basePath" />/resources/images/add.gif" onclick="openhidden('<s:property value="%{#stt.index}" />')" /></span>&nbsp;<s:property value="%{#stt.index+1}" /></td>
         <td style="text-align: center">
			&nbsp;<s:iterator  value="listSfjr21" status="stat_sfjr21" >
		           			<s:if test="%{#dxmmcs[#stt.index][0].toString()==#listSfjr21[#stat_sfjr21.index][0].toString()}">
		           				<s:if test="%{#listSfjr21[#stat_sfjr21.index][1]==1}">
		           					<s:set name="blx" value="1" />
		           				</s:if>
		           				<s:if test="%{#listSfjr21[#stat_sfjr21.index][1]==2}">
		           					<s:set name="bly" value="1" />
		           				</s:if>
		           				<s:if test="%{#listSfjr21[#stat_sfjr21.index][1]==3}">
		           					<s:set name="blz" value="1" />
		           				</s:if>
		           			</s:if>
	           			</s:iterator>
		           			<s:if test="%{#blx!=1}">
		           				<label style="color:#FFCC00">*</label>
		           			</s:if>
		           			<s:if test="%{#bly!=1}">
		           				<label style="color:blue">*</label>
		           			</s:if>
		           			<s:if test="%{#blz!=1}">
		           				<label style="color:red">*</label>
		           			</s:if>
		           			
			             <s:iterator value="#sfbjydhcj" status="stat2">
				         	<s:if test="#sfbjydhcj[#stat2.index] == 0 && #sf== false ">
				           		***
					           		<s:set name="sf" value="true" />
				           </s:if>
			           </s:iterator>
			           		 <s:property value="%{#dxmmcs[#stt.index][0]}"/><span id="<s:property value="#stt.index"/>_newIcon"></span>
		</td> 
		<s:if test="%{(#parameters.jp[0] == 0 ||#parameters.jp[0] == 3) && #dxmmcs[#stt.index][1]!=0}">
         <td style="text-align: center"><span id="one_<s:property value="%{#stt.index}" />"></span><script>con('<s:property value="#dxmmcs[#stt.index][1]" />','one_<s:property value="%{#stt.index}" />')</script></td>
        </s:if>
        <s:elseif test="#parameters.jp[0]==3">
        <td>--</td>
        </s:elseif>
        <s:elseif test="#parameters.jp[0]==0">
        	<script>toDisabled('<s:property value="#stt.index" />')</script>
        </s:elseif>
        <s:if test=" #sx!='1'.toString() ">
	     <s:if test="%{(#parameters.jp[0] == 1 ||#parameters.jp[0] == 3) && #dxmmcs[#stt.index][2]!=0}">
         	<td style="text-align: center"><span id="two_<s:property value="%{#stt.index}" />"></span><script>con('<s:property value="#dxmmcs[#stt.index][2]" />','two_<s:property value="%{#stt.index}" />')</script></td>
         </s:if>
        <s:elseif test="#parameters.jp[0]==3">
        <td>--</td>
        </s:elseif>
        <s:elseif test="#parameters.jp[0]==1">
        	<script>toDisabled('<s:property value="#stt.index" />')</script>
        </s:elseif>
	     <s:if test="%{(#parameters.jp[0] == 2 ||#parameters.jp[0] == 3) && #dxmmcs[#stt.index][3]!=0}">
         	<td style="text-align: center"><span id="three_<s:property value="%{#stt.index}" />"></span><script>con('<s:property value="#dxmmcs[#stt.index][3]" />','three_<s:property value="%{#stt.index}" />')</script></td>
         </s:if>
        <s:elseif test="#parameters.jp[0]==3">
        <td>--</td>
        </s:elseif>
        <s:elseif test="#parameters.jp[0]==2">
        	<script>toDisabled('<s:property value="#stt.index" />')</script>
        </s:elseif>
        </s:if>
        <s:if test="#parameters.jp[0] == 3 ||#parameters.jp[0] == 4">
         <td style="text-align: center"><span id="four_<s:property value="%{#stt.index}" />"></span><script>con('<s:property value="#dxmmcs[#stt.index][4]" />','four_<s:property value="%{#stt.index}" />')</script></td>
         <td></td>
         </s:if>
         </tr>
         <s:iterator value="listCj" status="stat">
         	<s:if test="%{listCj[#stat.index][0].toString()==#dxmmcs[#stt.index][0]}" >
         	<s:if test="(#parameters.jp[0] == 0 && listCj[#stat.index][2]!=0) ||(#parameters.jp[0] == 1 && listCj[#stat.index][3]!=0)||(#parameters.jp[0] == 2 && listCj[#stat.index][4]!=0)||(#parameters.jp[0] == 4 && listCj[#stat.index][14]!=0)||#parameters.jp[0] == 3">
         <tr id="display_<s:property value="%{#stt.index}" />_<s:property value='#stat.index' />" style="display: none">
	         	<s:set name="j" value="#i+1"/>
	         	<s:set name="i" value="#j"></s:set>
	           	<s:set name="blx" value="false" />
	           	<s:set name="bly" value="false" />
	            <s:set name="blz" value="false" />
	            <s:set name="sfbjydhcj" value="listCj[#stat.index][17].split(',')"/>
	            <s:set name="sf" value="false" />
		        <td colspan="2" style="border-right-color: #F7F7F7; text-align: left;"> &nbsp;&nbsp;&nbsp;&nbsp;
		        <%  i=0; %>
	           		<s:if test="listCj[#stat.index][6]=='' ">--</s:if>
		           	<s:else><s:date name="listCj[#stat.index][6]" format="yyyy-MM-dd" />
		           		<input type="text" id="date_<s:property value="#stt.index" />_<s:property value="#stat.index" />" value="<s:date name="listCj[#stat.index][6]" format="yyyy-MM-dd" />" style="display: none;" />
		           		<% i=1; %>
		           	</s:else>
		           	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		           	<s:property value="listCj[#stat.index][1]" /><span id="newIcon_<s:property value="#stt.index" />_<s:property value="#stat.index" />"></span><s:if test="listCj[#stat.index][15]!= 1 && listCj[#stat.index][15]!= 5">**</s:if>
	           		<%
	           			if(i==1){
	           				%>
	           				<script>displayNewIcon('date_<s:property value="#stt.index" />_<s:property value="#stat.index" />','newIcon_<s:property value="#stt.index" />_<s:property value="#stat.index" />','<s:property value="#stt.index" />_newIcon')</script>
	           				<%
	           			}
	           		%>
	           </td>
	           <s:if test="#parameters.jp[0] == 0  || #parameters.jp[0] == 3">
		           <td style="border-right-color: #F7F7F7; text-align: center;" class="gpai">
		          	 <s:if test=" listCj[#stat.index][2]==0 ">--</s:if> <s:else><s:property value="listCj[#stat.index][2]"/></s:else>
		           </td>
	           </s:if>
           	   <s:if test=" #sx!='1'.toString() ">
		           <s:if test="#parameters.jp[0] == 1 || #parameters.jp[0] == 3">
		           	<td class="spai"><s:if test=" listCj[#stat.index][3]==0 ">--</s:if><s:else><s:property value="listCj[#stat.index][3]"/></s:else></td>
		           </s:if>
		           <s:if test="#parameters.jp[0] == 2 || #parameters.jp[0] ==3">
		           	<td class="bpai"><s:if test=" listCj[#stat.index][4]==0 ">--</s:if><s:else><s:property value="listCj[#stat.index][4]"/></s:else></td>
		           </s:if>
	           </s:if>
	           <s:if test="#parameters.jp[0] == 3||#parameters.jp[0] == 4 ">
	           	<td><s:if test=" listCj[#stat.index][14]==0 ">--</s:if><s:else><s:property value="listCj[#stat.index][14]"/></s:else></td>
	            <td><span id="<s:property value='#stat.index' />_c" style="color: blue"><s:property value='listCj[#stat.index][8]'/></span><script> csh("<s:property value='#stat.index' />_c","<s:property value='listCj[#stat.index][8]'/>"); </script></td>
	           </s:if>
         </tr> </s:if> </s:if></s:iterator></s:iterator><%--
         <s:iterator value="listHzjjf" status="stat">
         <s:if test="#listHzjjf[#stat.index][0]!=0 || #listHzjjf[#stat.index][1]!=0 || #listHzjjf[#stat.index][2]!=0 || #listHzjjf[#stat.index][3]!=0">
		         <tr>
		           <td>--</td>
		           <td>其他项目</td>	
		           <s:if test="#parameters.jp[0] == 0 ||#parameters.jp[0] == 3">
		           	<s:if test=" #listHzjjf[#stat.index][0]==0 ">
		           		<th class="ccmd">&nbsp;--</th>
		           	</s:if>
		           	<s:else>
		           		<th class="ccmd">&nbsp;<s:property value="#listHzjjf[#stat.index][0]"/></th>
		           	</s:else>
		           </s:if>
		           <s:if test=" #sx!='1'.toString() ">
			           <s:if test="#parameters.jp[0] == 1 ||#parameters.jp[0] == 3">
				           <s:if test=" #listHzjjf[#stat.index][1]==0 ">
				           		<th class="ccmd">&nbsp;--</th>
				           	</s:if>
				           	<s:else>
			           			<th class="ccmd">&nbsp;<s:property value="#listHzjjf[#stat.index][1]"/></th>
			           		</s:else>
			           </s:if>
			           <s:if test="#parameters.jp[0] == 2 ||#parameters.jp[0] == 3">
			           		<s:if test=" #listHzjjf[#stat.index][2]==0 ">
				           		<th class="ccmd">&nbsp;--</th>
				           	</s:if>
				           	<s:else>
			           			<th class="ccmd">&nbsp;<s:property value="#listHzjjf[#stat.index][2]"/></th>
			           		</s:else>
			           </s:if>
		           </s:if>
		           <s:if test="#parameters.jp[0] == 3 ||#parameters.jp[0] == 4">
		           		<s:if test=" #listHzjjf[#stat.index][3]==0 ">
			           		<th class="ccmd">&nbsp;--</th>
			           	</s:if>
			           	<s:else>
		          			 <th class="ccmd"><s:property value="#listHzjjf[#stat.index][3]"/></th> 
		          		</s:else>
		           </s:if>
		         </tr>
	     </s:if>
	     </s:iterator>
         --%><s:if test="#listHz1==null&&#parameters.jp==null">
         	<tr>
	           <td>--</td>
	           <td>合计</td>	
	           <th class="ccmd">&nbsp;0</th>
	           <s:if test=" #sx!='1'.toString() ">
		           <th class="ccmd">&nbsp;0</th>
		           <th class="ccmd">&nbsp;0</th>
	           </s:if>
	           <th class="ccmd">&nbsp;0</th> 
	         </tr>
         </s:if>
         <s:elseif test="#listHz1==null&&#parameters.jp!=null">
         	<tr>
		           <td>--</td>
		           <td>合计</td>	
		           <s:if test="#parameters.jp[0] == 0 ||#parameters.jp[0] == 3">
		           <th class="ccmd">&nbsp;0</th>
		           </s:if>
		           <s:if test=" #sx!='1'.toString() ">
			           <s:if test="#parameters.jp[0] == 1 ||#parameters.jp[0] == 3">
			           <th class="ccmd">&nbsp;0</th>
			           </s:if>
			           <s:if test="#parameters.jp[0] == 2 ||#parameters.jp[0] == 3">
			           <th class="ccmd">&nbsp;0</th>
			           </s:if>
			       </s:if>
		           <s:if test="#parameters.jp[0] == 3 ||#parameters.jp[0] == 4">
		           <th class="ccmd">&nbsp;0</th>
		           </s:if>
		         </tr>
         </s:elseif>
         <s:else>
	         <s:iterator value="listHz1" status="stat">
		         <tr>
		           <td>--</td>
		           <td>合计</td>	
		           <s:if test="#parameters.jp[0] == 0 ||#parameters.jp[0] == 3">
		           <th class="ccmd">&nbsp;<s:property value="#listHz1[#stat.index][1]"/></th>
		           </s:if>
		           <s:if test=" #sx!='1'.toString() ">
			           <s:if test="#parameters.jp[0] == 1 ||#parameters.jp[0] == 3">
			           <th class="ccmd">&nbsp;<s:property value="#listHz1[#stat.index][2]"/></th>
			           </s:if>
			           <s:if test="#parameters.jp[0] == 2 ||#parameters.jp[0] == 3">
			           <th class="ccmd">&nbsp;<s:property value="#listHz1[#stat.index][3]"/></th>
			           </s:if>
			       </s:if>
		           <s:if test="#parameters.jp[0] == 3 ||#parameters.jp[0] == 4">
		           <th class="ccmd"><s:property value="#listHz1[#stat.index][0]"/></th> 
		           </s:if>
		         </tr>
	          </s:iterator>
          </s:else>
         <tr>
            <td colspan="9" style="text-align: left;line-height:20px;" ><span  style="text-align: left;padding-left: 2%;">说明信息：根据第十七届省运会竞赛办法，带<label style="color:#FFCC00">*</label>标记的项目不计入金牌榜，带<label style="color:blue">*</label>标记的项目不计入奖牌榜，带<label style="color:red">*</label>标记的项目不计入总分榜！</span>
            		<div style="line-height:0px;">&nbsp;</div><span  style="text-align: left;padding-left: 8.5%;">带**标记为输送运动员折算得分！带***标记为非本次竞赛得分成绩！</span>
            </td>
         </tr>
       </table>
       <table class="subTab" id="mainTable" summary="成绩单">
         <tr class="top">
           <th colspan="28" abbr="带入成绩信息"><s:iterator value="resultData"  status="i"><s:if test="areaid == #departid || areaid == #parameters.departid[0]"><s:property value="areaname" /></s:if></s:iterator><s:iterator value="re"  status="stat"><s:if test="#re[#stat.index][0]==#parameters.departid[0]"><s:property value="#re[#stat.index][1]"/></s:if></s:iterator><s:if test=" #sx!='1'.toString() ">代表团</s:if>带入成绩信息</th>
         </tr>
         <tr>
           <th  colspan="6" abbr="奥运带入成绩"  class="matchDate">奥运带入成绩</th>
           <th  colspan="6" abbr="全运带入成绩"  class="matchDate">全运带入成绩</th>
           <th  colspan="4" abbr="输送折算带入"  class="matchDate">输送折算带入</th>
           <th  colspan="6" abbr="总计带入成绩"  class="matchDate">总计带入成绩</th>
           <th  colspan="6" abbr="其他项目成绩"  class="matchDate">其他项目成绩</th>
         </tr>
         <tr>
           <th scope="col" abbr="金牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" style="margin-bottom:-6px;" /></th>
           <th scope="col" abbr="银牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/s.png" alt="银牌" style="margin-bottom:-6px;" /></th>
           <th scope="col" abbr="铜牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/b.png" alt="铜牌" style="margin-bottom:-6px;" /></th>
           <th colspan="3" abbr="总分" class="ccmd">总分</th>
           <th scope="col" abbr="金牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" style="margin-bottom:-6px;" /></th>
           <th scope="col" abbr="银牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/s.png" alt="银牌" style="margin-bottom:-6px;" /></th>
           <th scope="col" abbr="铜牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/b.png" alt="铜牌" style="margin-bottom:-6px;" /></th>
           <th colspan="3" abbr="总分" class="ccmd">总分</th>
           <th colspan="2" abbr="人数" class="ccmd">人数</th>
           <th colspan="2" abbr="金牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" style="margin-bottom:-6px;" /></th> 
           <th colspan="1" abbr="金牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" style="margin-bottom:-6px;" /></th>
           <th colspan="1" abbr="银牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/s.png" alt="银牌" style="margin-bottom:-6px;" /></th>
           <th colspan="1" abbr="铜牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/b.png" alt="铜牌" style="margin-bottom:-6px;" /></th>
           <th colspan="3" abbr="总分" class="ccmd">总分</th>
           <th colspan="1" abbr="金牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" style="margin-bottom:-6px;" /></th>
           <th colspan="1" abbr="银牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/s.png" alt="银牌" style="margin-bottom:-6px;" /></th>
           <th colspan="1" abbr="铜牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/b.png" alt="铜牌" style="margin-bottom:-6px;" /></th>
           <th colspan="3" abbr="总分" class="ccmd">总分</th>
         </tr>
         <s:iterator value="listDrcj" status="stat" >
         <tr>
           <td><s:property value="#listDrcj[#stat.index][0]"/></td>
           <td><s:property value="#listDrcj[#stat.index][1]"/></td>
           <td><s:property value="#listDrcj[#stat.index][2]"/></td>
           <td colspan="3"><s:property value="#listDrcj[#stat.index][3]"/></td>
           <td><s:property value="#listDrcj[#stat.index][4]"/></td>
           <td><s:property value="#listDrcj[#stat.index][5]"/></td>
           <td><s:property value="#listDrcj[#stat.index][6]"/></td>
           <td colspan="3"><s:property value="#listDrcj[#stat.index][7]"/></td>
           <td colspan="2"><s:property value="#listDrcj[#stat.index][8]"/></td>
           <td colspan="2"><s:property value="#listDrcj[#stat.index][9]"/></td>
           <td><s:property value="#listDrcj[#stat.index][10]"/></td>
           <td><s:property value="#listDrcj[#stat.index][11]"/></td>
           <td><s:property value="#listDrcj[#stat.index][12]"/></td>
           <td colspan="3"><s:property value="#listDrcj[#stat.index][13]"/></td>
           <td><s:property value="#listHzjjf[#stat.index][0]"/></td>
           <td><s:property value="#listHzjjf[#stat.index][1]"/></td>
           <td><s:property value="#listHzjjf[#stat.index][2]"/></td>
           <td colspan="3"><s:property value="#listHzjjf[#stat.index][3]"/></td>
         </tr>
		</s:iterator>
       </table>
       <s:if test=" #sx!='1'.toString() ">
       <table class="subTab" id="mainTable" summary="成绩单">
         <tr class="top">
           <th colspan="10" abbr="带入成绩信息"><s:iterator value="resultData"  status="i"><s:if test="areaid == #departid || areaid == #parameters.departid[0]"><s:property value="areaname" /></s:if></s:iterator>代表团四项带入成绩信息</th>
         </tr>
         <tr>
           <th  colspan="2" abbr="冬季项目带入成绩"  class="matchDate">冬季项目带入成绩</th>
           <th  colspan="2" abbr="帆船帆板带入成绩"  class="matchDate">帆船帆板带入成绩</th>
           <th  colspan="2" abbr="现代五项带入成绩"  class="matchDate">现代五项带入成绩</th>
           <th  colspan="2" abbr="皮划艇带入成绩"  class="matchDate">皮划艇带入成绩</th>
           <th  colspan="2" abbr="总计带入成绩"  class="matchDate">总计带入成绩</th>
         </tr>
         <tr>
           <th scope="col" abbr="金牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" style="margin-bottom:-6px;" /></th>
           <th scope="col" abbr="总分" class="ccmd">总分</th>
           <th scope="col" abbr="金牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" style="margin-bottom:-6px;" /></th>
           <th scope="col" abbr="总分" class="ccmd">总分</th>
           <th scope="col" abbr="金牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" style="margin-bottom:-6px;" /></th>
           <th scope="col" abbr="总分" class="ccmd">总分</th>
           <th scope="col" abbr="金牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" style="margin-bottom:-6px;" /></th>
           <th scope="col" abbr="总分" class="ccmd">总分</th>
           <th scope="col" abbr="金牌" class="ccmd"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" style="margin-bottom:-6px;" /></th>
           <th scope="col" abbr="总分" class="ccmd">总分</th>
         </tr>
         <s:iterator value="listDrcj" status="stat" >
         <tr>
           <td><s:property value="#listDrcj[#stat.index][15]"/></td>
           <td><s:property value="#listDrcj[#stat.index][16]"/></td>
           <td><s:property value="#listDrcj[#stat.index][17]"/></td>
           <td><s:property value="#listDrcj[#stat.index][18]"/></td>
           <td><s:property value="#listDrcj[#stat.index][19]"/></td>
           <td><s:property value="#listDrcj[#stat.index][20]"/></td>
           <td><s:property value="#listDrcj[#stat.index][21]"/></td>
           <td><s:property value="#listDrcj[#stat.index][22]"/></td>
           <td><s:property value="#listDrcj[#stat.index][23]"/></td>
           <td><s:property value="#listDrcj[#stat.index][24]"/></td>
         </tr>
		</s:iterator>
       </table>
       </s:if>
  </div>

  <!-- 主内容区 结束 -->
  
  <div class="clear"></div>
</div><!-- container end -->

<!-- 脚注部分导入 footer.jsp-->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
<!-- 脚注部分导入-->

</div>
<script>
	//alert('--');
$("img").each(function(i){
	if(this.name=='imgs'){
		openhidden('0');
		return false;
	}
	
})
</script>
</body>
</html>



