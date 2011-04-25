<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
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
	
	function openPage(wid){	
		window.location.href="../visitor/sportCjcxPjl-list.c?wid="+wid+"&reqtime="+(new Date());
		//window.open("../visitor/sportCjcxPjl-list.c?wid="+wid);
		//document.forms[0].action="../visitor/sportCjcxPjl-list.c?wid="+wid+"&reqtime="+(new Date());
		//alert(document.forms[0].action);
		//document.forms[0].submit();
	}
	function turnit(yy,ss){
		$("tr[@id*="+yy+"]").each(function(){
			$(this).toggle();
		});
		if(document.getElementById(yy+"a").style.display=='none'){
			ss.src="<s:property value='basePath'/>/resources/images/pages/plus.gif";
		}else{
			ss.src="<s:property value='basePath'/>/resources/images/pages/plus.jpg";
		}
		
		
	}
	</script>
	<style type="text/css">
		.subTab .top th { 
			padding-top: 4px;
			padding-bottom: 0px;
		}
		
		.subTab th.matchDate { 
		    width:145px;
		}
		.subTab td.matchWidth { 
		    width:145px;
		}
	</style>
  </head>
<body > 
<div class="container_16">
		<!-- 导入head 区域  head.jsp-->
			<jsp:include page="../common/head.jsp" flush="true"></jsp:include>
		<!-- 导入head 区域-->
<div id="container" class="grid_16"><!-- container begin -->
	<div>
	  	&nbsp;
	</div>
