<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/engine.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/interface/ajaxService.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/dwr/util.js"></script>
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/tablesort.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
	<script type="text/javascript">
	listPageStyle();
	function doreset(){
		$("#time").val("");
		$("#dbtmc").val("");
		$("#dxmmc").val("");
		$("#xxmmc").val("");
		$("#zb").val("");
		$("#xbz").val("");
	}
	function getAllDbtTime(){

		ajaxService.getAllDbtTime($("#departid").val(),$("#dxmmc").val(),function (data){
			getSelectedText();
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			DWRUtil.removeAllOptions('time');
			DWRUtil.addOptions( 'time', data,'id','caption');
			var obj1 = document.getElementById("hidden_time");
			if(obj1.value!=null && obj1.value!=''){
				DWRUtil.setValue('time',obj1.value);
				obj1.value='';
			}
			$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
			getZbByTimeAndDxmmcAndXxmmc();
		});

	} 
	//获取下拉列表选中项的文本
	function getSelectedText(){
		obj = $("#departid");
		for(i=0;i<obj.length;i++){
	  	 	if(obj[i].selected==true){
	    		$("#dbtmc").val(obj[i].innerText);      //关键是通过option对象的innerText属性获取到选项文本
	  	 	}
		}
	
	}
	
	function getDxmmcByTimeAndDbt(){

		ajaxService.getDxmmcByTimeAndDbt($("#departid").val(),function (data){
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			DWRUtil.removeAllOptions('dxmmc');
			DWRUtil.addOptions( 'dxmmc', data,'id','caption');
			var obj1 = document.getElementById("hidden_dxmmc");
			if(obj1.value!=null && obj1.value!=''){
				DWRUtil.setValue('dxmmc',obj1.value);
				obj1.value='';
			}
			$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
			getAllDbtTime();
		});
	}
	function getXbzByTimeAndDxmmcAndXxmmcAndZb (){

		ajaxService.getXbzByTimeAndDxmmcAndXxmmcAndZb($("#departid").val(),$("#time").val(),$("#dxmmc").val(),$("#xxmmc").val(),$("#zb").val(),function (data){
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			DWRUtil.removeAllOptions('xbz');
			DWRUtil.addOptions( 'xbz', data,'id','caption');
			var obj1 = document.getElementById("hidden_xbz");
			if(obj1.value!=null && obj1.value!=''){
				DWRUtil.setValue('xbz',obj1.value);
				obj1.value='';
			}
			$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
		});
	}
	function getZbByTimeAndDxmmcAndXxmmc (){

		ajaxService.getZbByTimeAndDxmmcAndXxmmc($("#departid").val(),$("#time").val(),$("#dxmmc").val(),$("#xxmmc").val(),function (data){
			jQuery.noConflict();//注意这个，如果页面引入的JQUERY，就必须加这句和最后一句
			DWRUtil.removeAllOptions('zb');
			DWRUtil.addOptions( 'zb', data,'id','caption');
			var obj1 = document.getElementById("hidden_zb");
			if(obj1.value!=null && obj1.value!=''){
				DWRUtil.setValue('zb',obj1.value);
				obj1.value='';
			}
			$ = jQuery;//注意这个，如果页面引入的JQUERY，就必须加这句和第一句
			getXbzByTimeAndDxmmcAndXxmmcAndZb();
		});
	}

	function csh(xm_span, wid, xm){
			var wids = wid.split(",");//wid_xm,wid_xm....
			var xms = xm.split(",");//wid_xm,wid_xm....
			var uri = '';
			for(i=0;i<wids.length;i++){
				var url1 = "../visitor/sportCjcxYdyxx-input.c?wid=" + wids[i];
				uri = uri + " <a href='#' onclick=\"openPage2('"+url1+"')\" ><font color='blue'>"+xms[i]+"</font></a> ";
			}
			document.getElementById(xm_span).innerHTML=""+uri;
	}
	function openPage2(uri){
		openWindow(uri,850,450);
	}
	</script>
	<style type="text/css">
		#paipang{
			display: none;
		}
		#printDate{
			display: none;
		}
		.mytext{
			text-align: center;
		}
		.total{
			display: none;
		}
	</style>
	<style type="text/css" media="print">
		#searchForm{
			display: none;
		}
		#buttonTable{
			display: none;
		}
		#nop{
			display: none;
		}
		#paipang{
			display: block;
		}
		#fsearch{
			display: none;
		}
		#printstyle{
			font-size: 30px; 
			text-align: center; 
			font-family: 黑体; 
			line-height: 30px; 
		}
		#printDate{
			display: block;
			font-size: 12px; 
			text-align: center; 
		}
		.total{
			display: none;
		}
	</style>
	
  </head>
