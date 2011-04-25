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
	  dUrl =  dUrl.substring(0,dUrl.lastIndexOf('/'))+'/sportCjcxRc-list.c?cssS=4&bssj='+mydate+"&mi="+middleIndex+"&departid=<s:property value='departid'/>&sx=<s:property value='sx'/>&dxmmc=<s:property value='dxmmc' />";

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

  	function jump(uri){
		location.href=uri;
	}
	function changGreen(obj){
		obj.style.color="green";
	}
	function changBlack(obj){
		obj.style.color="black";
	}
</script>
<style type="text/css">
#today1 {
	background: url(/SportsScore/resources/images/pages/bg_richeng1.png)
		no-repeat left top;
	margin-top: 7px;
	margin-left: 15px;
	height: 118px;
	width: 210px;
}
#today1 h2 {
	font-size: 12px;
	margin: 0;
	padding-left: 12px;
	padding-top: 8px;
	
}
#today1 ul {
	padding: 0px 0px 0px 5px;
}

#today1 ul li {
	margin-bottom: 1px;
}
</style>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<div id="scinfo" class="grid_16 alpha omega" >
  	<div id="today1" class="grid_4 alpha omega" align="left" >
  		<h2>通知公告</h2>
  	    <ul>
  	    	<s:iterator value="getMessage()" status="i">
  	    		<s:set name="bean" value="message[#i.index]" />
  	    		<s:if test="#bean[1].toString().length()>20" >
  	    			<li><a href="#" class="tTip"  title="<s:property value='#bean[2]' />"> &nbsp;&nbsp;&nbsp;<s:property value="#bean[1].toString().substring(0,18)" />...</a></li>
  	    		</s:if>
  	    		<s:else>
  	    			<li><a href="#" class="tTip"  title="<s:property value="#bean[2]" />">&nbsp;&nbsp;&nbsp;<s:property value="#bean[1]" /></a></li>
  	    		</s:else>
  	    	</s:iterator>
  	    </ul>
  	</div>
  	
  	<div id="today1" class="grid_4 alpha omega" align="left" >
          <s:if test="getTodayCsxm().size()>0">
          <h2 style="margin-bottom:5px;">本团今日比赛项目</h2>
          <marquee scrollAmount="2" width="220" height="85" onmouseover="stop()" onmouseout="start()"direction="up" scrollDelay="75">
          	<s:iterator value="getTodayCsxm()" status="i">
    		<s:set name="bean" value="todayCsxm[#i.index]" />
          	<ul>
          	<%
          	int i=0;
          	if(i%3==0){%><li><%}%>
          	<s:if test="#bean[3]==1">
          		<a href="../visitor/sportCjcxRc-input.c?scbm=<s:property value="#bean[2]" />&type=cj&xmmc=<s:property value="@java.net.URLEncoder@encode(#bean[0],'utf-8')" />&wid=&cssS=5" title="<s:property value="#bean[1]"/>">&nbsp;
          	【<s:property value="#bean[0]"/>】  <s:property value="#bean[1]"/>&nbsp;</a>
          	</s:if>
          	<s:else>
          		<a href="../visitor/sportCjcxRc-input.c?scbm=<s:property value="#bean[2]" />&type=md&xmmc=<s:property value="@java.net.URLEncoder@encode(#bean[0],'utf-8')" />&wid=&cssS=5" title="<s:property value="#bean[1]"/>">&nbsp;
          	【<s:property value="#bean[0]"/>】  <s:property value="#bean[1]"/>&nbsp;</a>
          	</s:else>
          	
          	<%if(i%3==0){%></li>
          	<%
          	}
          	i++; 
          	%>
          	</ul>
          </s:iterator>
          </marquee>
          </s:if>
          <s:else>
          <h2>本团今日比赛项目</h2>
          <ul><li style="margin-left: 10px;">今日无参赛项目</li></ul>
          </s:else>
      </div>
      
      <div id="today1" class="grid_4 alpha omega" align="left" >
          <h2 style="margin-bottom:5px;">本团历史战绩</h2>
          <marquee scrollAmount="2" width="220" height="85" onmouseover="stop()" onmouseout="start()"direction="up" scrollDelay="75">
           <s:iterator value="getHistoryGamesLogined()"></s:iterator>
          <s:iterator value="#dates" status="i">
          <span style="margin-left:10px; font-weight: bold;"><s:property value="%{#dates[#i.index]}" /></span><ul>
            <s:iterator value="#loginedHistoryGames" status="st">
            <s:if test="#loginedHistoryGames[#st.index][3]==#dates[#i.index]"><li>
          	<div style="cursor: pointer; color: black; font-size: 12px; font-weight: normal;padding-left: 8px;" onmousemove="changGreen(this)" onmouseout="changBlack(this)" 
          	onclick="jump('../visitor/sportCjcxRc-input.c?scbm=<s:property value="#loginedHistoryGames[#st.index][0]" />&paixu=0&sfxnsc=<s:property value='#loginedHistoryGames[#st.index][9]'/>&xmmc=<s:property value="@java.net.URLEncoder@encode(#loginedHistoryGames[#st.index][1],'utf-8')" />&wid=&sfdzxm=<s:property value="#loginedHistoryGames[#st.index][5]" />&totalXm=<s:property value="@java.net.URLEncoder@encode(#loginedHistoryGames[#st.index][6],'utf-8')" />&sfjtxm=<s:property value='#loginedHistoryGames[#st.index][7]' />&cssS=5<s:if test="%{#loginedHistoryGames[#st.index][8]==1 && (#loginedHistoryGames[#st.index][7]==1 || #loginedHistoryGames[#st.index][7]==2) }">&type=jscj</s:if><s:else>&type=cj</s:else>')">
          	【<s:property value="#loginedHistoryGames[#st.index][1]"/>】
          	<s:if test="#loginedHistoryGames[#st.index][2].toString().length()<5" ><s:property value="#loginedHistoryGames[#st.index][2]"/>|</s:if>
          	<s:else><s:property value="#loginedHistoryGames[#st.index][2].toString().substring(0,3)"/>...| </s:else><s:property value="#loginedHistoryGames[#st.index][4].toString().replaceAll('市', '')"/>
          	</div></li>
          	</s:if>
          	</s:iterator>
          	</ul>
          	</s:iterator>
          	</marquee>
      </div>
      
      <div id="today1" class="grid_4 alpha omega" align="left"><h2>今日决赛项目</h2>
  	    <marquee scrollAmount="2" width="220" height="85" onmouseover="stop()" onmouseout="start()"direction="up" scrollDelay="75">
  		<ul>
  	    	<s:iterator value="todaySc(bssj)" status="i">
	  	    		<li><a href="../visitor/sportCjcxRc-list.c?dxmmc=<s:property value="@java.net.URLEncoder@encode(dxmmc,'utf-8')" />&bssj=<s:property value='rsDate' />" title="<s:property value="dxmmc"/>">【<s:property  value="dxmmc"/>】<s:property value="count"/>项</a></li>
  	    	</s:iterator>
  	    	<s:if test="todaySc(null).isEmpty()">今日无决赛项目</s:if>
  	    </ul>
  	</marquee>
  </div>
  </div>
  <!-- 赛事日程 -->
