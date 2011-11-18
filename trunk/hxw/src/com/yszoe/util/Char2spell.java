/**
 * Char2spell.java
 */
package com.yszoe.util;

/**
 * 字转拼音缩写
 * @author Yangjianliang
 * datetime 2008-11-15
 */
public class Char2spell {
	
	/**
     * 汉字转拼音缩写，中文符号会转为*
     * @param str  要转换的汉字字符串
     * @return String  拼音缩写
     */
    public static final String getPYString(String str)
    {
    		if(str==null || str.replaceAll(" ", "").equals("") ){
    			return "";
    		}
    		str = str.replaceAll(" ", "");
            StringBuffer tempStr = new StringBuffer("");
            for(int i=0; i<str.length(); i++) {
                    char c = str.charAt(i);
                    if((int)c >= 33 && (int)c <=126) {//字母和符号原样保留
                            tempStr.append( String.valueOf(c) );
                    }
                    else {//累加拼音声母
                            tempStr.append( getPYChar( String.valueOf(c) ) );
                    }
            }
            return tempStr.toString();
    }

    /**
     * 取单个字符的拼音声母，中文符号会转为\*
     * @param c  要转换的单个汉字
     * @return String 拼音声母
     */
    public static final String getPYChar(String c)
    {
            byte[] array = new byte[2];
            array = String.valueOf(c).getBytes();
            int i = (short)(array[0] - '\0' + 256) * 256 + ((short)(array[1] - '\0' + 256));
            if ( i < 0xB0A1) return "_";
            if ( i < 0xB0C5) return "a";
            if ( i < 0xB2C1) return "b";
            if ( i < 0xB4EE) return "c";
            if ( i < 0xB6EA) return "d";
            if ( i < 0xB7A2) return "e";
            if ( i < 0xB8C1) return "f";
            if ( i < 0xB9FE) return "g";
            if ( i < 0xBBF7) return "h";
            if ( i < 0xBFA6) return "j";
            if ( i < 0xC0AC) return "k";
            if ( i < 0xC2E8) return "l";
            if ( i < 0xC4C3) return "m";
            if ( i < 0xC5B6) return "n";
            if ( i < 0xC5BE) return "o";
            if ( i < 0xC6DA) return "p";
            if ( i < 0xC8BB) return "q";
            if ( i < 0xC8F6) return "r";
            if ( i < 0xCBFA) return "s";
            if ( i < 0xCDDA) return "t";
            if ( i < 0xCEF4) return "w";
            if ( i < 0xD1B9) return "x";
            if ( i < 0xD4D1) return "y";
            if ( i < 0xD7FA) return "z";
            return "_";
    }
    
    public static void main(String[] args) {

		System.out.println( Char2spell.getPYString("军务处") );
	}
}