<s:form theme="simple" name="theform">
  	<div class="grid_16 alpha">
       <table class="subTab" id="mainTable" summary="今日赛程">
         <tr class="top" onmouseup="turnit('Auy1_',Img1);" >
         	<th colspan="7" style="border-right-style: none; border-right-width: medium;height: 30">
	         	<img src="<s:property value="basePath"/>/resources/images/sportsimage/juzhong.gif" alt="举重" width="28" height="28" />
	         	<font color="#CC0000" face="Arial" style="font-size: 11pt"><b> 举重</b></font>
	         	<font color="#636363" face="Arial" style="font-size: 9pt">（单击收起/展开本项目纪录信息）</font>
		        <img id="Img1"  src="<s:property value="basePath"/>/resources/images/pages/plus.jpg" alt="收起/展开本项目纪录信息" width="9" height="9">
	        </th>
         </tr>
         <tr id="Auy1_a" style="DISPLAY:BLOCK">
           <th colspan="1" abbr="比赛项目"  class="matchDate">比赛项目</th>
           <th colspan="1" abbr="代表团" class="matchDate">代表团</th>
           <th colspan="1" abbr="参赛者" class="matchDate">参赛者</th>
           <th colspan="1" abbr="成绩" class="matchDate">成绩</th>
           <th colspan="1" abbr="原纪录" class="matchDate">原纪录</th>
           <th colspan="1" abbr="日期" class="matchDate">日期</th>
           <th colspan="1" abbr="备注" class="matchDate">备注</th>
         </tr>
          <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='1'.toString()&&dxmmc=='举重'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy1_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#jz_pljlx1_rs" />人<s:property value="#jz_pljlx1_ds" />队<s:property value="#jz_pljlx1_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy1_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td>   
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='2'.toString()&&dxmmc=='举重'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy1_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#jz_pljlx2_rs" />人<s:property value="#jz_pljlx2_ds" />队<s:property value="#jz_pljlx2_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy1_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td>   
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='3'.toString()&&dxmmc=='举重'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy1_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#jz_pljlx3_rs" />人<s:property value="#jz_pljlx3_ds" />队<s:property value="#jz_pljlx3_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy1_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td> 	  
         </tr>
         </s:if>
         </s:iterator>
         	<s:if test="#str=='no'">
				 <tr id="Auy1_b" style="DISPLAY:" >
				     <td colspan="7">没有产生任何纪录</td>
				 </tr>
			 </s:if>
       </table>
       
       
       <table class="subTab" id="mainTable" summary="今日赛程">
         <tr class="top" onmouseup="turnit('Auy2_',Img2);"  >
         	<th colspan="7" style="border-right-style: none; border-right-width: medium">
	         	<img src="<s:property value="basePath"/>/resources/images/sportsimage/sheji.gif" alt="射击" width="28" height="28" />
	         	<font color="#CC0000" face="Arial" style="font-size: 11pt"><b> 射击</b></font>
	         	<font color="#636363" face="Arial" style="font-size: 9pt">（单击收起/展开本项目纪录信息）</font>
	         	<img id="Img2"  src="<s:property value="basePath"/>/resources/images/pages/plus.jpg" alt="收起/展开本项目纪录信息" width="9" height="9">
         	</th>
         </tr>
         <tr id="Auy2_a" style="DISPLAY:BLOCK">
           <th scope="col" abbr="比赛项目"  class="matchDate">比赛项目</th>
           <th scope="col" abbr="代表团" class="matchDate">代表团</th>
           <th scope="col" abbr="参赛者" class="matchDate">参赛者</th>
           <th scope="col" abbr="成绩" class="matchDate">成绩</th>
           <th scope="col" abbr="原纪录" class="matchDate">原纪录</th>
           <th scope="col" abbr="日期" class="matchDate">日期</th>
           <th scope="col" abbr="备注" class="matchDate">备注</th>
         </tr>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='1'.toString()&&dxmmc=='射击'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy2_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#sji_pljlx1_rs" />人<s:property value="#sji_pljlx1_ds" />队<s:property value="#sji_pljlx1_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy2_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth">&nbsp;<s:property value="cj"/></td>
			    <td class="matchWidth">&nbsp;<s:property value="yjlcj"/></td>
			    <td class="matchWidth">&nbsp;<s:property value="bssj"/></td>	
			    <td class="matchWidth">&nbsp;<s:property value="bz"/></td>   
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='2'.toString()&&dxmmc=='射击'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy2_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#sji_pljlx2_rs" />人<s:property value="#sji_pljlx2_ds" />队<s:property value="#sji_pljlx2_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy2_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td>   
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='3'.toString()&&dxmmc=='射击'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy2_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#sji_pljlx3_rs" />人<s:property value="#sji_pljlx3_ds" />队<s:property value="#sji_pljlx3_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy2_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td> 	  
         </tr>
         </s:if>
         </s:iterator>
         <s:if test="#str=='yes'">
				 <tr id="Auy2_b" style="DISPLAY:">
				     <td colspan="7">没有产生任何纪录</td>
				 </tr>
			 </s:if>
       </table>
       
       
       <table class="subTab" id="mainTable" summary="今日赛程">
         <tr class="top" onmouseup="turnit('Auy3_',Img3);">
         	<th colspan="7" style="border-right-style: none; border-right-width: medium">
         		<img src="<s:property value="basePath"/>/resources/images/sportsimage/shejian.gif" alt="射箭" width="28" height="28" />
         		<font color="#CC0000" face="Arial" style="font-size: 11pt"><b> 射箭</b></font>
         		<font color="#636363" face="Arial" style="font-size: 9pt">（单击收起/展开本项目纪录信息）</font>
         		<img id="Img3"  src="<s:property value="basePath"/>/resources/images/pages/plus.jpg" alt="收起/展开本项目纪录信息" width="9" height="9">
         	</th>
         </tr>
         <tr id="Auy3_a" style="display:block">
           <th scope="col" abbr="比赛项目"  class="matchDate">比赛项目</th>
           <th scope="col" abbr="代表团" class="matchDate">代表团</th>
           <th scope="col" abbr="参赛者" class="matchDate">参赛者</th>
           <th scope="col" abbr="成绩" class="matchDate">成绩</th>
           <th scope="col" abbr="原纪录" class="matchDate">原纪录</th>
           <th scope="col" abbr="日期" class="matchDate">日期</th>
           <th scope="col" abbr="备注" class="matchDate">备注</th>
         </tr>
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='1'.toString()&&dxmmc=='射箭'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy6_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#sjian_pljlx1_rs" />人<s:property value="#sjian_pljlx1_ds" />队<s:property value="#sjian_pljlx1_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy3_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td>   
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='2'.toString()&&dxmmc=='射箭'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy3_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#sjian_pljlx2_rs" />人<s:property value="#sjian_pljlx2_ds" />队<s:property value="#sjian_pljlx2_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy3_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td>   
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='3'.toString()&&dxmmc=='射箭'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy3_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#sjian_pljlx3_rs" />人<s:property value="#sjian_pljlx3_ds" />队<s:property value="#sjian_pljlx3_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy3_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td> 	  
         </tr>
         </s:if>
         </s:iterator>
         <s:if test="#str=='no'">
				 <tr id="Auy3_b" style="DISPLAY:">
				     <td colspan="7">没有产生任何纪录</td>
				 </tr>
			 </s:if>
       </table>
       
       <table class="subTab" id="mainTable" summary="今日赛程">
         <tr class="top" onmouseup="turnit('Auy4_',Img4);">
         	<th colspan="7" style="border-right-style: none; border-right-width: medium">
	         	<img src="<s:property value="basePath"/>/resources/images/sportsimage/tianjing.gif" alt="田径" width="28" height="28" />
	         	<font color="#CC0000" face="Arial" style="font-size: 11pt"><b> 田径</b></font>
	         	<font color="#636363" face="Arial" style="font-size: 9pt">（单击收起/展开本项目纪录信息）</font>
		        <img id="Img4"  src="<s:property value="basePath"/>/resources/images/pages/plus.jpg" alt="收起/展开本项目纪录信息" width="9" height="9">
	        </th>
         </tr>
         <tr id="Auy4_a" style="display:block">
           <th scope="col" abbr="比赛项目"  class="matchDate">比赛项目</th>
           <th scope="col" abbr="代表团" class="matchDate">代表团</th>
           <th scope="col" abbr="参赛者" class="matchDate">参赛者</th>
           <th scope="col" abbr="成绩" class="matchDate">成绩</th>
           <th scope="col" abbr="原纪录" class="matchDate">原纪录</th>
           <th scope="col" abbr="日期" class="matchDate">日期</th>
           <th scope="col" abbr="备注" class="matchDate">备注</th>
         </tr>
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='1'.toString()&&dxmmc=='田径'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy4_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#tj_pljlx1_rs" />人<s:property value="#tj_pljlx1_ds" />队<s:property value="#tj_pljlx1_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy4_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td>   
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='2'.toString()&&dxmmc=='田径'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy4_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#tj_pljlx2_rs" />人<s:property value="#tj_pljlx2_ds" />队<s:property value="#tj_pljlx2_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy4_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td>   
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='3'.toString()&&dxmmc=='田径'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy4_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#tj_pljlx3_rs" />人<s:property value="#tj_pljlx3_ds" />队<s:property value="#tj_pljlx3_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy4_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td> 	  
         </tr>
         </s:if>
         </s:iterator>
         
          <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='4'.toString()&&dxmmc=='田径'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy4_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#tj_pljlx4_rs" />人<s:property value="#tj_pljlx4_ds" />队<s:property value="#tj_pljlx4_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy4_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td> 	  
         </tr>
         </s:if>
         </s:iterator> <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='5'.toString()&&dxmmc=='田径'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy4_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#tj_pljlx5_rs" />人<s:property value="#tj_pljlx5_ds" />队<s:property value="#tj_pljlx5_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy4_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td> 	  
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='6'.toString()&&dxmmc=='田径'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy4_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#tj_pljlx6_rs" />人<s:property value="#tj_pljlx6_ds" />队<s:property value="#tj_pljlx6_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy4_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td> 	  
         </tr>
         </s:if>
         </s:iterator>
         
          <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='7'.toString()&&dxmmc=='田径'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy4_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#tj_pljlx7_rs" />人<s:property value="#tj_pljlx7_ds" />队<s:property value="#tj_pljlx7_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy4_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td> 	  
         </tr>
         </s:if>
         </s:iterator>
         
         <s:if test="#str=='no'">
				 <tr id="Auy4_b" style="DISPLAY:">
				     <td colspan="7">没有产生任何纪录</td>
				 </tr>
			 </s:if>
       </table>
       <table class="subTab" id="mainTable" summary="今日赛程">
         <tr class="top" onclick="turnit('Auy5_',Img5);">
         	<th colspan="7" style="border-right-style: none; border-right-width: medium">
	         	<img src="<s:property value="basePath"/>/resources/images/sportsimage/youyong.gif" alt="游泳" width="28" height="28" />
	         	<font color="#CC0000" face="Arial" style="font-size: 11pt"><b> 游泳</b></font>
	         	<font color="#636363" face="Arial" style="font-size: 9pt">（单击收起/展开本项目纪录信息）</font>
		        <img id="Img5"  src="<s:property value="basePath"/>/resources/images/pages/plus.jpg" alt="收起/展开本项目纪录信息" width="9" height="9">
	        </th>
         </tr>
         <tr id="Auy5_a" style="display:block">
           <th scope="col" abbr="比赛项目"  class="matchDate">比赛项目</th>
           <th scope="col" abbr="代表团" class="matchDate">代表团</th>
           <th scope="col" abbr="参赛者" class="matchDate">参赛者</th>
           <th scope="col" abbr="成绩" class="matchDate">成绩</th>
           <th scope="col" abbr="原纪录" class="matchDate">原纪录</th>
           <th scope="col" abbr="日期" class="matchDate">日期</th>
           <th scope="col" abbr="备注" class="matchDate">备注</th>
         </tr>
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='1'.toString()&&dxmmc=='游泳'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy5_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#yy_pljlx1_rs" />人<s:property value="#yy_pljlx1_ds" />队<s:property value="#yy_pljlx1_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy5_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td>   
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='2'.toString()&&dxmmc=='游泳'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy5_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#yy_pljlx2_rs" />人<s:property value="#yy_pljlx2_ds" />队<s:property value="#yy_pljlx2_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy5_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td>   
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='3'.toString()&&dxmmc=='游泳'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy5_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#yy_pljlx3_rs" />人<s:property value="#yy_pljlx3_ds" />队<s:property value="#yy_pljlx3_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy5_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td> 	  
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='4'.toString()&&dxmmc=='游泳'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy5_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#yy_pljlx4_rs" />人<s:property value="#yy_pljlx4_ds" />队<s:property value="#yy_pljlx4_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy5_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td> 	  
         </tr>
         </s:if>
         </s:iterator>
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='5'.toString()&&dxmmc=='游泳'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy5_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#yy_pljlx5_rs" />人<s:property value="#yy_pljlx5_ds" />队<s:property value="#yy_pljlx5_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy5_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td> 	  
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='6'.toString()&&dxmmc=='游泳'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy5_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#yy_pljlx6_rs" />人<s:property value="#yy_pljlx6_ds" />队<s:property value="#yy_pljlx6_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy5_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td> 	  
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='7'.toString()&&dxmmc=='游泳'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy5_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#yy_pljlx7_rs" />人<s:property value="#yy_pljlx7_ds" />队<s:property value="#yy_pljlx7_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy5_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td> 	  
         </tr>
         </s:if>
         </s:iterator>
         
         <s:if test="#str=='yes'">
				 <tr id="Auy5_b" style="DISPLAY:">
				     <td colspan="7">没有产生任何纪录</td>
				 </tr>
			 </s:if>
       </table>
       
       <table class="subTab" id="mainTable" summary="今日赛程">
         <tr class="top" onmouseup="turnit('Auy6_',Img6);">
         	<th colspan="7" style="border-right-style: none; border-right-width: medium">
	         	<img src="<s:property value="basePath"/>/resources/images/sportsimage/zixingche.gif" alt="自行车" width="28" height="28" />
	         	<font color="#CC0000" face="Arial" style="font-size: 11pt"><b> 自行车</b></font>
	         	<font color="#636363" face="Arial" style="font-size: 9pt">（单击收起/展开本项目纪录信息）</font>
		        <img id="Img6"  src="<s:property value="basePath"/>/resources/images/pages/plus.jpg" alt="收起/展开本项目纪录信息" width="9" height="9">
	        </th>
         </tr>
         <tr id="Auy6_a" style="display:block">
           <th scope="col" abbr="比赛项目"  class="matchDate">比赛项目</th>
           <th scope="col" abbr="代表团" class="matchDate">代表团</th>
           <th scope="col" abbr="参赛者" class="matchDate">参赛者</th>
           <th scope="col" abbr="成绩" class="matchDate">成绩</th>
           <th scope="col" abbr="原纪录" class="matchDate">原纪录</th>
           <th scope="col" abbr="日期" class="matchDate">日期</th>
           <th scope="col" abbr="备注" class="matchDate">备注</th>
         </tr>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='1'.toString()&&dxmmc=='自行车'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy6_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#zxc_pljlx1_rs" />人<s:property value="#zxc_pljlx1_ds" />队<s:property value="#zxc_pljlx1_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy6_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td>   
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='2'.toString()&&dxmmc=='自行车'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy6_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#zxc_pljlx2_rs" />人<s:property value="#zxc_pljlx2_ds" />队<s:property value="#zxc_pljlx2_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy6_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td>   
         </tr>
         </s:if>
         </s:iterator>
         
         <s:set name="str" value="'no'" />
         <s:iterator value="listCj" status="stat">
         <s:if test="pjllx1=='3'.toString()&&dxmmc=='自行车'.toString()">
         <s:if test="#str=='no'">
	         <tr id="Auy6_c" style="DISPLAY:">
	         	<th style="background: #cccccc" colspan="7"><label style="color:black;"><s:property value="pjllx"/>&nbsp;&nbsp;&nbsp;
	         	<s:property value="#zxc_pljlx3_rs" />人<s:property value="#zxc_pljlx3_ds" />队<s:property value="#zxc_pljlx3_cs" /><s:property value="pjllx"/></label></th>
	         </tr>
	     </s:if>
	     <s:set name="str" value="'yes'" />
         <tr id="Auy6_" style="display:block">
           <td class="matchWidth">&nbsp;<s:property value="xxmmc"/></td> 
           		<td class="matchWidth">&nbsp;<s:property value="dbd"/> </td>
				<td class="matchWidth">&nbsp;<s:property value="ydybm"/></td> 
			    <td class="matchWidth"><s:property value="cj"/></td>
			    <td class="matchWidth"><s:property value="yjlcj"/></td>
			    <td class="matchWidth"><s:property value="bssj"/></td>	
			    <td class="matchWidth"><s:property value="bz"/></td> 	  
         </tr>
         </s:if>
         </s:iterator>
         
         <s:if test="#str=='no'">
				 <tr id="Auy6_b" style="DISPLAY:">
				     <td colspan="7">没有产生任何纪录</td>
				 </tr>
			 </s:if>
       </table>
       
  </div>
</s:form>
      <!-- 主内容区 结束 -->
 
 
  
  <div class="clear"></div>
</div><!-- container end -->

<!-- 脚注部分导入 footer.jsp-->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
<!-- 脚注部分导入-->

</div>
  </body>
</html>

