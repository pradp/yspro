<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>上传文件</title>
		<script type="text/javascript">
		function submitForm(){
			document.getElementById("doUpload_B").disabled=true;
		}
		</script>
		<base target="_self">
	</head>
	<body>
		<s:if
			test="actionErrors.size()>0 || actionMessages.size()>0 || fieldErrors.size()>0">
			<div id="SystemErrorMessage" style="color:red">
				<s:actionerror />
				<s:actionmessage />
				<s:fielderror />
			</div>
		</s:if>
		<s:else>
			<br/><br/>
		</s:else>
		<div id="listC" style="text-align:center;">
			<s:form theme="simple" name="theform" method="post" enctype="multipart/form-data" onsubmit="submitForm()">
				<table border="0" cellspacing="0" cellpadding="0" width="98%">
					
					<tr align="center">
						<td>
							&nbsp;
							<input type="file" size="30" id="myexcel" name="myexcel"/>
						</td>
						<td>
							&nbsp;&nbsp;
							<input type="submit" id="doUpload_B" value="上传"/>
						</td>
						<td>
							&nbsp;&nbsp;
							<input value="关闭" type="button" onclick="window.close()"/>
						</td>
					</tr>
				</table>
			</s:form>
		</div>
	</body>
</html>
