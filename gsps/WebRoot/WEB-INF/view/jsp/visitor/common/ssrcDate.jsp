<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
<script type="text/javascript" src="<s:property value="basePath"/>/component/jquerybetterTooltip/jquery.betterTooltip.js"></script>
<link href="<s:property value="basePath"/>/component/jquerybetterTooltip/style.css" rel="stylesheet" type="text/css" media="all" />
<script type="text/javascript">
  var middleIndex = parseInt('<s:property value="getMiddleDay()"/>');
  var maxDay = parseInt('<s:property value="getMaxDay()"/>');
  var chooseDay = parseInt('<s:property value="getDateIndex()"/>');
  var indexO = 0;   //用于滑动按钮是否起作用 1为向右滑动 2为向左滑动 0为不滑动
  function onChooseDate(mydate,myIndex){
	  var dUrl = document.URL;
	  dUrl =  dUrl.substring(0,dUrl.lastIndexOf('/'))+'/sportCjcxRc-list.c?cssS=4&bssj='+mydate+"&mi="+middleIndex;

	  window.location.href = dUrl;
  }

  jQuery(document).ready(function(){
	  var c = '<s:property value="%{#parameters.bssj[0]}"/>';
	  var mi = '<s:property value="%{#parameters.mi[0]}"/>';
	  if(c!=null && c!=''){
		  chooseDay = c;
	  }
	  if(mi!=null && mi!= ''){
		  middleIndex = parseInt(mi);
	  }
	  changeDateList();
	  
	  jQuery('.k1').bind('mousedown', function(){
			if(middleIndex>3 && $(this).attr('id')=='leftControl'){
				setTimeout("checkSnF(2)",500);
			}else if(middleIndex<maxDay-4 && $(this).attr('id')=='rightControl'){
				setTimeout("checkSnZ(1)",500);
			}
	  });
	
	  $('.tTip').betterTooltip({speed: 150, delay: 300});
  });
  function checkSnF(str){
	  
		if(str) indexO = str;
		if(middleIndex<4 || indexO!=2){
			return false;
		}else{
			middleIndex =  middleIndex-1;
			changeDateList('1');
			//setTimeout("checkSnF()",500);
		}
  }
  function checkSnZ(str){
		if(str) indexO = str;
	  	if(middleIndex>maxDay-5 || indexO !=1){
			return false;
		}else{
			middleIndex =  middleIndex+1;
			changeDateList('1');
			//setTimeout("checkSnZ()",500);
		}
}
  function changeDateList(str){
	  var xsrq = '<s:property value="%{#parameters.xsrq[0]}"/>';
	  var c = '<s:property value="%{#parameters.bssj[0]}"/>';
	  if(str==null && (c==null || c=='')){
			middleIndex = parseInt('<s:property value="getMiddleDay()"/>');
	  }
	 jQuery("li[id^='md_']").each(function(i){
		  if(middleIndex<4){
			  if(i>-1 && i<7){
				  jQuery(this).show();
			  }else{ 
				  jQuery(this).hide();
			  }
		  }else if(middleIndex>maxDay-4){
			  if(i>maxDay-8){
				  jQuery(this).show();
			  }else{ 
				  jQuery(this).hide();
			  }
		  }else{
			  if(i>middleIndex-4 && i<middleIndex+4){
				  jQuery(this).show();
			  }else{ 
				  jQuery(this).hide();
			  }
		  }
		  
		  if((xsrq==null || xsrq== '') && (i == chooseDay || jQuery(this).attr('id') == 'md_'+chooseDay)){
			  if(c != null && c != ''){
				  jQuery(this).addClass("on");
				  document.body.focus();
			  }else{
				  jQuery(this).removeClass("on");
			  }
		  }else{ 
			  jQuery(this).removeClass("on");
		  }
	  });
	}

</script>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div id="scinfo" class="grid_16 alpha omega">
  	<div id="saicheng" class="grid_12 alpha">
  	  <h2 align="center">赛事日程</h2>
  	  <div class="c2" id="divCl2">
  	  <span class="k1" id="leftControl" style="cursor:pointer;"><img src="<s:property value='basePath'/>/resources/images/pages/arrow_left.png" width="13" height="26" alt="" /></span>
  	  <ul id="ul_li">
  	  <!--开始迭代日期-->
          <s:iterator value="getListDate()" status="i" id="listDate">
    		<s:set name="bean" value="listDate[#i.index]" />
  	  		 <li id="md_<s:property value='%{#bean[3]}' />" style="display: none"><a href="javascript:void(null)" onclick="onChooseDate('<s:property value="%{#bean[3]}"/>','<s:property value='%{#i.index}' />');return false;" target="_self"><h2><s:property value="%{#bean[0]}" /></h2><h3><s:property value="%{#bean[1]}" /></h3><h4><span class="fB"><s:property value="%{#bean[2]}" /></span>项比赛</h4></a></li> 
  	  	</s:iterator>
  	  
  	  </ul>
  	  <span class="k1" id="rightControl" style="cursor:pointer;"><img src="<s:property value='basePath'/>/resources/images/pages/arrow_right.png" width="13" height="26" alt="" /></span>
  	  </div>
  	</div>
  	<div id="today" class="grid_4 alpha omega" align="left"><h2><s:property value="bssj" /> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;决赛项目</h2>
  	<marquee scrollAmount="2" width="220" height="85" onmouseover="stop()" onmouseout="start()"direction="up" scrollDelay="75">
  		<ul>
  	    	<s:iterator value="todaySc(bssj)" status="i">
	  	    		<li><a href="../visitor/sportCjcxRc-list.c?dxmmc=<s:property value="@java.net.URLEncoder@encode(dxmmc,'utf-8')" />&bssj=<s:property value='rsDate' />&cssS=5" title="<s:property value="dxmmc"/>">【<s:property  value="dxmmc"/>】<s:property value="count"/>项</a></li>
  	    	</s:iterator>
  	    	<s:if test="todaySc(null).isEmpty()">今日无决赛项目</s:if>
  	    </ul>
  	</marquee>
  	    
  </div>
  </div>
  <!-- 赛事日程 -->
