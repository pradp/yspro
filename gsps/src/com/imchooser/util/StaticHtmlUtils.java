package com.imchooser.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/*******************************************************************************
 * 
 * 项目名称：zzzx 模块说明：静态网页生成工具 作 者：杨建亮 创建日期：2007-1-30
 * 
 ******************************************************************************/
public class StaticHtmlUtils {

	private static final Log log = LogFactory.getLog(StaticHtmlUtils.class);

	/**
	 * 生成HTML页面
	 * 
	 * @param srcurl 数据源页面，http://网址
	 * @param tofile 生成后的文件，绝对路径和全文件名
	 * @throws IOException
	 */
	public static boolean createHtml(String srcurl, String tofile) throws IOException {

		srcurl = getFullURL(srcurl);
		boolean f = checkFileURI(tofile);

		if (srcurl != null && f == true) {

			CropNetSource cs = new CropNetSource();
			cs.setCropurl(srcurl);
			cs.doCrop();
			String html = cs.getResult();

			if (html != null && html.length() > 0) {
				log.info(srcurl);
				log.info(tofile);
				deleteFileIfExists(tofile);
				// 创建文件
				File myfile = new File(tofile);
				myfile.createNewFile();
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(myfile), "UTF-8"));

				bw.write(html);
				bw.flush();
				bw.close();

				log.info("new file created.");
			}
		} else {
			return false;
		}
		return f;
	}

	/**
	 * 删除存在的文件。
	 * 
	 * @param tofile
	 * @throws IOException
	 */
	public static void deleteFileIfExists(String tofile) throws IOException {

		File file = new File(tofile);
		if (file.exists() && file.isFile()) {
			boolean d = file.delete();
			if (d) {
				log.info("old file deleted");
			}

		}

	}

	/**
	 * 返回绝对URL
	 * 
	 * @param url 需要处理的URL
	 * @return
	 */
	protected static String getFullURL(String srcurl) {

		if (srcurl == null || srcurl.length() < 1)
			return null;
		if (!srcurl.startsWith("http://"))
			srcurl = "http://" + srcurl;

		return srcurl;
	}

	/**
	 * 检查输出的对象是否是有效文件，根据有没有.来判断
	 * 
	 * @param uri 需要处理的URL
	 * @return
	 */
	protected static boolean checkFileURI(String uri) {
		boolean f = true;
		String[] tmp = null;
		tmp = uri.split("/");
		if (tmp.length < 1) {
			tmp = uri.split("\\\\");
		}
		if (tmp[tmp.length - 1].indexOf(".") == -1) {
			f = false;
		}
		return f;
	}

}
