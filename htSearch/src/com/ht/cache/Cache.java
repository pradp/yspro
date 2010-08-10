package com.ht.cache;
 
public interface Cache {


    /**
     * can Clear
     * @return canClear
     */
    public boolean canClear();

    /**
     * set canClear
     * @param canClear
     */
    public void setCanClear(boolean canClear);

    /**
     * 得到cache中key对应条目的value。
     *
     * @param key
     * @return key对应的Object,如果不存在,返回null.
     */
    public Object get(String key);

    /**
     * 移除cache中key对应的条目。
     *
     * @param key
     */
    public void remove(String key);

    /**
     * 将条目置入cache
     *
     * @param key
     * @param obj
     */
    public void put(String key, Object obj);


    /**
     * 移除cache所有条目。
     *
     */
    public void clear();

    /**
     * 得到cache中所有键值。
     *
     */
    public String[] getKeys();

}
