package com.yszoe.util;

import java.io.IOException;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 邮件发送类
 * @author Yangjianliang
 * datetime 2011-8-15
 */
public class SendMail extends Authenticator {

	private static final Log LOG = LogFactory.getLog(SendMail.class);
	
	MailConfig mailConfig = null;
	MailTemplate mailTemplate = null;
	
	ResourceBundle properties = ResourceBundle.getBundle("mail");
	
	public SendMail(){
		mailConfig = new MailConfig();
		mailTemplate = new MailTemplate();
	}

	public String sendMailFromDefaultConfig(boolean stopIfConfigErr){

		readyMailConfig();
		String result=send();
		return result;
	}

	/**
	 * 通过读配置文件，准备发送邮件需要的信息
	 * @throws IOException 
	 */
	public void readyMailConfig(){

		mailConfig.setSmtphost(properties.getString("smtphost"));
		mailConfig.setSmtpport( Integer.parseInt( properties.getString("smtpport") ) );
		mailConfig.setSender(properties.getString("sender"));
		mailConfig.setUsername(properties.getString("username"));
		mailConfig.setPassword(properties.getString("password"));

		mailTemplate.setAccepter(properties.getString("accepter"));
		mailTemplate.setSubject(properties.getString("subject"));
		mailTemplate.setBody(properties.getString("body"));
		
	}

	/**
	 * 发送邮件组件
	 * @return 错误的邮件地址和发送错误信息
	 */
	public String send() {
		
		String[] emails = checkEmails(mailTemplate.getAccepter());
		String safeAccepters = emails[0];
		String errorAccepters = emails[1];
		
		Transport transport = null;
		// 以下为发送程序
		try {
			Properties props = new Properties();
			props.put("mail.smtp.host", mailConfig.getSmtphost());
			props.put("mail.smtp.auth", "true");
			Session ssn = Session.getInstance(props, null);

			MimeMessage message = new MimeMessage(ssn);

			InternetAddress fromAddress = new InternetAddress(mailConfig.getSender());
			message.setFrom(fromAddress);
			
			String[] accepter = safeAccepters.split(",");
			for(int i=0;i<accepter.length;i++){
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(accepter[i]));
			}

			message.setSubject(mailTemplate.getSubject(), "utf-8");
//			message.setText(mailTemplate.getBody());
			message.setContent(mailTemplate.getBody(), "text/html; charset=utf-8"); 
//			message.saveChanges();
			transport = ssn.getTransport("smtp");
			transport.connect(mailConfig.getSmtphost(), mailConfig.getSmtpport(), mailConfig.getUsername(), mailConfig.getPassword());
			transport.sendMessage( message, message.getRecipients(Message.RecipientType.TO) );
			// transport.send(message);
		} catch (MessagingException m) {
			errorAccepters += "\n" + m.toString();
		} finally{
			if(transport!=null){
				try {
					transport.close();
				} catch (MessagingException e) {
					LOG.error(e);
				}
			}
		}
		return errorAccepters;
	}

	/**
	 * 邮件发送接口。 异常为运行时异常。
	 * 邮件发送可能造成延时，所以开启新线程发送。
	 * @param accepters 邮件接收人邮箱地址。多个邮箱中间用英文逗号隔开即可。
	 * @return 返回String[2]数组，String[0]里是格式正确的邮箱地址。String[1]里是格式不正确的邮箱地址。
	 */
	public static final String[] checkEmails(String accepters){
		
		if(StringUtils.isBlank(accepters)){
			throw new RuntimeException("接收人邮箱地址不能为空！");
		}
		//收信人邮箱地址格式验证。 
		String[] as = accepters.split(",");
		StringBuffer safeAccepters = new StringBuffer("");//正确的发送
		StringBuffer errorAccepters = new StringBuffer("");//错误地址不发送，返回给用户
		for(String accepter : as){
			if(checkEmail(accepter)){
				safeAccepters.append(accepter).append(",");
			}else{
				errorAccepters.append(accepter).append(",");
			}
		}
		if(safeAccepters.length()>1){
			safeAccepters.deleteCharAt(safeAccepters.length()-1);
		}
		if(errorAccepters.length()>1){
			errorAccepters.deleteCharAt(errorAccepters.length()-1);
		}
		String[] res = new String[2];
		res[0] = safeAccepters.toString();
		res[1] = errorAccepters.toString();
		return res;
	}
	
	/**
	 * 邮箱地址验证
	 * @param email 待验证地址
	 * @return 地址正确返回true，错误返回false
	 */
	public static boolean checkEmail(String email){
	//	String p = "\\w+(\\.\\w+)*@\\w+(\\.\\w+)+";
		String p="^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$";
		
		//String check = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
		Pattern regex = Pattern.compile( p );
		Matcher matcher = regex.matcher( email );
		boolean isMatched = matcher.matches();
		return isMatched;
	}

	
	public static class MailConfig {

		// 以下变量为用户根据自己的情况设置
		private String smtphost = ""; // 发送邮件服务器
		private int smtpport = 25; // 发送邮件服务器端口
		private String sender = ""; // 发送人邮件地址
		private String username = ""; // 邮件服务器登录用户名
		private String password = ""; // 邮件服务器登录密码

		public int getSmtpport() {
			return smtpport;
		}

		public void setSmtpport(int smtpport) {
			this.smtpport = smtpport;
		}

		public String getSender() {
			return sender;
		}

		public void setSender(String sender) {
			this.sender = sender;
		}

		public String getPassword() {
			return password;
		}

		public void setPassword(String password) {
			this.password = password;
		}

		public String getSmtphost() {
			return smtphost;
		}

		public void setSmtphost(String smtphost) {
			this.smtphost = smtphost;
		}

		public String getUsername() {
			return username;
		}

		public void setUsername(String username) {
			this.username = username;
		}
	}

	public static class MailTemplate {

		private String accepter = ""; // 接受人邮件地址
		private String subject = ""; // 邮件标题
		private String body = ""; // 邮件内容

		public String getBody() {
			return body;
		}

		public void setBody(String body) {
			this.body = body;
		}

		public String getSubject() {
			return subject;
		}

		public void setSubject(String subject) {
			this.subject = subject;
		}

		public String getAccepter() {
			return accepter;
		}

		public void setAccepter(String accepter) {
			this.accepter = accepter;
		}

	}
	
	public MailConfig getMailConfig() {
		return mailConfig;
	}

	public void setMailConfig(MailConfig mailConfig) {
		this.mailConfig = mailConfig;
	}

	public MailTemplate getMailTemplate() {
		return mailTemplate;
	}

	public void setMailTemplate(MailTemplate mailTemplate) {
		this.mailTemplate = mailTemplate;
	}

	public static void main(String[] args) {
		SendMail sm = new SendMail();
		sm.readyMailConfig();
		MailTemplate mailTemplate = sm.getMailTemplate();
		mailTemplate.setSubject("testTitle");
		mailTemplate.setAccepter("yszoe@qq.com");
		sm.setMailTemplate(mailTemplate);
		sm.send();
	}
}