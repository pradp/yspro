<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
int i=0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
    
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>赛程成绩查询</title>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/960.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/reset.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/text.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/main.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/saicheng4ssrc.css" type="text/css" media="all" />
	<style>
		#floatDateDiv{ 
			position: absolute; 
			height:30px;
			z-index:1000; 
			width: 940px;
			}
	</style>
	<script type="text/javascript">
		
		var $=function(obj){return document.getElementById(obj);}
		function addEvent(oElement,sEvent,func){ 
			if(window.addEventListener){
				sEvent=sEvent.substring(2,sEvent.length); 
				oElement.addEventListener(sEvent,func,false); 
			}else{
				try{oElement.attachEvent(sEvent,func); }catch(e){alert(e);}
			}
		}
		function findElementPos(elemFind){
			var elemX = 0;
			var elemY = 0;
			do{
				elemX += elemFind.offsetLeft;
				elemY += elemFind.offsetTop;
			}while( elemFind = elemFind.offsetParent){
				return Array(elemX, elemY);
			}
		}
		
		function tblPos(){
			//var docH=document.documentElement.scrollHeight;
			//var leftL=findElementPos($('dateDiv'))[0];
			//var leftM=leftL+334;
			//$('floatDateDiv').style.left=leftL+"px";
			//var topL=document.documentElement.clientHeight+$('container').scrollTop-$('floatDateDiv').scrollHeight;
			//$('floatDateDiv').style.top=topL+"px";
			//if (findElementPos($('dateDiv'))[1]-document.documentElement.clientHeight-$('container').scrollTop<-$('dateDiv').scrollHeight){
			//	$('floatDateDiv').style.display="none";
			//}else{
				
			//	$('floatDateDiv').style.display="block";
			//}
			document.getElementById("floatDateDiv").style.top=(document.documentElement.scrollTop+document.documentElement.clientHeight-document.getElementById("floatDateDiv").offsetHeight)+"px"; 


			var f1 = document.getElementById("floatDateDiv").style.top; 
			var f2 = document.getElementById("dateDiv").style.top;
			var f11 = parseInt(f1.substring(0,f1.length-2));
			var f22 = parseInt(f2.substring(0,f2.length-2));
			if(f11>=f22){
				document.getElementById("floatDateDiv").style.display="none";
			}else{
				document.getElementById("floatDateDiv").style.display="block";
			}
		}
		
		function infom(xmmc,rq){
			var uri = "../visitor/sportCjcxRc-list.c?dxmmc="+xmmc+"&paixu=0&bssj="+rq;
			location.href=uri;
		}
		function changeStyle(obj){
			obj.style.color="#7CFC00";
		}
		function changeStyle2(obj){
			obj.style.color="#FFFFFF";
		}
		function view(a) {
				 location.href='../visitor/sportCjcxRcZk-list.c?cssS=4&jd='+a;
		}
	</script>

  </head>
  
  <body>
    <div class="container_16" id="container_16" >
		<!-- 导入head 区域  head.jsp-->
			<jsp:include page="../common/head.jsp" flush="true"></jsp:include>
		<!-- 导入head 区域-->
	<div id="container" class="grid_16"><!-- container begin -->
  
  <!--导入赛事日程  区域 （可选） ssrcDate.jsp-->
  <!--导入赛事日程  区域（可选）-->
  <div>&nbsp;</div>
  <!-- 赛事日程 -->
  <div id="allsc" class="grid_16 alpha omega" >
      <!--列表内容 begin-->
     	 <div class="idTabs"> <!-- 带标签的标题文章 begin -->
     	  <ul class="tabstitle"> 
              <li id="tab1" <s:if test="#jd==null||#jd==3"> class="selected"</s:if> ><span style="cursor: pointer"  onclick="javascript:view(3);">第三阶段</span></li>
              <li id="tab2" <s:if test="#jd==2"> class="selected"</s:if> ><span style="cursor: pointer" onclick="javascript:view(2);">第二阶段</span></li>
              <li id="tab3" <s:if test="#jd==1"> class="selected"</s:if>><span style="cursor: pointer" onclick="javascript:view(1);">第一阶段</span></li>
            </ul> 
      <div id="top<s:property value='jd' />" style="display: block; "><!-- 学术动态 -->
      <table class="mainTab" id="mainTable">
      	<tr class="top">
      		<td style="text-align:center;"><h2><s:if test="#jd==1">第一阶段赛程</s:if><s:elseif test="#jd==2">第二阶段赛程</s:elseif><s:elseif test="#jd==3">第三阶段赛程</s:elseif></h2></td>
      		<td colspan="<s:property value='#bsxmsj3.size()+1' />" ><div class="tmpR">比赛日<img src="<s:property value='basePath'/>/resources/images/pages/rqbs.gif" width="21" height="19" style="margin-bottom:4px;" />　决赛日及金牌数<img src="<s:property value='basePath'/>/resources/images/pages/jpshu.gif" width="20" height="21" style="margin-bottom:3px;" />　开幕<img src="<s:property value='basePath'/>/resources/images/pages/km.gif" width="15" height="22" style="margin-bottom:3px;" />　闭幕<img src="<s:property value='basePath'/>/resources/images/pages/bm.gif" width="15" height="22" style="margin-bottom:3px;" />　机动日 R　表演日 G</div>
      		</td>
      	</tr><tr id="datelist1"><th class="matchDate" >项目/日期 <sup><s:property value="mouths" /></sup></th>
      	<s:iterator value="#bsxmsj3" status="st">
    	 <th class="on">
    		 <span onclick="location.href='../visitor/sportCjcxRc-list.c?cssS=4&paixu=0&bssj=<s:property value="startTime" />&mi=<s:property value="getMi(startTime.toString())" />'" style="cursor:pointer; font-size: 12px;" onmouseover="changeStyle(this)" onmouseout="changeStyle2(this)" title="<s:property value="startTime" />"><s:property value="endTime"/></span>
   		 </th>
    	</s:iterator>
      	<th align="center" style="width: 4%">小计</th></tr>
      	<tr>
      		<td class="leSort">开幕式</td>
      		<s:iterator value="#bsxmsj3" status="st">
 	 		<s:if test="%{startTime==getKmssj()}"><td><img src="<s:property value='basePath'/>/resources/images/pages/km.gif" width="15" height="22" /></td></s:if><s:else><td></td></s:else>
    	 	</s:iterator><td></td>
      	</tr>
      	<tr>
      		<td class="leSort">闭幕式</td>
      		<s:iterator value="#bsxmsj3" status="st">
 	    	 <s:if test="%{startTime==getBmssj()}"><td><img src="<s:property value='basePath'/>/resources/images/pages/bm.gif" width="15" height="22" /></td></s:if><s:else><td></td></s:else>
     	 	</s:iterator><td></td>
      	</tr>
      	<s:iterator value="resultData" status="status">
  	<tr>
    <td class="leSort"><a href="../visitor/sportCjcxRc-list.c?cssS=5&paixu=0&dxmmc=<s:property value="@java.net.URLEncoder@encode(dxmmc,'utf-8')" />&xsrq=1"><s:property value="dxmmc" /></a></td>
     <s:iterator value="bsxmsj3" status="st">
     <td id="<s:property value="#status.index"/>_<s:property value="#st.index"/>_style"><s:iterator value="#down2" status="stat"><% //比较项目名称 %><s:if test="resultData[#status.index].dxmmc==#down2[#stat.index][2].toString()"><% //比较比赛日期 %><s:if test="%{startTime==#down2[#stat.index][1].toString()}"><% //比较是否有金牌数 %><s:if test="#down2[#stat.index][0].toString()!='0'.toString()"><s:if test="%{#down2[#stat.index][0].toString().length()>3}"><span class="medal" id="<s:property value="#status.index"/>_<s:property value="#st.index"/>_span" style="cursor:pointer;font-size:10px;"></s:if><s:else><span class="medal" id="<s:property value="#status.index"/>_<s:property value="#st.index"/>_span" style="cursor:pointer"></s:else><s:property value="#down2[#stat.index][0].toString()" /></span></s:if><script>document.getElementById("<s:property value='#status.index'/>_<s:property value='#st.index'/>_style").className="match"; document.getElementById("<s:property value='#status.index'/>_<s:property value='#st.index'/>_style").onclick=function() { infom('<s:property value="@java.net.URLEncoder@encode(resultData[#status.index].dxmmc,'utf-8')" />&mi=<s:property value="getMi(startTime.toString())" />&cssS=<s:property value="cssS" />','<s:property value="startTime" />');}</script></s:if></s:if></s:iterator></td></s:iterator>	
