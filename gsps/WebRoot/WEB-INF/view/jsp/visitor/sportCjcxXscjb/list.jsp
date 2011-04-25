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
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript">
		var i =0;
		
		function getzy1(){
			//alert("1");
			i=1;
			document.getElementById("qx_later").value="";
			getzy();
		}
		function getzy(){
			//alert("3");
			var ds=document.getElementById("ds").value;
			//alert(ds);
			if(ds!=""){
		   		changeSelectHtml(ds);
		   	}
		}
		function changeSelectHtml(obj){
			//alert("2");
				ajaxService.getSelectQx(obj,ds);
		}
		function ds(result){
			//alert(result);
			var changeSelectId = "qx";
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			DWRUtil.removeAllOptions('qx');
			DWRUtil.addOptions( changeSelectId, result,'id','caption');
			var obj = document.getElementById("qx_later");
			if(obj.value != '' && i==0){
				DWRUtil.setValue(changeSelectId,obj.value);
			}
			$ = jQuery;
		}
		function find(){
			if(document.getElementById("qx").value!=""&&document.getElementById("ds").value!=""){
				var url = "../visitor/sportCjcxDbt-list.c?sx=1&jp=3&departid=" + document.getElementById("qx").value;
				window.location = url;
			}else{
				alert("请选择大市以及市（区）县");
			}
		}
	</script>
</head>
<body onload="getzy()" >
<s:hidden name="wid" value="%{#parameters.departid[0]}" id="departid" />
<input type="hidden" value="<s:property value="qx" />" id="qx_later" />
<div class="container_16">
		<!-- 导入head 区域  head.jsp-->
			<jsp:include page="../common/head.jsp" flush="true"></jsp:include>
		<!-- 导入head 区域-->
<div id="container" class="grid_16"><!-- container begin -->
  
  <div>
  	&nbsp;
  </div>
  
    
  <table width="85%">
		<tr>
			<td style="background: white;" valign="top">
				<s:select theme="simple" name="ds" id ="ds" list="getDbdName()" listKey="caption" onchange="getzy1()" listValue="caption" headerKey="" headerValue="--请选择 市--"/>
			</td>
			<td>
				<s:select list="#{}" listKey="id" id="qx" theme="simple" headerKey="" headerValue="--请选择 区县--" listValue="caption" name="qx"></s:select>
			</td>
			<td> 
				<img src="<s:property value="basePath"/>/resources/images/gif-0083.gif" style=" cursor: pointer; margin-top: 3px; " onclick="find()" alt="查询" />
			</td>
		</tr>
	</table>
	<!-- 主体内容区域  开始 -->
    <div  class="grid_6 alpha">
       <table class="subTab" cellspacing="0" summary="直辖区成绩榜">
         <tr>
           <th  colspan="7" abbr="直辖区成绩榜"  class="matchDate">各区（省辖市的）金牌榜</th>
         </tr>
         <tr>
           <td scope="col" abbr="合计" width="25%">名次</td>
           <td scope="col" width="55%">地区</td>
           <td scope="col" abbr="金牌" width="20%"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" style="margin-bottom:-6px;" /></td>
         </tr>
		 <s:iterator value="list_zxq" status="status">
			<tr>
				<s:if test="#status.index%2==1">
			    	<td scope="row" class="alt"><s:property value="#list_zxq[#status.index][3]"/></td> 
			    	<td scope="row" class="alt"><a href='../visitor/sportCjcxDbt-list.c?sx=1&jp=3&departid=<s:property value="#list_zxq[#status.index][2]"/>' ><s:property value="#list_zxq[#status.index][0]"/></a></td>
				    <td scope="row" class="gpai"><a href='../visitor/sportCjcxDbt-list.c?sx=1&jp=0&departid=<s:property value="#list_zxq[#status.index][2]"/>' ><s:property value="#list_zxq[#status.index][1]"/></a></td> 
			    </s:if>
			    <s:else>
				    <td><s:property value="#list_zxq[#status.index][3]"/></td> 
				    <td><a href='../visitor/sportCjcxDbt-list.c?sx=1&jp=3&departid=<s:property value="#list_zxq[#status.index][2]"/>' ><s:property value="#list_zxq[#status.index][0]"/></a></td> 
				    <td class="gpai"><a href='../visitor/sportCjcxDbt-list.c?sx=1&jp=0&departid=<s:property value="#list_zxq[#status.index][2]"/>' ><s:property value="#list_zxq[#status.index][1]"/></a></td> 
			    </s:else>
			 </tr>
    	 </s:iterator>
       </table>
  </div>
  
   <div class="grid_6">
      <table class="subTab" cellspacing="0" summary="区县成绩榜">
        <tr>
          <th  colspan="7" abbr="区县成绩榜"  class="matchDate">各县（市、区）金牌榜</th>
        </tr>
        <tr>
          <td scope="col" abbr="合计" width="25%">名次</td>
          <td scope="col" width="55%">地区</td>
           <td scope="col" abbr="金牌" width="20%"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" style="margin-bottom:-6px;" /></td>
        </tr>
        <s:iterator value="list_qx" status="status">
        	<s:if test="#status.index%2==1">
				 <tr>
			    	 <td scope="row" class="alt"><s:property value="#list_qx[#status.index][3]"/></td>
			    	 <td scope="row" class="alt" ><a href='../visitor/sportCjcxDbt-list.c?sx=1&jp=3&departid=<s:property value="#list_qx[#status.index][2]"/>' name="list_qx"><s:property value="#list_qx[#status.index][0]"/></a></td> 
			    	 <td scope="row" class="gpai"><a href='../visitor/sportCjcxDbt-list.c?sx=1&jp=0&departid=<s:property value="#list_qx[#status.index][2]"/>' ><s:property value="#list_qx[#status.index][1]"/></a></td> 
			     </tr>
        	</s:if>
        	<s:else>
        		<tr>
			    	 <td><s:property value="#list_qx[#status.index][3]"/></td>
			    	 <td><a href='../visitor/sportCjcxDbt-list.c?sx=1&jp=3&departid=<s:property value="#list_qx[#status.index][2]"/>' ><s:property value="#list_qx[#status.index][0]"/></a></td> 
			    	 <td class="gpai"><a href='../visitor/sportCjcxDbt-list.c?sx=1&jp=0&departid=<s:property value="#list_qx[#status.index][2]"/>' ><s:property value="#list_qx[#status.index][1]"/></a></td> 
			     </tr>
        	</s:else>
    	</s:iterator>
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
