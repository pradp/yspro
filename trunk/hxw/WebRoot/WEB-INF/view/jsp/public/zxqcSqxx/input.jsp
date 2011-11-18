<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ page import="com.yszoe.identity.IdConstants"%>
<%@ page import="com.yszoe.identity.entity.LoginUserVO"%>
<%@ page import="com.yszoe.identity.entity.TSysDepart"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<script type="text/javascript" src="../resources/jquery/jquery-1.6.2.min.js"></script>
		<script type="text/javascript" src="../resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.bgiframe.min.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/jquery.ajaxQueue.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/lib/thickbox-compressed.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.pack.js"></script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/jquery.autocomplete.css"/>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/component/jsuggest/lib/thickbox.css"/>
	<script language="javascript" type="text/javascript" src="<s:property value="basePath"/>/component/datepicker/WdatePicker.js"></script>
	
    	<title> 用户注册  </title>

	<script type="text/javascript">
	var canSubmit=false;
	var canSubmitBh=false;
	$(function(){
		$(".button").css({
			"width":"72px","height":"25px",
			"margin-top":"10px",
			"background-image":"url('/angr/faceui/images/button_bg.gif')",			
			"border": "0px solid #83B1F2","color":"#FFFFFF","font-size":"14px","cursor":"pointer"});
		$(".button1").css({
			"width":"90px","height":"25px",
			"background-image":"url('/angr/faceui/images/button_bg_big.gif')",
			"border": "0px solid #83B1F2","color":"#FFFFFF","font-size":"14px","cursor":"pointer"});
	})	
	$(function(){
		corpCtrl();
	//	disNcbh();		
		$("#userPwd").val($("#userPwd_hide").val());//这里重新设置一下，因为UUR界面会把password清空。
		
		var departid = '<s:property value="getDepartid()"/>';
		var url = "<s:property value="basePath"/>/suggest?aim=mydepart.register&departid="+departid;		
		getSuggest("departname","departid",url);
		//changeRightCtrl();
	});	
	validate_required_fields = [    
	       {fieldId:"userLoginId", message:"登录帐号不能为空！", mustMatch: true}, 
	       {fieldId:"userName", message:"用户名称不能为空！", mustMatch: true}, 
	       {fieldId:"userPwd", message:"登录密码不能为空！", mustMatch: true}, 
	       {fieldId:"passwd", message:"确认密码不能为空！", mustMatch: true}
	    ];
	validate_length_range_fields = [
	        {fieldId:"userLoginId", minLen:4, maxLen:10, message:"用户名4~10位！", ignoreIfEmpty: false},
	        {fieldId:"userPwd", minLen:4, maxLen:20, message:"密码4~20位！", ignoreIfEmpty: false},
	        {fieldId:"passwd", minLen:4, maxLen:20, message:"确认密码4~20位！", ignoreIfEmpty: false}
		];         	
	function doSave(){		
		var userLoginId=document.getElementById('userLoginId');
		var userName=document.getElementById('userName');
		var pd=document.getElementById("userPwd");
		var pd1=document.getElementById("passwd");
		var bh=document.getElementById('bh');
		var flag=document.getElementById("flag").value;
		if(!canSubmit){
			alert("登录帐号不可以用！");
			userLoginId.focus();
			return false;
		}
		if (userLoginId.value.length<4||userLoginId.value.length>11){
			alert("登录帐号4-10位！");
			userLoginId.focus();
			return false;
		}
		if (pd.value==''){
			alert("登录密码不能为空！");
			pd.focus();
			return false;
		}	
		if (pd.value.length<4||pd.value.length>21){
			alert("登录密码4-20位！");
			pd.focus();
			return false;
		}
		if (pd1.value==''){
			alert("确认密码不能为空！");
			pd1.focus();
			return false;
		}
		if (pd1.value.length<4||pd1.value.length>21){
			alert("确认密码4-20位！");
			pd1.focus();
			return false;
		}
		if (pd.value!=pd1.value){
			alert("确认密码输入错误！");
			pd.fouce();
			return false;
		}		
		if (userName.value==''){
			alert("用户名称不能为空！");
			userName.focus();
			return false;
		}
		
					
		
		
		if (flag=='2'){
			checkXz();
			var departtype = document.getElementById("departtype").value;	
			var updepartid = document.getElementById("updepartid");			
			var city = document.getElementById("city");	
			var newdepartname = document.getElementById("newdepartname");
			
	//		validate_required_fields.append({fieldId:"newdepartname", message:"单位名称不能为空！", mustMatch: true});
	//		validate_required_fields.append({fieldId:"updepartid", message:"上级单位不能为空！", mustMatch: true});
	//		validate_required_fields.append({fieldId:"city", message:"所属区县不能为空！", mustMatch: true})
			if (newdepartname.value==''){
				alert("单位名称不能为空！");
				newdepartname.focus();
				return false;
			}
	
			if (city.value==''){
				alert("所属区县不能为空！");
				document.getElementById("cityname").focus();
				return false;
			}
			var xz = document.getElementById("xz");
				if (xz.value!=''){					
					if ((xz.value=='02'&&departtype=='2')||xz.value=='01'){
						var bh=  document.getElementById("bh");
						if (bh.value==''){
							alert("单位编号不能为空！");
							bh.focus();
							return false;
						}						
						if (!canSubmitBh){
							  alert("单位编号不正确！"); 
							  return false;
						}
					}
				}else{				
					alert("畜种不能为空！");
					xz.focus();
					return false;
				}
		}else{
			var departname = document.getElementById("departname");
			if (departname.value==''){
				alert("所属单位不能为空！");
				departname.focus();
				return false;
			}
			
		}
		document.forms[0].action = getActionName() + "-save.action";
		document.forms[0].submit();
		return true;
	}		

	
	function onchPzxx(){
		var xz = document.getElementById("xz").value;
		if(xz!=''){
			var url = "${basePath}/jsonVisitor/ajaxBiz-loadPzxx.action?"+(new Date()).getTime();
			$.getJSON(url,{xz: xz}, function(data){
		    	var pzxx = data.datamap.pzxx;			    	
		    	var num = 0;		    	
		    	changeSelectOption(pzxx,'',"listTDepartVariety["+num+"].pz");	  
			    var ryInput = $("input[name*=listTDepartVariety]").each(function(i){
			        if (this.name.indexOf(".wid") != -1) {
			            var thisIndexStr = this.name;
			            var end = thisIndexStr.substring("listTDepartVariety[".length);
			            var thisIndex = end.substring(0, end.indexOf("].wid"));				        	
			            if (thisIndex!=0){	            
			            	changeSelectOption(pzxx,'',"listTDepartVariety["+thisIndex+"].pz");
			            }
			        }
			    });  	
    			
			});
		}
	}	
	function onchPxxx(obj){		
		var pzbh = document.getElementsByName("listTDepartVariety["+obj+"].pz")[0].value		
		if(pzbh!=''){
			var url = "${basePath}/jsonVisitor/ajaxBiz-loadPxxx.action?"+(new Date()).getTime();
			$.getJSON(url,{pzbh: pzbh}, function(data){
		    	var pxxx = data.datamap.pxxx;
    			changeSelectOption(pxxx,'',"listTDepartVariety["+obj+"].px");
			});
		}
	}
	//创建一行家庭成员
	function createyzgm(){
	    var id = (new Date()).getTime() + "";	    
	    var maxNum = getPersonMaxNum();
	    var newnum = parseInt(maxNum) + 1;
	    var newTag = "listTDepartVariety[" + newnum + "]";	   
	    
	    var a = document.getElementById("pzFirst").innerHTML;
        a = a.replace(/(^\s*)|(\s*$)/g, ""); 
        var addd = a.indexOf("listTDepartVariety[0]");
        var start = a.substring(0, addd);
        var end = a.substring(addd + "listTDepartVariety[0]".length); 
       
        pz=start + newTag + end;

        a = document.getElementById("pxFirst").innerHTML;
        a = a.replace(/(^\s*)|(\s*$)/g, ""); 
        addd = a.indexOf("listTDepartVariety[0]");
        start = a.substring(0, addd);
        end = a.substring(addd + "listTDepartVariety[0]".length); 

        px=start + newTag + end;

        a = document.getElementById("dcFirst").innerHTML;
        a = a.replace(/(^\s*)|(\s*$)/g, ""); 
        addd = a.indexOf("listTDepartVariety[0]");
        start = a.substring(0, addd);
        end = a.substring(addd + "listTDepartVariety[0]".length); 

        dc=start + newTag + end;
        
	    var row = "<tr>";
			row += "<td>"+pz+"<input type='hidden' name='" + newTag + ".wid'/></td>";
			row += "<td>"+px+"</select>";
	        row += "<td>"+dc+"</td>";	       
	        row += "<td><input type='text' name='"+newTag+".jcmxqcl' id='jcmxqcl'  maxlength='8' size='15'/>";
	        row += "<td><input type='text' name='"+newTag+".jcgxqcl' id='jcgxqcl'  maxlength='8' size='15'/>";
	        row += "<td><input type='text' name='"+newTag+".hbmxqcl' id='hbmxqcl'  maxlength='8' size='15'/>";
	        row += "<td><input type='text' name='"+newTag+".hbgxqcl' id='hbgxqcl'  maxlength='8' size='15'/>";
	        row += "<td><input id='" + id + "' type='button' value='删除' onclick='removeThisRow(this)'/>";
	        row += "</tr>";	 
	        row=row.replace("onchangePxxx('0')","onchangePxxx('"+newnum+"')");    
	        row=row.replace("onchPxxx('0')","onchPxxx('"+newnum+"')"); 
	        $(row).appendTo("#yzgm");
	}

	//删除一行家庭成员
	function removeThisRow(obj){
	    $("#" + obj.id).parent().parent().remove();
	}

	function getPersonMaxNum(){
	    var num = 0;
	    var ryInput = $("input[name*=listTDepartVariety]").each(function(i){
	        if (this.name.indexOf(".wid") != -1) {
	            var thisIndexStr = this.name;
	            var end = thisIndexStr.substring("listTDepartVariety[".length);
	            var thisIndex = end.substring(0, end.indexOf("].wid"));
	            if (thisIndex > num) 
	                num = thisIndex;
	        }
	    });
	    return num;
	}
	
	/**
	 * 修改单选下拉框选项时恢复原有样式
	 * @param {Object} data json返回值
	 * @param {Object} id 单选下拉框标签id属性
	 */
	function changeSelectOption(data,id,name,value){
		if(data!=null && data!="[]" && data!=''){
			var jsonarray = eval("("+data+")");
			if(id!=''){
				$("#"+id+" option").remove();
				for(var i=0;i<jsonarray.length;i++){
					var obj = jsonarray[i];
					$("#"+id).append("<option value='"+obj.id+"'>"+obj.caption+"</option>");
				}
				$("#"+id).parent().html($("#"+id));
				if(value!=null && value!=''){
					$("#"+id).val(value);
				}			
			}else{
				$("select[name='"+name+"'] option").remove();
				for(var i=0;i<jsonarray.length;i++){
					var obj = jsonarray[i];
					$("select[name='"+name+"']").append("<option value='"+obj.id+"'>"+obj.caption+"</option>");
				}
				$("select[name='"+name+"']").parent().html($("select[name='"+name+"']"));
				if(value!=null && value!=''){
					$("select[name='"+name+"']").val(value);
				}				
			}
			//页面只读时单选下拉框也只读
			var url = location.href;
			var readOnly = false;
			if(url.indexOf("readOnlyPage")!=-1){
				var readOnlyPage_value_index = url.indexOf("readOnlyPage")+"readOnlyPage=".length;
				readOnly = url.substr(readOnlyPage_value_index,4)=='true';
			}else{
				readOnly = $("#readOnlyPage").val() == 'true';
			}
			if(readOnly){
				$("table[id!='notReadOnly'] select").parent().find("input[type='button']").attr("disabled","disabled"); 
				$("table[id!='notReadOnly'] select").parent().find("input[type='text']").attr("disabled","disabled");
			}
		}
	}
	 function onchangePzxx(obj,value){
			var xz = document.getElementById("xz").value;
			if(xz!=''){
				var url = "${basePath}/jsonVisitor/ajaxBiz-loadPzxx.action?"+(new Date()).getTime();
				$.getJSON(url,{xz: xz}, function(data){
			    	var pzxx = data.datamap.pzxx;		    	
	    			changeSelectOption(pzxx,'',"listTDepartVariety["+obj+"].pz",value);
				});
			}
		}	
	function onchangePxxx(obj,pzbh,value){
			if(pzbh!=''){
				var url = "${basePath}/jsonVisitor/ajaxBiz-loadPxxx.action?"+(new Date()).getTime();
				$.getJSON(url,{pzbh: pzbh}, function(data){
			    	var pxxx = data.datamap.pxxx;
	    			changeSelectOption(pxxx,'',"listTDepartVariety["+obj+"].px",value);
				});
			}
		}
	
	function dosavenew(){
		document.getElementById("sfxz").value = "1";
		doSave();
	}
	var tem_valueObjid,tem_nameObjid;
	function selectArea(valueObjid,nameObjid){
		tem_valueObjid = valueObjid;
		tem_nameObjid = nameObjid;
		var url = "<s:property value="basePath"/>/system/area-areaTree.action";
		openTreeDialog(url);
	}
	function selectSjbm(valueObjid,nameObjid){
		tem_valueObjid = valueObjid;
		tem_nameObjid = nameObjid;
		var url = "../system/depart-departTree.action?state=1&onlyCompany=1";
		openTreeDialog(url);		
	}

	/**
	 * 选中的纪录。
	 * AJAX 请求传统页面方式实现
	 */
	function checkusername(){
		var username=document.getElementById('userLoginId');
		var span = document.getElementById('span');			
		if (username.value!=''&&username.value.length>3&&username.value.length<21){
			var url_bak = document.forms[0].action;			
			var url = getActionName() + "-checkusername.action";						
			$.post(url,
				  {username: username.value, reqtime: (new Date()).getTime()  },
				  function(data){	
						if(data.indexOf('true') != -1){
		            		canSubmit = true;
		            		span.innerHTML = '<font style="color:green;">可使用</span>';
		            	}else{
			            	canSubmit = false;
			            	span.innerHTML = '<font style="color:red;">不可用</span>';
		            	}
				}
			 );
	   }else{
		   canSubmit = false;
       	   span.innerHTML = '<font style="color:red;">请填写</span>';
	   }		
	}

	function getActionName(){
		var url = window.location.href;
		var actionName = url.substring( url.lastIndexOf("/")+1, url.lastIndexOf("-") );
		return actionName;
	}

	
	function corpCtrl(){
		if($("#departtype").val()=="1"){
			$("#corpCtrl_yzcxx").hide();
			$("#ssgs").hide();
			$("#ssgstxt").hide();
		}else{
			$("#corpCtrl_yzcxx").show();
			$("#ssgs").show();
			$("#ssgstxt").show();
		}
	}
	
	
	function addBm(){
		$("#dwdj").show();
		//$("#openZc").hide();
	    //$("#closeZc").show();
	    $("button").toggle();
		document.getElementById("departname").disabled=true;
		document.getElementById("departname").value="";
		document.getElementById("flag").value="2";
		var departid = '<s:property value="getDepartid()"/>';
		var url = "<s:property value="basePath"/>/suggest?aim=djdepart&departid="+departid;	
		var urlqy = "<s:property value="basePath"/>/suggest?aim=qydepart&departid="+departid;	
		getSuggest("updepartname","updepartid",url);		
		getSuggest("cityname","city",urlqy);
		return false;
	}
	function closeBm(){
		document.getElementById("updepartname").value="";
		document.getElementById("updepartid").value="";
		document.getElementById("cityname").value="";
		document.getElementById("city").value="";	
		$("#dwdj").hide();	
		$("#openZc").show();
		$("#closeZc").hide();	
		document.getElementById("departname").disabled=false;	
		document.getElementById("flag").value="1";
		return false;
	}
	
	function checkXz(){
		
		 var xz = document.getElementById("xz").value;
		 var departtype = document.getElementById("departtype").value;
		 var bh = document.getElementById("bh").value;
		 var span = document.getElementById('spanbh');
			 if (departtype==''){
				 canSubmit = false;
		       	 span.innerHTML = '<font style="color:red;">请选择单位类型</span>';	       	  
				 document.getElementById("bh").value='';
				 return false;
			 }
			 if (xz==''){
				 canSubmit = false;
		       	 span.innerHTML = '<font style="color:red;">请选择畜种</span>';	       	  
				 document.getElementById("bh").value='';
				 return false;
			 }
			 if (xz=='01'&&departtype=='2'&&bh.length!=5){
				 canSubmit = false;
		       	 span.innerHTML = '<font style="color:red;">请输入5位单位编号</span>';	       	  
				 document.getElementById("bh").value='';
				 return false;
			 }
			 if (xz=='02'&&departtype=='2'&&bh.length!=6){
				 canSubmit = false;
		       	 span.innerHTML = '<font style="color:red;">请输入6位单位编号</span>';	       	  
				 document.getElementById("bh").value='';
				 return false;
			 }
			 if (xz=='01'&&departtype=='1'&&bh.length!=4){
				 canSubmit = false;
		       	 span.innerHTML = '<font style="color:red;">请输入4位单位编号</span>';	       	  
				 document.getElementById("bh").value='';
				 return false;
			 }
			 span.innerHTML = '';
			 if(xz!=''&&bh.length>0){
					var url_bak = document.forms[0].action;			
					var url = getActionName() + "-checkDwbh.action";						
					$.post(url,
						  {xz: xz,bh: bh, reqtime: (new Date()).getTime()  },
						  function(data){	
								if(data.indexOf('true') != -1){
									canSubmitBh = true;
				            		span.innerHTML = '<font style="color:green;">可使用</span>';
				            	}else{
				            		canSubmitBh = false;
					            	span.innerHTML = '<font style="color:red;">不可用</span>';
				            	}
						}
					 );
			}
		 }
	
	</script>	
  </head>
  
  <body style="text-align=center;">
