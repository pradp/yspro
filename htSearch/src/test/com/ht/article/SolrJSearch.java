package test.com.ht.article;

import java.net.MalformedURLException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.solr.client.solrj.SolrQuery;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.CommonsHttpSolrServer;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.common.SolrDocument;
import org.apache.solr.common.SolrDocumentList;

public class SolrJSearch {

	private static final String SOLR_URL = "http://localhost:7080/solr/";
	private CommonsHttpSolrServer solrServer = null;

	public SolrJSearch() {
		try {
			solrServer = new CommonsHttpSolrServer(SOLR_URL);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		}
	}

	public void search(List list) {
		SolrQuery query = new SolrQuery();
		query.setQuery("text:丝 小兄弟 枯");
		String groups[] = splitListToArray(list);
		//String groups[] = new String[]{"56147","56151","56157","56158","56165","56173","56182","56186","56193","56194"};
		StringBuffer filterQuery = new StringBuffer();
		if (groups != null && groups.length > 0) {

			filterQuery.append(" (art_id:").append(StringUtils.join(groups, " OR art_id:")).append(")");
		}

		query.setFilterQueries(filterQuery.toString());
		
		query.setStart(new Integer(1));
		query.setRows(new Integer(100));
		
		System.out.println(query.toString());
		//排序用的  
		//query.addSortField( "price", SolrQuery.ORDER.asc );    
		try {
			QueryResponse rsp = solrServer.query(query);

			SolrDocumentList docs = rsp.getResults();

			System.out.println("文档个数：" + docs.getNumFound());
			System.out.println("查询时间：" + rsp.getQTime());
			for (SolrDocument doc : docs) {
				String title = (String) doc.getFieldValue("art_id");
				String id = (String) doc.getFieldValue("art_title");
				System.out.println(id);
				System.out.println(title);
			}
		} catch (SolrServerException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {

		SolrJSearch sj = new SolrJSearch();

	//	List list = sj.queryArtId();
		sj.search(new ArrayList());
	}

	private String[] splitListToArray(List list) {
		String[] result = new String[list.size()];
		int i = 0;
		for (Iterator iterator = list.iterator(); iterator.hasNext();) {
			String mp = (String) iterator.next();

			result[i] = mp;
			//(String) Integer.toString((Integer) mp.get("article_id"));
			i++;

		}

		return result;

	}

	class Article {
		private String artId;
		private String artTitle;
		private String artUrl;

		public String getArtId() {
			return artId;
		}

		public void setArtId(String artId) {
			this.artId = artId;
		}

		public String getArtTitle() {
			return artTitle;
		}

		public void setArtTitle(String artTitle) {
			this.artTitle = artTitle;
		}

		public String getArtUrl() {
			return artUrl;
		}

		public void setArtUrl(String artUrl) {
			this.artUrl = artUrl;
		}

	}

	public List queryArtId() {
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost/lportal521?useUnicode=true&amp;characterEncoding=UTF-8&amp;useFastDateParsing=false";
		String user = "portal";
		String password = "portal";
		Statement stmt;
		ResultSet rs;
		List articles = new ArrayList();
		try {
			Class.forName(driver);
			Connection conn = DriverManager.getConnection(url, user, password);

			if (!conn.isClosed())
				System.out.println("数据库连接成功！");
			stmt = conn.createStatement();
			
			String sql = "select article_id from  article where category_id in (select category_id from  category where category_id in (select category_id from category_role where role_id in ( select roleid  from   Users_Roles where userid='10113' ) ) )";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				articles.add(rs.getString("article_id"));

			}
			System.out.println("可看文章数＝＝＝＝" + articles.size());
			conn.close();
		} catch (ClassNotFoundException e) {
			System.out.println("找不到驱动程序");
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		List tmp = new ArrayList();
		tmp.add("1222");
		return articles;

	}
}
