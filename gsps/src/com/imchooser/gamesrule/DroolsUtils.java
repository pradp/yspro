package com.imchooser.gamesrule;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.drools.KnowledgeBase;
import org.drools.KnowledgeBaseFactory;
import org.drools.builder.KnowledgeBuilder;
import org.drools.builder.KnowledgeBuilderError;
import org.drools.builder.KnowledgeBuilderErrors;
import org.drools.builder.KnowledgeBuilderFactory;
import org.drools.builder.ResourceType;
import org.drools.io.ResourceFactory;
import org.drools.logger.KnowledgeRuntimeLogger;
import org.drools.logger.KnowledgeRuntimeLoggerFactory;
import org.drools.runtime.StatefulKnowledgeSession;

import com.imchooser.infoms.entity.biz.TSportBsxm;
import com.imchooser.infoms.service.biz.impl.SportCjYdyServiceImpl;

/**
 * 封装了drools的固定代码，提供上次业务直接调用指定规则的功能。
 * @author Yangjianliang
 * datetime 2011-4-25
 */
public class DroolsUtils {

	private static final Log LOG = LogFactory.getLog(DroolsUtils.class);

	private static KnowledgeBase knowledgeBase;
		
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
	}
	
	public static void auditGamesRule(TSportBsxm bsxm){
		try {
			// load up the knowledge base
			if(knowledgeBase==null){
				knowledgeBase = readKnowledgeBase();
			}
//			KnowledgeBase kbase = readKnowledgeBase();
			StatefulKnowledgeSession statefulKSession = knowledgeBase.newStatefulKnowledgeSession();
			KnowledgeRuntimeLogger logger = KnowledgeRuntimeLoggerFactory.newFileLogger(statefulKSession, "gameslog");
			// go !
			TSportBsxm bsxm1 = new TSportBsxm();
			bsxm1.setWid("");
			bsxm1.setShzt("");
			SportCjYdyServiceImpl sportCjYdyService = new SportCjYdyServiceImpl();
			statefulKSession.setGlobal("globalbean", sportCjYdyService);//设置一 个global对象
			statefulKSession.insert(bsxm1);
			statefulKSession.fireAllRules();
			statefulKSession.dispose();
			logger.close();
		} catch (Throwable t) {
			LOG.error(t);
		}
	}

	private static KnowledgeBase readKnowledgeBase() throws Exception {
		KnowledgeBuilder kbuilder = KnowledgeBuilderFactory.newKnowledgeBuilder();
		kbuilder.add(ResourceFactory.newClassPathResource("Sample.drl"), ResourceType.DRL);
		KnowledgeBuilderErrors errors = kbuilder.getErrors();
		if (errors.size() > 0) {
			for (KnowledgeBuilderError error: errors) {
//				System.err.println(error);
				LOG.error(error);
			}
			throw new IllegalArgumentException("Could not parse knowledge.");
		}
		KnowledgeBase kbase = KnowledgeBaseFactory.newKnowledgeBase();
		kbase.addKnowledgePackages(kbuilder.getKnowledgePackages());
		return kbase;
	}

}
