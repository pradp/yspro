<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" >

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="author" content="" />
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta name="robots" content="all" />
	<title>江苏省第十七届运动会综合成绩榜</title>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/960.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/reset.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/text.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/main.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/saicheng.css" type="text/css" media="all" />
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
	<script type="text/javascript">
	listPageStyle();
	//显示项目比赛的成绩排名 cj:成绩
	function toShowScoreList(scbm){
		var uri = "../visitor/sportCjcxRc-input.c?scbm="+scbm+"&type=cj&wid=";
		openPage(uri);
	}
	//显示项目秩序单 md: 名单
	function toShowNameList(scbm,xmmc){
		var uri = "../visitor/sportCjcxRc-input.c?scbm="+scbm+"&type=md&xmmc="+xmmc+"&wid=";
		openPage(uri);
	}
	function openPage(uri){
		openWindow(uri,850,450);
	}
	</script>

</head>
<body>
<div class="container_16">
		<!-- 导入head 区域  head.jsp-->
			<jsp:include page="../common/head.jsp" flush="true"></jsp:include>
		<!-- 导入head 区域-->
<div id="container" class="grid_16"><!-- container begin -->
  
  <!--导入赛事日程  区域 （可选） ssrcDate.jsp-->
	<jsp:include page="../common/ssrcDate.jsp" flush="true"></jsp:include>
  <!--导入赛事日程  区域（可选）-->
  
  
	<!-- 主体内容区域  开始 -->
  <div id="saichengxx" class="grid_12 alpha">
  		
    	<table class="subTab" id="mainTable" summary="成绩单">
    	 <tr class="top">
           <th colspan="8" abbr="出场名单"><s:property value="#dxmmc"/><br/></th>
         </tr> 	
	     <tr>
	          <th  colspan="8" abbr="出场名单"  class="matchDate">比赛成绩</th>
	        </tr>
			<tr>
			   <th scope="col" abbr="日期"  class="ccmd">日期</th>
			   <th scope="col" abbr="级（赛）别"  class="ccmd">级（赛）别</th>
			   <th scope="col" abbr="金牌数"  class="ccmd">金牌数</th>
			   <th scope="col" abbr="赛次"  class="ccmd">赛次</th>
			   <th scope="col" abbr="场馆"  class="ccmd">场馆</th>
			   <th scope="col" abbr="秩序单/成绩"  class="ccmd">秩序单/成绩</th>
			  </tr>
			  
  		 <tbody id="listData">
	    	<s:iterator value="resultData" status="status">
	    	<tr>
	    	<td>&nbsp;<s:property value="resultData[#status.index][0]" /></td>
	    	<td>&nbsp;<s:property value="resultData[#status.index][1]" /><s:property value="resultData[#status.index][2]" /></td>
	    	<s:if test="%{resultData[#status.index][3]==null||resultData[#status.index][3]==0}">
	    	<td>--</td>
	    	</s:if>
	    	<s:else>
	    	<td>&nbsp;<s:property value="resultData[#status.index][3]" /></td>
	    	</s:else>
	    	<td>&nbsp;<s:property value="resultData[#status.index][4]" /></td>
	    	<td>&nbsp;<s:property value="resultData[#status.index][5]" /></td>
	    	<td>&nbsp;<span style="cursor:pointer; color:blue" onclick="toShowNameList('<s:property value="resultData[#status.index][5]" />','<s:property value="dxmmc" />')">秩序单</span>
	    	</td>
	    	</tr>
	    	</s:iterator>
	    	<tr>
	          <td  colspan="8" abbr="说明">说明：</td>
	        </tr>
   		 </tbody>
   		</table>
       
  </div>
    
 <!-- 主内容区 结束 -->
	<!-- 右边 登录、历史成绩、模块导入(可选) right.jsp -->
		<jsp:include page="../common/right.jsp" flush="true"></jsp:include>
	<!-- 右边 登录、历史成绩、模块导入(可选) -->
 
  
  <div class="clear"></div>
</div><!-- container end -->

<!-- 脚注部分导入 footer.jsp-->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
<!-- 脚注部分导入-->

</div>
</body>
</html>
