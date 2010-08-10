package test.com.ht.article;

import junit.framework.TestCase;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 * 
 * @author cdji 2010-5-13
 */
public abstract class TestService extends TestCase {
	protected final static ApplicationContext ctx;

	static {
		String[] paths = { "classpath:applicationContext" };
		ctx = new ClassPathXmlApplicationContext(paths);
	}
}
