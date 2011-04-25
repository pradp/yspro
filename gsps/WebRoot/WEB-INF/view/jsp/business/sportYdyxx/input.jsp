<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>运动员信息维护</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" href="<s:property value="basePath"/>/resources/css/webface.css" type="text/css">
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/jquery/jquery-1.2.6.pack.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/myutil.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/webctrl.js"></script>
	<script type="text/javascript" src="<s:property value="basePath"/>/resources/js/common/idcard.js"></script>
	<script type="text/javascript">
		detailPageStyle();

		validate_required_fields = [ 
		    {fieldId:"sfzh", message:"身份证号不能为空！", mustMatch: true}, 
		    {fieldId:"xm", message:"姓名不能为空！", mustMatch: true},
		    {fieldId:"xb", message:"性别不能为空！", mustMatch: true},
		    {fieldId:"csrq", message:"出生日期不能为空！", mustMatch: true},
		    {fieldId:"zch", message:"注册号不能为空！", mustMatch: true},
		    {fieldId:"yddbmName", message:"所属运动队不能为空！", mustMatch: true},
		    {fieldId:"state", message:"状态不能为空！", mustMatch: true}
		                	];
		var tem_valueObjid,tem_nameObjid;
		function selectArea(valueObjid,nameObjid){
			tem_valueObjid = valueObjid;
			tem_nameObjid = nameObjid;
			var url = "<s:property value="basePath"/>/system/area-areaTree.c";
			openTreeDialog(url);
		}

		function selectDepart(valueObjid,nameObjid){
			tem_valueObjid = valueObjid;
			tem_nameObjid = nameObjid;
			//document.getElementById("xyjfdq7").value = tem_valueObjid;
			var url = "<s:property value="basePath"/>/system/depart-departTree.c";
			openTreeDialog(url);
		}

		function complete2(){
		    var address=document.getElementById("hjszqxName").value;
		    var id=document.getElementById("hjszqx").value;
		    if(address!=""){
		       if(document.getElementById("zzszqxName").value==""){
		          document.getElementById("zzszqxName").value=address;
		          document.getElementById("zzszqx").value=id;
		       }
		       if(document.getElementById("jzhjszqxName").value==""){
		          document.getElementById("jzhjszqxName").value=address;
		          document.getElementById("jzhjszqx").value=id;
		       }
		       if(document.getElementById("jtszqxName").value==""){
		          document.getElementById("jtszqxName").value=address;
		          document.getElementById("jtszqx").value=id;
		       }
		    }
		}

		function complete1(){
			var address=document.getElementById("yddbmName").value;
			var id=document.getElementById("yddbm").value;
			if(id.length!=9){
				alert("所属运动队中,请选择具体的区县!");
				return false;
			}else{
				if(address!=""){
					   if(document.getElementById("xyjfdqName1").value==""){
					       document.getElementById("xyjfdqName1").value=address.substring(0,(address.length-3));
					       document.getElementById("xyjfdq1").value=id;
					   }
				}
			}
		}
		
		function checkXssfzh(objid){
		    var sfzh = document.getElementById(objid).value;
		    //alert(sfzh);
		    if(sfzh.length!=0){
	        	if (!idChecked("theform", objid, "")) {
					document.getElementById(objid).value = "";
				}
	        }
		    if(sfzh.length==18){
			        var xb=sfzh.substring(16,17);
			        //alert(xb);
			        if (xb=="0"||xb=="2"||xb=="4"||xb=="6"||xb=="8"){
			           xb="2";
			        }else{xb="1";}
			        //alert("1222");
					document.getElementById('xb').value=xb;
					//alert(xb)
			        var csny= sfzh.substring(6,10)+'-'+sfzh.substring(10,12)+'-'+sfzh.substring(12,14);
			        //alert(csny);
					document.getElementById('csrq').value=csny;
					document.getElementById('sfzh').value=(document.getElementById('sfzh').value).toUpperCase();

			}else if(sfzh.length==15){
			    
			        var xb=sfzh.substr(14,1);
			        if (xb=="0"||xb=="2"||xb=="4"||xb=="6"||xb=="8")
			           {
			           xb="2";}
			            else
			            {xb="1";}
					document.getElementById('xb').value=xb;
				
			        var csny='19'+sfzh.substring(6,8)+'-'+sfzh.substring(8,10);
			        document.getElementById('csrq').value=csny;
			}
			
		}

		function dosave(){//<s:property value="depart.departtype" />
			var userpart = '<s:property value="getLoginUser().getUsertype()" />';
			if(userpart!=4){
				dosave_new();
			}else{
				if(isValidateForm()){
					submitForm();
				}
			}
		}
		
		function dosave_new(){
			var ydd = document.getElementById('yddbm').value;//运动队
			//alert(ydd);
			//return false;
			if(ydd.length==9){
				ydd = ydd.substring(0,6);
			}
			//alert(ydd);
			var ssd = document.getElementById('xyjfdq7').value;//输送地
			var cxd = document.getElementById('xyjfdq3').value;//承训地
			var zcd = document.getElementById('xyjfdq1').value;//注册地
			var xyd = document.getElementById('xyjfdq2').value;//协议地
			var xbd = document.getElementById('xyjfdq4').value;//选拔地
			var qx1 = document.getElementById('xyjfdq5').value;//区县一
			qx11 = qx1;
			if(qx1.length==9){
				qx1 = qx1.substring(0,6);
			}
			var qx2 = document.getElementById('xyjfdq6').value;//区县二
			qx22 = qx2;
			if(qx2.length==9){
				qx2 = qx2.substring(0,6);
			}
			var cxdjfbl = document.getElementById('xyjfbl3').value;//承训地计分比例
			var cxddpbl = document.getElementById('xydpbl3').value;//承训地得牌比列
			var ssdjfbl = document.getElementById('xyjfbl7').value;//输送地计分比例
			var ssddpbl = document.getElementById('xydpbl7').value;//输送地得牌比例 
			var xydjfbl = document.getElementById('xyjfbl2').value;//协议地计分比例
			var xyddpbl = document.getElementById('xydpbl2').value;//协议地得牌比例
			var qx1jfbl = document.getElementById('xyjfbl5').value;//区县一计分比例
			var qx1dpbl = document.getElementById('xydpbl5').value;//区县一得牌比例
			var qx2jfbl = document.getElementById('xyjfbl6').value;//区县二计分比例
			var qx2dpbl = document.getElementById('xydpbl6').value;//区县二得牌比例
			//alert(qx1jfbl);alert(qx1dpbl);alert(qx2jfbl);alert(qx2dpbl);
			var xbdjf = document.getElementById('xyjfbl4').value;//选拔地得分
			if(ydd==cxd){
				if(ydd!=ssd&&ssd!=""){
					if(cxdjfbl==1&&cxddpbl==1){
						document.getElementById('xyjfdq1').value = cxd;
						document.getElementById('xyjfbl1').value = cxdjfbl;
						document.getElementById('xydpbl1').value = cxddpbl;
					}
					if(cxdjfbl!=1){
						var conf = window.confirm("承训地计分比例应该为1，点击【确认】修改，忽略点击【取消】");
						if(conf==true){
							return false;
						}else{
							document.getElementById('xyjfdq1').value = cxd;
							document.getElementById('xyjfbl1').value = cxdjfbl;
							document.getElementById('xydpbl1').value = cxddpbl;
						}
					}
					if(cxddpbl!=1){
						var conf = window.confirm("承训地得牌比例应该为1，点击【确认】修改，忽略点击【取消】");
						if(conf==true){
							return false;
						}else{
							document.getElementById('xyjfdq1').value = cxd;
							document.getElementById('xyjfbl1').value = cxdjfbl;
							document.getElementById('xydpbl1').value = cxddpbl;
						}
					}
					if(xyd==""){
						if(ssdjfbl==1&&ssddpbl==1){
							document.getElementById('xyjfdq1').value = cxd;
							document.getElementById('xyjfbl1').value = cxdjfbl;
							document.getElementById('xydpbl1').value = cxddpbl;
						}
						if(ssdjfbl!=1){
							var conf = window.confirm("输送地计分比例应该为1，点击【确认】修改，忽略点击【取消】");
							if(conf==true){
								return false;
							}else{
								document.getElementById('xyjfdq1').value = cxd;
								document.getElementById('xyjfbl1').value = cxdjfbl;
								document.getElementById('xydpbl1').value = cxddpbl;
							}
						}
						if(ssddpbl!=1){
							var conf = window.confirm("输送地得牌比例应该为1，点击【确认】修改，忽略点击【取消】");
							if(conf==true){
								return false;
							}else{
								document.getElementById('xyjfdq1').value = cxd;
								document.getElementById('xyjfbl1').value = cxdjfbl;
								document.getElementById('xydpbl1').value = cxddpbl;
							}
						}
					}else if(xyd!=""){
						if(xydjfbl==""){
							alert("请填写协议地计分比例!");
							return false;
						}
						if(xyddpbl==""){
							alert("请填写协议地得牌比例!");
							return false;
						}
						if(ssdjfbl==0.5&&ssddpbl==0.5){
							document.getElementById('xyjfdq1').value = cxd;
							document.getElementById('xyjfbl1').value = cxdjfbl;
							document.getElementById('xydpbl1').value = cxddpbl;
						}
						if(ssdjfbl!=0.5){
							var conf = window.confirm("输送地计分比例应该为0.5，点击【确认】修改，忽略点击【取消】");
							if(conf==true){
								return false;
							}else{
								document.getElementById('xyjfdq1').value = cxd;
								document.getElementById('xyjfbl1').value = cxdjfbl;
								document.getElementById('xydpbl1').value = cxddpbl;
							}
						}
						if(ssddpbl!=0.5){
							var conf = window.confirm("输送地得牌比例应该为0.5，点击【确认】修改，忽略点击【取消】");
							if(conf==true){
								return false;
							}else{
								document.getElementById('xyjfdq1').value = cxd;
								document.getElementById('xyjfbl1').value = cxdjfbl;
								document.getElementById('xydpbl1').value = cxddpbl;
							}
						}
						if(xydjfbl!=0.5){
							var conf = window.confirm("协议地计分比例应该为0.5，点击【确认】修改，忽略点击【取消】");
							if(conf==true){
								return false;
							}
						}
						if(xyddpbl!=0.5){
							var conf = window.confirm("协议地得牌比例应该为0.5，点击【确认】修改，忽略点击【取消】");
							if(conf==true){
								return false;
							}
						}
					}
				}else if(ydd!=ssd&&ssd==""){
					alert("输送地未填写!");
					return false;
				}else{
					alert("注册地不允许既为输送地又为承训地!");
					return false;
				}
			}else if(ydd==ssd){
				if(ydd!=cxd&&cxd!=""){
					if(xyd==""){
						if(ssdjfbl==1&&ssddpbl==1){
							document.getElementById('xyjfdq1').value = ssd;
							document.getElementById('xyjfbl1').value = ssdjfbl;
							document.getElementById('xydpbl1').value = ssddpbl;
						}
						if(ssdjfbl!=1){
							var conf = window.confirm("输送地计分比例应该为1，点击【确认】修改，忽略点击【取消】");
							if(conf==true){
								return false;
							}else{
								document.getElementById('xyjfdq1').value = ssd;
								document.getElementById('xyjfbl1').value = ssdjfbl;
								document.getElementById('xydpbl1').value = ssddpbl;
							}
						}
						if(ssddpbl!=1){
							var conf = window.confirm("输送地得牌比例应该为1，点击【确认】修改，忽略点击【取消】");
							if(conf==true){
								return false;
							}else{
								document.getElementById('xyjfdq1').value = ssd;
								document.getElementById('xyjfbl1').value = ssdjfbl;
								document.getElementById('xydpbl1').value = ssddpbl;
							}
						}
					}else if(xyd!=""){
						if(xydjfbl==""){
							alert("请填写协议地计分比例!");
							return false;
						}
						if(xyddpbl==""){
							alert("请填写协议地得牌比例!");
							return false;
						}
						if(ssdjfbl==0.5&&ssddpbl==0.5){
							document.getElementById('xyjfdq1').value = ssd;
							document.getElementById('xyjfbl1').value = ssdjfbl;
							document.getElementById('xydpbl1').value = ssddpbl;
						}
						if(ssdjfbl!=0.5){
							var conf = window.confirm("输送地计分比例应该为0.5，点击【确认】修改，忽略点击【取消】");
							if(conf==true){
								return false;
							}else{
								document.getElementById('xyjfdq1').value = ssd;
								document.getElementById('xyjfbl1').value = ssdjfbl;
								document.getElementById('xydpbl1').value = ssddpbl;
							}
						}
						if(ssddpbl!=0.5){
							var conf = window.confirm("输送地得牌比例应该为0.5，点击【确认】修改，忽略点击【取消】");
							if(conf==true){
								return false;
							}else{
								document.getElementById('xyjfdq1').value = ssd;
								document.getElementById('xyjfbl1').value = ssdjfbl;
								document.getElementById('xydpbl1').value = ssddpbl;
							}
						}
						if(xydjfbl!=0.5){
							var conf = window.confirm("协议地计分比例应该为0.5，点击【确认】修改，忽略点击【取消】");
							if(conf==true){
								return false;
							}
						}
						if(xyddpbl!=0.5){
							var conf = window.confirm("协议地得牌比例应该为0.5，点击【确认】修改，忽略点击【取消】");
							if(conf==true){
								return false;
							}
						}
					}
					if(cxdjfbl==1&&cxddpbl==1){
						document.getElementById('xyjfdq1').value = ssd;
						document.getElementById('xyjfbl1').value = ssdjfbl;
						document.getElementById('xydpbl1').value = ssddpbl;
					}
					if(cxdjfbl!=1){
						var conf = window.confirm("承训地计分比例应该为1，点击【确认】修改，忽略点击【取消】");
						if(conf==true){
							return false;
						}else{
							document.getElementById('xyjfdq1').value = ssd;
							document.getElementById('xyjfbl1').value = ssdjfbl;
							document.getElementById('xydpbl1').value = ssddpbl;
						}
					}
					if(cxddpbl!=1){
						var conf = window.confirm("承训地得牌比例应该为1，点击【确认】修改，忽略点击【取消】");
						if(conf==true){
							return false;
						}else{
							document.getElementById('xyjfdq1').value = ssd;
							document.getElementById('xyjfbl1').value = ssdjfbl;
							document.getElementById('xydpbl1').value = ssddpbl;
						}
					}
				}else if(ydd!=cxd&&cxd==""){
					alert("承训地未填写!");
					return false;
				}else{
					alert("注册地不允许既为输送地又为承训地!");
					return false;
				}
			}else if(ydd!=cxd&&ydd!=ssd&&cxd!=""&&ssd!=""){
				alert("注册地不允许既不是输送地又不是承训地!");
				return false;
			}
			
			if(xbd!=""&&xbdjf!=""&&xbd!=ydd){
				if(xbdjf!=3){
					var conf = window.confirm("选拔地得分应该为3分，点击【确认】修改，忽略点击【取消】");
					if(conf==true){
						return false;
					}
				}
			}
			if(xbd!=""&&xbdjf!=""&&xbd==ydd){
				alert("注册地不能与选拔地相同!");
				return false;
			}
			if(xbd!=""&&xbdjf==""){
				alert("请填写选拔地得分!");
				return false;
			}
			if((qx11!=""&&qx1!=ydd)){
				alert("区县一应该为注册地的下级区县!");
				return false;
			}
			if(qx11!=""&&qx11.length!=9){
				alert("区县一中应该填写区县!");
				return false;
			}
			if((qx22!=""&&qx2!=ydd)){
				alert("区县二应该为注册地的下级区县!");
				return false;
			}
			if(qx22!=""&&qx12.length!=9){
				alert("区县二中应该填写区县!");
				return false;
			}
			if(qx1!=""&&qx11==qx22){
				alert("请选择两个不同的区县!");
				return false;
			}
			if((qx1!=""&&qx1jfbl=="")||(qx1!=""&&qx1dpbl=="")){
				//alert("1");
				alert("请将区县一中数据填写完整!");
				return false;
			}
			if(qx1!=""&&qx1jfbl>1){
				var conf = window.confirm("区县一计分比例应该小于1，点击【确认】修改，忽略点击【取消】");
				if(conf==true){
					return false;
				}
			}
			if(qx1!=""&&qx1dpbl>1){
				var conf = window.confirm("区县一记牌比例应该小于1，点击【确认】修改，忽略点击【取消】");
				if(conf==true){
					return false;
				}
			}
			if(qx2!=""&&(qx2jfbl==""||qx2dpbl=="")){
				alert("请将区县二中数据填写完整!");
				return false;
			}
			if(qx2!=""&&qx2jfbl>1){
				var conf = window.confirm("区县二计分比例应该小于1，点击【确认】修改，忽略点击【取消】");
				if(conf==true){
					return false;
				}
			}
			if(qx2!=""&&qx2dpbl>1){
				var conf = window.confirm("区县二记牌比例应该小于1，点击【确认】修改，忽略点击【取消】");
				if(conf==true){
					return false;
				}
			}
			if(isValidateForm()){
				submitForm();
			}
		}	
		function dosavenew(){
			document.getElementById("sfxz").value = "1";
			dosave();
		}
		function dosaveclose(){
			dosave();
			parent.closeInputWindow();
		}

		function checkqx(ob1,ob2){
			var dq = document.getElementById(ob1).value;
			if(dq.length!=6&&ob1=='xyjfdq3'&&dq!=""){
				alert("承训地请选择大市!");
				document.getElementById(ob2).value="";
				return false;
			}else if(dq.length!=6&&ob1=='xyjfdq7'&&dq!=""){
				alert("输送地请选择大市!");
				document.getElementById(ob2).value="";
				return false;
			}else if(dq.length!=6&&ob1=='xyjfdq2'&&dq!=""){
				alert("协议地请选择大市!");
				document.getElementById(ob2).value="";
				return false;
			}else if(dq.length!=6&&ob1=='xyjfdq4'&&dq!=""){
				alert("选拔地请选择大市!");
				document.getElementById(ob2).value="";
				return false;
			}
		}

		function checkqx1(ob1,ob2){
			var dq = document.getElementById(ob1).value;
			if(dq.length!=9&&ob1=='xyjfdq5'&&dq!=""){
				alert("区县一请选择具体区县!");
				document.getElementById(ob2).value="";
				return false;
			}else if(dq.length!=9&&ob1=='xyjfdq6'&&dq!=""){
				alert("区县二请选择具体区县!");
				document.getElementById(ob2).value="";
				return false;
			}
		}
		
	</script>
	<link rel="stylesheet" type="text/css" href="<s:property value="basePath"/>/resources/css/webface.css">
  	<base target="_self">
  </head>
  
  <body style="text-align:center;">