<div class="box1" style="width:960px;height:560px;margin:0 auto;">
  <s:form name="theform" method="post" theme="simple" enctype="multipart/form-data">  
  <s:hidden name="tdepartDetail.departid" />
  <s:hidden id="departid" name="tsysUser.depart.departid" />
  <s:hidden name="sfxz" id="sfxz" />
  <s:hidden name="tsysDepart.departid" id="newdepartid"/>
  <s:hidden name="tsysDepart.updepartid" id="updepartid"/>
  <s:hidden name="tsysDepart.city" id="city"/>
  <s:hidden name="tsysDepart.depth" id="depth"/>
  <s:hidden name="tdepartDetail.zxqct" id="zxqct"/>
  <s:hidden name="tsysDepart.state" id="state" value="2"/>
  <s:hidden name="type" value="%{#parameters.type[0]}"/>
  <s:hidden name="flag" id="flag" value="1"/>
  <style>
	body { 
font-family: Arial, Helvetica, sans-serif; 
font-size:12px; 
color:#666666; 
background:#fff; 
text-align:center; 
} 
td{
font-size:14px; 
line-height: 20px
}
* { 
margin:0; 
padding:0; 
} 

h3 { 
font-size:13px; 
font-weight:bold; 
} 

pre,p { 
color:#1E7ACE; 
margin:4px; 
} 
input, select,textarea { 
padding:1px; 
margin:2px; 
font-size:13px; 
} 
.buttom{ 
padding:1px 10px; 
font-size:13px; 
border:1px #1E7ACE solid; 
background:#D0F0FF; 
} 
#formwrapper { 
width:450px; 
margin:15px auto; 
padding:20px; 
text-align:left; 
border:1px #1E7ACE solid; 
} 

