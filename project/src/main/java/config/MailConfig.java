//package config;
//
//import java.util.Properties;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.ComponentScan;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.mail.javamail.JavaMailSender;
//import org.springframework.mail.javamail.JavaMailSenderImpl;
//
//@Configuration
//@ComponentScan (basePackages={"controller"})
//public class MailConfig {
//    @Bean
//    public static JavaMailSender mailSender() {
//        JavaMailSenderImpl jms = new JavaMailSenderImpl();
//        jms.setHost("smtp.naver.com");//google smtp 서버 설정(고정)
//        jms.setPort(465);//네이버는 465(고정) //메일 포트587
//        jms.setUsername("jjeongjuri@naver.com");
//        jms.setPassword("qlalfqjsgh0408");
//
//	//세부사항
//        Properties prop = new Properties();
//        prop.setProperty("mail.smtp.starttls.enable", "true");
//        prop.setProperty("mail.smtp.auth", "true"); 
// //       prop.setProperty("mail.transport.protocol", "smtp");
//        prop.setProperty("mail.debug", "true");
// //       prop.setProperty("mail.smtp.ssl.trust", "smtp.gmail.com");
//        prop.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
//        prop.setProperty("mail.smtp.socketFactory.port", "465"); //
//        prop.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); // 
//        prop.setProperty("mail.smtp.socketFactory.fallback", "false"); // 
//        jms.setJavaMailProperties(prop);
//
//        return jms;
//    }
//}