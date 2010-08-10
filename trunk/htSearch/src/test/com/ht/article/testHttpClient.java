package test.com.ht.article;

import java.io.IOException;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.httpclient.util.URIUtil;

import com.ht.article.search.Constants;

public class testHttpClient {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String results = null;
		HttpClient client = new HttpClient();
		String url="http://localhost:8080/solr/select";
		String key="东奔西走大规模大规模大规模大规模大规模大规模城";
		StringBuffer queryString=new StringBuffer();
		queryString.append("fl=art_title,art_content,art_navigation,art_date,art_url&hl=true&hl.fl=url,art_title&hl.simple.pre=<font color='red'>&hl.simple.post=</font>&hl.snippets=2&q=");
		queryString.append(key);
		queryString.append( "&start=0&rows=1000");
		 ;
		  
		client.getHttpConnectionManager().getParams().setConnectionTimeout(Constants.CONNECTION_TIMEOUT);
		GetMethod get = new GetMethod(url);
		get.getParams().setParameter(HttpMethodParams.SO_TIMEOUT, new Integer(Constants.CONNECTION_TIMEOUT));
		try {
			get.setQueryString(URIUtil.encodeQuery(queryString.toString(), "UTF-8"));
			// Execute the method.
			int statusCode = client.executeMethod(get);
			if (statusCode != HttpStatus.SC_OK) {
				System.out.println("Method failed: " + get.getStatusLine());
			}
			// Read the response body.
			byte[] responseBody = get.getResponseBody();
			// Deal with the response.
			// Use caution: ensure correct character encoding and is not binary
			// data
			results = new String(responseBody, "UTF-8");
		} catch (HttpException e) {
			System.out.println("Fatal protocol violation: " + e.getMessage());
			e.printStackTrace();
		} catch (IOException e) {
			System.out.println("Fatal transport error: " + e.getMessage());
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println(e);
		} finally {
			// Release the connection.
			get.releaseConnection();
		}
		System.out.println(results);

	}
}