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
	<style type="text/css">
		#jsysxm {
			background: url(/SportsScore/resources/images/pages/bg_jsysxm.jpg)
				no-repeat center top;
			padding-top: 95px;  
		}
		#paipang{
			display: none;
			text-align: center;
			font-size: 24px;
		}
	</style>
	<style type="text/css" media="print">
		#todis{
			display: none;
		}
		#paipang{
			display: block;
		}
		body {
			background: ;
		}
	</style>
	<script>
		/*function toPrint(){
			
			var content = "<div class=\"container_16\">"+"<div id=\"container\" class=\"grid_16\">"+document.getElementById('dy').innerHTML+"</div></div>";
			document.printPage.document.body.innerHTML = content;
			document.printPage.focus();
			window.print();
		    return false;
		}*/
		function toPrint2(){
			window.print();
		    return false;
		}
			
	</script>
</head>
<body>
<s:hidden name="wid" value="%{#parameters.departid[0]}" id="departid" />
<div class="container_16">
	<div id="todis">
		<!-- 导入head 区域  head.jsp-->
			<jsp:include page="../common/head.jsp" flush="true"></jsp:include>
		<!-- 导入head 区域-->
	</div>
		
<div id="container" class="grid_16"><!-- container begin -->
	<div id="todis">
		 <!--历史成绩、模块导入(可选) nbbd.jsp-->
			<jsp:include page="../common/nbbd.jsp" flush="true"></jsp:include>
 		 <!--历史成绩、模块导入(可选) -->
	</div>
  
	<!-- 主体内容区域  开始 -->
	<div id="dy">
  <div id="jinpai" class="grid_jp alpha">
       <table class="mytable" cellspacing="0" summary="金牌榜">
       	<tr id="paipang">
       		<td align="center" colspan="6" ><b>金牌榜</b></td>
       	</tr>
         <tr>
           <th scope="col" abbr="排名" style="text-align: center"><strong>排名</strong></th>
           <th scope="col" abbr="代表团" style="text-align: center"><strong>代表团</strong></th>
           <th scope="col" abbr="金牌" style="text-align: center"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" /></th>
           <th scope="col" abbr="银牌" style="text-align: center"><img src="<s:property value="basePath"/>/resources/images/pages/s.png" alt="银牌" /></th>
           <th scope="col" abbr="铜牌" style="text-align: center"><img src="<s:property value="basePath"/>/resources/images/pages/b.png" alt="铜牌" /></th>
           <th scope="col" abbr="合计" style="text-align: center"><strong>合计</strong></th>
         </tr>
        <s:set name="str1" value="0" />
        <s:set name="ydybm1" value="-1" />
         <s:iterator value="list_jpb" status="status">
				  	<s:if test="#status.index%2==1">
				  			<tr>
				  				<s:if test="#ydybm1==#list_jpb[#status.index][4]"><s:set name="str1" value="#str1" /></s:if>
			      				<s:else><s:set name="str1" value="%{#status.index+1}" /></s:else>
					  			<td class="alt" scope="row" abbr="<s:property value="#list_jpb[#status.index][0]"/>" class="specalt" style="text-align: center"><s:property value="#list_jpb[#status.index][0]"/></td>
					  			<td class="alt" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_jpb[#status.index][2]"/>' ><s:property value="#list_jpb[#status.index][1]"/></a></td>
					  		 	<td class="gpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=0&departid=<s:property value="#list_jpb[#status.index][2]"/>' ><s:property value="#list_jpb[#status.index][4]"/></a></td>
				    	      	<td class="spai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=1&departid=<s:property value="#list_jpb[#status.index][2]"/>' ><s:property value="#list_jpb[#status.index][5]"/></a></td>
				    	      	<td class="bpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=2&departid=<s:property value="#list_jpb[#status.index][2]"/>' ><s:property value="#list_jpb[#status.index][6]"/></a></td>
				    	      	<td class="alt" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_jpb[#status.index][2]"/>' ><s:property value="#list_jpb[#status.index][7]"/></a></td>
					  			<s:set name="ydybm1" value="#list_jpb[#status.index][4]" />
					  			
					  			<%-- 
				    	      	<td class="alt"><a href='../visitor/sportJytp-list.c?jp=0&departid=<s:property value="#list_jpb[#status.index][4]"/>' ><s:property value="#list_jpb[#status.index][1]"/></a></td>
				    	      	<td class="alt"><a href='../visitor/sportJytp-list.c?jp=1&departid=<s:property value="#list_jpb[#status.index][4]"/>'><s:property value="#list_jpb[#status.index][2]"/></a></td>
				    	      	<td class="alt"><a href='../visitor/sportJytp-list.c?jp=2&departid=<s:property value="#list_jpb[#status.index][4]"/>'><s:property value="#list_jpb[#status.index][3]"/></a></td>
				    	      	<td class="alt"><a href='../visitor/sportJytp-list.c?jp=3&departid=<s:property value="#list_jpb[#status.index][4]"/>' ><s:property value="#list_jpb[#status.index][5]"/></a></td> 
					  			--%>
				  			</tr>
				  	</s:if>
				  	<s:else>
				  			<tr>
				  				<s:if test="#ydybm1==#list_jpb[#status.index][3]"><s:set name="str1" value="#str1" /></s:if>
			      				<s:else><s:set name="str1" value="%{#status.index+1}" /></s:else>
				  			    <td scope="row" abbr="<s:property value="#list_jpb[#status.index][1]"/>" class="spec" style="text-align: center"><s:property value="#list_jpb[#status.index][0]"/></td>
					  			<td style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_jpb[#status.index][2]"/>' ><s:property value="#list_jpb[#status.index][1]"/></a></td> 
				    	      	<td class="gpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=0&departid=<s:property value="#list_jpb[#status.index][2]"/>' ><s:property value="#list_jpb[#status.index][4]"/></a></td>
				    	      	<td class="spai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=1&departid=<s:property value="#list_jpb[#status.index][2]"/>' ><s:property value="#list_jpb[#status.index][5]"/></a></td>
				    	      	<td class="bpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=2&departid=<s:property value="#list_jpb[#status.index][2]"/>' ><s:property value="#list_jpb[#status.index][6]"/></a></td>
				    	      	<td style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_jpb[#status.index][2]"/>' ><s:property value="#list_jpb[#status.index][7]"/></a></td> 
				    	      	<s:set name="ydybm1" value="#list_jpb[#status.index][3]" />
				  			</tr>
				  	</s:else>
			    	
    	</s:iterator>
       </table>
  </div>
  
  <div id="jiangpai" class="grid_jp">
       <table class="mytable" cellspacing="0" summary="奖牌榜">
       	<tr id="paipang">
       		<td align="center" colspan="6" ><b>奖牌榜</b></td>
       	</tr>
         <tr>
           <th scope="col" abbr="排名" style="text-align: center"><strong>排名</strong></th>
           <th scope="col" abbr="代表团" style="text-align: center"><strong>代表团</strong></th>
           <th scope="col" abbr="金牌" style="text-align: center"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" /></th>
           <th scope="col" abbr="银牌" style="text-align: center"><img src="<s:property value="basePath"/>/resources/images/pages/s.png" alt="银牌" /></th>
           <th scope="col" abbr="铜牌" style="text-align: center"><img src="<s:property value="basePath"/>/resources/images/pages/b.png" alt="铜牌" /></th>
           <th scope="col" abbr="合计" style="text-align: center"><strong>合计</strong></th>
         </tr>
          <s:set name="str1" value="0" />
        <s:set name="ydybm1" value="-1" />
          <s:iterator value="list_sum" status="status">
				  <s:if test="#status.index%2==1">
				       <tr>
				       		<s:if test="#ydybm1==#list_sum[#status.index][7]"><s:set name="str1" value="#str1" /></s:if>
			      			<s:else><s:set name="str1" value="%{#status.index+1}" /></s:else>
				  			<td class="alt" scope="row" abbr="<s:property value="#list_sum[#status.index][2]"/>" class="specalt" style="text-align: center"><s:property value="#list_sum[#status.index][0]"/></td>
				  			<td class="alt" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_sum[#status.index][2]"/>' ><s:property value="#list_sum[#status.index][1]"/></a></td>
				  			<td class="gpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=0&departid=<s:property value="#list_sum[#status.index][2]"/>' ><s:property value="#list_sum[#status.index][4]"/></a></td> 
			    	      	<td class="spai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=1&departid=<s:property value="#list_sum[#status.index][2]"/>' ><s:property value="#list_sum[#status.index][5]"/></a></td>
			    	      	<td class="bpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=2&departid=<s:property value="#list_sum[#status.index][2]"/>' ><s:property value="#list_sum[#status.index][6]"/></a></td>
			    	      	<td class="alt" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_sum[#status.index][2]"/>' ><s:property value="#list_sum[#status.index][7]"/></a></td>
			    	      	<s:set name="ydybm1" value="#list_sum[#status.index][7]" />
				  			
				  			<%-- style="text-align: center"
			    	      	<td class="alt"><a href='../visitor/sportJytp-list.c?jp=0&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][2]"/></a></td> 
			    	      	<td class="alt"><a href='../visitor/sportJytp-list.c?jp=1&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][3]"/></a></td>
			    	      	<td class="alt"><a href='../visitor/sportJytp-list.c?jp=2&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][4]"/></a></td>
			    	      	<td class="alt"><a href='../visitor/sportJytp-list.c?jp=3&departid=<s:property value="#list_sum[#status.index][5]"/>' ><s:property value="#list_sum[#status.index][6]"/></a></td>
				  			--%>
				  		</tr>
				  </s:if>
				  <s:else>
				  		<tr>
				  			<s:if test="#ydybm1==#list_sum[#status.index][7]"><s:set name="str1" value="#str1" /></s:if>
			      			<s:else><s:set name="str1" value="%{#status.index+1}" /></s:else>
				  			<td scope="row" abbr="<s:property value="#list_sum[#status.index][1]"/>" class="spec" style="text-align: center"><s:property value="#list_sum[#status.index][0]"/></td>
				  			<td style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_sum[#status.index][2]"/>' ><s:property value="#list_sum[#status.index][1]"/></a></td> 
			    	      	<td class="gpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=0&departid=<s:property value="#list_sum[#status.index][2]"/>' ><s:property value="#list_sum[#status.index][4]"/></a></td>
			    	      	<td class="spai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=1&departid=<s:property value="#list_sum[#status.index][2]"/>' ><s:property value="#list_sum[#status.index][5]"/></a></td>
			    	      	<td class="bpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=2&departid=<s:property value="#list_sum[#status.index][2]"/>' ><s:property value="#list_sum[#status.index][6]"/></a></td>
			    	      	<td style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_sum[#status.index][2]"/>' ><s:property value="#list_sum[#status.index][7]"/></a></td> 
			    	      	<s:set name="ydybm1" value="#list_sum[#status.index][7]" />
				  		</tr>
				  </s:else>
    	</s:iterator>
       </table>
       
  </div>
  
  <div id="jifen" class="grid_jp">
      <table class="mytable" cellspacing="0" summary="金牌榜">
      	<tr id="paipang">
       		<td align="center" colspan="6" ><b>积分榜</b></td>
       	</tr>
        <tr>
          <th scope="col" abbr="排名" class="title" style="text-align: center"><strong>排名</strong></th>
          <th scope="col" abbr="代表团" class="title" style="text-align: center"><strong>代表团</strong></th>
          <th scope="col" abbr="总分" class="title" style="text-align: center"><strong>总分</strong></th>
        </tr>
         <s:set name="str1" value="0" />
        <s:set name="ydybm1" value="-1" />
         <s:iterator value="list_jfb" status="status">
				  	<s:if test="#status.index%2==1">
				  	   <tr>
				  	   		<s:if test="#ydybm1==#list_jfb[#status.index][3]"><s:set name="str1" value="#str1" /></s:if>
			      			<s:else><s:set name="str1" value="%{#status.index+1}" /></s:else>
				  			<td class="alt" scope="row" abbr="<s:property value="#list_jfb[#status.index][1]"/>" class="specalt" style="text-align: center"><s:property value="#list_jfb[#status.index][0]"/></td>
				  			<td class="alt" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_jfb[#status.index][2]"/>' ><s:property value="#list_jfb[#status.index][1]"/></a></td> 
    						<td class="alt" style="text-align: center">&nbsp;<a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=4&departid=<s:property value="#list_jfb[#status.index][2]"/>' ><s:property value="#list_jfb[#status.index][3]"/></a></td>
  							<s:set name="ydybm1" value="#list_jfb[#status.index][3]" />
  						</tr>
				  	</s:if>
				  	<s:else>
				  	    <tr>
				  	    	<s:if test="#ydybm1==#list_jfb[#status.index][3]"><s:set name="str1" value="#str1" /></s:if>
			      			<s:else><s:set name="str1" value="%{#status.index+1}" /></s:else>
				  			<td scope="row" abbr="<s:property value="#list_jfb[#status.index][1]"/>" class="spec" style="text-align: center"><s:property value="#list_jfb[#status.index][0]"/></td>
				  			<td style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_jfb[#status.index][2]"/>' ><s:property value="#list_jfb[#status.index][1]"/></a></td> 
    						<td style="text-align: center">&nbsp;<a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=4&departid=<s:property value="#list_jfb[#status.index][2]"/>' ><s:property value="#list_jfb[#status.index][3]"/></a></td>
    						<s:set name="ydybm1" value="#list_jfb[#status.index][3]" />
			    		</tr>
			    	</s:else>
    	</s:iterator>
      </table>
  </div>

  <div id="silder" class="grid_4 omega">
 		<div id="jsysxm">
      <table class="mytable" cellspacing="0" summary="金牌榜">
      	<tr id="paipang">
       		<td align="center" colspan="6"><b>优势项目排行榜</b></td>
       	</tr>
        <tr>
          <th scope="col" abbr="排名" class="title" style="text-align: center"><strong>排名</strong></th>
          <th scope="col" abbr="代表团" class="title" style="text-align: center"><strong>代表团</strong></th>
          <th scope="col" abbr="总分" class="title" style="text-align: center"><strong>总分</strong></th>
        </tr>
        <s:set name="str1" value="0" />
        <s:set name="ydybm1" value="-1" />
         <s:iterator value="list_ysjfb" status="status">
				  	<s:if test="#status.index%2==1">
				  	    <tr>
				  	    	<s:if test="#ydybm1==#list_ysjfb[#status.index][2]"><s:set name="str1" value="#str1" /></s:if>
			      			<s:else><s:set name="str1" value="%{#status.index+1}" /></s:else>
				  			<td class="alt" scope="row" abbr="<s:property value="#list_ysjfb[#status.index][0]"/>" class="specalt" style="text-align: center"><s:property value="#str1" /></td>
				  			<td class="alt" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_ysjfb[#status.index][1]"/>' ><s:property value="#list_ysjfb[#status.index][0]"/></a></td> 
    						<td class="alt" style="text-align: center">&nbsp;<a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=4&departid=<s:property value="#list_ysjfb[#status.index][1]"/>' ><s:property value="#list_ysjfb[#status.index][2]"/></a></td>
			      			<s:set name="ydybm1" value="#list_ysjfb[#status.index][2]" />
  						</tr>
				  	</s:if>
				  	<s:else>
				  	    <tr>
				  	    	<s:if test="#ydybm1==#list_ysjfb[#status.index][2]"><s:set name="str1" value="#str1" /></s:if>
			      			<s:else><s:set name="str1" value="%{#status.index+1}" /></s:else>
				  			<td scope="row" abbr="<s:property value="#list_jfb[#status.index][0]"/>" class="spec" style="text-align: center"><s:property value="#str1" /></td>
				  			<td style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_ysjfb[#status.index][1]"/>' ><s:property value="#list_ysjfb[#status.index][0]"/></a></td> 
    						<td style="text-align: center">&nbsp;<a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=4&departid=<s:property value="#list_ysjfb[#status.index][1]"/>' ><s:property value="#list_ysjfb[#status.index][2]"/></a></td>
    						<s:set name="ydybm1" value="#list_ysjfb[#status.index][2]" />
			    		</tr>
			    	</s:else>
    	</s:iterator>
      </table>
  </div>
 </div>
  <!-- 主内容区 结束 -->
  <div class="clear"></div>
  <p></p>
  <div><span style="color : red;">说明:此榜是各代表团参与的所有项目成绩的综合统计排行 &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="cursor: pointer;" id="todis" onclick="toPrint2()" title="打印榜单"><img src="<s:property value="basePath"/>/resources/images/print.bmp"  width="20" height="20"/><span style="color: blue; ">打印榜单</span><span style="color:gray; font-size:12px;">(请选择横向打印)</span></span></div>
  </div>
</div>
	<div id="todis">
	<!-- container end -->
	<!-- 脚注部分导入 footer.jsp-->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>  
	</div>
<!-- 脚注部分导入-->
</div>
</body>
</html>
