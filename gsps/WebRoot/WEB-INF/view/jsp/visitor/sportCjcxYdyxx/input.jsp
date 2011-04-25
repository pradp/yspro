<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>运动员信息</title>
    
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/idcard.js"></script>
	<script type="text/javascript">
		detailPageStyle();
		//改变 特殊 Double 类型 为 Int( 如： 1.0  2.0 ....)
		function changeValue(arg1,arg2,id,ids){
		    var r1,r2,m;
		    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
		    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
		    m=Math.pow(10,Math.max(r1,r2))
		  $("#"+ids+id).html(((arg1*m+arg2*m)/m)+"")
		}
	</script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/resources/css/webface.css">
  	<base target="_self">
  </head>
  
<body style="text-align:center;">
<div align="center">
<s:hidden name="wid" value="%{#parameters.wid[0]}" id="wid" />
 <table border="1" width="520" style="border-collapse: collapse" bordercolor="#000000" id="table1">
　       <tr>
			<td width="450" colspan="3" align="center" height="29" bgcolor="#D4D4D4">
			<p align="left"><span style="font-size: 9pt">&nbsp; <b>个人信息</b></span></p></td>
		</tr>
  
		<tr>
			<td width="88" align="center" height="24" >
				<span style="font-size: 9pt">代表团</span></td>
			<td width="151" align="center" height="24" >
				<s:property value="tsportYdyxx.yddbm" /> 
			</td>
			<td width="180" align="center" height="186" rowspan="9" bgcolor="#EEEEEE">
			<s:if test="tsportYdyxx.zp == null"><img border="0" src="../resources/images/ydyimage/nopicture.gif" width="180"></s:if>
			<s:else><img border="0" src="../resources/images/ydyimage/<s:property value="tsportYdyxx.zp"/>" width="200"></s:else>
			</td>
			
		</tr>
		<tr>
			<td width="88" align="center" height="24" >
				<span style="font-size: 9pt">姓名</span>
			</td>
			<td width="151" align="center" height="24" >
				<s:property value="tsportYdyxx.xm" />
			</td>
		</tr>
		
		<tr>
			<td width="88" align="center" height="24" >
				<span style="font-size: 9pt">性别</span></td>
			<td width="151" align="center" height="24" >
				<s:if test="tsportYdyxx.xb=='1'.toString() ">男</s:if>
				<s:elseif test="tsportYdyxx.xb=='2'.toString() ">女</s:elseif> 
			</td>
		</tr>
		<tr>
			<td width="88" align="center" height="24" >
				<span style="font-size: 9pt">身高</span>
			</td>
			<td align="center" height="24" width="151">
				<s:property value="tsportYdyxx.sg" /> CM
			</td>
		</tr>

		<tr>
			<td width="88" align="center" height="24">
				<span style="font-size: 9pt">体重</span>
			</td>
			<td align="center" height="24"width="151">
				<s:property value="tsportYdyxx.tz" /> KG
			</td>
		</tr>

		<tr>
			<td width="88" align="center" height="24">
				<span style="font-size: 9pt">注册号</span>
			</td>
			<td align="center" height="24"  width="151">
				<s:property value="tsportYdyxx.zch" />
			</td>
		</tr>
  	</table>
 </div>
 
 <div align="center">
   <table border="1" width="520" style="border-collapse: collapse" bordercolor="#000000" id="table2"">
　 	    <tr>
			<td width="450" align="center" height="23" bgcolor="#D4D4D4" colspan="10">
			<p align="left"><span style="font-size: 9pt">&nbsp;<b>赛前报名项目</b></span></p></td>
		</tr>
    	<s:iterator value="result" status="stat">
    		 <tr>
    		  <td width="450" align="center" height="23" bgcolor="#EEEEEE">
			  <span style="font-size: 9pt"><s:property value="#result[#stat.index][0]"/></span></td>
			  </tr> 	
    	</s:iterator>
    </table>