<s:if test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
	<div id="SystemErrorMessage" style="top: 20px">
		<s:actionerror/>
		<s:actionmessage/>
		<s:fielderror/>
	</div>
</s:if>

<div class="framestyle" style="width:98%;padding: 0pt 10pt 10pt 10pt;">
  <s:form name="theform" method="post" theme="simple" >
  <s:hidden name="tsportYdyxx.yddbm" id="yddbm" />
  <s:hidden name="tsportYdyxx.xyjfdq1" id="xyjfdq1" />
  <s:hidden name="tsportYdyxx.xyjfdq2" id="xyjfdq2" />
  <s:hidden name="tsportYdyxx.xyjfdq3" id="xyjfdq3" />
  <s:hidden name="tsportYdyxx.xyjfdq4" id="xyjfdq4" />
  <s:hidden name="tsportYdyxx.xyjfdq5" id="xyjfdq5" />
  <s:hidden name="tsportYdyxx.xyjfdq6" id="xyjfdq6" />
  <s:hidden name="tsportYdyxx.xyjfdq7" id="xyjfdq7" />
  <s:hidden name="tsportYdyxx.wid" />
  <s:hidden name="tsportYdyxx.createtime" />
  <s:hidden id="menues" name="menues" />
  <s:hidden name="sfxz" id="sfxz" />

 <fieldset> 
