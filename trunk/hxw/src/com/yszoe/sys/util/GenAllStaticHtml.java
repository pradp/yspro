package com.yszoe.sys.util;

import java.io.File;
import java.io.IOException;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.yszoe.util.StaticHtmlUtils;

/**
 * 业务操作日志记录类
 * 
 * @author Yangjianliang datetime 2009-8-5
 */
public class GenAllStaticHtml extends QuartzJobBean implements Runnable {

	private static final Log log = LogFactory.getLog(GenAllStaticHtml.class);
	private static String serverPath;

	public GenAllStaticHtml() {
		super();
	}

	/**
	 * 记录用户的操作信息到数据库。 此方法是静默执行的，不会抛出任何异常（包括运行时异常）。
	 * 
	 * @param opUserLoginid 操作人的登录ID
	 * @param opTableObject 操作的表（HQL对象）
	 * @param opType 操作类型（保存1、更新2、删除3）
	 */
	public static final void gen(String serverPaths) {
		serverPath = serverPaths;
		GenAllStaticHtml bizLogUtil = new GenAllStaticHtml();
		Thread t = new Thread(bizLogUtil, "genHtmlThread");
		t.setPriority(Thread.MAX_PRIORITY);
		t.start();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Runnable#run()
	 */
	public void run() {
		try {
			createHtmlAllPages();
		} catch (IOException e) {
			log.error(e);
			throw new RuntimeException("生成静态页面异常！");
		}
	}

	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		try {
			String serverUrl = (String) context.getJobDetail().getJobDataMap().get("serverUrl");
			if (StringUtils.isNotBlank(serverUrl)) {
				serverPath = serverUrl;
			}
			if (StringUtils.isNotBlank(serverPath)) {
				createHtmlAllPages();
			}
		} catch (IOException e) {
			log.fatal(e);
		}
	}

