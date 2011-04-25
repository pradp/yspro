<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
  		<style>
  		ul {
padding: 0px;
font-size: 12px;
white-space: nowrap;

}
 li {
list-style-type: none;
display: inline;
}
  		</style>
  		<script>
  		function csh(xm_span, wid_xm,wid_bm){
  			if(wid_xm!=""){
  				var wid_xms = wid_xm.split(",");//wid_xm,wid_xm....
  				var wid_bms = wid_bm.split(",");//wid_xm,wid_xm....
  				//alert(wid_xms);
  				var uri = '';
  				for(i=0;i<wid_xms.length;i++){
  					var url1 = "../visitor/sportCjcxYdyxx-input.c?wid=" + wid_bms[i];
  					uri = uri + " <a href='#' onclick=\"openPage2('"+url1+"')\" ><font color='blue'>"+wid_xms[i]+"</font></a> ";
  				}
  				document.getElementById(xm_span).innerHTML=uri;
  			}
  		}
  		function openPage2(uri){
  			omvc = window.open(uri, 'newwindow', 'height=700, width=600, top=50, left=100, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
  			omvc.focus();
  		}
  		
  		</script>
    	<div style="font-size: 12px;color: red"><s:property value="%{@java.net.URLDecoder@decode(#totalXm, 'utf-8')}" /> &nbsp;&nbsp;&nbsp;<s:if test="#cdxx[0][1]==null ||#cdxx[0][1]==''"><s:property value="#cdxx[0][0]" /></s:if><s:else><a href="<s:property value="#cdxx[0][1]" />"><s:property value="#cdxx[0][0]" /></a></s:else>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="cursor: pointer;" class="todis" onclick="toPrint2()" title="打印"><img src="<s:property value="basePath"/>/resources/images/print.bmp"  width="20" height="20"/><span style="color: blue; ">打印</span></span></div><div>&nbsp;</div>
    	<div id="saichengxx" style="width: 73%" class="grid_12 alpha">
   	<table width="100%" border="1">
   	<s:if test="#type=='cj'.toString() || #type=='jscj'.toString()">
  		<tr>
  			<td  style="text-align: center"><span style="color:black; font-size: 25px;"><b><s:property value="#tuandui1[0]"/></b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:black; font-size: 20px;"><s:property value="#tuandui1[1]"/></span><b></b>：<span style="color:black; font-size: 20px;"><s:property value="#tuandui2[1]"/></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:black;  font-size: 25px;"><b><s:property value="#tuandui2[0]"/></b></span>
  			</td>
  		</tr>
    	</s:if>
   	<tr>
   	<s:elseif test="#type=='md'.toString()">
    	<tr>
  			<td style="text-align: center"><span style="color:black;  font-size: 25px;"><b><s:property value="#tuandui1[0]"/></b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b> VS </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color:black;  font-size: 25px;"><b><s:property value="#tuandui2[0]"/></b></span></td>
  		</tr>
    </s:elseif>
   </tr>
    </table>
     <ul>
     <li>
    	 <table class="subTab" id="mainTable"  summary="今日赛程" style="float: left; width: 340px;" >
       	 <tr>
           <th scope="col" abbr="运动员"  class="matchDate">运动员</th>
           <th scope="col" abbr="号码" class="matchDate">号码</th>
         </tr>
          <s:iterator value="listSportCjTdHz" status="st">
    		<s:if test="listSportCjTdHz[#st.index].departid==#tuandui1[2].toString()" >
    			<tr><td>&nbsp;<span id="<s:property value='#st.index' />_c"></span>  <script> csh("<s:property value='#st.index' />_c","<s:property value='ydymc'/>","<s:property value='ydybm'/>"); </script></td>
           	   <td><s:property value="bpxh" /></td></tr>
    		</s:if>
   		 </s:iterator>
         </table>
     	</li>
     	<li>
     	<table class="subTab" id="mainTable"  width="20" summary="今日赛程" style="float: right;  width: 340px;" >
        <tr>
           <th scope="col"  abbr="运动员"  class="matchDate">运动员</th>
           <th scope="col"  abbr="号码" class="matchDate">号码</th>
         </tr>
          <s:iterator value="listSportCjTdHz" status="sta">
    		<s:if test="listSportCjTdHz[#sta.index].departid==#tuandui2[2].toString()" >
    			<tr><td>&nbsp;<span id="<s:property value='#sta.index' />_d"></span>  <script> csh('<s:property value="#sta.index" />_d','<s:property value="ydymc"/>','<s:property value="ydybm"/>'); </script></td><td><s:property value="bpxh" /></td></tr>
    		</s:if>
    	</s:iterator>
         </table>
         </li>
       </ul> 
    </div>
   
