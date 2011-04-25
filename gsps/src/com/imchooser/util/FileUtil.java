package com.imchooser.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

public class FileUtil {

	private static final int BUFFER_SIZE = 16 * 1024;

	/**
	 * 把一个文件复制到另一个文件里
	 * 
	 * @param src
	 *            被复制的文件
	 * @param dst
	 *            目标写入文件
	 */
	public static void copy(File src, File dst) {
		try {
			InputStream in = null;
			OutputStream out = null;
			try {
				in = new BufferedInputStream(new FileInputStream(src),
						BUFFER_SIZE);
				out = new BufferedOutputStream(new FileOutputStream(dst),
						BUFFER_SIZE);
				byte[] buffer = new byte[BUFFER_SIZE];
				while (in.read(buffer) > 0) {
					out.write(buffer);
				}
			} finally {
				if (null != in) {
					in.close();
				}
				if (null != out) {
					out.close();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获得文件的后缀名。
	 * @param fileName 文件的全名
	 * @return 后缀名，不包含点号，如（jpg exe bmp gif等）
	 */
	public static final String getFileExt(String fileName){
		String ext = StringUtil.EMPTY;
		if(StringUtil.isNotBlank(fileName)){
			int pos = fileName.lastIndexOf(".");
			if(pos!=-1 && pos!=fileName.length()-1){
				ext = fileName.substring(pos+1);
			}
		}
		return ext;
	}

	/**
	 * 检查文件大小是否在允许的给定值的范围内，按字节大小比较
	 * @param myFileSize 当前文件大小
	 * @param maxFileSize 允许的最大文件大小
	 * @return 合法大小，返回true，否则返回false
	 */
	public static final void checkFileSize(long myFileSize, long maxFileSize){
		if( myFileSize>maxFileSize ){
			throw new RuntimeException("文件大小超过允许的最大值（"+maxFileSize/1024+"kb），请重新上传");
		}
	}

	/**
	 * 检查文件的类型是否是图片
	 * @param fileContentType 文件的类型
	 * @param fileName 文件全名
	 * @return 文件是图片，返回true，否则以抛出相应的异常
	 */
	public static final void checkFileIsImage(String fileContentType, String fileName){
		if(StringUtil.isNotBlank(fileContentType) && StringUtil.isNotBlank(fileName) && fileContentType.length()>5){
			String filetype = fileContentType.substring(0, 6);
			
			if( !"image/".equals(filetype) ) {
				throw new RuntimeException("所选择文件不是图片类型，请选择图片！");
			}
			fileContentType = filetype + getFileExt(fileName);
			if ("image/bmp".equalsIgnoreCase(fileContentType)
					|| ("image/gif").equalsIgnoreCase(fileContentType)
					|| ("image/jpg").equalsIgnoreCase(fileContentType)
					|| ("image/jpeg").equalsIgnoreCase(fileContentType)
					|| ("image/png").equalsIgnoreCase(fileContentType)) {
				
			} else {
				throw new RuntimeException("只支持标准格式的图片文件bmp/gif/jpeg/png/jpg！请重新上传！");
			}
		}else{
			throw new RuntimeException("只支持标准格式的图片文件bmp/gif/jpeg/png/jpg！请重新上传！");
		}
		
	}
}
