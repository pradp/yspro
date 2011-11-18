/**
 * TimeHandler.java
 */
package com.yszoe.identity.springinterceptor;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.log4j.Logger;

/**
 * spring拦击器，打印方法执行时间
 * @author Yangjianliang 
 * datetime 2008-11-29
 */
public class MethodTimeInterceptor implements MethodInterceptor {

	private static final Logger logger = Logger.getLogger(MethodTimeInterceptor.class);

	// 重写invoke()方法
	public Object invoke(MethodInvocation methodInvocation) throws Throwable {

		long procTime = System.currentTimeMillis();
		try {

			Object result = methodInvocation.proceed();
			return result;
		} finally {
			// 计算执行时间
			procTime = System.currentTimeMillis() - procTime;
			Object[] oo = methodInvocation.getArguments();
			if(oo!=null){
				logger.info( "执行 " + methodInvocation.getMethod().getName() 
						+ " 方法共用了 " + procTime + "毫秒");
			}
		}
	}
}
