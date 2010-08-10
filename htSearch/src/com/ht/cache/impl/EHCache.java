package com.ht.cache.impl;
import java.io.Serializable;

import net.sf.ehcache.Element;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
 
public class EHCache extends AbstractCache {

    private static final Log log = LogFactory.getLog(EHCache.class);

    private net.sf.ehcache.Cache cache;

    public EHCache(net.sf.ehcache.Cache cache) {
        this.cache = cache;
    }

    public final String[] getKeys() {
        try {
            Object[] arr = cache.getKeys().toArray();
            String[] sA = new String[arr.length];
            for (int i = 0; i < arr.length; i++) {
                Object o = arr[i];
                sA[i] = (String) o;
            }
            return sA;
        } catch (Exception e) {
            log.error(e.getMessage());
        }
        return null;
    }

    public Object get(String key) {
        try {
            if (key == null) {
                return null;
            } else {
                Element element = cache.get(key);
                if (element == null) {
                    return null;
                } else {
                    return element.getValue();
                }
            }
        } catch (Exception e) {
            log.error(e.getMessage());
        }
        return null;
    }


    public void put(String key, Object value) {
        try {
            if (value instanceof Serializable) {
                Element element = new Element(key, (Serializable) value);
                cache.put(element);
            }
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }


    public void remove(String key) {
        try {
            cache.remove(key);
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

    public void clear() {
        if (!canClear()) return;
        try {
            cache.removeAll();
        } catch (Exception e) {
            log.error(e.getMessage());
        }
    }

}