　 <legend>个人信息</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" width="10%" nowrap="nowrap">身份证号：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:textfield id="sfzh" name="tsportYdyxx.sfzh" maxlength="18" size="18" onblur="checkXssfzh('sfzh')" /> <label style="color:red">*</label>
	</td>
	<td align="right" width="10%">姓名：</td>
	<td align="left" width="20%" nowrap="nowrap">
      	<s:textfield id="xm" name="tsportYdyxx.xm" maxlength="15" size="10" onblur="isUnblank('xm')"/> <label style="color:red">*</label>
      </td>
      <td align="right" nowrap="nowrap" width="10%">性别：</td>
      <td width="16%">
		 <s:select id="xb" name="tsportYdyxx.xb" list="#{'1':'男','2':'女'}" headerKey="" headerValue="-请选择-" />
			 <label style="color:red">*</label>
		</td> 
    </tr>
 
    <tr> 
      <td align="right" nowrap="nowrap" width="10%">出生日期：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:textfield name="tsportYdyxx.csrq" id="csrq" maxlength="10" size="10"/>&nbsp;如:1988-12-1 <label style="color:red">*</label>					   
      </td>
      <td align="right" nowrap="nowrap" width="10%">身高：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:textfield name="tsportYdyxx.sg" id="sg" maxlength="10" size="10"  onkeypress="NumberText(event,false,true);" />&nbsp;CM				   
      </td>
      <td align="right" nowrap="nowrap" width="10%">体重：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:textfield name="tsportYdyxx.tz" id="tz" maxlength="10" size="10" onkeypress="NumberText(event,false,true);" />&nbsp;KG				   
      </td>
    </tr>
    <tr> 
      <td align="right" nowrap="nowrap" width="10%">注册号：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:textfield name="tsportYdyxx.zch" id="zch" maxlength="12" size="10"/> <label style="color:red">*</label>					   
      </td>
      <td align="right" nowrap="nowrap" width="10%">所属运动队：</td>
      <td><s:textfield name="tsportYdyxx.yddbmName" id="yddbmName" maxlength="20" size="20" readonly="true" />
		  <input type="button" value="..." onblur="complete2()"  onclick="selectDepart('yddbm','yddbmName')" /> <label style="color:red">*</label>
	  </td>
	  <td align="right" nowrap="nowrap" width="10%">状态：</td>
      <td width="16%">
      <s:select id="state" name="tsportYdyxx.state" list="getSysCode('STATE')" listKey="id" listValue="caption" headerKey="" headerValue="------请选择------"/>
      					<label style="color:red">*</label>
	  </td>
    </tr>
   
  </table>
 </fieldset>
 
