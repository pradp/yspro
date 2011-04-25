<%@ page language="java" pageEncoding="UTF-8"
	contentType="application/vnd.ms-excel"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.imchooser.framework.identity.entity.TSysUser"%>
<%@ page import="com.imchooser.framework.identity.IdConstants"%>
<%@ page import="com.imchooser.framework.util.DBUtil"%>
<%@ page import="com.imchooser.sys.util.excel.Export2excelService"%>
<%@ page import="com.imchooser.infoms.util.excel.Export2excelServiceImpl"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.imchooser.sys.util.CommonQuery"%>
<%@page import="java.net.URLDecoder"%>
<%
	Log log = Export2excelService.log;
	TSysUser currentUser = (TSysUser) request.getSession().getAttribute(IdConstants.SESSION_USER);
	if (currentUser == null) {
		response.sendRedirect("/SportsScore/identity/login.c");
	} else {
		/********************* business code **************************/
		
		ResultSet rs = null;
		String departid = currentUser.getDepart().getDepartid();
		String departid2 = request.getParameter("departid");
		String dxmmc = request.getParameter("dxmmc");
		String xm = request.getParameter("xm");
		String xb = request.getParameter("xb");
		String state = request.getParameter("state");
		String shzt= request.getParameter("shzt");
		if(departid.length()==3 && StringUtils.isNotBlank(departid2)){
	departid=departid2;
		}
		
		
		if (StringUtils.isNotBlank(departid)) {
	StringBuffer sql = new StringBuffer();
	String[] sheetNames = { currentUser.getDepart().getDepartname() + "代表团二次报名数据" };//导出EXCEL文件SHEET名称
	String[] headColmuns = { "注册证编号", "姓名", "身份证号", "出生日期", "性别", "项目", "所属市", "组别", "报项1", "报项2",
			"报项3", "报项4", "报项5", "报项6", "报项7", "报项8", "报项9" };//导出的行头文字

	sql.append(" select c.zch,c.xm,c.sfzh,c.csrq,");
	sql.append("(select s.zdmc  from t_sys_code s where s.zdlb='XB' and s.zdbm=c.xb), ");
	sql.append("a.dxmmc,d.departname, ");
	sql.append(" (select s.zdmc  from t_sys_code s where s.zdlb='BSXM_ZB' and s.zdbm=b.zb),");
	sql.append(" wmsys.wm_concat(nvl(b.xxmmc,'')) ");
	sql.append(" from t_sport_ydyxx c  ");
	sql.append(" left join  t_sport_ydybmxm a on c.wid=a.ydywid ");
	sql.append(" left join t_sport_bsxm b on a.bsxmwid=b.wid   ");
	sql.append(" left join t_sys_depart d on d.departid=substr(c.yddbm,0,6) ");
	sql.append("  where c.yddbm like '" + departid + "%' ");
	if(StringUtils.isNotBlank(dxmmc)){
		sql.append(" and a.dxmmc='" + URLDecoder.decode(dxmmc,"utf-8") + "' ");
	}
	if(StringUtils.isNotBlank(xm)){
		sql.append(" and  c.xm='" + xm + "' ");
	}
	if(StringUtils.isNotBlank(xb)){
		sql.append(" and c.xb='" + xb + "' ");
	}
	
	if(StringUtils.isNotBlank(state)){
		if("1".equals(state)){
			sql.append (" and c.state = '1' ");
		}else{
			sql.append (" and (c.state != '1' or c.state is null) ");
		}
	}
	if(StringUtils.isNotBlank(shzt)){
		sql.append(" and c.shzt='" + shzt + "' ");
	}
	sql.append("  group by  c.zch,c.xm,c.sfzh,c.csrq,c.xb,a.dxmmc,d.departname,b.zb ");
	try {
		rs = DBUtil.queryRowSet(sql.toString());
		log.info("执行sql完成：" + sql);
		String exportFileName = currentUser.getDepart().getDepartname() + "代表团二次报名数据";//下载的文件的内容名称，不设置就用当前时间
		int dataSheetIndex = 0;//要写数据的SHEET页索引
		/**************** below code changeless *********************/
		Export2excelServiceImpl export2excelService = new Export2excelServiceImpl(sheetNames, headColmuns);
		export2excelService.setDataSheetIndex(dataSheetIndex);
		export2excelService.setExcelFileTitle(exportFileName);
		export2excelService.writeData2ExportExcel(rs);
		export2excelService.doExportData(response);
	} catch (Exception e) {
		log.error("导出二次报名数据异常：" + e);
	} finally {
		DBUtil.close(log, rs, null, null);
	}
		} else {
	log.error("导出二次报名数据异常：代表团编号为空");
		}
	}
	out.clear();
	out = pageContext.pushBody();
%>