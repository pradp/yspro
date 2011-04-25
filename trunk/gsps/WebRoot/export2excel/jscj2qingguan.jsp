<%@ page language="java" pageEncoding="UTF-8" contentType="application/vnd.ms-excel"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.imchooser.framework.identity.entity.TSysUser"%>
<%@ page import="com.imchooser.framework.identity.IdConstants "%>
<%@ page import="com.imchooser.framework.util.DBUtil"%>
<%@ page import="com.imchooser.framework.service.Export2excelService"%>
<%@ page import="com.imchooser.framework.service.impl.Export2excelServiceImpl"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%
//导出未贷款学生：在我们系统里有申请记录，在国开行没有记录的学生数据
Log log = Export2excelService.log;
TSysUser currentUser = (TSysUser)request.getSession().getAttribute(IdConstants.SESSION_USER);
if (currentUser == null) {
	response.sendRedirect("/SportsScore/identity/login.c");
} else {
	/********************* business code **************************/
	ResultSet rs = null;
	String departid = request.getParameter("yxbm");
	if(StringUtils.isBlank(departid)){
		departid = currentUser.getDepart().getDepartid();
	}
	StringBuffer sql = new StringBuffer();
	String mytype = currentUser.getDepart().getDeparttype();
	String[] sheetNames = { "决赛成绩数据表" };//导出EXCEL文件SHEET名称
	String[] headColmuns = { "大项目名称", "组别", "小项目名称", "名次", "注册号", "姓名", "比赛时间", "创建时间"};
	
	sql.append("select b.dxmmc,"+
			"(select d.zdmc from t_sys_code d where d.zdlb='BSXM_XBZ' and d.zdbm=b.xbz)||(select d.zdmc from t_sys_code d where d.zdlb='BSXM_ZB' and d.zdbm=b.zb) as zb,"+ 
			"b.xxmmc, t.mc, x.zch, x.xm, to_char(c.bssj,'yyyy-mm-dd hh24:mi:ss'), to_char(t.createtime,'yyyy-mm-dd hh24:mi:ss') "+
			"from t_sport_cj_ydy t, t_sport_bsxm b, t_sport_ssrc c, t_sport_ydyxx x "+
			"where t.scbm=c.wid and c.xmbm=b.wid and t.sfjs=1 and x.wid=t.ydybm and t.mc>0 and t.mc<9 "+
			"and c.bssj>to_date('2010-10-11','yyyy-mm-dd') and c.fbzt=3 "+
			"order by t.createtime,b.dxmmc,b.xbz,b.zb, b.xxmmc ,t.mc");

	Object[] oo = new Object[1];
	rs = DBUtil.queryRowSet(sql.toString());
			
	log.info("执行sql完成："+sql);
	String exportFileName = "成绩系统决赛成绩导出";//下载的文件的内容名称，不设置就用当前时间
	int dataSheetIndex = 0;//要写数据的SHEET页索引
	
	/**************** below code changeless *********************/
	try {
		Export2excelService export2excelService = new Export2excelServiceImpl(sheetNames, headColmuns);
		export2excelService.setDataSheetIndex( dataSheetIndex );
		export2excelService.setExcelFileTitle( exportFileName );
		export2excelService.writeData2ExportExcel( rs );
		export2excelService.doExportData(response);
	} catch (Exception e) {
		log.error("导出成绩系统决赛成绩异常："+e);
	} finally {
		DBUtil.close(log, rs, null, null);
	}
}
out.clear();
out = pageContext.pushBody();
%>