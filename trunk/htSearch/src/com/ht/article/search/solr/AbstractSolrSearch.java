package com.ht.article.search.solr;

import java.io.IOException;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.embedded.EmbeddedSolrServer;
import org.apache.solr.core.CoreContainer;
import org.xml.sax.SAXException;

import com.ht.article.search.AbstractSolrSearchService;

/**
 * 基於solr的檢索服務
 * 
 * @author JL.Yang
 * 2010-8-22
 */
public class AbstractSolrSearch {

	protected static Log log = LogFactory.getFactory().getInstance(AbstractSolrSearchService.class);

	private static SolrServer solrServer = null;
	
	/**
	 * 使用EmbeddedSolrServer方式获得solr服务对象
	 * 注： EmbeddedSorrServer提供和CommonsHttpSorlrServer相同的接口，它不需要http连接。
	 * 内嵌solr服务，这将是一个不错的选择。
	 * @return solr服务对象：SolrServer
	 */
	public static SolrServer getSolrServer() {
		if(solrServer==null){
//			System.setProperty("solr.solr.home", "solr_home");
			CoreContainer.Initializer initializer = new CoreContainer.Initializer();
			CoreContainer coreContainer;
			try {
				coreContainer = initializer.initialize();
				solrServer = new EmbeddedSolrServer(coreContainer, "");
			} catch (IOException e) {
				log.error(e);
				throw new RuntimeException("getSolrServer() failed!! " + e);
			} catch (ParserConfigurationException e) {
				log.error(e);
				throw new RuntimeException("getSolrServer() failed!! " + e);
			} catch (SAXException e) {
				log.error(e);
				throw new RuntimeException("getSolrServer() failed!! " + e);
			}
			//also can like this : return new CommonsHttpSolrServer(new URL(solrUrl));
		}
		return solrServer;
	}
}
