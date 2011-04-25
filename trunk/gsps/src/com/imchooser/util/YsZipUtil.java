/**
 * 项目：
 * 模块：Zip压缩/解压缩工具
 * 作者：Yangjianliang
 * 日期：2007-9-10
 */
package com.imchooser.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Enumeration;

import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;

public class YsZipUtil {

	static final int BUFFER = 2048;

	/**
	 * 压缩文件/文件夹
	 * @param zipFileFullName 压缩后的ZIP文件的全路径名称
	 * @param inputFileFullName 需要压缩的文件/文件夹 全路径名称
	 * @throws Exception
	 */
	public static void zip(String zipFileFullName, String inputFileFullName) throws Exception {
		File zip = new File(zipFileFullName);
		File parentDir = zip.getParentFile();
		char pathSeparator = File.pathSeparatorChar;
		zip(zip, parentDir, new File[]{new File(inputFileFullName)}, pathSeparator);
	}
	
    /**
     * Recursively zips a set of root entries into a zipfile, compressing the
     * contents.
     *
     * @param zipFile target zip file.
     * @param parentDir a directory containing source files to zip.
     * @param sources an array of files and/or directories to zip.
     * @param pathSeparator path separator for zip entries.
     * 
     * @throws IOException
     */
   public static void zip( File zipFile, File parentDir, File[] sources, char pathSeparator) throws IOException {
           
       String stripPath = (parentDir != null) ? parentDir.getPath() : "";
       if (stripPath.length() > 0 && !stripPath.endsWith(File.separator)) {
           stripPath += File.separator;
       }

       ZipOutputStream out =
           new ZipOutputStream(new FileOutputStream(zipFile));
       out.setMethod(ZipOutputStream.DEFLATED);

       try {
           // something like an Ant directory scanner wouldn't hurt here
           for (int i = 0; i < sources.length; i++) {
               if (!sources[i].exists()) {
                   throw new IllegalArgumentException(
                       "File or directory does not exist: " + sources[i]);
               }

               if (sources[i].isDirectory()) {
                   zipDirectory(out, stripPath, sources[i], pathSeparator);
               } else {
                   zipFile(out, stripPath, sources[i], pathSeparator);
               }
           }
       } finally {
           out.close();
       }
   }

   /**
    * Uses code fragments from Jakarta-Ant, Copyright: Apache Software
    * Foundation.
    */
   private static void zipDirectory(ZipOutputStream out, String stripPath, File dir, char pathSeparator) throws IOException {

       String[] entries = dir.list();

       if (entries == null || entries.length == 0) {
           return;
       }

       // recurse via entries
       for (int i = 0; i < entries.length; i++) {
           File file = new File(dir, entries[i]);
           if (file.isDirectory()) {
               zipDirectory(out, stripPath, file, pathSeparator);
           } else {
               zipFile(out, stripPath, file, pathSeparator);
           }
       }
   }

   /**
    * Uses code fragments from Jakarta-Ant, Copyright: Apache Software
    * Foundation.
    */
   private static void zipFile( ZipOutputStream out, String stripPath, File file, char pathSeparator) throws IOException {
       ZipEntry ze =
           new ZipEntry(processPath(file.getPath(), stripPath, pathSeparator));
       ze.setTime(file.lastModified());
       out.putNextEntry(ze);

       byte[] buffer = new byte[2 * BUFFER];
       BufferedInputStream in =
           new BufferedInputStream(new FileInputStream(file), buffer.length);

       try {
           int count = 0;
           while ((count = in.read(buffer, 0, buffer.length)) >= 0) {
               if (count != 0) {
                   out.write(buffer, 0, count);
               }
           }
       } finally {
           in.close();
       }
   }

   private static String processPath( String path, String stripPath, char pathSeparator) {
       if (!path.startsWith(stripPath)) {
           throw new IllegalArgumentException(
               "Invalid entry: "
                   + path
                   + "; expected to start with "
                   + stripPath);
       }

       return path.substring(stripPath.length()).replace(
           File.separatorChar,
           pathSeparator);
   }

	/**
	 * 解压缩文件
	 * @param zipFileName 压缩文件，全路径
	 * @param outputDirectory 解压缩到哪个目录
	 */
	public static void unzip(String zipFileName, String outputDirectory) {

		try {

			BufferedOutputStream dest = null;

			BufferedInputStream is = null;

			ZipEntry entry;

			java.io.File f = new java.io.File(outputDirectory);
			if (f.exists() == false) {
				f.mkdirs();// 建立解压缩的目录
			}

			ZipFile zipfile = new ZipFile(zipFileName);

			Enumeration<?> e = zipfile.getEntries();

			while (e.hasMoreElements()) {

				entry = (ZipEntry) e.nextElement();

				System.out.println("Extracting: " + entry.getName());

				if (entry.isDirectory()) {
					File theDir = new File(outputDirectory + File.separator
							+ entry.getName());
					if (theDir.exists() == false) {
						theDir.mkdirs();
					}

				} else {

					File theFile = new File(outputDirectory + File.separator
							+ entry.getName());
					if (theFile.getParentFile().exists() == false) {
						theFile.getParentFile().mkdirs();
					}

					is = new BufferedInputStream

					(zipfile.getInputStream(entry));

					int count;

					byte data[] = new byte[BUFFER];

					FileOutputStream fos = new

					FileOutputStream(outputDirectory + File.separator
							+ entry.getName());

					dest = new

					BufferedOutputStream(fos, BUFFER);

					while ((count = is.read(data, 0, BUFFER)) != -1) {

						dest.write(data, 0, count);

					}

					dest.flush();

					dest.close();

					is.close();

				}
			}

		} catch (Exception e) {

			e.printStackTrace();

		}

	}
	
	public static void main(String s[]){
		try {
			YsZipUtil.zip("e:\\model.zip", "e:\\复件java编写规范.doc");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.print("zip failed!");
		}
	}
}