</div>
 <div>&nbsp;</div>
 <div align="center">
  <table border="1" width="520" style="border-collapse: collapse" bordercolor="#000000" id="table2">
        <tr>
			<td width="450" align="center" height="23" bgcolor="#D4D4D4" colspan="10">
			<p align="left"><span style="font-size: 9pt">&nbsp;<b>本届赛会得牌得分</b></span></p></td>
		</tr>
	  	<tr>
		   		<td width="200" align="center" height="20" >
				<span style="font-size: 9pt">参赛项目</span></td>
				<td width="100" align="center" height="20" >
				<span style="font-size: 9pt">成绩</span></td>
				<td width="85" align="center" height="20" >
				<span style="font-size: 9pt">名次</span></td>
				<td width="85" align="center" height="20" >
				<span style="font-size: 9pt">得分</span></td>
		  </tr>
		  
			 	<s:iterator value="result1" status="st">
				  	<tr>
			    	      	<td width="200" align="center" height="21" bgcolor="#EEEEEE">
			                <span style="font-size: 9pt"><s:property value="bsxm"/></span></td>
			                <s:if test="sfjtxm==0&&cj!=null ">
				                <td width="100" align="center" height="21" bgcolor="#EEEEEE">
				                <span style="font-size: 9pt"><s:property value="cj"/></span></td>
			                </s:if>
			                <s:else>
			                	<td width="100" align="center" height="21" bgcolor="#EEEEEE">
				                <span style="font-size: 9pt">--</span></td>
			                </s:else>
			                <td width="85" align="center" height="21" bgcolor="#EEEEEE">
			                <span style="font-size: 9pt"><s:property value="mc"/></span></td>
			                <s:if test="sfjtxm==0&&df!=null ">
				                <td width="85" align="center" height="21" bgcolor="#EEEEEE">
			                	<span style="font-size: 9pt" id="df_<s:property value='#st.index' />"><script>changeValue(<s:property value='df'/>,0,<s:property value='#st.index' />,'df_')</script></span></td>
			                </s:if>
			                <s:else>
			                	<td width="85" align="center" height="21" bgcolor="#EEEEEE">
			                	<span style="font-size: 9pt" id="df_<s:property value='#st.index' />">--</span></td>
			                </s:else>
			                
			    	</tr>
    			</s:iterator>
    	</table>
   </div>

<div>&nbsp;</div>
<s:if test="(user.getUserLoginId()!=null&&user.getUserLoginId()!='') && (#result2!=null && #result2.size()>0)">
   <div align="center">
  <table border="1" width="520" style="border-collapse: collapse" bordercolor="#000000" id="table2">
        <tr>
			<td width="450" align="center" height="23" bgcolor="#D4D4D4" colspan="10">
			<p align="left"><span style="font-size: 9pt">&nbsp;<b>得牌得分折算情况</b></span></p></td>
		</tr>
	  	<tr>
	  	        <td width="150" align="center" height="20" >
				<span style="font-size: 9pt">得分类型</span></td>
				<td width="250" align="center" height="20" >
				<span style="font-size: 9pt">单位</span></td>
				<td width="150" align="center" height="20" >
				<span style="font-size: 9pt">项目</span></td>
				<td width="450" align="center" height="20" >
				<span style="font-size: 9pt">级（赛）别</span></td>
				<td width="50" align="center" height="20" >
				<%--<span style="font-size: 9pt">名次</span></td>
				<td width="50" align="center" height="20" >
				--%><span style="font-size: 9pt">金牌</span></td>
				<td width="55" align="center" height="20" >
				<span style="font-size: 9pt">银牌</span></td>
				<td width="55" align="center" height="20" >
				<span style="font-size: 9pt">铜牌</span></td>
				<td width="55" align="center" height="20" >
				<span style="font-size: 9pt">得分</span></td>
		  </tr>
			 	<s:iterator value="result2" status="stat">
				  	<tr>
			    	          <td width="150" align="center" height="21" bgcolor="#EEEEEE">
			                <span style="font-size: 9pt"><s:property value="#result2[#stat.index][0]"/></span></td>
			                <s:if test="%{#result2[#stat.index][9]!=null&&#result2[#stat.index][9]!=''}">
			                <td width="150" align="center" height="21" bgcolor="#EEEEEE">
			                <span style="font-size: 9pt"><s:property value="%{#result2[#stat.index][1]}"/></span></td>
			                </s:if><s:else>
			                <td width="250" align="center" height="21" bgcolor="#EEEEEE">
			                <span style="font-size: 9pt"><s:property value="#result2[#stat.index][2]"/></span></td>
			                </s:else>
			                <td width="200" align="center" height="21" bgcolor="#EEEEEE">
			                <span style="font-size: 9pt"><s:property value="#result2[#stat.index][3]"/></span></td>
			                <td width="400" align="center" height="21" bgcolor="#EEEEEE">
			                <span style="font-size: 9pt"><s:property value="#result2[#stat.index][4]"/></span></td>
			                <td width="50" align="center" height="21" bgcolor="#EEEEEE">
			                <%--<span style="font-size: 9pt"><s:property value="#result2[#stat.index][5]"/></span></td>
			                <td width="50" align="center" height="21" bgcolor="#EEEEEE">
			                --%><span style="font-size: 9pt"><s:property value="#result2[#stat.index][6]"/></span></td>
			                <td width="55" align="center" height="21" bgcolor="#EEEEEE">
			                <span style="font-size: 9pt"><s:property value="#result2[#stat.index][7]"/></span></td>
			                <td width="55" align="center" height="21" bgcolor="#EEEEEE">
			                <span style="font-size: 9pt"><s:property value="#result2[#stat.index][8]"/></span></td>
			                 <td width="55" align="center" height="21" bgcolor="#EEEEEE">
			                <span style="font-size: 9pt"><s:property value="#result2[#stat.index][9]"/></span></td>
			    	</tr>
    			</s:iterator>
    	</table>
   </div>
 </s:if>
  </body>
</html>
