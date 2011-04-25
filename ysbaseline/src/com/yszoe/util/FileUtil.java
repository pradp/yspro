package com.yszoe.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 文件操作工具类
 * 
 * @author Yangjianliang datetime 2010-10-29
 */
public class FileUtil {

	private static final int BUFFER_SIZE = 16 * 1024;
	private static final Log LOG = LogFactory.getLog(FileUtil.class);
	public static int k = 0;

	/**
	 * 把一个文件复制到另一个文件里
	 * 
	 * @param src 被复制的文件
	 * @param dst 目标写入文件
	 */
	public static void copyFile(File src, File dst) {
		try {
			InputStream in = null;
			OutputStream out = null;
			try {
				in = new BufferedInputStream(new FileInputStream(src), BUFFER_SIZE);
				out = new BufferedOutputStream(new FileOutputStream(dst), BUFFER_SIZE);
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
			LOG.error(e);
		}
	}

	/**
	 * copyDirectoryWithoutRoot 目录拷贝（不拷贝根目录）
	 * 
	 * @param srcPath
	 * @param dstPath
	 * @throws IOException
	 */
	public static void copyDirectoryWithoutRoot(File srcPath, File dstPath) throws IOException {
		if (srcPath.isDirectory()) {
			if (!dstPath.exists()) {
				dstPath.mkdir();
			} else {
				FileUtil.deleteDirectory(dstPath.getCanonicalPath());
				dstPath.mkdir();
			}
			String files[] = srcPath.list();
			for (int i = 0; i < files.length; i++) {
				copyDirectoryWithoutRoot(new File(srcPath, files[i]), new File(dstPath, files[i]));
			}
		} else {
			if (srcPath.exists()) {
				copyFile(srcPath, dstPath);
			}
		}
		LOG.debug(srcPath.toString() + "  copied.");
	}

	/**
	 * 目录拷贝（拷贝根目录）
	 * 
	 * @param srcPath
	 * @param dstPath
	 * @throws IOException
	 */
	public static void copyDirectoryWithRoot(File srcPath, File dstPath) throws IOException {
		if (k == 0) {
			String name = srcPath.getName();
			String rootPath = dstPath + File.separator + name;
			LOG.info(rootPath);
			dstPath = new File(rootPath);
			k++;
		}
		if (srcPath.isDirectory()) {
			if (!dstPath.exists()) {
				dstPath.mkdir();
			} else {
				FileUtil.deleteDirectory(dstPath.getCanonicalPath());
				dstPath.mkdir();
			}
			String files[] = srcPath.list();
			for (int i = 0; i < files.length; i++) {
				copyDirectoryWithRoot(new File(srcPath, files[i]), new File(dstPath, files[i]));
			}
		} else {
			if (srcPath.exists()) {
				copyFile(srcPath, dstPath);
			}
		}
		LOG.info(srcPath.toString() + "  copied.");
	}

	/**
	 * 获得文件的后缀名。
	 * 
	 * @param fileName 文件的全名
	 * @return 后缀名，不包含点号，如（jpg exe bmp gif等）
	 */
	public static final String getFileExt(String fileName) {
		String ext = StringUtils.EMPTY;
		if (StringUtils.isNotBlank(fileName)) {
			int pos = fileName.lastIndexOf(".");
			if (pos != -1 && pos != fileName.length() - 1) {
				ext = fileName.substring(pos + 1);
			}
		}
		return ext;
	}

	/**
	 * 检查文件大小是否在允许的给定值的范围内，按字节大小比较
	 * 
	 * @param myFileSize 当前文件大小
	 * @param maxFileSize 允许的最大文件大小
	 * @return 合法大小，返回true，否则返回false
	 */
	public static final void checkFileSize(long myFileSize, long maxFileSize) {
		if (myFileSize > maxFileSize) {
			throw new RuntimeException("文件大小超过允许的最大值（" + maxFileSize / 1024 + "kb），请重新上传");
		}
	}

	/**
	 * 检查文件的类型是否是图片
	 * 
	 * @param fileContentType 文件的类型
	 * @param fileName 文件全名
	 * @return 文件是图片，返回true，否则以抛出相应的异常
	 */
	public static final void checkFileIsImage(String fileContentType, String fileName) {
		if (StringUtils.isNotBlank(fileContentType) && StringUtils.isNotBlank(fileName) && fileContentType.length() > 5) {
			String filetype = fileContentType.substring(0, 6);

			if (!"image/".equals(filetype)) {
				throw new RuntimeException("所选择文件不是图片类型，请选择图片！");
			}
			fileContentType = filetype + getFileExt(fileName);
			if ("image/bmp".equalsIgnoreCase(fileContentType) || ("image/gif").equalsIgnoreCase(fileContentType)
					|| ("image/jpg").equalsIgnoreCase(fileContentType)
					|| ("image/jpeg").equalsIgnoreCase(fileContentType)
					|| ("image/png").equalsIgnoreCase(fileContentType)) {

			} else {
				throw new RuntimeException("只支持标准格式的图片文件bmp/gif/jpeg/png/jpg！请重新上传！");
			}
		} else {
			throw new RuntimeException("只支持标准格式的图片文件bmp/gif/jpeg/png/jpg！请重新上传！");
		}

	}

	/**
	 * 删除目录（文件夹）以及目录下的文件
	 * 
	 * @param dir 被删除目录的文件路径
	 * @return 目录删除成功返回true,否则返回false
	 */
	public static boolean deleteDirectory(String dir) {
		boolean del = deleteDirectoryWithoutSelf(dir);

		// 删除当前目录
		if(del){
			File dirFile = new File(dir);
			if (dirFile.delete()) {
				LOG.debug("删除目录" + dir + "成功！");
				return true;
			} else {
				LOG.info("删除目录" + dir + "失败！");
				return false;
			}
		}else{
			return false;
		}
	}

	/**
	 * 删除目录（文件夹）下的文件，不删除目录自己
	 * 
	 * @param dir 被删除目录的文件路径
	 * @return 目录删除成功返回true,否则返回false
	 */
	public static boolean deleteDirectoryWithoutSelf(String dir) {
		// 如果dir不以文件分隔符结尾，自动添加文件分隔符
		if (!dir.endsWith(File.separator)) {
			dir = dir + File.separator;
		}
		File dirFile = new File(dir);
		// 如果dir对应的文件不存在，或者不是一个目录，则退出
		if (!dirFile.exists() || !dirFile.isDirectory()) {
			LOG.info("删除目录失败" + dir + "目录不存在！");
			return false;
		}
		boolean flag = true;
		// 删除文件夹下的所有文件(包括子目录)
		File[] files = dirFile.listFiles();
		for (int i = 0; i < files.length; i++) {
			// 删除子文件
			if (files[i].isFile()) {
				flag = deleteFile(files[i].getAbsolutePath());
				if (!flag) {
					break;
				}
			} // 删除子目录
			else {
				flag = deleteDirectory(files[i].getAbsolutePath());
				if (!flag) {
					break;
				}
			}
		}

		if (!flag) {
			LOG.info("删除目录失败");
			return false;
		}

		return true;
	}

	/**
	 * 删除单个文件
	 * 
	 * @param fileName 被删除文件的文件名
	 * @return 单个文件删除成功返回true,否则返回false
	 */
	public static boolean deleteFile(String fileName) {
		File file = new File(fileName);
		if (file.isFile() && file.exists()) {
			file.delete();
			LOG.debug("删除单个文件" + fileName + "成功！");
			return true;
		} else {
			LOG.info("删除单个文件" + fileName + "失败！");
			return false;
		}
	}
}
