package com.ht.cache.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ht.cache.Cache;
import com.ht.cache.CacheManager;

/**
 * CacheManager��EHCacheʵ�ְ汾
 *
 *  
 */
public class EHCacheManager implements CacheManager {

	private static final Log log = LogFactory.getLog(EHCacheManager.class);

	private net.sf.ehcache.CacheManager manager;

	protected Map caches = new HashMap();

	/**
	 * ���캯��,��classloader path��Ѱ��ehcache.xml��Ϊ�����ļ���
	 */
	public EHCacheManager() {
		manager = net.sf.ehcache.CacheManager.create();
	}

	/**
	 * ���캯��
	 *
	 * @param configurationFileName �����ļ���·��
	 */
	public EHCacheManager(String configurationFileName) {
		manager = net.sf.ehcache.CacheManager.create(configurationFileName);
	}

	public void start() {
		//do nothing
	}

	/**
	 * �õ���Ͻ������cache��name
	 */
	public String[] getCacheNames() {
		return manager.getCacheNames();
	}

	/**
	 * ���û����ָ��cacheName��Ӧ��cache,�򴴽�һ����
	 *
	 * @param cacheName
	 * @return ��cacheName��Ӧ��cache
	 */
	public synchronized Cache getCache(String cacheName) {
		if ((cacheName == null) || (cacheName.length() == 0)) {
			throw new java.lang.IllegalArgumentException("cacheName is null");
		}
		Cache ehCache = (Cache) caches.get(cacheName);
		if (ehCache != null)
			return ehCache;
		try {
			net.sf.ehcache.Cache cache = manager.getCache(cacheName);
			if (cache == null) {
				manager.addCache(cacheName);
				cache = manager.getCache(cacheName);
			}
			ehCache = new EHCache(cache);
			caches.put(cacheName, ehCache);
			return ehCache;
		} catch (Exception e) {
			log.error(e.getMessage());
			return null;
		}
	}

	/**
	 * �Ƴ�ָ��cacheName��Ӧ��cache
	 *
	 * @param cacheName
	 */
	public synchronized void remove(String cacheName) {
		if ((cacheName == null) || (cacheName.length() == 0)) {
			throw new java.lang.IllegalArgumentException("cacheName is null");
		}
		try {
			manager.removeCache(cacheName);
			caches.remove(cacheName);
		} catch (Exception e) {
			log.error(e.getMessage());
		}
	}

	/**
	 * ֹͣ
	 */
	public synchronized void stop() {
		if (manager != null) {
			manager.shutdown();
			manager = null;
		}
		caches.clear();
	}

	protected void finalize() throws Throwable {
		this.stop();
		super.finalize();
	}

}
