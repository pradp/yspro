<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/saicheng.css" type="text/css" media="all" />
<script type="text/javascript">
	//改变 特殊 Double 类型 为 Int( 如： 1.0  2.0 ....)
	function changeValue(arg1,arg2,id,ids){
	    var r1,r2,m;
	    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
	    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
	    m=Math.pow(10,Math.max(r1,r2))
	  $("#"+ids+id).html(((arg1*m+arg2*m)/m)+"")
	}
	function csh(xm_span, wid_xm,wid_bm){
		if(wid_xm!=""){
			var wid_xms = wid_xm.split(",");//wid_xm,wid_xm....
			var wid_bms = wid_bm.split(",");//wid_xm,wid_xm....
			var uri = '';
			for(i=0;i<wid_xms.length;i++){
				var url1 = "../visitor/sportCjcxYdyxx-input.c?wid=" + wid_bms[i];
				uri = uri + " <a href='#' onclick=\"openPage2('"+url1+"')\" ><span  style='text-decoration: none;color: blue;'>"+wid_xms[i]+"</span></a> ";
			}
			document.getElementById(xm_span).innerHTML=""+uri;
		}
	}
	function openPage2(uri){
		omvc = window.open(uri, 'newwindow', 'height=700, width=600, top=50, left=100, toolbar=no, menubar=no, scrollbars=yes, resizable=no,location=no, status=no');
		omvc.focus();
	}
	
