package com.imchooser.infoms.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.imchooser.framework.util.DBUtil;
import com.imchooser.framework.util.SeqFactory;

/**
 * 业务操作日志记录类
 * @author Yangjianliang
 * datetime 2009-8-5
 */
public class BusinessLogUtil implements Runnable{

	private static final Log log = LogFactory.getLog(BusinessLogUtil.class);
	private static final String sql = "insert into t_sys_biz_log(wid,czsj,czdx,czr,czlx) values(?,sysdate,?,?,?)";
	private String opUserLoginid;
	private Object opTableObject; 
	private int opType;
	
	public BusinessLogUtil() {
		super();
	}

	public BusinessLogUtil(String opUserLoginid, Object opTableObject,
			int opType) {
		super();
		this.opUserLoginid = opUserLoginid;
		this.opTableObject = opTableObject;
		this.opType = opType;
	}

	/**
	 * 记录用户的操作信息到数据库。
	 * 此方法是静默执行的，不会抛出任何异常（包括运行时异常）。
	 * @param opUserLoginid 操作人的登录ID
	 * @param opTableObject 操作的表（HQL对象）
	 * @param opType 操作类型（保存1、更新2、删除3）
	 */
	public static final void log(String opUserLoginid, Object opTableObject, int opType){
		BusinessLogUtil bizLogUtil = new BusinessLogUtil(opUserLoginid, opTableObject, opType);
		Thread t = new Thread(bizLogUtil, "infomsBizLogThread");
        t.setPriority(Thread.MIN_PRIORITY);
        t.start();
	}

	/* (non-Javadoc)
	 * @see java.lang.Runnable#run()
	 */
	public void run() {
		String wid = SeqFactory.getNewSequenceAlone();
		try{
			DBUtil.executeSQL( sql, wid, opTableObject, opUserLoginid, opType );
		}catch(RuntimeException e){
			log.error("为["+opUserLoginid+"， "+String.valueOf(opTableObject)+"， "+opType+"]记录日志的时候发生运行时异常：");
			log.error(e);
		}catch(Exception e){
			log.error("为["+opUserLoginid+"， "+String.valueOf(opTableObject)+"， "+opType+"]记录日志的时候发生异常：");
			log.error(e);
		}
	}

	public String getOpUserLoginid() {
		return opUserLoginid;
	}

	public void setOpUserLoginid(String opUserLoginid) {
		this.opUserLoginid = opUserLoginid;
	}

	public Object getOpTableObject() {
		return opTableObject;
	}

	public void setOpTableObject(Object opTableObject) {
		this.opTableObject = opTableObject;
	}

	public int getOpType() {
		return opType;
	}

	public void setOpType(int opType) {
		this.opType = opType;
	}
	
}
