/*****************************************************
 *
 * 本类作者：杨建亮
 * 创建日期：2006-6-27
 *
 ****************************************************/
package com.yszoe.util;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail extends Authenticator {

	MailBean mailbean = null;

	public SendMail(){
		mailbean = new MailBean();
	}
	public static void main(String[] args) {
		SendMail s = new SendMail();
		s.sendMailFromDefaultConfig(false);
	}
	public String sendMailFromDefaultConfig(boolean stopIfConfigErr){
		try {
			readyMailConfig();
		} catch (IOException e) {
			System.out.println(this.getClass().getName()+"发邮件出错：");
			e.printStackTrace();
			if(stopIfConfigErr)return e.toString();
			else {
				mailbean = new MailBean();
				mailbean.setBody("邮件发送失败："+e.toString());
			}
		}
		
		String result=send();
		return result;
	}
	/**
	 * 通过读配置文件，准备发送邮件需要的信息
	 * @throws IOException 
	 * 
	 */
	public void readyMailConfig() throws IOException {

			PropertiesUtil properties = new PropertiesUtil("mail.properties");
			
			mailbean.setSmtphost(properties.getProperty("smtphost"));

			mailbean.setSender(properties.getProperty("sender"));

			mailbean.setUsername(properties.getProperty("username"));

			mailbean.setPassword(properties.getProperty("password"));

			mailbean.setAccepter(properties.getProperty("accepter"));

			mailbean.setSubject(properties.getProperty("subject"));

			mailbean.setBody(properties.getProperty("body"));
		
	}

	/**
	 * 发送邮件组件
	 * 
	 * @return
	 */
	public String send() {
		String result = null;
		// 以下为发送程序
		try {
			Properties props = new Properties();
			props.put("mail.smtp.host", mailbean.getSmtphost());
			props.put("mail.smtp.auth", "true");
			Session ssn = Session.getInstance(props, null);

			MimeMessage message = new MimeMessage(ssn);

			InternetAddress fromAddress = new InternetAddress(mailbean.getSender());
			message.setFrom(fromAddress);
			
			String[] accepter=mailbean.getAccepter().split(",");
			for(int i=0;i<accepter.length;i++){
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(accepter[i]));
			}

			message.setSubject(mailbean.getSubject());
			message.setText(mailbean.getBody());

			Transport transport = ssn.getTransport("smtp");
			transport.connect(mailbean.getSmtphost(), mailbean.getUsername(), mailbean.getPassword());
			transport.sendMessage(message, message
					.getRecipients(Message.RecipientType.TO));
			// transport.send(message);
			transport.close();
			result = "send ok!";
		} catch (MessagingException m) {
			result = m.toString();
		}
		return result;
	}

	public MailBean getMailbean() {
		return mailbean;
	}

	public void setMailbean(MailBean mailbean) {
		this.mailbean = mailbean;
	}
	
	public static class MailBean {

		// 以下变量为用户根据自己的情况设置
		private String smtphost = ""; // 发送邮件服务器

		private String sender = ""; // 发送人邮件地址

		private String username = ""; // 邮件服务器登录用户名

		private String password = ""; // 邮件服务器登录密码

		private String accepter = ""; // 接受人邮件地址

		private String subject = ""; // 邮件标题

		private String body = ""; // 邮件内容

		public String getBody() {
			return body;
		}

		public void setBody(String body) {
			this.body = body;
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

		public String getUsername() {
			return username;
		}

		public void setUsername(String username) {
			this.username = username;
		}
	}

}