package com.yszoe.sys.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.yszoe.framework.util.DBUtil;
import com.yszoe.framework.util.SeqFactory;

/**
 * 业务操作日志记录类
 * @author Yangjianliang
 * datetime 2009-8-5
 */
public class BusinessLogUtil implements Runnable{

	private static final Log log = LogFactory.getLog(BusinessLogUtil.class);
	private static final String sql = "insert into t_sys_biz_log(wid,czsj,czdx,czr,czlx,czbid,type,czms,cznrzy) values(?,sysdate,?,?,?,?,?,?,?)";
	//TODO sql增加一个描述字段
	private String opUserLoginid;
	private Object opTableObject;
	private int opType;
	private String memo;

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

	public BusinessLogUtil(String opUserLoginid, Object opTableObject,
			int opType, String memo) {
		super();
		this.opUserLoginid = opUserLoginid;
		this.opTableObject = opTableObject;
		this.opType = opType;
		this.memo = memo;
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

	/**
	 * 记录好友足迹/动作
	 * 此方法是静默执行的，不会抛出任何异常（包括运行时异常）。
	 * @param opUserLoginid 操作人的登录ID
	 * @param memo 备注
	 * @param opType 操作类型（保存1、更新2、删除3）
	 */
	public static final void action(String opUserLoginid, Object opTableObject,String czbid, int opType,String type,String czms,String cznrzy){
		//TODO 记录好友足迹，此处要组织一段描述文字
		String memo = "";
		String wid = SeqFactory.getNewSequenceAlone();
		try{
			DBUtil.executeSQL( sql, wid, opTableObject, opUserLoginid, opType ,czbid,type,czms,cznrzy);
		}catch(RuntimeException e){
			log.error("为["+opUserLoginid+"， "+String.valueOf(opTableObject)+"， "+opType+"]记录日志的时候发生运行时异常：");
			log.error(e);
		}catch(Exception e){
			log.error("为["+opUserLoginid+"， "+String.valueOf(opTableObject)+"， "+opType+"]记录日志的时候发生异常：");
			log.error(e);
		}
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

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

}
