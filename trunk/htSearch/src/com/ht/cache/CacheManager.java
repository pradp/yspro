package com.ht.cache;

/**
 * Cache������
 *
 * 
 */
public interface CacheManager {

    /**
     * ����
     *
     */
    public void start();

    /**
     * �õ���Ͻ������cache��name
     *
     */
    public String[] getCacheNames();

    /**
     * �õ�cache
     *
     * @param cacheName
     */
    public Cache getCache(String cacheName);

    /**
     * �Ƴ�cache
     *
     * @param cacheName
     */
    public void remove(String cacheName);

    /**
     * ֹͣ
     *
     */
    public void stop();
}