<body onload="getDxmmcByTimeAndDbt()"> 
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" >
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>
    <div id="listC" style="text-align:center;">
    <s:form theme="simple" name="theform">
    <s:hidden name="pager.formname" value="theform"/>
    <s:hidden id="hidden_time" value="%{cjTdMx.createtime1}"/>
    <s:hidden id="hidden_dxmmc" value="%{cjTdMx.dxmmc}"/>
    <s:hidden id="hidden_xxmmc" value="%{cjTdMx.xxmmc}"/>
    <s:hidden id="hidden_zb" value="%{cjTdMx.zb}"/>
    <s:hidden id="hidden_xbz" value="%{cjTdMx.xbz}"/>
     <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="maginB">
    <tr><td id="fsearch">  
    <table width="100%" border="0" align="left" cellpadding="0" cellspacing="0" class="maginB">
	  <tr>
	    <td class="chaxunleft">
         <table id="searchForm" border="0" align="center" cellspacing="3" cellpadding="0" width="100%">
			    <tr>
			    		<td align="right" nowrap="nowrap"  <s:if test="getDepartID()!=320">class="total"</s:if> colspan="1">&nbsp;代表团：</td>
						<td align="left" nowrap="nowrap"  <s:if test="getDepartID()!=320">class="total"</s:if> id="xbzContainer" colspan="1">
							<s:select name="cjTdMx.departid" id ="departid" list="getDbtmc2()" onchange="getDxmmcByTimeAndDbt()" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
							<s:textfield name="cjTdMx.dbtmc" id="dbtmc" cssStyle="display : none"></s:textfield>
						</td>
					<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;大项目：</td>
					<td align="left" nowrap="nowrap" id="xbzContainer" colspan="1">
						 <s:select name="cjTdMx.dxmmc" id ="dxmmc" list="#{}" onchange="getAllDbtTime()" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
					</td>
					<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;时间：</td>
					<td align="left" nowrap="nowrap" id="xbzContainer" colspan="1">
						 <s:select name="cjTdMx.createtime1" id ="time" list="#{}" listKey="id" onchange="getZbByTimeAndDxmmcAndXxmmc()" listValue="caption" headerKey="" headerValue="--请选择--"/>
					</td>
					<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;组别：</td>
					<td align="left" nowrap="nowrap" id="xbzContainer" colspan="1">
						 <s:select name="cjTdMx.zb" id ="zb" list="#{}" onchange="getXbzByTimeAndDxmmcAndXxmmcAndZb()" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
					</td>
					<td align="right" nowrap="nowrap" class="" colspan="1">&nbsp;性别组：</td>
					<td align="left" nowrap="nowrap" id="xbzContainer" colspan="1">
						 <s:select name="cjTdMx.xbz" id ="xbz" list="#{}" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--"/>
					</td>
					<td align="left" nowrap="nowrap"><ul class="btn_gn">
						<li>
							<a href="#" title="查询" onClick="super_doSearch()"
								id="searchButton" name="btn3"><span> 查询 </span>
							</a>
						</li></ul></td>
					<td align="left" nowrap="nowrap"><ul class="btn_gn">
						<li>
							<a href="#" title="重置" onClick="doreset()"
								id="searchButton2" name="btn4"><span> 重置 </span>
							</a>
						</li>
					</ul></td>
				</tr>
		</table>	
		</td>
	    <td width="15" height="70" class="chaxunright">&nbsp;</td>
	  </tr>
    </table>
    
    </td></tr>
    <tr><td>
     <table id="buttonTable" border="0" cellspacing="3" cellpadding="0" width="100%">
    		<tr>
    			<td height="30px"  width="70" align="center">
    			<ul class="btn_gn">
					    <li><a href="#" title="打印" onClick="window.print();" name="create0"><span>打印</span></a></li>
			    </ul>
			   </td>   	
			   <td align="left"><span style="font-size :12px; color: red;">说明：代表团得牌为竞赛得牌，不含带入成绩。</span></td>	  
    		</tr>
    		<tr>
    		<td></td>
    			<td><b>本次查询结果为：</b>  金牌：<s:property value="#listHz[0][0]" />  银牌：<s:property value="#listHz[0][1]" />  铜牌：<s:property value="#listHz[0][2]" />  奖牌总数：<s:property value="#listHz[0][3]" />  总分：<s:property value="#listHz[0][4]" /> </td>
    		</tr>
   </table>
    </td></tr>
    	<tr height="40" align="center" id="paipang">
   			<td align="center" id="printstyle"><s:property value="cjTdMx.dbtmc" />代表团<s:if test="%{#cxDxmmc!=null && #cxDxmmc!=''}" ><s:property value="cxDxmmc" /></s:if>成绩查询</td>
   		</tr>
    	<tr align="center" id="paipang">
   			<td align="center" id="printDate"> <s:if test="cjTdMx.createtime1=='all'">截止比赛时间：<s:property value="recentDate" /></s:if><s:else>比赛时间:<s:property value="cjTdMx.createtime1" /></s:else> &nbsp;&nbsp;&nbsp;&nbsp;打印时间：<s:property value="printDate" /></td>
   		</tr>
   <tr><td align="center">
    <table width="100%" border="0" height="100%" align="center" cellpadding="0" cellspacing="0" class="maginB" >
	  <tr>
	    <td class="infomainbg">
		
		
		<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0">
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>&nbsp;</td>
	      </tr>
	      <tr>
	        <td width="10">&nbsp;</td>
	        <td>
    	<table id="listTable" border="0" cellspacing="0" cellpadding="0" width="100%" class="middle">
    		<thead id="listHead">
  				<tr>
    			<s:if test="cjTdMx.dxmmc!=null &&cjTdMx.dxmmc!=''" >
	    			<th width="5%">比赛时间</th>
	    			<th width="23%">项目</th>
	    			<th width="4%">名次</th>
	    			<th width="8%">运动员</th>
	    			<th width="6%">成绩</th>
	    			<th width="6%">金牌</th>
	    			<th width="6%">银牌</th>
	    			<th width="6%">铜牌</th>
	    			<th width="6%">得分</th>
	    			<th width="11%">双重/协议地</th>
    			</s:if>
    			<s:else>
	    			<th width="45%">项目</th>
	    			<th width="11%">金牌</th>
	    			<th width="11%">银牌</th>
	    			<th width="11%">铜牌</th>
	    			<th width="11%">总分</th>
	    			<th width="11%">奖牌总数</th>
    			</s:else>
    			</tr>
    		</thead>
    		<tbody id="listData">
    		
		    <s:if test="cjTdMx.dxmmc!=null &&cjTdMx.dxmmc!=''" >
		    		<s:iterator value="#mainList" status="st">
		    		  <tr>
					    <td style="vertical-align: middle" >&nbsp;<s:property value="%{#mainList[#st.index][3]}" /></td>
					    <td style="vertical-align: middle" >&nbsp;<s:property value="%{#mainList[#st.index][1]}" /></td>
						 	<td colspan="8" style="vertical-align:middle; border-right: 1px #D7D8D9 solid; " >
						 		<table class="middle" width="100%" border="0" cellspacing="0" cellpadding="0">
						 		 <s:iterator value="resultData" status="status">	
						 		 	<s:if test="%{resultData[#status.index][0]==#mainList[#st.index][0]}">
						 		 		<%//集体项目 %>
						 		 		<s:if test="%{resultData[#status.index][2]==1 ||resultData[#status.index][2]==2}">
						 		 			
						 		 			<tr>
								 				<td width="5%" class="mytext"><s:property value="resultData[#status.index][5]==0 ? '--':resultData[#status.index][5]" /></td>
								 				<td width="12%" class="mytext">&nbsp;<span id="a_<s:property value='#st.index' />_<s:property value='#status.index' />"></span><script>csh("a_<s:property value='#st.index' />_<s:property value='#status.index' />","<s:property value='resultData[#status.index][7]' />","<s:property value='resultData[#status.index][8]' />")</script></td>
								 				<td width="8%" class="mytext">--</td>
								 				<td width="8%" class="mytext">&nbsp;<s:property value="resultData[#status.index][10]==0 ? '--':resultData[#status.index][10]" /></td>
								 				<td width="8%" class="mytext">&nbsp;<s:property value="resultData[#status.index][11]==0 ? '--':resultData[#status.index][11]" /></td>
								 				<td width="8%" class="mytext">&nbsp;<s:property value="resultData[#status.index][12]==0 ? '--':resultData[#status.index][12]" /></td>
								 				<td width="9%" class="mytext">&nbsp;<s:property value="resultData[#status.index][13]==0 ? '--':resultData[#status.index][13]" /></td>
								 				<td width="17%" class="mytext">&nbsp;<s:property value="resultData[#status.index][14]" /></td>
							 				</tr>
						 		 					
						 		 			
						 		 		</s:if>
						 		 		<s:else>
						 		 		<%//非集体项目 %>
							 		 		<tr>
								 				<td width="5%" class="mytext"><s:property value="resultData[#status.index][5]==0 ? '--':resultData[#status.index][5]" /></td>
								 				<td width="12%" class="mytext">&nbsp;<span id="b_<s:property value='#st.index' />_<s:property value='#status.index' />"></span><script>csh("b_<s:property value='#st.index' />_<s:property value='#status.index' />","<s:property value='resultData[#status.index][6]' />","<s:property value='resultData[#status.index][4]' />")</script></td>
								 				<td width="8%" class="mytext">&nbsp;<s:property value="resultData[#status.index][9]==0 ? '--':resultData[#status.index][9]" /></td>
								 				<td width="8%" class="mytext">&nbsp;<s:property value="resultData[#status.index][10]==0 ? '--':resultData[#status.index][10]" /></td>
								 				<td width="8%" class="mytext">&nbsp;<s:property value="resultData[#status.index][11]==0 ? '--':resultData[#status.index][11]" /></td>
								 				<td width="8%" class="mytext">&nbsp;<s:property value="resultData[#status.index][12]==0 ? '--':resultData[#status.index][12]" /></td>
								 				<td width="9%" class="mytext">&nbsp;<s:property value="resultData[#status.index][13]==0 ? '--':resultData[#status.index][13]" /></td>
								 				<td width="17%" class="mytext">&nbsp;<s:property value="resultData[#status.index][14]" /></td>
							 				</tr>
						 		 		</s:else>
						 			</s:if>
						 		 </s:iterator>
						 		</table>
						 	</td>
						   
					 </tr>
				  </s:iterator>
					  
		    	</s:if>
		    	<s:else>
		    	<s:iterator value="resultData" status="status">
		    	<tr>
		    		 <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][0]" /></td>
                     <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][1]==0 ? '--':resultData[#status.index][1]" /></td>
                     <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][2]==0 ? '--':resultData[#status.index][2]" /></td>
                     <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][3]==0 ? '--':resultData[#status.index][3]" /></td>
                     <td style="vertical-align:middle">&nbsp;<s:property value="resultData[#status.index][4]==0 ? '--':resultData[#status.index][4]" /></td>
                     <td style="vertical-align:middle; border-right: 1px #D7D8D9 solid; ">&nbsp;<s:property value="resultData[#status.index][5]==0 ? '--':resultData[#status.index][5]" /></td>
		    	</tr>
		    	</s:iterator>
		    	</s:else>
    		 </tbody>
    	</table>
    	</td>
	        </tr>
	    </table>
		
		
		
		
		</td>
	    <td width="10" class="infomainright">&nbsp;</td>
	  </tr>
	  <tr>
	    <td height="20" class="infobottomleft"></td>
	    <td width="10" class="infobottomright"></td>
	  </tr>
	</table></td></tr>
    </table> 	
    	
    	
    	</s:form>
    </div>
  </body>
</html>

