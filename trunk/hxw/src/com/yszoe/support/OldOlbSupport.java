package com.yszoe.support;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.framework.jdbc.DBConn;

/**
 * 针对oracle9i数据库的olb类型，特殊处理
 * 在oracle10g以后，都不需要这个类特别处理了
 */
public class OldOlbSupport {

	private static final Log LOG = LogFactory.getLog( DBConn.class );

	/**
	 * 更新CLOB字段
	 * @param table 表名
	 * @param col 字段名
	 * @param exp 条件
	 * @param content 要更新的内容
	 * @throws SQLException
	 */
	public static void updateClob(Connection conn, String table, String col, String exp, String content)
			throws SQLException, IOException {
		boolean defaultCommit = conn.getAutoCommit();
		conn.setAutoCommit(false);
		String sql = "update " + table + " set " + col + " =empty_clob() where "
				+ exp;
		Statement stmt = conn.createStatement();
		stmt.executeUpdate(sql);
		java.sql.Clob myClob = null;

		ResultSet rs = stmt.executeQuery("select " + col + " from " + table
				+ " where " + exp + " for update");
		if (rs.next()) {
			myClob = rs.getClob(1);
			java.io.Writer os = ((oracle.sql.CLOB) myClob)
					.getCharacterOutputStream();
			char[] b = new char[content.length()];
			content.getChars(0, content.length(), b, 0);
			os.write(b);
			os.flush();
			os.close();
			java.sql.PreparedStatement pstmt = conn.prepareStatement("update "
					+ table + " set " + col + " =? where " + exp);
			pstmt.setClob(1, (Clob) myClob);
			pstmt.executeUpdate();
			pstmt.close();
		}
		rs.close();
		stmt.close();
		conn.commit();
		conn.setAutoCommit(defaultCommit);
	}

	public static void updateBlob(Connection conn, String tab, String col, String exp, String infile)
			throws Exception {
		/* 设定不自动提交 */
		boolean defaultCommit = conn.getAutoCommit();
		conn.setAutoCommit(false);
		java.sql.Statement stmt = conn.createStatement();
		try {
			/* 清空原BLOB对象 */
			String sql = "update " + tab + " set " + col
					+ "=EMPTY_BLOB() where " + exp;
			stmt.executeUpdate(sql);
			/* 查询此BLOB对象并锁定 */
			if ((infile != null) && (!infile.equals(""))) {
				sql = "select " + col + " from " + tab + " where " + exp
						+ " for update";
				ResultSet rs = stmt.executeQuery(sql);
				if (rs.next()) {
					oracle.sql.BLOB blob = (oracle.sql.BLOB) (rs.getBlob(col));
					BufferedOutputStream out = new BufferedOutputStream(blob
							.getBinaryOutputStream());
					BufferedInputStream in = new BufferedInputStream(
							new FileInputStream(infile));
					int c;
					byte[] inBytes = new byte[65534];
					while ((c = in.read(inBytes)) > 0) {
						out.write(inBytes, 0, c);
					}
					in.close();
					out.flush();
					out.close();
				}
			}
			/* 正式提交 */
			conn.commit();
		} catch (Exception ex) {
			/* 出错回滚 */
			conn.rollback();
			conn.setAutoCommit(defaultCommit);
			throw (ex);
		}
		/* 恢复原提交状态 */
		conn.setAutoCommit(defaultCommit);
	}
	
	/**
	 * 取出CLOB数据
	 * @param rs
	 * @param colIndex 字段索引
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	public static String getClob(ResultSet rs, int colIndex) throws SQLException,
			IOException {
		StringBuffer content = new StringBuffer("");
		java.sql.Clob clob = rs.getClob(colIndex);
		if (clob != null) {
			Reader is = clob.getCharacterStream();
			BufferedReader br = new BufferedReader(is);
			String s = br.readLine();
			while (s != null) {
				content.append(s).append("\n");
				s = br.readLine();
			}
		}
		// log.logInfo("exec00000");
		return content.toString();
	}
	
	/**
	 * 取出CLOB数据
	 * @param rs
	 * @param col 字段名称
	 * @return
	 * @throws SQLException
	 * @throws IOException
	 */
	public static String getClob(ResultSet rs, String col) throws SQLException,
			IOException {
		StringBuffer content = new StringBuffer("");
		java.sql.Clob clob = rs.getClob(col);
		if (clob != null) {
			Reader is = clob.getCharacterStream();
			BufferedReader br = new BufferedReader(is);
			String s = br.readLine();
			while (s != null) {
				content.append(s).append("\n");
				s = br.readLine();
			}
		}
		// log.logInfo("exec00000");
		return content.toString();
	}

	public static byte[] getByteArray(java.sql.Blob blob) {
		byte[] c = null;
		int amount = 0; // 声明文件大小的变量。
		InputStream in = null; // 声明输入流。
		try {
			in = blob.getBinaryStream();

			int bufferSize = 1024; // 声明一个大小的 变量。

			byte[] b = new byte[bufferSize]; // 声明字节数组。

			int count = in.read(b, 0, bufferSize); // 读取输入流。

			while (count != -1) {
				amount += count;
				count = in.read(b, 0, bufferSize);
			} // 循环读取流，取得文件的 大小。

			c = new byte[amount]; // 得到文件的大小，声明一个 字节数组。

			in = null; // 将流设为空。
			in = blob.getBinaryStream(); // 从新读取“BLOB”中的流。

			in.read(c, 0, amount); // 将“BLOB”的全部读取到字节数组中。

			in.close();
			in = null;
		} catch (Exception e) {
			LOG.error(e);
		}

		return c;
	}
}
