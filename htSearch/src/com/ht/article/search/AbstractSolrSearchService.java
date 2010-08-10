package com.ht.article.search;

import java.io.IOException;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 
 * @author cdji 2010-5-13
 */
public class AbstractSolrSearchService {

	protected Log log = LogFactory.getFactory().getInstance(getClass());

	protected String solrSelectURL;

	public void setSolrSelectURL(String solrSelectURL) {
		this.solrSelectURL = solrSelectURL;
	}

	protected String sendGetCommand(String queryString, String url) {
		String results = null;
		HttpClient client = new HttpClient();
		client.getHttpConnectionManager().getParams().setConnectionTimeout(Constants.CONNECTION_TIMEOUT);
		GetMethod get = new GetMethod(url);
		get.addRequestHeader("Content-type", "text/html; charset=utf-8");
		get.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, new Integer(Constants.CONNECTION_TIMEOUT));
		try {
			get.setQueryString(queryString.trim());
			// Execute the method.
			int statusCode = client.executeMethod(get);
			if (statusCode != HttpStatus.SC_OK) {
				log.error("Method failed: " + get.getStatusLine());
			}
			// Read the response body.
			byte[] responseBody = get.getResponseBody();
			// Deal with the response.
			// Use caution: ensure correct character encoding and is not binary
			// data
			results = new String(responseBody, "UTF-8");
		} catch (HttpException e) {
			log.error("Fatal protocol violation: " + e.getMessage());
			e.printStackTrace();
		} catch (IOException e) {
			log.error("Fatal transport error: " + e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			log.error(e);
		} finally {
			// Release the connection.
			get.releaseConnection();
		}
		return results;
	}

}
