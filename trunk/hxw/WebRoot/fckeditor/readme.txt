注意这个版本的jar是修改过的，上传文件自动重命名了。

1、结合struts2初始化编辑器内容：
<%@ page import="net.fckeditor.*" %>
<%@ page import="com.opensymphony.xwork2.*"%>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<%@ page import="com.yszoe.cms.entity.TXxfbWz"%>

<%
TXxfbWz wz = (TXxfbWz)ActionContext.getContext().getValueStack().findValue("txxfbWz");
FCKeditor fckEditor = new FCKeditor(request, "txxfbWz.nr");
if(wz!=null && wz.getNr()!=null){
	fckEditor.setValue(wz.getNr());//为FCK编辑器赋值
}
//fckEditor.setToolbarSet("Basic");//决定工具条内容的。参考FCKCONFIG.JS,默认值是Default。
%>

2、
