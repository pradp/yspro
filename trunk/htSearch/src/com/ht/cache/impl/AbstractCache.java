package com.ht.cache.impl;

import com.ht.cache.Cache;

 
public abstract class AbstractCache implements Cache {

    private boolean canClear = true;

    public boolean canClear() {
        return canClear;
    }

    public void setCanClear(boolean canClear) {
        this.canClear = canClear;
    }

}
