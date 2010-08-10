package com.ht.cache.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ht.cache.Cache;
import com.ht.cache.CacheManager;

/**
 * CacheManager的EHCache实现版本
 *
 *  
 */
public class EHCacheManager implements CacheManager {

	private static final Log log = LogFactory.getLog(EHCacheManager.class);

	private net.sf.ehcache.CacheManager manager;

	protected Map caches = new HashMap();

	/**
	 * 构造函数,从classloader path中寻找ehcache.xml作为配置文件。
	 */
	public EHCacheManager() {
		manager = net.sf.ehcache.CacheManager.create();
	}

	/**
	 * 构造函数
	 *
	 * @param configurationFileName 配置文件的路径
	 */
	public EHCacheManager(String configurationFileName) {
		manager = net.sf.ehcache.CacheManager.create(configurationFileName);
	}

	public void start() {
		//do nothing
	}

	/**
	 * 得到管辖的所有cache的name
	 */
	public String[] getCacheNames() {
		return manager.getCacheNames();
	}

	/**
	 * 如果没有与指定cacheName对应的cache,则创建一个。
	 *
	 * @param cacheName
	 * @return 与cacheName对应的cache
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
	 * 移除指定cacheName对应的cache
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
	 * 停止
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
