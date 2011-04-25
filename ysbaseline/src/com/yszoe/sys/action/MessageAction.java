package com.yszoe.sys.action;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.framework.util.DBUtil;
import com.yszoe.sys.entity.TSysMessage;
import com.yszoe.sys.entity.TSysMessageGxqf;
import com.yszoe.sys.service.impl.MessageServiceImpl;

@SuppressWarnings("serial")
public class MessageAction extends BaseActionAbstractSupport {
	private static final Log log = LogFactory.getLog(MessageAction.class);

	private TSysMessage tsysMessage;
	private TSysMessageGxqf tsysMessageGxqf;
	private File myFile;

	public TSysMessage getTsysMessage() {
		return tsysMessage;
	}

	public void setTsysMessage(TSysMessage sysMessage) {
		tsysMessage = sysMessage;
	}

	public TSysMessageGxqf getTsysMessageGxqf() {
		return tsysMessageGxqf;
	}

	public void setTsysMessageGxqf(TSysMessageGxqf tsysMessageGxqf) {
		this.tsysMessageGxqf = tsysMessageGxqf;
	}

	/**
	 * 发送附件用
	 * 
	 * @return
	 */
	public String download() {
		return "download";
	}

	/**
	 * 下载附件
	 * 
	 * @param wid 消息wid
	 * @param response
	 */
	public void getNR_XZ(String wid, HttpServletResponse response) {
		String sqlt = "select t.fj from t_sys_message t where t.wid = ?";
		try {
			ResultSet rs = DBUtil.queryRowSet(sqlt, wid);
			if (rs.next()) {
				Blob b = rs.getBlob("fj");
				InputStream in = b.getBinaryStream();
				byte[] by = new byte[1000];
				ServletOutputStream sos;
				try {
					sos = response.getOutputStream();
					int len = 0;
					while ((len = in.read(by)) != -1) {
						sos.write(by, 0, len);
					}
				} catch (IOException e) {
					log.error(e);
				} finally {
					try {
						in.close();
					} catch (IOException e) {
						log.error(e);
					}
				}
			}
		} catch (SQLException e) {
			log.error(e);
		}

	}

	public File getMyFile() {
		return myFile;
	}

	public void setMyFile(File myFile) {
		this.myFile = myFile;
	}

	public String msgbody() {
		MessageServiceImpl msg = (MessageServiceImpl) this.getBaseService();
		msg.msgbody(this);
		return "msgbody";
	}
}
