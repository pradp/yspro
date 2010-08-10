package test.com.ht.article;

import com.ht.article.search.ArticleIndexService;
import com.ht.article.search.ArticleSearchService;

/**
 * 
 * @author cdji 2010-5-13
 */
public class SearchTest extends TestService {
	protected ArticleIndexService articleIndexService;
	protected ArticleSearchService articleSearchService;

	public void setUp() {
		articleIndexService = (ArticleIndexService) ctx.getBean("com.ht.article.search.impl.SolrIndexManagerImpl");
		articleSearchService = (ArticleSearchService) ctx.getBean("com.ht.article.search.impl.LinkIndexService");
	}

	public void tearDown() {
		articleSearchService = null;
		articleIndexService = null;
	}

	public void testRebuildAll() {
		articleIndexService.rebuildAll(null);
	}
}
