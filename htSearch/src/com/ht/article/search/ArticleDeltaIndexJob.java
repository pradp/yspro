package com.ht.article.search;

import java.io.IOException;
import java.util.ResourceBundle;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

/**
 * 定时执行增量建立索引任务
 * 
 * @author cdji 2010-5-13
 */
public class ArticleDeltaIndexJob extends QuartzJobBean {

	protected final Log logger = LogFactory.getLog(getClass());
	private static final ResourceBundle searchResourceFile = ResourceBundle.getBundle("search");

	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		try {

//			long startTime = System.currentTimeMillis();

			doIndexJob();
			
//			long endTime = System.currentTimeMillis();

//			logger.info("build index spend " + (endTime - startTime) / 1000 + "seconds ");

		} catch (Exception e) {
			logger.error(e);
		}
	}

	/**
	 * 索引任务
	 * @throws IOException 
	 * @throws HttpException 
	 */
	protected void doIndexJob() throws HttpException, IOException {

		HttpClient client = new HttpClient();
		String url = searchResourceFile.getString("solr.dataimportURL");
		client.getHttpConnectionManager().getParams().setConnectionTimeout(Constants.CONNECTION_TIMEOUT);
		GetMethod get = new GetMethod(url);
		get.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, new Integer(Constants.CONNECTION_TIMEOUT));

		try {
			// Execute the method.
			int statusCode = client.executeMethod(get);
			if (statusCode != HttpStatus.SC_OK) {
				logger.error("Index Job Method failed: " + get.getStatusLine());
			}
			// Read the response body.
			get.getResponseBody();

		} finally {
			// Release the connection.
			get.releaseConnection();
		}

	}

}
