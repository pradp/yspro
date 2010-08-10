package test.com.ht.article;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * 
 * @author cdji 2010-5-13
 */
public class TestStringUtilsJoin {

	public static void main(String args[]) {
		ArrayList list1 = new ArrayList();
		System.out.println("size: " + list1.size());
		for (int i = 0; i < 88; i++) {
			Map mp = new HashMap();
			mp.put("article_id", "xxxxxxxxx");
			list1.add(mp);
		}
		
		
		int i = 0;
		String [] result = new String [list1.size()];
		for (Iterator iterator = list1.iterator(); iterator.hasNext();) {
			Map mp = (Map) iterator.next();
			
			result[i] =mp.get("article_id").toString();
			//(String) Integer.toString((Integer) mp.get("article_id"));
			i++;

		}
		
		 
		for (int j = 0; j < result.length; j++) {
			System.out.println("str: " + result[j]+"=="+j);

		}
	}
}