<s:iterator value="#right" status="st4"><s:if test="#right[#st4.index][0].toString()==dxmmc" ><td><s:if test="%{#right[#st4.index][1].toString().length()>3}"><span class="medal" style="font-size:10px;"></s:if><s:else><span class="medal"></s:else><s:property value="#right[#st4.index][1].toString()" /></span></td></s:if></s:iterator>
  </tr>
  </s:iterator>
  <tr class="allMatch">
   <td class="leSort">金牌总数</td>
   <s:iterator value="#bsxmsj3" status="st">
   <td><s:iterator value="#down" status="st2"><s:if test="#down[#st2.index][1].toString()==startTime" ><s:if test="%{#down[#st2.index][0].toString().length()>3}"><span class="medal" style="font-size:10px;"></s:if><s:else><span class="medal"></s:else><s:property value="#down[#st2.index][0].toString()" /></span></s:if></s:iterator></td>
   </s:iterator><td><span id="total_c"></span></td>
  </tr>
   	<tr id="dateDiv" style="top: 1185px;">
   	<th class="matchDate">项目/日期 <sup><s:property value="mouths" /></sup></th>
   		<s:iterator value="#bsxmsj3" status="st"><th class="on"><span onclick="location.href='../visitor/sportCjcxRc-list.c?bssj=<s:property value="startTime" />&mi=<s:property value="getMi(startTime.toString())" />'" style="cursor:pointer;font-size: 12px;" onmouseover="changeStyle(this)" onmouseout="changeStyle2(this)" title="<s:property value="startTime" />"><s:property value="endTime"/></span></th></s:iterator>
    	<th align="center" style="width: 4%">小计</th>
    </tr>
    </table>
     <div id="floatDateDiv" ><table class="mainTab" style="margin-top:0;"><tbody><tr id="flyDivTR"><th  class="matchDate">项目/日期 <sup><s:property value="mouths" /></sup></th>
   		 <s:iterator value="#bsxmsj3" status="st"><th class="on"><span onclick="location.href='../visitor/sportCjcxRc-list.c?bssj=<s:property value="startTime" />&mi=<s:property value="getMi(startTime.toString())" />'" style="cursor:pointer;font-size: 12px;" onmouseover="changeStyle(this)" onmouseout="changeStyle2(this)" title="<s:property value="startTime" />"><s:property value="endTime"/></span></th></s:iterator>
    	<th align="center" style="width: 4%">小计</th>
    </tr></tbody></table></div>
     <script>
		//tblPos();
		window.onscroll=tblPos; 
		window.onresize=tblPos; 
		window.onload=tblPos;
		//addEvent($('container'),"onscroll",tblPos);
		//addEvent($('container'),"onresize",tblPos);
	</script>
    </div>
   
  <!-- 主内容区 结束 -->
  <div class="clear"></div>
</div><!-- container end -->

<!-- 脚注部分导入 footer.jsp-->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
<!-- 脚注部分导入-->
</div></div></div>
  </body>
</html>