<s:if test="getLoginUser().getUsertype()!=4">
 <fieldset> 
　 <legend>协议地区计分规则</legend>
  <table width="100%" border="0" align="center">
    <tr> 
      <td align="right" width="10%" nowrap="nowrap">代表地：</td>
      <td align="left" width="20%" nowrap="nowrap">
      	<s:textfield name="tsportYdyxx.xyjfdqName1" id="xyjfdqName1" maxlength="25" size="20" readonly="true"  cssStyle="ime-mode:disabled;background-color:#F1F1F1" />
	  </td>
	<td align="right" width="20%">代表地记分比例：</td>
	<td align="left" width="20%" nowrap="nowrap">
      	<s:textfield id="xyjfbl1" name="tsportYdyxx.xyjfbl1"  maxlength="10" size="10" onkeypress="NumberText(event,false,true);" readonly="true"  cssStyle="ime-mode:disabled;background-color:#F1F1F1" />
      </td>
      <td align="right" nowrap="nowrap" width="10%">代表地得牌比例：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:textfield name="tsportYdyxx.xydpbl1" id ="xydpbl1" maxlength="10" size="10"  onkeypress="NumberText(event,false,true);" readonly="true"  cssStyle="ime-mode:disabled;background-color:#F1F1F1" />		   
      </td>
    </tr>
 	
   <tr> 
      <td align="right" width="10%" nowrap="nowrap">承训地：</td>
      <td align="left" width="20%" nowrap="nowrap"><s:textfield name="tsportYdyxx.xyjfdqName3" id="xyjfdqName3" maxlength="25" size="20" readonly="true" onblur="checkqx('xyjfdq3','xyjfdqName3')"/>
		  <input type="button" value="..."  onclick="selectArea('xyjfdq3','xyjfdqName3')" />
	  </td>
	<td align="right" width="20%">承训地记分比例：</td>
	<td align="left" width="20%" nowrap="nowrap">
      	<s:textfield id="xyjfbl3" name="tsportYdyxx.xyjfbl3" maxlength="10" size="10" onkeypress="NumberText(event,false,true);"  />
      </td>
      <td align="right" nowrap="nowrap" width="10%">承训地得牌比例：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:textfield name="tsportYdyxx.xydpbl3" id ="xydpbl3" maxlength="10" size="10" onkeypress="NumberText(event,false,true);"  />				   
      </td>
    </tr>
    
    <tr> 
      <td align="right" width="10%" nowrap="nowrap">注册地：</td>
      <td align="left" width="20%" nowrap="nowrap"><s:textfield name="tsportYdyxx.xyjfdqName7" id="xyjfdqName7" maxlength="25" size="20" readonly="true"  onblur="checkqx('xyjfdq7','xyjfdqName7')"/>
		  <input type="button" value="..."  onclick="selectArea('xyjfdq7','xyjfdqName7')" />
	  </td>
	<td align="right" width="20%">注册地记分比例：</td>
	<td align="left" width="20%" nowrap="nowrap">
      	<s:textfield id="xyjfbl7" name="tsportYdyxx.xyjfbl7" maxlength="10" size="10" onkeypress="NumberText(event,false,true);" />
      </td>
      <td align="right" nowrap="nowrap" width="10%">注册地得牌比例：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:textfield name="tsportYdyxx.xydpbl7" id ="xydpbl7" maxlength="10" size="10" onkeypress="NumberText(event,false,true);"  />					   
      </td>
    </tr>
    
    <tr> 
      <td align="right" width="10%" nowrap="nowrap">原注册地：</td>
      <td align="left" width="20%" nowrap="nowrap"><s:textfield name="tsportYdyxx.xyjfdqName2" id="hjszqxName2" maxlength="25" size="20" readonly="true"  onblur="checkqx('xyjfdq2','hjszqxName2')"/>
		  <input type="button" value="..." onclick="selectArea('xyjfdq2','hjszqxName2')" />
	  </td>
	<td align="right" width="20%">原注册地记分比例：</td>
	<td align="left" width="20%" nowrap="nowrap">
      	<s:textfield id="xyjfbl2" name="tsportYdyxx.xyjfbl2" maxlength="10" size="10" onkeypress="NumberText(event,false,true);" />
      </td>
      <td align="right" nowrap="nowrap" width="10%">原注册地得牌比例：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:textfield name="tsportYdyxx.xydpbl2" id ="xydpbl2" maxlength="10" size="10" onkeypress="NumberText(event,false,true);"  />					   
      </td>
    </tr>
    
    <tr> 
      <td align="right" width="10%" nowrap="nowrap">原&nbsp;&nbsp;&nbsp;&nbsp;籍：</td>
      <td align="left" width="20%" nowrap="nowrap"><s:textfield name="tsportYdyxx.xyjfdqName4" id="xyjfdqName4" maxlength="25" size="20" readonly="true"  onblur="checkqx('xyjfdq4','xyjfdqName4')"/>
		  <input type="button" value="..."  onclick="selectArea('xyjfdq4','xyjfdqName4')" />
	  </td>
	<td align="right" width="20%">原&nbsp;&nbsp;&nbsp;籍&nbsp;&nbsp;&nbsp;得&nbsp;&nbsp;&nbsp;分：</td>
	<td align="left" width="20%" nowrap="nowrap" colspan="3">
      	<s:textfield id="xyjfbl4" name="tsportYdyxx.xyjfbl4" maxlength="10" size="10" onkeypress="NumberText(event,false,true);" />
      </td>
    </tr>
   
   <tr> 
      <td align="right" width="10%" nowrap="nowrap">原注册地区县：</td>
      <td align="left" width="20%" nowrap="nowrap"><s:textfield name="tsportYdyxx.xyjfdqName5" id="xyjfdqName5" maxlength="25" size="20" readonly="true"  onblur="checkqx1('xyjfdq5','xyjfdqName5')"/>
		  <input type="button" value="..."  onclick="selectArea('xyjfdq5','xyjfdqName5')" />
	  </td>
	<td align="right" width="20%">原注册地区县记分比例：</td>
	<td align="left" width="20%" nowrap="nowrap">
      	<s:textfield id="xyjfbl5" name="tsportYdyxx.xyjfbl5" maxlength="10" size="10" onkeypress="NumberText(event,false,true);" />
      </td>
      <td align="right" nowrap="nowrap" width="10%">原注册地区县得牌比例：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:textfield name="tsportYdyxx.xydpbl5" id ="xydpbl5" maxlength="10" size="10" onkeypress="NumberText(event,false,true);"  />					   
      </td>
    </tr>
    
    <tr> 
      <td align="right" width="10%" nowrap="nowrap">注册地区县：</td>
      <td align="left" width="20%" nowrap="nowrap"><s:textfield name="tsportYdyxx.xyjfdqName6" id="xyjfdqName6" maxlength="25" size="20" readonly="true"  onblur="checkqx1('xyjfdq6','xyjfdqName6')"/>
		  <input type="button" value="..."  onclick="selectArea('xyjfdq6','xyjfdqName6')" />
	  </td>
	<td align="right" width="20%">注册地区县记分比例：</td>
	<td align="left" width="20%" nowrap="nowrap">
      	<s:textfield id="xyjfbl6" name="tsportYdyxx.xyjfbl6" maxlength="10" size="10" onkeypress="NumberText(event,false,true);" />
      </td>
      <td align="right" nowrap="nowrap" width="10%">注册地区县得牌比例：</td>
      <td align="left" width="20%" nowrap="nowrap">
      <s:textfield name="tsportYdyxx.xydpbl6" id ="xydpbl6" maxlength="10" size="10" onkeypress="NumberText(event,false,true);"  />					   
      </td>
    </tr>
    
   
  </table>
 </fieldset></s:if>
  <table width="100%" border="0" align="center">
    <tr> 
      <td colspan="7">&nbsp;</td>
    </tr>
	  <tr align="center" valign="middle"> 
	  <td colspan="30">&nbsp;</td>
	    <td height="30" colspan="7">
		    <ul class="btn_gn">
			    <s:if test="getLoginUser().getUsertype()!=4 && getDepartID()=='320'" > 
		    		<li><a href="#" title="保存" onClick="dosave()"><span>保存</span></a></li>
					<li><a href="#" title="保存并新增" onclick="dosavenew()"><span>保存并新增</span></a></li>
					<li><a href="#" title="保存并关闭" onclick="dosaveclose()"><span>保存并关闭</span></a></li>
			    </s:if>
		      		<li><a href="#" title="关闭" onclick="parent.closeInputWindow()"><span>关闭</span></a></li>
		    </ul>
	    </td>
	  </tr>
  </table>
</s:form>
</div>
  </body>
</html>