fieldset { 
padding:10px; 
margin-top:10px; 
font-size:14px; 
border:1px solid #FAA10C; 
background:#fff; 
} 

fieldset legend { 
color:#FAA10C; 
font-weight:bold; 
padding:3px 20px 3px 20px; 
border:1px solid #FAA10C; 
background:#fff; 
}
fieldset div { 
clear:left; 
margin-bottom:2px; 
} 

.enter{ text-align:center;} 
.clear { 
clear:both; 
} 
	
</style>

	<%@include file="../../cms/public/common/head.jsp" %>
	
<div class="padding_top10" >
		<table class="tableStyle" transMode="true">
			<tr>
				<td colspan="4">									
					<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
						<span id="SystemErrorMessage" style="top: 20px">
							<s:actionerror cssStyle="color:red"/>
							<s:actionmessage cssStyle="color:blue"/>
							<s:fielderror/>
						</span>
					</s:if>
				</td>
			</tr>
		</table>
	</div> 
 <div>
  <fieldset> 
　 <legend>用户登录信息</legend>
  <table class="tableStyle" transMode="true"  footer="normal" border="0">     
    <tr> 
      <td align="right" nowrap="nowrap" width="132px">登录帐号：</td>
      <td align="left" nowrap="nowrap" width="283px"><s:textfield id="userLoginId" name="tsysUser.userloginid" maxlength="10" size="20" onblur="checkusername();" cssClass=" validate[required,length[4,10],custom[noSpecialCaracters]]"/> <label style="color:red">*</label><span id="span" ></span></td>
	  <td width="5px"></td>
	  <td align="left">用户名由4-10个英文字母或数字及下划线组成。一旦注册成功，不可修改。</td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap">密&nbsp;&nbsp;码：</td>
      <td align="left" nowrap="nowrap"><s:password id="userPwd" name="tsysUser.userpwd" maxlength="50" size="20" style="ime-mode:disabled;width: 150px"/> <label style="color:red">*</label></td>
	  <td width="5px" ></td>
	  <td align="left" nowrap="nowrap">密码由4-20个英文字母或数字及下划线组成，建议采用易记、难猜的英文数字组合。 </td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap">确认密码：</td>
      <td align="left"><s:password id="passwd"  maxlength="50" size="20" style="ime-mode:disabled;width: 150px" /> <label style="color:red">*</label></td>
	  <td width="5px"></td>
	  <td align="left">请再次输入密码确认。</td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap">用户名称：</td>
      <td align="left"><s:textfield id="userName" name="tsysUser.username" maxlength="10" size="20" cssClass="validate[required,custom[chinese],length[0,10]]"/> <label style="color:red">*</label></td>
      <td width="5px"></td>
      <td align="left"></td>	
    </tr>    
    <tr> 
      <td align="right" nowrap="nowrap">所属单位：</td>
      <td align="left" ><span id="olddepart"><s:textfield id="departname" name="tsysUser.depart.departname" maxlength="25" size="20" disabled="false"/></span> <label style="color:red">*</label>
      &nbsp;<button class="button1" onclick="addBm();return false;" id="openZc"><span class="icon_edit">注册新单位</span></button>
      <button class="button1" onclick="closeBm();return false;" id="closeZc" style="display:none"><span class="icon_edit" >取消注册单位</span></button> 
      </td>
      <td width="5px"></td>
      <td align="left">请在输入框里输入所属单位，如果没有或需要添加，请点击"注册新单位"</td>
    </tr>    
  </table>
  </fieldset>
  </div>
  <div id="dwdj" style="display:none" >
	  <div>
		  <fieldset> 
		　 <legend>基本信息</legend>
		  <table class="tableStyle" transMode="true"  footer="normal">
		    <tr>      
		      <td align="right" width="142px" nowrap="nowrap">单位名称：</td>
		      <td width="40%" align="left" nowrap="nowrap"><s:textfield name="tsysDepart.departname" id="newdepartname" maxlength="20" size="26"/> <label style="color:red">*</label></td>
		      <td align="right" width="10%" nowrap="nowrap"><span id="ssgs">所属公司：</span></td>
		      <td width="40%" align="left"><span id="ssgstxt"><s:textfield name="tsysDepart.updepartname" id="updepartname" maxlength="20" size="26" /></span>	
		     </td>   
		    </tr>       
		    <tr>
		      <td align="right" nowrap="nowrap">单位类型：</td>
		      <td align="left"><s:select id="departtype" name="tsysDepart.departtype" list="#{'2':'种畜禽场','1':'公司'}" listKey="key" listValue="value" cssClass="default" onchange="corpCtrl();"></s:select></td>
		      <td align="right" nowrap="nowrap">所属区县：</td>
		      <td align="left"><s:textfield name="tsysDepart.cityname" id="cityname" maxlength="20" size="20" /> <label style="color:red">*</label></td>
		    </tr>    
			<tr> 
			  <td align="right" nowrap="nowrap">单位描述：</td>
			  <td colspan="3" align="left">
				 <span class="float_left"><s:textarea name="tsysDepart.description" id="description" cssStyle="width:400px;" cssClass="validate[length[0,50]]"/></span>
				 <span class="img_light" style="height:80px;" title="限制在50字以内"></span> 
			  </td>
			</tr> 	
		  </table>
		  </fieldset>  
	  </div>
	  <div id="corpCtrl_yzcxx_" >
	    <div>
		<fieldset> 
				<legend>养殖信息</legend> 		
				<table class="tableStyle" transMode="true" footer="normal" border="0" width="940px">
					<tr>
						<td align="right" width="148px" nowrap="nowrap">许可证号：</td>
						<td align="left" width="300px" nowrap="nowrap"><s:textfield name="tdepartDetail.xkzbh" /></td>					
						<td align="right" width="148px" nowrap="nowrap"><span class="float_right">许可证有效期到：</span></td>
						<td align="left" width="30%" nowrap="nowrap"><input type="text" name="tdepartDetail.yxq" onFocus="WdatePicker({startDate:'%y-%M-%d',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true})" /></td>
					</tr>
					<tr>
						<td align="right" nowrap="nowrap">养殖畜种：</td>
						<td align="left" nowrap="nowrap"><s:select name="tdepartDetail.xz" id="xz" list="getSysCode('xz')" cssClass="default" listKey="id" listValue="caption" headerKey="" headerValue="----请选择-----" onchange="onchPzxx();checkXz();" /> <label style="color:red">*</label></td>
						<td align="right" nowrap="nowrap">单位性质：</td>
						<td align="left" nowrap="nowrap"><s:select name="tdepartDetail.dwxz" list="getSysCode('dwxz')" cssClass="default" listKey="id" listValue="caption" headerKey="" headerValue="----请选择-----"/></td>
					</tr>								
					<tr>
						<td align="right" nowrap="nowrap">法人代表：</td>
						<td align="left" nowrap="nowrap"><s:textfield name="tdepartDetail.frdb" /></td>
						<td align="right" nowrap="nowrap">单位图片：</td>
						<td align="left" nowrap="nowrap"> 
							<span class="float_left"><input type="file" name="zxqct" class="default"/></span>
						    <s:if test="tdepartDetail.zxqct!=null&&tdepartDetail.zxqct!=''">
							    <ul class="imgBubble">
							    	<li><a href="../${tdepartDetail.zxqct }" target="_blank"><img id="syydt_img" src="../${txxfbWz.zxqct }" alt="点击查看原图" border="1"/></a></li>
							    </ul>
						    </s:if>
					    </td>					
					</tr>	
					<tr>
						<td align="right" nowrap="nowrap">单位编号：</td>
						<td align="left" nowrap="nowrap"><s:textfield name="tdepartDetail.bh" id="bh" maxlength="6" onblur="checkXz();" /><label style="color:red">*</label><span id="spanbh" ></span></td>					
						<td align="right" colspan="2"></td>
					</tr>				
				</table>
		</fieldset> 
		</div>		
			<div id="corpCtrl_yzcxx" >
				<fieldset> 
					<legend>养殖规模信息</legend> 		
					<table  id="yzgm" class="default">
						<tr>
							<th width="100">品种</th>
							<th width="100">品系</th>
							<th width="100">代次</th>					
							<th width="100">基础母畜禽存栏</th>
							<th width="100">基础公畜禽存栏</th>
							<th width="100">后备母畜禽存栏</th>
							<th width="100">后备公畜禽存栏</th>
							<th></th>
						</tr>
						 <s:if test="listTDepartVariety==null || listTDepartVariety.size==0">
			               <tr id="[%{#stat.index}]">
			                 <td id="pzFirst"><s:hidden name="listTDepartVariety[%{#stat.index}].wid"/>
			                 	  <select id="pz" name="listTDepartVariety[0].pz"  onchange="onchPxxx('0');" style="width:100px;" class="default">	                     
			                      </select>             
			                 </td>
			                 <td id="pxFirst"><select id="px" name="listTDepartVariety[0].px"  style="width:100px;" class="default">	
			                      </select>             
			                 </td>
			                 <td id="dcFirst"><s:select id="dc" name="listTDepartVariety[0].dc" list="getSysCode('dc')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--" cssClass="default"/></td>
			                 <td><s:textfield name="listTDepartVariety[0].jcmxqcl"  id="jcmxqcl"  maxlength="8" size="15" onkeypress="NumberText(event,false,false);"/></td>
			                 <td><s:textfield name="listTDepartVariety[0].jcgxqcl"  id="jcgxqcl"  maxlength="8" size="15" onkeypress="NumberText(event,false,false);"/></td>
			                 <td><s:textfield name="listTDepartVariety[0].hbmxqcl"  id="hbmxqcl"  maxlength="8" size="15" onkeypress="NumberText(event,false,false);"/></td>
			                 <td><s:textfield name="listTDepartVariety[0].hbgxqcl"  id="hbgxqcl"  maxlength="8" size="15" onkeypress="NumberText(event,false,false);"/></td>
			                <td ><input type="button" value="添加" onclick="createyzgm();"/></td>
			             </tr>
			             </s:if>
			            <s:else>
			            <% int i=0; %>
							   <s:iterator value="listTDepartVariety" status="stat">
						    	  <tr>  
							    	<s:hidden name="listTDepartVariety[%{#stat.index}].wid"/>
							    	 <td <%if(i==0){%> id="pzFirst" <%}%> ><select name="listTDepartVariety[<%=i%>].pz"  id="pz" style="width:100px;" class="default" onchange="onchPxxx('<%=i%>');"></select>
							         </td>
							         <td  <%if(i==0){%> id="pxFirst" <%}%>><select      name="listTDepartVariety[<%=i%>].px"  id="px" style="width:100px;" class="default"></select>
							         </td>
							         <td  <%if(i==0){%> id="dcFirst" <%}%>><s:select    name="listTDepartVariety[%{#stat.index}].dc" list="getSysCode('dc')" listKey="id" listValue="caption" headerKey="" headerValue="--请选择--" cssClass="default"/></td>
							         <td><s:textfield name="listTDepartVariety[%{#stat.index}].jcmxqcl" id="jcmxqcl" value="%{jcmxqcl}" maxlength="100" size="15" onkeypress="NumberText(event,false,false);"/></td>
							         <td><s:textfield name="listTDepartVariety[%{#stat.index}].jcgxqcl" id="jcgxqcl" value="%{jcgxqcl}" maxlength="100" size="15" onkeypress="NumberText(event,false,false);"/></td>
							         <td><s:textfield name="listTDepartVariety[%{#stat.index}].hbmxqcl" id="hbmxqcl" value="%{hbmxqcl}" maxlength="100" size="15" onkeypress="NumberText(event,false,false);"/></td>
							         <td><s:textfield name="listTDepartVariety[%{#stat.index}].hbgxqcl" id="hbgxqcl" value="%{hbgxqcl}" maxlength="100" size="15" onkeypress="NumberText(event,false,false);"/></td>
							         
							        <td >
							         <script type="text/javascript">					           
								         var pzbh='<s:property value="pz"/>';
								         var px='<s:property value="px"/>';				             				          
							             onchangePzxx(<%=i%>,pzbh);	
							             onchangePxxx(<%=i%>,pzbh,px);				            
							          </script>	
							         
							         <s:if test="#stat.index==0">
									     <input type="button" value="添加" onclick="createyzgm()"/>
								     </s:if>
								     <s:else>
									     <input id="jtxx_<s:property value="#stat.index"/>" type="button" value="删除" onclick="removeThisRow(this)"/>			     
								     </s:else>
								     </td>
								      <% i++; %>
							     </tr>
						    	</s:iterator>
					    </s:else>	
					</table>
			</fieldset> 
			</div>	
	</div>
	 <div >
	 <fieldset> 
	　 <legend>通讯信息</legend>
		  <table class="tableStyle" transMode="true" footer="normal">   
		    <tr>      
		      <td align="right" width="7%">联系人：</td>
		      <td width="28%" align="left"><s:textfield name="tsysDepart.linkname" id="linkname" maxlength="20" size="31"/> </td>
		      <td align="right" width="7%">联系电话：</td>
		      <td width="28%" align="left"><s:textfield name="tsysDepart.linktel" id="linktel" maxlength="12" size="31" onkeypress="NumberText(event,false,false);" cssStyle="ime-mode:disabled"/> </td>
		    </tr>    
		    <tr>      
		      <td align="right">联系地址：</td>
		      <td align="left"><s:textfield name="tsysDepart.linkaddress" id="linkaddress" maxlength="40" size="31"/> </td>
		      <td align="right">联系邮编：</td>
		      <td align="left"><s:textfield name="tsysDepart.linkpostcode" id="linkpostcode" maxlength="6" size="31" onkeypress="NumberText(event,false,false);" cssStyle="ime-mode:disabled"/> </td>
		    </tr>    
		    <tr>      
		      <td align="right">联系邮箱：</td>
		      <td align="left"><s:textfield name="tsysDepart.linkemail" id="linkemail" maxlength="50" size="31"/> </td>
		      <td align="right">联系传真：</td>
		      <td align="left"><s:textfield name="tsysDepart.linkfax" id="linkfax" maxlength="50" size="31"/> </td>
		    </tr>
		    
		  </table>
  </fieldset> 
  </div>
  </div>
	<div class="padding_top10" >
		<table class="tableStyle" transMode="true" border="0" align="center" width="957px">
			<tr>
				<td colspan="4" align="center">									
					<input class="button" type="button" id="" value="注 册 " onclick="doSave();"/>&nbsp;&nbsp;&nbsp;&nbsp;		
					<input class="button" type="reset" value="重 置 "/>
				</td>
			</tr>
		</table>
	</div> 
</s:form>
<div class="padding-top20">
<%@include file="../../cms/public/common/foot.jsp" %>
</div>
</div>
  </body>
</html>
