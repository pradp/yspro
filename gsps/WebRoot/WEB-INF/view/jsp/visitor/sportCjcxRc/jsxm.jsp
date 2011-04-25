<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>

<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/pages/saicheng.css" type="text/css" media="all" />
 	<script>
		function openPage2(uri){
			omvc = window.open(uri, 'newwindow', 'height=600, width=800, top=50, left=100, toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=yes, status=yes');
			omvc.focus();
		}
		function openPage2Before(departid,scbm,dbtmc){
			uri = "../visitor/sportCjcxRc-tdry.c?departid="+departid+"&scbm="+scbm+"&totalXm="+$("#xxmmess").html()+"&dbtmc="+dbtmc ;
			openPage2(uri);
		}
	</script>
     <s:hidden name="listSportYdydf_size" id="listSportYdydf_size" value="%{listSportYdydf.size()}" />
    <s:form theme="simple" name="theform">
    <s:hidden name="type" id="type_id" value="%{#type}" />
    	
    		<div style="font-size: 12px;color: red"><s:property value="%{@java.net.URLDecoder@decode(#totalXm, 'utf-8')}" /> &nbsp;&nbsp;&nbsp;<s:if test="#cdxx[0][1]==null ||#cdxx[0][1]==''"><s:property value="#cdxx[0][0]" /></s:if><s:else><a href="<s:property value="#cdxx[0][1]" />"><s:property value="#cdxx[0][0]" /></a></s:else>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="cursor: pointer;" class="todis" onclick="toPrint2()" title="打印"><img src="<s:property value="basePath"/>/resources/images/print.bmp"  width="20" height="20"/><span style="color: blue; ">打印</span></span></div><div>&nbsp;</div>
 <span id="xxmmess" style="display : none"><s:property value="%{@java.net.URLEncoder@encode(#totalXm,'utf-8')}" /></span>
  <div id="saichengxx" class="grid_12 alpha" style="margin-right: 2px;">
       <table class="subTab" id="mainTable" summary="今日赛程">
      	 <tr>
        		 <th scope="col" abbr="名次"  class="matchDate">名次</th>
        		 <th scope="col" abbr="代表团"  class="matchDate">代表团</th>
        		 <th scope="col" abbr="金牌"  class="matchDate">金牌</th>
        		 <th scope="col" abbr="银牌"  class="matchDate">银牌</th>
        		 <th scope="col" abbr="铜牌"  class="matchDate">铜牌</th>
        		 <th scope="col" abbr="得分"  class="matchDate">得分</th>
        		  <s:if test="%{(#dxmmc=='田径' || #dxmmc=='游泳' || #dxmmc=='举重' || #dxmmc=='自行车' || #dxmmc=='射箭' || #dxmmc=='射击' || #dxmmc=='蹦技')&&#sfxnsc==0}">
        			 <th scope="col" abbr="成绩"  class="matchDate">成绩</th>
        		 </s:if>
        		 <th scope="col" abbr="备注"  class="matchDate">备注</th>
         </tr>
         <s:iterator value="#jscjList" status="status">
    		<tr>
    			<td>&nbsp;<s:property value="mc"/></td>
    			<td>&nbsp;<s:if test="sfbjydhcj==1" ><span style="color: blue; cursor: pointer" onclick="openPage2Before('<s:property value="departid"/>','<s:property value="scbm"/>','<s:property value="@java.net.URLEncoder@encode(dbtmc,'utf-8')"/>')"><s:property value="dbtmc"/></span></s:if></td>
    			<td>&nbsp;<s:property value="@com.imchooser.util.NumberUtil@formatPoint(jps)"/> </td>
    			<td>&nbsp;<s:property value="@com.imchooser.util.NumberUtil@formatPoint(yps)"/> </td>
    			<td>&nbsp;<s:property value="@com.imchooser.util.NumberUtil@formatPoint(tps)"/> </td>
    			<td>&nbsp;<s:property value="@com.imchooser.util.NumberUtil@formatPoint(df)"/></td>
    			 <s:if test="%{(#dxmmc=='田径' || #dxmmc=='游泳' || #dxmmc=='举重' || #dxmmc=='自行车' || #dxmmc=='射箭' || #dxmmc=='射击' || #dxmmc=='蹦技')&&#sfxnsc==0}">
        		  <td scope="col" abbr="得分"  class="matchDate"><s:property value="cj"/></td>
        		 </s:if>
    			<td>&nbsp;<s:if test="bz!=null || bz!=''" ><s:property value="bz"/></s:if> </td>
    		</tr>
    	</s:iterator>
    	<tr>
    			<td colspan="7" align="right" style="color:#666">&nbsp;说明：&nbsp;DNS（弃权）&nbsp;&nbsp;
    			DSQ（犯规） &nbsp;&nbsp;DNF（中退）  &nbsp;&nbsp;CAN（取消）&nbsp;&nbsp;*（非本届成绩）   </td>
    		</tr>
    	</table>
    	
    	</div>
    	</s:form>
    	 
 
