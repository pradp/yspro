package com.ht.article.search;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.TimeZone;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.RequestEntity;
import org.apache.commons.httpclient.methods.StringRequestEntity;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;

/**
 * 
 * @author cdji 2010-5-13
 */
public class AbstractSolrIndexService {

	protected Log log = LogFactory.getFactory().getInstance(getClass());

	protected static SimpleDateFormat solrFormatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS", Locale.US);

	protected static TimeZone UTC = TimeZone.getTimeZone("UTC");

	protected String solrUpdateURL;

	public void setSolrUpdateURL(String solrUpdateURL) {
		this.solrUpdateURL = solrUpdateURL;
	}

	public AbstractSolrIndexService() {
		solrFormatter.setTimeZone(UTC);
	}

	protected void processCommit() {
		Document document = DocumentHelper.createDocument();
		document.addElement("commit");
		sendPostCommand(document.asXML(), solrUpdateURL);
	}

	protected void sendPostCommand(String command, String url) {
		HttpClient client = new HttpClient();
		client.getHttpConnectionManager().getParams().setConnectionTimeout(Constants.CONNECTION_TIMEOUT);
		PostMethod post = new PostMethod(url);
		post.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, new Integer(Constants.CONNECTION_TIMEOUT));

		try {
			RequestEntity re = new StringRequestEntity(command, "text/xml", "UTF-8");
			post.setRequestEntity(re);
			// Execute the method.
			int statusCode = client.executeMethod(post);
			if (statusCode != HttpStatus.SC_OK) {
				log.error("Method failed: " + post.getStatusLine());
			}
		} catch (HttpException e) {
			log.error("Fatal protocol violation: " + e.getMessage());
		} catch (IOException e) {
			log.error("Fatal transport error: " + e.getMessage());
		} catch (Exception e) {
			log.error(e);
		} finally {
			// Release the connection.
			post.releaseConnection();
		}
	}

}
