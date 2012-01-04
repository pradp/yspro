package com.yszoe.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.framework.util.SeqFactory;
import com.yszoe.sys.util.SysConfigUtil;
import com.yszoe.sys.util.Util;

/**
 * 支持集群应用环境下的文件保存、读取工具类
 * 注意遵守一个约定：数据库保存的相对路径，一定为磁盘绝对路径中的后半部分。
 * 比如文件存储在/opt/upload/cms/pic/12139819.jpg，那绝对路径/opt/upload/是在配置文件设定好的；相对路径就是 cms/pic/12139819.jpg
 * 相对路径在各个应用模块中可自己定义中间的文件夹，然后传入。
 * @author Yangjianliang datetime 2010-10-29
 */
public class FileUtil {

	static final int BUFFER_SIZE = 16 * 1024;
	static final Log LOG = LogFactory.getLog(FileUtil.class);
	static int k = 0;
	private final static String relativeRootFolder = "upload" + File.separator;//所有上传文件的根目录文件夹名
	private static String fileStoreRootPath = null;//存储文件的磁盘绝对路径根目录
	
	static{
		fileStoreRootPath = SysConfigUtil.getString("FileStoreRootPath");//存储文件的磁盘绝对路径根目录
		if(StringUtil.isBlank(fileStoreRootPath)){
			fileStoreRootPath = Util.getAppRootPath();//未配置，就使用站点根目录
		}else if( !fileStoreRootPath.endsWith("/") ){
			fileStoreRootPath = fileStoreRootPath + File.separator;
		}
	}
	
	/**
	 * 把一个文件复制到另一个文件里
	 * 
	 * @param src 被复制的文件
	 * @param dst 目标写入文件
	 */
	public static void copyFile(InputStream src, File dst) {
		File dstDir = dst.getParentFile();
		if( dstDir==null ){
			LOG.error("ParentFile return null !");
			throw new RuntimeException("ParentFile return null !");
		}else if( !dstDir.exists() ){
			//检查父目录是否存在，不存在自动创建它
			boolean f = dstDir.mkdirs();
			if(!f){
				LOG.error("ParentFile create failure!");
				throw new RuntimeException("ParentFile create failure!");
			}
		}
		InputStream in = null;
		OutputStream out = null;
		try {
			in = new BufferedInputStream(src, BUFFER_SIZE);
			out = new BufferedOutputStream(new FileOutputStream(dst), BUFFER_SIZE);
			byte[] buffer = new byte[BUFFER_SIZE];
			while (in.read(buffer) > 0) {
				out.write(buffer);
			}
		} catch (FileNotFoundException e) {
			LOG.error(e);
			throw new RuntimeException(e);
		} catch (IOException e) {
			LOG.error(e);
			throw new RuntimeException(e);
		}finally {
			if (null != in) {
				try {
					in.close();
				} catch (IOException e) {
					LOG.error(e);
					throw new RuntimeException(e);
				}
			}
			if (null != out) {
				try {
					out.close();
				} catch (IOException e) {
					LOG.error(e);
					throw new RuntimeException(e);
				}
			}
		}
	}

