/*******************************************************
 *
 * 项目名称： 
 * 模块说明： 远程资源抓取
 * 本类作者： 杨建亮
 * 创建日期： 2006-5-20
 *
 ******************************************************/
package com.yszoe.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class CropNetSource implements Runnable {
	
	private static final Log log = LogFactory.getLog( CropNetSource.class );
	
//	private Mylog log = new Mylog( CropNetSource.class.getName() );
	
	private String cropurl = null;// 远程资源URL地址

	private String result = null;// 用于返回结果

	private boolean hasDone = false;// 标志是否完成
	
	private boolean hasErr = false;// 标志是否有错误

	private int execRetryTimes = 0, orderRetryTimes = 3;//已经执行的次数，允许执行的最大次数

	/**
	 * @return 返回 cropurl。
	 */
	public String getCropurl() {
		return cropurl;
	}

	/**
	 * @param cropurl 要设置的 cropurl。
	 */
	public void setCropurl(String cropurl) {
		this.cropurl = cropurl;
	}

	/**
	 * @return 返回 execRetryTimes。
	 */
	public int getExecRetryTimes() {
		return execRetryTimes;
	}

	/**
	 * @param execRetryTimes 要设置的 execRetryTimes。
	 */
	public void setExecRetryTimes(int execRetryTimes) {
		this.execRetryTimes = execRetryTimes;
	}

	/**
	 * @return 返回 hasDone。
	 */
	public boolean isHasDone() {
		return hasDone;
	}

	/**
	 * @param hasDone 要设置的 hasDone。
	 */
	public void setHasDone(boolean hasDone) {
		this.hasDone = hasDone;
	}

	/**
	 * @return 返回 hasErr。
	 */
	public boolean isHasErr() {
		return hasErr;
	}

	/**
	 * @param hasErr 要设置的 hasErr。
	 */
	public void setHasErr(boolean hasErr) {
		this.hasErr = hasErr;
	}

	/**
	 * @return 返回 orderRetryTimes。
	 */
	public int getOrderRetryTimes() {
		return orderRetryTimes;
	}

	/**
	 * @param orderRetryTimes 要设置的 orderRetryTimes。
	 */
	public void setOrderRetryTimes(int orderRetryTimes) {
		this.orderRetryTimes = orderRetryTimes;
	}

	/**
	 * @return 返回 result。
	 */
	public String getResult() {
		return result;
	}

	/**
	 * @param result 要设置的 result。
	 */
	public void setResult(String result) {
		this.result = result;
	}
	
	/**
     * 开一新线程，执行抓取远程资源
     * @param urlstr
     */
	public void cropInNewThread(String urlstr) {
		    this.cropurl=urlstr;
    		Thread t=new Thread(this);
    		t.setPriority(Thread.MIN_PRIORITY);
    		t.start();
	}
	
	public void run(){
        doCrop();
	}

    /**
     * 获得指定URL资源的同步方法
     *  
     */
	public void doCrop(){
        String currentLine=null;
        URL url=null;
        HttpURLConnection http=null;
    	InputStream urlstream=null;
        StringBuffer totalstring=new StringBuffer("");
        try {
        	url = new URL(cropurl);
        } catch (Exception ef) {
        	log.error("实例URL"+cropurl+"出错！=="+ef.getMessage());
        }
        log.info("执行抓取线程...");
        try {

            http = (HttpURLConnection) url.openConnection();
            http.setRequestProperty("User-Agent","Mozilla/4.0");//针对google的检查躲避
            System.setProperty("sun.net.client.defaultConnectTimeout","90000");//连接主机超时为90秒
            System.setProperty("sun.net.client.defaultReadTimeout","120000");//从主机读取数据超时为120秒
            
            http.connect();
            int isok=http.getResponseCode();
            if(isok != HttpURLConnection.HTTP_OK){
//                返回错误，doSomeThing
                log.error(cropurl+" 服务器返回错误："+isok+"；开始重新第"+execRetryTimes+"次抓取！");
                
                if(execRetryTimes<=orderRetryTimes){
//                    开始重试
                    execRetryTimes+=1;
                    doCrop();
                    log.error("重试第"+execRetryTimes+"次");
                }
                else{
//                    重试次数已过，标记该次抓取操作为失败！
                    hasErr=true;
                    return;
                }
            }
            urlstream = http.getInputStream();

        } catch (Exception ef) {
        	log.error("打开URL："+cropurl+" 出错！=="+ef.getMessage());
            if(execRetryTimes<=orderRetryTimes){
  //              开始重试
                  execRetryTimes+=1;
                  doCrop();
                  log.error("重试第"+execRetryTimes+"次");
              }
              else{
//              重试次数已过，标记该次抓取操作为失败！
                  this.hasErr=true;
                  return;
              }
        }

        try{
            BufferedReader l_reader = new BufferedReader(new java.io.InputStreamReader(urlstream,"UTF-8"));
            while ((currentLine = l_reader.readLine()) != null) {
                totalstring.append(currentLine).append("\n");
            }
            l_reader.close();
        } catch (IOException ex3) {
        	log.error("读取URL："+cropurl+" 代码出错！=="+ex3.getMessage());
            if(execRetryTimes<=orderRetryTimes){
//              开始重试
                  execRetryTimes+=1;
                  doCrop();
                  log.error("重试第"+execRetryTimes+"次");
              }
              else{
//              重试次数已过，标记该次抓取操作为失败！
                  hasErr=true;
                  return;
              }
        }

        // 本次搜索的结果已经放到totalstring中了，是一些HTML代码，需要下一步进行分析了。
        
        result=totalstring.toString();
        if(result!=null && !result.equals("")){
        	log.info("资源获取完成！"); 
        }
        hasDone=true;  
    }
	
	
}
