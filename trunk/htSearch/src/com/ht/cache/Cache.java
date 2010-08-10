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
     * �õ�cache��key��Ӧ��Ŀ��value��
     *
     * @param key
     * @return key��Ӧ��Object,���������,����null.
     */
    public Object get(String key);

    /**
     * �Ƴ�cache��key��Ӧ����Ŀ��
     *
     * @param key
     */
    public void remove(String key);

    /**
     * ����Ŀ����cache
     *
     * @param key
     * @param obj
     */
    public void put(String key, Object obj);


    /**
     * �Ƴ�cache������Ŀ��
     *
     */
    public void clear();

    /**
     * �õ�cache�����м�ֵ��
     *
     */
    public String[] getKeys();

}
