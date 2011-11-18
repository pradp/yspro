/***********************************************************
 * 
 * 说 明：
 * 作 者：yangjianliang
 * 日 期：2007-11-9
 *
 **********************************************************/
package com.yszoe.util;

import org.springframework.dao.DataAccessException;

public class CustomException extends DataAccessException {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1182363336501189623L;

	public CustomException(String errMessage) {
		super(errMessage);
	}

	public CustomException(Throwable err) {
		super(null, err);
	}

	public CustomException(String errMessage, Throwable err) {
		super(errMessage, err);
	}

	/**
	 * 根据异常堆栈,找出数据访问错误信息的有效部分返回给用户界面
	 * @return
	 */
	public String getPackedMessage(){
		
		return getRootCause().getLocalizedMessage();
	}

}
