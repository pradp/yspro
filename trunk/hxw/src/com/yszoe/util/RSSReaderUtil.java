package com.yszoe.util;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Collections;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.gnu.stealthp.rsslib.RSSChannel;
import org.gnu.stealthp.rsslib.RSSException;
import org.gnu.stealthp.rsslib.RSSHandler;
import org.gnu.stealthp.rsslib.RSSItem;
import org.gnu.stealthp.rsslib.RSSParser;

/**
 * RSS 阅读器
 * 
 * @author Yangjianliang datetime 2010-2-2
 */
public class RSSReaderUtil {

	private static final Log LOG = LogFactory.getLog(RSSReaderUtil.class);

	/**
	 * 获取RSS新闻列表集合
	 * @param rssAddress RSS地址
	 * @return RSS新闻列表集合。永远不返回null，没有数据就返回零长度的集合。
	 */
	@SuppressWarnings("unchecked")
	public static List<RSSItem> getRssNews(String rssAddress) {

//		LOG.info("STARTING TO FETCH RSS FROM : " + rssAddress);
		List<RSSItem> rssItems = null;
		try {
			URL url = new URL(rssAddress);
			RSSHandler handler = new RSSHandler();

			RSSParser.parseXmlFile(url, handler, false);
			RSSChannel rch = handler.getRSSChannel();
			rssItems = rch.getItems();
		} catch (MalformedURLException e) {
			LOG.error(e);
		} catch (RSSException e) {
			LOG.error(e);
		}
		if(rssItems==null){
			rssItems = Collections.EMPTY_LIST;
		}
		return rssItems;
	}

	public static void main(String[] a) throws IOException {
 
		List<RSSItem> lst = RSSReaderUtil.getRssNews("http://113.105.159.155:9080/jsprun/rss.jsp?auth=0");
		for (int j = 0; j < lst.size(); j++) {
			RSSItem itm = lst.get(j);
//			LOG.info(itm.getTitle());
//			LOG.info(itm.getDate());
			System.out.println(itm.getTitle());
			System.out.println(itm.getDate());
		}
	}
}
