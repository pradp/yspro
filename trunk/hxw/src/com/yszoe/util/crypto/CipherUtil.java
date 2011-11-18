package com.yszoe.util.crypto;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

/**
 * 加密、解密工具类（对称加密）
 * 使用AES算法，提供生成KEY方法，以后用此KEY来加密解密字符串。
 * @author Yangjianliang datetime 2009-8-17
 */
public class CipherUtil {
	
	private static final Log log = LogFactory.getLog(CipherUtil.class);

	/**
	 * DES升级版
	 */
	public static final String KEY_AES = "AES";//"算法/模式/补码方式"
	
	/**
	 * 初始化HMAC密钥
	 * 
	 * @return
	 * @throws Exception
	 */
	public static String getAESKeyAsString(){
		SecretKey secretKey = getAESKey();//生成密匙，可用多种方法来保存密匙
		return encryptBASE64(secretKey.getEncoded());
	}

	/**
	 * 取得一个AES加密算法的KEY
	 * @return 一个AES加密算法的KEY。SecretKey对象
	 * @throws Exception
	 */
	public static SecretKey getAESKey(){
		KeyGenerator keyGenerator;
		SecretKey secretKey = null;
		try {
			keyGenerator = KeyGenerator.getInstance(KEY_AES);//获取密匙生成器
			keyGenerator.init(128); //初始化
			//DES算法必须是56位
			//DESede算法可以是112位或168位
			//AES算法可以是128、192、256位
			//192 and 256 bits may not be available
			secretKey = keyGenerator.generateKey();//生成密匙，可用多种方法来保存密匙
		} catch (NoSuchAlgorithmException e) {
			log.error(e);
		}
		return secretKey;
	}

	/**
	 * 用AES算法加密
	 * @param src_msg 消息原文
	 * @param key 加密用的KEY
	 * @return 加密后的密文
	 */
	public static String encryptByAES(String src_msg, String key){
		if(src_msg==null || src_msg.equals("")){
			return src_msg;
		}
		Cipher cipher;
		byte[] encrypted = null;
		try {
			cipher = Cipher.getInstance(KEY_AES);//创建密码器
			// Generate the secret key specs.
			byte[] raw = decryptBASE64(key);
			SecretKeySpec skeySpec = new SecretKeySpec(raw, KEY_AES);
			cipher.init(Cipher.ENCRYPT_MODE, skeySpec);

			encrypted = cipher.doFinal(src_msg.getBytes(DigestUtil.ENCODE_TYPE));
			
		} catch (NoSuchAlgorithmException e) {
			log.error(e);
		} catch (NoSuchPaddingException e) {
			log.error(e);
		} catch (InvalidKeyException e) {
			log.error(e);
		} catch (IllegalBlockSizeException e) {
			log.error(e);
		} catch (BadPaddingException e) {
			log.error(e);
		} catch (UnsupportedEncodingException e) {
			log.error(e);
		} catch (IOException e) {
			log.error(e);
		} 

		String encryptedstr = DigestUtil.asHex(encrypted);
		return encryptedstr;
	}
	
	/**
	 * 用AES算法解密
	 * @param crypt 密文
	 * @param key AES KEY
	 * @return 解密后的原文
	 */
	public static String decryptByAES(String crypt, String key) {
		if(crypt==null || crypt.equals("")){
			return crypt;
		}
		Cipher cipher;
		byte[] original = null;
		try {
			cipher = Cipher.getInstance(KEY_AES); //创建密码器
			// Generate the secret key specs.
			byte[] raw = decryptBASE64(key);
			SecretKeySpec skeySpec = new SecretKeySpec(raw, KEY_AES);
			cipher.init(Cipher.DECRYPT_MODE, skeySpec);
			original = cipher.doFinal(DigestUtil.asBin(crypt));
			
		} catch (NoSuchAlgorithmException e) {
			log.error(e);
		} catch (NoSuchPaddingException e) {
			log.error(e);
		} catch (InvalidKeyException e) {
			log.error(e);
		} catch (IllegalBlockSizeException e) {
			log.error(e);
		} catch (BadPaddingException e) {
			log.error(e);
		} catch (IOException e) {
			log.error(e);
		}
		String decryptedStr = new String(original);
//		String decryptedStr = DigestUtil.asHex(original);

		return decryptedStr;
	}
	
	/**
	 * BASE64解密
	 * 
	 * @param key
	 * @return 解密后取得的原文字节数组
	 * @throws IOException 
	 * @throws Exception
	 */
	public static byte[] decryptBASE64(String key) throws IOException{

		return (new BASE64Decoder()).decodeBuffer(key);
	}

	/**
	 * BASE64加密
	 * 
	 * @param key
	 * @return 加密后的字符串
	 * @throws Exception
	 */
	public static String encryptBASE64(byte[] key){
		return (new BASE64Encoder()).encodeBuffer(key);
	}

	public static void main(String[] args){
		String yuan = "测试被加密的字符串";
		log.info(yuan);
		String key = getAESKeyAsString();
//		String key = "KKLd4kXp9URTnRBzc5123456";
		log.info("key: " + key);
		String mi = encryptByAES(yuan, key);
		log.info("加密: " + mi);
		
//		String mi = "4afb90dd6ab2035b755e8f7e05aecb22955ef2cb6bdcd5d25ab92aeef1dea5e3";
		String ming = decryptByAES(mi, key);
		log.info("解密: " + ming);
		
	}
}
