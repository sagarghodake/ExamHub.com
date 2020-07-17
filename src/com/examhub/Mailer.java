package com.examhub;

import java.io.File;
import java.util.Properties;    
import javax.mail.*;    
import javax.mail.internet.*;

import javax.activation.*;  


public class Mailer{  
	 public static void main(String to,String user,String password,File file){  
		  
		  //1) get the session object     
		  
          Properties props = new Properties();    
          props.put("mail.smtp.host", "smtp.gmail.com");    
          props.put("mail.smtp.socketFactory.port", "465");    
          props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");    
          props.put("mail.smtp.auth", "true");    
          props.put("mail.smtp.port", "465");    

		  
		  Session session = Session.getDefaultInstance(props,  
		   new javax.mail.Authenticator() {  
		   protected PasswordAuthentication getPasswordAuthentication() {  
		   return new PasswordAuthentication(user,password);  
		   }  
		  });  
		     
		  //2) compose message     
		  try{  
		    MimeMessage message = new MimeMessage(session);  
		    message.setFrom(new InternetAddress(user));  
		    message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));  
		    message.setSubject("Examhub.com : Certificate Of Appreciation.");  
		      
		    //3) create MimeBodyPart object and set your message text     
		    BodyPart messageBodyPart1 = new MimeBodyPart();  
		    messageBodyPart1.setText("Dear Candidate,\r\n" + 
		    		" \r\n" + 
		    		"               Examhub.com is very pleased to inform that you have been Awarded a certificate of appreciation as you cleared our mock test with A Grade."
		    		+ "Looking forward  for more mock test attempts from your side , Keep Growing.!\r\n\n\n" + 
		    		"Good Luck with your prep !,\r\n" + 
		    		"Team Examhub.com \r\n" + 
		    		" \r\n" + 
		    		" " + 
		    		"");  
		      
		    //4) create new MimeBodyPart object and set DataHandler object to this object      
		    MimeBodyPart messageBodyPart2 = new MimeBodyPart();  
		  
		    DataSource source = new FileDataSource(file.getAbsolutePath());  
		    messageBodyPart2.setDataHandler(new DataHandler(source));  
		    messageBodyPart2.setFileName(file.getAbsolutePath());  
		     
		     
		    //5) create Multipart object and add MimeBodyPart objects to this object      
		    Multipart multipart = new MimeMultipart();  
		    multipart.addBodyPart(messageBodyPart1);  
		    multipart.addBodyPart(messageBodyPart2);  
		  
		    //6) set the multiplart object to the message object  
		    message.setContent(multipart );  
		     
		    //7) send message  
		    Transport.send(message);  
		   
		   System.out.println("message sent....");  
		   }catch (MessagingException ex) {ex.printStackTrace();}  
		 }  
		

	 public static void main(String fullname,String mailId,String msg){  
		  
		  //1) get the session object     
		  
         Properties props = new Properties();    
         props.put("mail.smtp.host", "smtp.gmail.com");    
         props.put("mail.smtp.socketFactory.port", "465");    
         props.put("mail.smtp.socketFactory.class",    
                   "javax.net.ssl.SSLSocketFactory");    
         props.put("mail.smtp.auth", "true");    
         props.put("mail.smtp.port", "465");    

		  
		  Session session = Session.getDefaultInstance(props,  
		   new javax.mail.Authenticator() {  
		   protected PasswordAuthentication getPasswordAuthentication() {  
		   return new PasswordAuthentication("examHub2020@gmail.com","ExamHub@2020");  
		   }  
		  });  
		     
		  //2) compose message     
		  try{  
		    MimeMessage message = new MimeMessage(session);  
		    message.setFrom(new InternetAddress("examhub2020@gmail.com"));  
		    message.addRecipient(Message.RecipientType.TO,new InternetAddress("examHub2020@gmail.com"));  
		    message.setSubject("Examhub.com : Message From Website");  
		      
		    //3) create MimeBodyPart object and set your message text     
		    BodyPart messageBodyPart1 = new MimeBodyPart();  
		    messageBodyPart1.setText("Dear Team,"
		    		+ "\n               A message from user on website.Following details :"
		    		+ "\n 1) Fullname : "+fullname+""
		    				+ "\n 2) mailId : "+mailId+""
		    						+ "\n 3) message : "+msg);  
		      
		    //5) create Multipart object and add MimeBodyPart objects to this object      
		    Multipart multipart = new MimeMultipart();  
		    multipart.addBodyPart(messageBodyPart1);  
		  
		    //6) set the multiplart object to the message object  
		    message.setContent(multipart );  
		     
		    //7) send message  
		    Transport.send(message);  
		   
		   System.out.println("message sent....");  
		   }catch (MessagingException ex) {ex.printStackTrace();}  
		 }  

	 
	 
}  
   

