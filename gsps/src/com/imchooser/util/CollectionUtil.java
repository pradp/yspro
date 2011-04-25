package com.imchooser.util;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;

public class CollectionUtil {

	/**
	 * 去除list中的重复元素
	 * @param src
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static List removeRepeat(List src){
		if(src==null)return null;
		if(src.isEmpty()){
			return src;
		}
		return new ArrayList(new LinkedHashSet(src));
	}

	/**
	 * 去除空元素
	 * @param src
	 * @return
	 */
	public static List<?> removeNullElement(List<?> src){
		if(src==null)return null;
		for(int i=0;i<src.size();i++){
			if(src.get(i)==null){
				src.remove(i);
				i--;
			}
		}
		
		return src;
	}
	
}