	/**
	 * 执行 生成静态页面
	 * 
	 * @throws IOException
	 */
	public static void createHtmlAllPages() throws IOException {
		// 服务器地址
		// 链接地址url
		String index = "visitor/sportCjTdHz-list.c?cssS=1";// 首页
		String dbtcjcx_nj = "visitor/sportCjcxDbt-list.c?jp=3&departid=320001&sx=&cssS=2";// 代表团成绩查询
		String dbtcjcx_sz = "visitor/sportCjcxDbt-list.c?jp=3&departid=320005&sx=&cssS=2";// 代表团成绩查询
		String dbtcjcx_xz = "visitor/sportCjcxDbt-list.c?jp=3&departid=320003&sx=&cssS=2";// 代表团成绩查询
		String dbtcjcx_cz = "visitor/sportCjcxDbt-list.c?jp=3&departid=320004&sx=&cssS=2";// 代表团成绩查询
		String dbtcjcx_wx = "visitor/sportCjcxDbt-list.c?jp=3&departid=320002&sx=&cssS=2";// 代表团成绩查询
		String dbtcjcx_nt = "visitor/sportCjcxDbt-list.c?jp=3&departid=320006&sx=&cssS=2";// 代表团成绩查询
		String dbtcjcx_lyg = "visitor/sportCjcxDbt-list.c?jp=3&departid=320007&sx=&cssS=2";// 代表团成绩查询
		String dbtcjcx_ha = "visitor/sportCjcxDbt-list.c?jp=3&departid=320008&sx=&cssS=2";// 代表团成绩查询
		String dbtcjcx_yc = "visitor/sportCjcxDbt-list.c?jp=3&departid=320009&sx=&cssS=2";// 代表团成绩查询
		String dbtcjcx_yz = "visitor/sportCjcxDbt-list.c?jp=3&departid=320010&sx=&cssS=2";// 代表团成绩查询
		String dbtcjcx_zj = "visitor/sportCjcxDbt-list.c?jp=3&departid=320011&sx=&cssS=2";// 代表团成绩查询
		String dbtcjcx_tz = "visitor/sportCjcxDbt-list.c?jp=3&departid=320012&sx=&cssS=2";// 代表团成绩查询
		String dbtcjcx_sq = "visitor/sportCjcxDbt-list.c?jp=3&departid=320013&sx=&cssS=2";// 代表团成绩查询
		String sccx = "visitor/sportCjcxRcZk-list.c?cssS=4";// 赛事日程
		String xmcx = "visitor/sportDxmmc-list.c?cssS=5";// 项目查询
		String pjlcx = "visitor/sportCjcxPjl-list.c?cssS=6";// 破纪录查询
		String qtjx = "visitor/sportCjcxZhcjb-list.c?cssS=9";// 其他奖项
		String dbtqbcjb = "visitor/sportCjcxNbbd-list.c?cssS=7";// 代表团全部成绩榜
		String qxcjb = "visitor/sportCjcxXscjb-list.c?cssS=3";// 区县成绩榜

		// 项目根目录路径
		String fileRoot = Util.getAppRootPath();
		fileRoot = fileRoot + File.separator + "visitor" + File.separator;
		fileRoot = java.net.URLDecoder.decode(fileRoot, "UTF-8");

		// 静态文件地址
		String index_html = fileRoot + "sportCjTdHz-list.html";// 首页
		String dbtcjcx_html_nj = fileRoot + "sportCjcxDbt-nj.html";// 南京代表团成绩
		String dbtcjcx_html_cz = fileRoot + "sportCjcxDbt-cz.html";// 常州代表团成绩
		String dbtcjcx_html_xz = fileRoot + "sportCjcxDbt-xz.html";// 徐州代表团成绩
		String dbtcjcx_html_sz = fileRoot + "sportCjcxDbt-sz.html";// 苏州代表团成绩
		String dbtcjcx_html_wx = fileRoot + "sportCjcxDbt-wx.html";// 无锡代表团成绩
		String dbtcjcx_html_nt = fileRoot + "sportCjcxDbt-nt.html";// 南通代表团成绩
		String dbtcjcx_html_lyg = fileRoot + "sportCjcxDbt-lyg.html";// 连云港代表团成绩
		String dbtcjcx_html_ha = fileRoot + "sportCjcxDbt-ha.html";// 淮安代表团成绩
		String dbtcjcx_html_yc = fileRoot + "sportCjcxDbt-yc.html";// 盐城代表团成绩
		String dbtcjcx_html_yz = fileRoot + "sportCjcxDbt-yz.html";// 扬州代表团成绩
		String dbtcjcx_html_zj = fileRoot + "sportCjcxDbt-zj.html";// 镇江代表团成绩
		String dbtcjcx_html_tz = fileRoot + "sportCjcxDbt-tz.html";// 泰州代表团成绩
		String dbtcjcx_html_sq = fileRoot + "sportCjcxDbt-sq.html";// 宿迁代表团成绩

		String sccx_html = fileRoot + "sportCjcxRcZk-list.html";// 赛事日程
		String xmcx_html = fileRoot + "sportDxmmc-list.html";// 项目查询
		String pjlcx_html = fileRoot + "sportCjcxPjl-list.html";// 破纪录查询
		String qtjx_html = fileRoot + "sportCjcxZhcjb-list.html";// 其他奖项
		String dbtqbcjb_html = fileRoot + "sportCjcxNbbd-list.html";// 代表团全部成绩榜
		String qxcjb_html = fileRoot + "sportCjcxXscjb-list.html";// 区县成绩榜

		StaticHtmlUtils.createHtml(serverPath + index, index_html);// 首页
		StaticHtmlUtils.createHtml(serverPath + dbtcjcx_nj, dbtcjcx_html_nj);// 代表团成绩查询
		StaticHtmlUtils.createHtml(serverPath + sccx, sccx_html);// 成绩查询
		StaticHtmlUtils.createHtml(serverPath + xmcx, xmcx_html);// 项目查询
		StaticHtmlUtils.createHtml(serverPath + pjlcx, pjlcx_html);// 破纪录查询
		StaticHtmlUtils.createHtml(serverPath + qtjx, qtjx_html);// 其他奖项
		StaticHtmlUtils.createHtml(serverPath + dbtqbcjb, dbtqbcjb_html);// 代表团全部成绩榜
		StaticHtmlUtils.createHtml(serverPath + qxcjb, qxcjb_html);// 区县成绩榜

		StaticHtmlUtils.createHtml(serverPath + dbtcjcx_sz, dbtcjcx_html_sz);// 代表团成绩查询
		StaticHtmlUtils.createHtml(serverPath + dbtcjcx_xz, dbtcjcx_html_xz);// 代表团成绩查询
		StaticHtmlUtils.createHtml(serverPath + dbtcjcx_cz, dbtcjcx_html_cz);// 代表团成绩查询
		StaticHtmlUtils.createHtml(serverPath + dbtcjcx_wx, dbtcjcx_html_wx);// 代表团成绩查询
		StaticHtmlUtils.createHtml(serverPath + dbtcjcx_nt, dbtcjcx_html_nt);// 代表团成绩查询
		StaticHtmlUtils.createHtml(serverPath + dbtcjcx_lyg, dbtcjcx_html_lyg);// 代表团成绩查询
		StaticHtmlUtils.createHtml(serverPath + dbtcjcx_ha, dbtcjcx_html_ha);// 代表团成绩查询
		StaticHtmlUtils.createHtml(serverPath + dbtcjcx_yc, dbtcjcx_html_yc);// 代表团成绩查询
		StaticHtmlUtils.createHtml(serverPath + dbtcjcx_yz, dbtcjcx_html_yz);// 代表团成绩查询
		StaticHtmlUtils.createHtml(serverPath + dbtcjcx_zj, dbtcjcx_html_zj);// 代表团成绩查询
		StaticHtmlUtils.createHtml(serverPath + dbtcjcx_tz, dbtcjcx_html_tz);// 代表团成绩查询
		StaticHtmlUtils.createHtml(serverPath + dbtcjcx_sq, dbtcjcx_html_sq);// 代表团成绩查询
	}

	public static String getServerPath() {
		return serverPath;
	}

	public static void setServerPath(String serverPath) {
		GenAllStaticHtml.serverPath = serverPath;
	}
	
}
