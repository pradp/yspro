package com.ht.cache;

/**
 * Cache管理器
 *
 * 
 */
public interface CacheManager {

    /**
     * 启动
     *
     */
    public void start();

    /**
     * 得到管辖的所有cache的name
     *
     */
    public String[] getCacheNames();

    /**
     * 得到cache
     *
     * @param cacheName
     */
    public Cache getCache(String cacheName);

    /**
     * 移除cache
     *
     * @param cacheName
     */
    public void remove(String cacheName);

    /**
     * 停止
     *
     */
    public void stop();
}
