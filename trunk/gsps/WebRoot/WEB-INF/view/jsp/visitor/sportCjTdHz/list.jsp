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
	
</head>
<body>
<s:hidden name="wid" value="%{#parameters.departid[0]}" id="departid" />
<div class="container_16">
		<!-- 导入head 区域  head.jsp-->
			<jsp:include page="../common/head.jsp" flush="true"></jsp:include>
		<!-- 导入head 区域-->
<div id="container" class="grid_16"><!-- container begin -->
  
  <!--导入赛事日程  区域 （可选） ssrcDate.jsp-->
	<jsp:include page="../common/ssrcDate.jsp" flush="true"></jsp:include>
  <!--导入赛事日程  区域（可选）-->
  
  
	<!-- 主体内容区域  开始 -->
  <div id="jinpai" class="grid_jp alpha">
       <table class="mytable" cellspacing="0" summary="金牌榜">
         <tr>
           <th scope="col" abbr="排名" style="text-align: center"><strong>排名</strong></th>
           <th scope="col" abbr="代表团" style="text-align: center"><strong>代表团</strong></th>
           <th scope="col" abbr="金牌" style="text-align: center"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" /></th>
           <th scope="col" abbr="银牌" style="text-align: center"><img src="<s:property value="basePath"/>/resources/images/pages/s.png" alt="银牌" /></th>
           <th scope="col" abbr="铜牌" style="text-align: center"><img src="<s:property value="basePath"/>/resources/images/pages/b.png" alt="铜牌" /></th>
           <th scope="col" abbr="合计" style="text-align: center"><strong>合计</strong></th>
         </tr>
         
         	<s:if test="getUserLoginId() != null && getUserLoginId() != '' " >
         		<s:iterator value="list_jpb" status="status">
         		<s:if test="#status.index%2==1">
         		
				  			<tr>
					  			<td class="alt" scope="row" abbr="<s:property value="#list_jpb[#status.index][0]"/>" class="specalt" style="text-align: center"><s:property value="#list_jpb[#status.index][0]"/></td>
					  			<td class="alt" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_jpb[#status.index][5]"/>' ><s:property value="#list_jpb[#status.index][1]"/></a></td>
					  		 	<td class="gpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=0&departid=<s:property value="#list_jpb[#status.index][5]"/>' ><s:property value="#list_jpb[#status.index][2]"/></a></td>
				    	      	<td class="spai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=1&departid=<s:property value="#list_jpb[#status.index][5]"/>'><s:property value="#list_jpb[#status.index][3]"/></a></td>
				    	      	<td class="bpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=2&departid=<s:property value="#list_jpb[#status.index][5]"/>'><s:property value="#list_jpb[#status.index][4]"/></a></td>
				    	      	<td class="alt" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_jpb[#status.index][5]"/>' ><s:property value="#list_jpb[#status.index][6]"/></a></td>
				  			</tr>
				  	</s:if>
				  	<s:else>
				  			<tr>
				  			    <td scope="row" abbr="<s:property value="#list_jpb[#status.index][0]"/>" class="spec" style="text-align: center"><s:property value="#list_jpb[#status.index][0]"/></td>
					  			<td style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_jpb[#status.index][5]"/>' ><s:property value="#list_jpb[#status.index][1]"/></a></td> 
				    	      	<td class="gpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=0&departid=<s:property value="#list_jpb[#status.index][5]"/>' ><s:property value="#list_jpb[#status.index][2]"/></a></td>
				    	      	<td class="spai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=1&departid=<s:property value="#list_jpb[#status.index][5]"/>'><s:property value="#list_jpb[#status.index][3]"/></a></td>
				    	      	<td class="bpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=2&departid=<s:property value="#list_jpb[#status.index][5]"/>'><s:property value="#list_jpb[#status.index][4]"/></a></td>
				    	      	<td style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_jpb[#status.index][5]"/>' ><s:property value="#list_jpb[#status.index][6]"/></a></td> 
				  			</tr>
				  	</s:else>
				</s:iterator>
         	</s:if>
         	<s:else>
         		<s:iterator value="list_jpb" status="status">
         		 	<s:if test="#status.index%2==1">
				  			<tr>
					  			<td class="alt" scope="row" abbr="<s:property value="#list_jpb[#status.index][0]"/>" class="specalt" style="text-align: center"><s:property value="#list_jpb[#status.index][0]"/></td>
					  			<td class="alt" style="text-align: center"><a href='<s:property value="@com.imchooser.infoms.util.GetDbtUrl@getUrl(#list_jpb[#status.index][5])" />' ><s:property value="#list_jpb[#status.index][1]"/></a></td>
					  		 	<td class="gpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=0&departid=<s:property value="#list_jpb[#status.index][5]"/>' ><s:property value="#list_jpb[#status.index][2]"/></a></td>
				    	      	<td class="spai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=1&departid=<s:property value="#list_jpb[#status.index][5]"/>'><s:property value="#list_jpb[#status.index][3]"/></a></td>
				    	      	<td class="bpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=2&departid=<s:property value="#list_jpb[#status.index][5]"/>'><s:property value="#list_jpb[#status.index][4]"/></a></td>
				    	      	<td class="alt" style="text-align: center"><a href='<s:property value="@com.imchooser.infoms.util.GetDbtUrl@getUrl(#list_jpb[#status.index][5])" />S' ><s:property value="#list_jpb[#status.index][6]"/></a></td>
				  			</tr>
				  	</s:if>
				  	<s:else>
				  			<tr>
				  			    <td scope="row" abbr="<s:property value="#list_jpb[#status.index][0]"/>" class="spec" style="text-align: center"><s:property value="#list_jpb[#status.index][0]"/></td>
					  			<td style="text-align: center"><a href='<s:property value="@com.imchooser.infoms.util.GetDbtUrl@getUrl(#list_jpb[#status.index][5])" />' ><s:property value="#list_jpb[#status.index][1]"/></a></td> 
				    	      	<td class="gpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=0&departid=<s:property value="#list_jpb[#status.index][5]"/>' ><s:property value="#list_jpb[#status.index][2]"/></a></td>
				    	      	<td class="spai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=1&departid=<s:property value="#list_jpb[#status.index][5]"/>'><s:property value="#list_jpb[#status.index][3]"/></a></td>
				    	      	<td class="bpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=2&departid=<s:property value="#list_jpb[#status.index][5]"/>'><s:property value="#list_jpb[#status.index][4]"/></a></td>
				    	      	<td style="text-align: center"><a href='<s:property value="@com.imchooser.infoms.util.GetDbtUrl@getUrl(#list_jpb[#status.index][5])" />' ><s:property value="#list_jpb[#status.index][6]"/></a></td> 
				  			</tr>
				  	</s:else>
				</s:iterator>
         	</s:else>
       </table>
  </div>
  
  <div id="jiangpai" class="grid_jp">
       <table class="mytable" cellspacing="0" summary="奖牌榜">
         <tr>
           <th scope="col" abbr="排名" style="text-align: center"><strong>排名</strong></th>
           <th scope="col" abbr="代表团" style="text-align: center"><strong>代表团</strong></th>
           <th scope="col" abbr="金牌" style="text-align: center"><img src="<s:property value="basePath"/>/resources/images/pages/g.png" alt="金牌" /></th>
           <th scope="col" abbr="银牌" style="text-align: center"><img src="<s:property value="basePath"/>/resources/images/pages/s.png" alt="银牌" /></th>
           <th scope="col" abbr="铜牌" style="text-align: center"><img src="<s:property value="basePath"/>/resources/images/pages/b.png" alt="铜牌" /></th>
           <th scope="col" abbr="合计" style="text-align: center"><strong>合计</strong></th>
         </tr>
          	<s:if test="getUserLoginId() != null && getUserLoginId() != '' " >
          		<s:iterator value="list_jpb" status="status">
	          	 	<s:if test="#status.index%2==1">
					       <tr>
					  			<td class="alt" scope="row" abbr="<s:property value="#list_sum[#status.index][1]"/>" class="specalt" style="text-align: center"><s:property value="#list_sum[#status.index][0]"/></td>
					  			<td class="alt" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_sum[#status.index][5]"/>' ><s:property value="#list_sum[#status.index][1]"/></a></td>
					  			<td class="gpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=0&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][2]"/></a></td> 
				    	      	<td class="spai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=1&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][3]"/></a></td>
				    	      	<td class="bpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=2&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][4]"/></a></td>
				    	      	<td class="alt" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_sum[#status.index][5]"/>' ><s:property value="#list_sum[#status.index][6]"/></a></td>
					  		</tr>
					  </s:if>
					  <s:else>
					  		<tr>
					  			<td scope="row" abbr="<s:property value="#list_sum[#status.index][1]"/>" class="spec" style="text-align: center"><s:property value="#list_sum[#status.index][0]"/></td>
					  			<td style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_sum[#status.index][5]"/>' ><s:property value="#list_sum[#status.index][1]"/></a></td> 
				    	      	<td class="gpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=0&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][2]"/></a></td>
				    	      	<td class="spai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=1&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][3]"/></a></td>
				    	      	<td class="bpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=2&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][4]"/></a></td>
				    	      	<td style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_sum[#status.index][5]"/>' ><s:property value="#list_sum[#status.index][6]"/></a></td> 
					  		</tr>
					  </s:else>
				  </s:iterator>
          	</s:if>
          	<s:else>
          		<s:iterator value="list_jpb" status="status">
	          		  <s:if test="#status.index%2==1">
					       <tr>
					  			<td class="alt" scope="row" abbr="<s:property value="#list_sum[#status.index][1]"/>" class="specalt" style="text-align: center"><s:property value="#list_sum[#status.index][0]"/></td>
					  			<td class="alt" style="text-align: center"><a href='<s:property value="@com.imchooser.infoms.util.GetDbtUrl@getUrl(#list_sum[#status.index][5])" />' ><s:property value="#list_sum[#status.index][1]"/></a></td>
					  			<td class="gpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=0&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][2]"/></a></td> 
				    	      	<td class="spai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=1&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][3]"/></a></td>
				    	      	<td class="bpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=2&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][4]"/></a></td>
				    	      	<td class="alt" style="text-align: center"><a href='<s:property value="@com.imchooser.infoms.util.GetDbtUrl@getUrl(#list_sum[#status.index][5])" />' ><s:property value="#list_sum[#status.index][6]"/></a></td>
					  		</tr>
					  </s:if>
					  <s:else>
					  		<tr>
					  			<td scope="row" abbr="<s:property value="#list_sum[#status.index][1]"/>" class="spec" style="text-align: center"><s:property value="#list_sum[#status.index][0]"/></td>
					  			<td style="text-align: center"><a href='<s:property value="@com.imchooser.infoms.util.GetDbtUrl@getUrl(#list_sum[#status.index][5])" />' ><s:property value="#list_sum[#status.index][1]"/></a></td> 
				    	      	<td class="gpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=0&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][2]"/></a></td>
				    	      	<td class="spai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=1&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][3]"/></a></td>
				    	      	<td class="bpai" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=2&departid=<s:property value="#list_sum[#status.index][5]"/>'><s:property value="#list_sum[#status.index][4]"/></a></td>
				    	      	<td style="text-align: center"><a href='<s:property value="@com.imchooser.infoms.util.GetDbtUrl@getUrl(#list_sum[#status.index][5])" />' ><s:property value="#list_sum[#status.index][6]"/></a></td> 
					  		</tr>
					  </s:else>
          		</s:iterator>
          	</s:else>
       </table>
       
  </div>
  
  <div id="jifen" class="grid_jp">
      <table class="mytable" cellspacing="0" summary="总分榜">
        <tr>
          <th scope="col" abbr="排名" class="title" style="text-align: center"><strong>排名</strong></th>
          <th scope="col" abbr="代表团" class="title" style="text-align: center"><strong>代表团</strong></th>
          <th scope="col" abbr="总分" class="title" style="text-align: center"><strong>总分</strong></th>
        </tr>
        	 <s:if test="getUserLoginId() != null && getUserLoginId() != '' " >
        	 	<s:iterator value="list_jpb" status="status">
	        	 	<s:if test="#status.index%2==1">
					  	   <tr>
					  			<td class="alt" scope="row" abbr="<s:property value="#list_jfb[#status.index][1]"/>" class="specalt" style="text-align: center"><s:property value="#list_jfb[#status.index][0]"/></td>
					  			<td class="alt" style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_jfb[#status.index][3]"/>' ><s:property value="#list_jfb[#status.index][1]"/></a></td> 
				    	      	<s:if test="%{#list_jfb[#status.index][2]==null||#list_jfb[#status.index][2]==''}">
	    							<td class="alt" style="text-align: center">--</td>
	    						</s:if>
	    						<s:else>
	    							<td class="alt" style="text-align: center">&nbsp;<a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=4&departid=<s:property value="#list_jfb[#status.index][3]"/>' ><s:property value="#list_jfb[#status.index][2]"/></a></td>
	    						</s:else>
	  						</tr>
					  	</s:if>
					  	<s:else>
					  	    <tr>
					  			<td scope="row" abbr="<s:property value="#list_jfb[#status.index][1]"/>" class="spec" style="text-align: center"><s:property value="#list_jfb[#status.index][0]"/></td>
					  			<td style="text-align: center"><a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=3&departid=<s:property value="#list_jfb[#status.index][3]"/>' ><s:property value="#list_jfb[#status.index][1]"/></a></td> 
				    	      	<s:if test="%{#list_jfb[#status.index][2]==null||#list_jfb[#status.index][2]==''}">
				    	      	<td style="text-align: center">--</td>
	    						</s:if>
	    						<s:else>
	    							<td style="text-align: center">&nbsp;<a href='../visitor/sportCjcxDbt-list.c?cssS=2&jp=4&departid=<s:property value="#list_jfb[#status.index][3]"/>' ><s:property value="#list_jfb[#status.index][2]"/></a></td>
	    						</s:else>
				    		</tr>
				    	</s:else>
			    </s:iterator>
        	 </s:if>
        	 <s:else>
        	 	<s:iterator value="list_jpb" status="status">
	        	 	<s:if test="#status.index%2==1">
					  	   <tr>
					  			<td class="alt" scope="row" abbr="<s:property value="#list_jfb[#status.index][1]"/>" class="specalt" style="text-align: center"><s:property value="#list_jfb[#status.index][0]"/></td>
					  			<td class="alt" style="text-align: center"><a href='<s:property value="@com.imchooser.infoms.util.GetDbtUrl@getUrl(#list_jfb[#status.index][3])" />' ><s:property value="#list_jfb[#status.index][1]"/></a></td> 
				    	      	<s:if test="%{#list_jfb[#status.index][2]==null||#list_jfb[#status.index][2]==''}">
	    							<td class="alt" style="text-align: center">--</td>
	    						</s:if>
	    						<s:else>
	    							<td class="alt" style="text-align: center">&nbsp;<a href='<s:property value="@com.imchooser.infoms.util.GetDbtUrl@getUrl(#list_jfb[#status.index][3])" />' ><s:property value="#list_jfb[#status.index][2]"/></a></td>
	    						</s:else>
	  						</tr>
					  	</s:if>
					  	<s:else>
					  	    <tr>
					  			<td scope="row" abbr="<s:property value="#list_jfb[#status.index][1]"/>" class="spec" style="text-align: center"><s:property value="#list_jfb[#status.index][0]"/></td>
					  			<td style="text-align: center"><a href='<s:property value="@com.imchooser.infoms.util.GetDbtUrl@getUrl(#list_jfb[#status.index][3])" />' ><s:property value="#list_jfb[#status.index][1]"/></a></td> 
				    	      	<s:if test="%{#list_jfb[#status.index][2]==null||#list_jfb[#status.index][2]==''}">
				    	      	<td style="text-align: center">--</td>
	    						</s:if>
	    						<s:else>
	    							<td style="text-align: center">&nbsp;<a href='<s:property value="@com.imchooser.infoms.util.GetDbtUrl@getUrl(#list_jfb[#status.index][3])" />' ><s:property value="#list_jfb[#status.index][2]"/></a></td>
	    						</s:else>
				    		</tr>
				     </s:else>
			    	</s:iterator>
        	 </s:else>
      </table>
  </div>

 <!-- 主内容区 结束 -->
	<!-- 右边 登录、历史成绩、模块导入(可选) right.jsp -->
		<jsp:include page="../common/right.jsp" flush="true"></jsp:include>
	<!-- 右边 登录、历史成绩、模块导入(可选) -->
 
 
  <div class="clear"></div>
  <p></p>
  <div><font color="red">说明：此榜是根据十七届省运会竞赛办法，将各代表团21项成绩综合统计得分</font></div>
</div><!-- container end -->

<!-- 脚注部分导入 footer.jsp-->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
<!-- 脚注部分导入-->

</div>
</body>
</html>
