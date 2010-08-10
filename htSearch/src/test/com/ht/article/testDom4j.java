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
		String query = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><response><lst name=\"responseHeader\"><int name=\"status\">0</int><int name=\"QTime\">79</int><lst name=\"params\"><str name=\"fl\">art_title,art_content,art_navigation,art_date,art_url</str><str name=\"hl\">true</str><str name=\"hl.fl\">url,art_title</str><str name=\"hl.simple.pre\">&lt;font color='red'&gt;</str><str name=\"hl.simple.post\">&lt;/font&gt;</str><str name=\"hl.snippets\">2</str><str name=\"q\">2010</str></lst></lst><result name=\"response\" numFound=\"19\" start=\"0\"><doc><str name=\"art_date\"/><str name=\"art_navigation\">�人���ڻ�վ��ŷ½���� �����ڼ䲿��Ͷ��</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">�����ӹ�¥�㳡д�����֡�С�ꡱ��2��(</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">�ܿ�������Ӵ��� �Ա�ɽСƷ�����ŵ�������Ա</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">�������̨3��15���������������������</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">��ЭΪ�����ر�������� 26�շ�����������</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">ס����ǣͷ����ط����Ϸ�Ͷ��������</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">�������Ļ�־Ը���͸�����[ͼ]</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">�����ز������ն����ͷ� �ɼ���������</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">�Ϸ����籭�������ݽ��� �й���������������</str><str name=\"art_title\"/><str name=\"art_url\"/></doc><doc><str name=\"art_date\"/><str name=\"art_navigation\">�����˹�Ӱ������Ԥ���ƶ� ��12��̨���չ�</str><str name=\"art_title\"/><str name=\"art_url\"/></doc></result><lst name=\"highlighting\"><lst name=\"MzI2\"/><lst name=\"MzU2\"/><lst name=\"MzM3\"/><lst name=\"MzI5\"/><lst name=\"MzQ1\"/><lst name=\"MzMx\"/><lst name=\"MzU1\"/><lst name=\"MzYy\"/><lst name=\"MzQz\"/><lst name=\"MzMw\"/></lst></response>";
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