	/**
	 * 把一个文件复制到另一个文件里
	 * 
	 * @param src 被复制的文件
	 * @param dst 目标写入文件
	 */
	public static void copyFile(File src, File dst) {
		
		FileInputStream file;
		try {
			file = new FileInputStream(src);
			copyFile(file, dst);
		} catch (FileNotFoundException e) {
			LOG.error(e);
			throw new RuntimeException(e);
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
				boolean f = dstPath.mkdir();
				if(!f){
					LOG.error("ParentFile create failure!");
					throw new RuntimeException("ParentFile create failure!");
				}
			} else {
				FileUtil.deleteDirectory(dstPath.getCanonicalPath());
				boolean f = dstPath.mkdir();
				if(!f){
					LOG.error("ParentFile create failure!");
					throw new RuntimeException("ParentFile create failure!");
				}
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
		if(LOG.isDebugEnabled()){
			LOG.debug(srcPath.toString() + "  copied.");
		}
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
			if(LOG.isInfoEnabled()){
				LOG.info(rootPath);
			}
			dstPath = new File(rootPath);
			k++;
		}
		if (srcPath.isDirectory()) {
			if (!dstPath.exists()) {
				boolean f = dstPath.mkdir();
				if(!f){
					LOG.error("ParentFile create failure!");
					throw new RuntimeException("ParentFile create failure!");
				}
			} else {
				FileUtil.deleteDirectory(dstPath.getCanonicalPath());
				boolean f = dstPath.mkdir();
				if(!f){
					LOG.error("ParentFile create failure!");
					throw new RuntimeException("ParentFile create failure!");
				}
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
		if(LOG.isInfoEnabled()){
			LOG.info(srcPath.toString() + "  copied.");
		}
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
	 * 如果超出大小，抛出运行时异常供action捕捉
	 * @param myFileSize 当前文件大小
	 * @param maxFileSize 允许的最大文件大小
	 */
	public static final void checkFileSize(long myFileSize, long maxFileSize) {
		if (myFileSize > maxFileSize) {
			throw new RuntimeException("文件大小超过允许的最大值（" + maxFileSize / 1024 + "kb），请重新上传");
		}
	}

	/**
	 * 检查文件的类型是否是图片
	 * 如果文件不是图片，抛出运行时异常供action捕捉
	 * @param fileContentType 文件的类型
	 * @param fileName 文件全名
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
				if(LOG.isDebugEnabled()){
					LOG.debug("删除目录" + dir + "成功！");
				}
				return true;
			} else {
				if(LOG.isErrorEnabled()){
					LOG.error("删除目录" + dir + "失败！");
				}
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
		if (file.exists()) {
			if( file.isFile() ){
				boolean f = file.delete();
				if(!f){
					LOG.error( file.getName() + " delete failure!" );
					throw new RuntimeException( file.getName() + " delete failure!" );
				}
				if(LOG.isDebugEnabled()){
					LOG.debug("删除单个文件" + fileName + "成功！");
				}
				return true;
			}else{
				if(LOG.isWarnEnabled()){
					LOG.warn("删除单个文件" + fileName + "失败！目标是文件夹。");
				}
				return false;
			}
		} else {
			if(LOG.isWarnEnabled()){
				LOG.warn("删除单个文件" + fileName + "失败！目标不存在。");
			}
			return false;
		}
	}

	/**
	 * 保存文件在集群环境里，relativePathFileName传入相对路径文件名，自动加上配置的绝对路径根目录存储文件。
	 * 注意，可能文件实际存储不在站点根路径下，此时HTTP要访问到文件，可以结合tomcat7的路径别名映射。
	 * 或者Apache等服务器的提供访问此目录功能。
	 * 允许指定保存的文件名是什么。空的话就自动用时间戳
	 * @param src 被复制的文件对象
	 * @param modelCatalog 存储文件目录模块名
	 * @param oldfilename 上传文件的名称，用于取得后缀名 
	 * @param newfilename 保存后的文件的名称，不包括后缀名的。如 abc.zip，那就传abc
	 * @return 保存后的文件相对路径及文件名。如 upload/pic/201293872174.jpg
	 */
	public static String saveFile(File src, String modelCatalog, String oldfilename, String newfilename) {
		//单机集群，存本地磁盘
		String relativePathFileName = getNewRelativePathFilename(modelCatalog, oldfilename, newfilename);
		String dst = getFullPathInDist( relativePathFileName );
		File dstFile = new File(dst);
		FileUtil.copyFile(src, dstFile);
		return relativePathFileName;
	}
	
	public static String saveFile(InputStream src, String modelCatalog, String oldfilename, String newfilename) {
		//单机集群，存本地磁盘
		String relativePathFileName = getNewRelativePathFilename(modelCatalog, oldfilename, newfilename);
		String dst = getFullPathInDist( relativePathFileName );
		File dstFile = new File(dst);
		FileUtil.copyFile(src, dstFile);
		return relativePathFileName;
	}


	/**
	 * 保存文件在集群环境里，relativePathFileName传入相对路径文件名，自动加上配置的绝对路径根目录存储文件。
	 * 注意，可能文件实际存储不在站点根路径下，此时HTTP要访问到文件，可以结合tomcat7的路径别名映射。
	 * 或者Apache等服务器的提供访问此目录功能。
	 * 保存的文件名是自动新生成的。
	 * @param src 被复制的文件对象
	 * @param modelCatalog 存储文件目录模块名
	 * @param oldfilename 上传文件的名称，用于取得后缀名 
	 * @return 保存后的文件相对路径及文件名。如 upload/pic/201293872174.jpg
	 */
	public static String saveFile(File src, String modelCatalog, String oldfilename) {
		//单机集群，存本地磁盘
		return saveFile(src, modelCatalog, oldfilename, null);
	}
	
	public static String saveFile(InputStream src, String modelCatalog, String oldfilename) {

		return saveFile(src, modelCatalog, oldfilename, null);
	}
	
	/**
	 * 返回相对路径（含新生成的文件名）。用于往数据库保存相对路径。
	 * @param modelCatalog 上传到upload/下的哪个文件夹，null表示不指定
	 * @param oldfilename 原文件名，用于取后缀名生成新文件名
	 * @param newfilename 保存后的文件的名称，不包括后缀名的。如 abc.zip，那就传abc
	 * @return
	 */
	public static String getNewRelativePathFilename(String modelCatalog, String oldfilename, String newfilename){
//TODO 支持按月份或者日期分隔目录....
		String dst = null;
		if( StringUtil.isBlank(newfilename) ){
			newfilename = FileUtil.getNewFileNameByTime();
		}
		if( StringUtil.isBlank(modelCatalog) ){
			dst = relativeRootFolder + newfilename + "." + FileUtil.getFileExt( oldfilename );
		}else{
			dst = relativeRootFolder + modelCatalog + File.separator + newfilename + "." + FileUtil.getFileExt( oldfilename );
		}
		dst = dst.replaceAll("\\\\", "/");//windows下的路径分隔符，firefox打开时会不认识
		return dst;
	}
	
	/**
	 * 生成新文件名
	 * @return
	 */
	public static final String getNewFileNameByTime(){
		String d = SeqFactory.getNewSequenceAlone();
		return d;
	}

	/**
	 * 返回存储文件的绝对路径根目录路径，最后一定以/号结束。
	 * @return 根目录路径名，如 /ope/upload/
	 */
	public static String getFileStoreRootPath() {
		return fileStoreRootPath;
	}

	public static void setFileStoreRootPath(String _fileStoreRootPath) {
		fileStoreRootPath = _fileStoreRootPath;
	}

	/**
	 * 返回完整的文件路径（按约定的存储路径）
	 * @param pathInDb 文件存在数据库的相对路径（含文件名）
	 * @return 磁盘上的完整路径（含文件名）
	 */
	public static String getFullPathInDist(String pathInDb){
		
		return getFileStoreRootPath() + pathInDb;
	}
	
	/**
	 * 删除单个文件（根据相对路径，方法会自动生成绝对路径查找文件）
	 * @param relativePathFileName 从数据库取出的相对路径文件名
	 * @return 单个文件删除成功返回true,否则返回false
	 */
	public static boolean deleteFileByRelativePath(String relativePathFileName) {
		
		return FileUtil.deleteFile( getFullPathInDist(relativePathFileName) );
	}
	
}