</script>
     <s:hidden name="listSportYdydf_size" id="listSportYdydf_size" value="%{listSportYdydf.size()}" />
    <s:form theme="simple" name="theform">
    <s:hidden name="type" id="type_id" value="%{#type}" />
    	
    		<div style="font-size: 12px;color: red"><s:property value="%{@java.net.URLDecoder@decode(#totalXm, 'utf-8')}" /> &nbsp;&nbsp;&nbsp;<s:if test="#cdxx[0][1]==null ||#cdxx[0][1]==''"><s:property value="#cdxx[0][0]" /></s:if><s:else><a href="<s:property value="#cdxx[0][1]" />"><s:property value="#cdxx[0][0]" /></a></s:else>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="cursor: pointer;" class="todis" onclick="toPrint2()" title="打印"><img src="<s:property value="basePath"/>/resources/images/print.bmp"  width="20" height="20"/><span style="color: blue; ">打印</span></span></div><div>&nbsp;</div>
  <div id="saichengxx" class="grid_12 alpha">
       <table class="subTab" id="mainTable" summary="今日赛程">
      	 <tr>
        		<s:if test="#type=='jscj'">
        		 <th scope="col" abbr="名次"  width="7%" class="matchDate">名次</th>
        		 <th scope="col" abbr="代表团" width="10%"  class="matchDate">代表团</th>
        		 <th scope="col" abbr="运动员"  class="matchDate">运动员</th>
        		 <th scope="col" abbr="道次/出场顺序" width="16%"  class="matchDate">道次/出场顺序</th>
        		 <th scope="col" abbr="金牌数" width="8%" class="matchDate">金牌数</th>
        		 <th scope="col" abbr="银牌数" width="8%" class="matchDate">银牌数</th>
        		 <th scope="col" abbr="铜牌数" width="8%" class="matchDate">铜牌数</th>
        		 <th scope="col" abbr="得分" width="8%" class="matchDate">得分</th>
        		 <s:if test="%{(#dxmmc=='田径' || #dxmmc=='游泳' || #dxmmc=='举重' || #dxmmc=='自行车' || #dxmmc=='射箭' || #dxmmc=='射击' || #dxmmc=='蹦技')&&#sfxnsc==0}">
        		  <th scope="col" abbr="成绩" width="8%" class="matchDate">成绩</th>
        		 </s:if>
    			</s:if>
    			<s:elseif test="#type=='md' || #type=='cj'" >
    			 <th scope="col" abbr="代表团"  class="matchDate">代表团</th>
    			 <th scope="col" abbr="运动员(注册号)"  class="matchDate">运动员</th>
    			 <th scope="col" abbr="道次/出场顺序"  class="matchDate">道次/出场顺序</th>
    			 <s:if test="#type=='cj'">
    			 <th scope="col" abbr="成绩"  class="matchDate">成绩</th>
    			 </s:if>
    			  
    			</s:elseif>
    			<th scope="col" abbr="备注" width="8%" class="matchDate">备注</th>
         </tr>
         <s:iterator value="listSportCjTdHz" status="status">
    		<tr>
    			<s:if test="#type=='jscj'">
    			<td>&nbsp;<s:property value="mc"/></td>
    			<td>&nbsp;<s:if test="sfbjydhcj==1" ><s:property value="dbtmc"/></s:if></td>
				<td>&nbsp;<span id="<s:property value='#status.index' />_c"></span><script> csh("<s:property value='#status.index' />_c","<s:property value='ydymc'/>","<s:property value='ydybm'/>"); </script></td>
    		
    			<td>&nbsp;<s:property value="bpxh"/></td>
    			<s:if test="jps== null || jps=='0'.toString()">
    			<td>--</td>
    			</s:if><s:else>
    			<td id="jp_<s:property value='#status.index' />">&nbsp;
    			<script>changeValue(<s:property value='jps'/>,0,<s:property value='#status.index' />,'jp_')</script></td></s:else>
    			<s:if test="yps== null || yps=='0'.toString()">
    			<td>--</td>
    			</s:if><s:else>
    			<td id="yp_<s:property value='#status.index' />">&nbsp;
    			<script>changeValue(<s:property value='yps'/>,0,<s:property value='#status.index' />,'yp_')</script></td></s:else>
    			<s:if test="tps== null || tps=='0'.toString()">
    			<td>--</td>
    			</s:if><s:else>
    			<td id="tp_<s:property value='#status.index' />">&nbsp;
    			<script>changeValue(<s:property value='tps'/>,0,<s:property value='#status.index' />,'tp_')</script></td></s:else>
    			<td id="df_<s:property value='#status.index' />">&nbsp;--
    			<s:if test="df!=null && df!=''">
    				<script>changeValue(<s:property value='df'/>,0,<s:property value='#status.index' />,'df_')</script>
    			</s:if>
    			</td>
    			 <s:if test="%{(#dxmmc=='田径' || #dxmmc=='游泳' || #dxmmc=='举重' || #dxmmc=='自行车' || #dxmmc=='射箭' || #dxmmc=='射击' || #dxmmc=='蹦技')&&#sfxnsc==0}">
        		  <td><s:property value="cj"/></td>
        		 </s:if>
    			</s:if>
    			<s:elseif test="#type=='md' || #type=='cj'" >
    			<td>&nbsp; <s:property value="dbtmc"/></td>
    			<td>&nbsp;<span id="<s:property value='#status.index' />_c"></span><script> csh("<s:property value='#status.index' />_c","<s:property value='ydymc'/>","<s:property value='ydybm'/>"); </script></td>
           	  
    			<td>&nbsp;<s:property value="bpxh"/></td>
    			 <s:if test="#type=='cj'">
    			 	<td>&nbsp;<s:property value="cj"/></td>
    			 </s:if>
    			</s:elseif>
    			<td>&nbsp;<s:if test="bz!=null || bz!=''" ><s:property value="bz"/></s:if></td>
    			
    		</tr>
    	</s:iterator>
    		<tr>
    			<td colspan="11" align="right" style="color:#666">&nbsp;说明：&nbsp;DNS（弃权）&nbsp;&nbsp;
    			DSQ（犯规） &nbsp;&nbsp;DNF（中退）  &nbsp;&nbsp;CAN（取消）&nbsp;&nbsp;*（非本届成绩）   </td>
    		</tr>
    	</table>
    	</div>
    	</s:form>
    	 
 
