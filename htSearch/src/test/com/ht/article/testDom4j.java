package test.com.ht.article;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.ht.article.search.model.Article;
import com.ht.util.DateUtil;

public class testDom4j {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String query = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><response><lst name=\"responseHeader\"><int name=\"status\">0</int><int name=\"QTime\">79</int><lst name=\"params\"><str name=\"fl\">art_title,art_content,art_navigation,art_date,art_url</str><str name=\"hl\">true</str><str name=\"hl.fl\">url,art_title</str><str name=\"hl.simple.pre\">&lt;font color='red'&gt;</str><str name=\"hl.simple.post\">&lt;/font&gt;</str><str name=\"hl.snippets\">2</str><str name=\"q\">2010</str></lst></lst><result name=\"response\" numFound=\"19\" start=\"0\"><doc><str name=\"art_date\"/><str name=\"art_navigation\">武汉汉口火车站显欧陆风情 春运期间部分投用</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">北京钟鼓楼广场写春联闹“小年”（2）(</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">跑酷登上央视春晚 赵本山小品不彩排但增加演员</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">中央电视台3·15晚会消费线索二号征集令</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">田协为刘翔特别增设比赛 26日飞人新年首秀</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">住建部牵头督察地方保障房投入完成情况</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">北京：文化志愿者送福下乡[图]</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">大龙地产：做空动能释放 股价有望反弹</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">南非世界杯裁判阵容揭晓 中国人穆宇欣进名单</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">世博人工影响天气预案制定 遇12级台风或闭馆</str><str name=\"art_title\"/><str name=\"art_url\"/></doc></result><lst name=\"highlighting\"><lst name=\"MzI2\"/><lst name=\"MzU2\"/><lst name=\"MzM3\"/><lst name=\"MzI5\"/><lst name=\"MzQ1\"/><lst name=\"MzMx\"/><lst name=\"MzU1\"/><lst name=\"MzYy\"/><lst name=\"MzQz\"/><lst name=\"MzMw\"/></lst></response>";
		List result = new ArrayList();
		SAXReader reader = new SAXReader();
		try {
			Document document = reader.read(new StringReader(query));
			Element resultE = (Element) document.selectSingleNode("//result[@name='response']");

			Iterator docs = resultE.elementIterator("doc");
			while (docs.hasNext()) {
				Element doc = (Element) docs.next();
				Article article = new Article();
				Element title = (Element) doc.selectSingleNode("str[@name='art_title']");
				article.setArtTitle(title.getTextTrim());
			 
				Element navigation = (Element) doc.selectSingleNode("str[@name='art_navigation']");
				article.setArtNavigation(navigation.getTextTrim());
				Element url = (Element) doc.selectSingleNode("str[@name='art_url']");
				article.setArtUrl(url.getTextTrim());
			 
				result.add(article);
			}

		} catch (Exception e) {
			e.printStackTrace();

		}
		System.out.println(result.size());

	}
}