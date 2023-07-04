package config;

import java.util.Properties;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.fasterxml.jackson.databind.ser.std.StdKeySerializers.Default;

//import interceptor.BoardInterceptor;

@Configuration //xml 방식의 설정을 대신 해주는 자바 클래스
@ComponentScan(basePackages={"controller","logic","dao","aop","websocket","util"}) // xml에서 context:component-scan 부분 : 객체화 하겠다.
@EnableAspectJAutoProxy //aop:aspectj-autoproxy 부분 : AOP 관련된 어노테이션을 쓰겠다.
@EnableWebMvc //유효성 검증 사용
public class MvcConfig implements WebMvcConfigurer {
	@Bean
	public HandlerMapping handlerMapping() { //요청 url 부분 처리
		RequestMappingHandlerMapping hm = new RequestMappingHandlerMapping();
		hm.setOrder(0);
		return hm;
	}
	@Bean
	public ViewResolver viewResolver() { //뷰 결정자
		InternalResourceViewResolver vr = new InternalResourceViewResolver();
		vr.setPrefix("/WEB-INF/view/");
		vr.setSuffix(".jsp");
		return vr;
	}

	@Bean
	//message.properties 파일의 코드값을 이용해서 message로 처리
	public MessageSource messageSource() {
		ResourceBundleMessageSource ms = new ResourceBundleMessageSource();
		ms.setBasename("messages"); // 오류 메시지 
		return ms;
		
	}
	@Bean
	//파일 업로드를 위한 설정 
	public MultipartResolver multipartResolver() {
		CommonsMultipartResolver mr = new CommonsMultipartResolver();
		mr.setMaxInMemorySize(10485760);//업로드 시 메모리 가능 크기 지정, ex_임시파일을 지정해서 가지고 있는데 10정도는 내가 가지고 쓰겠다?? 크키를 크게 하면 메인 메모리가 떨어짐?? 작게하면 성능은 떨어지지만 메인 메모리는 괜찮다?
		mr.setMaxUploadSize(104857600); //최대 업로드 가능 파일의 크기
		return mr;
		
	}
	@Bean
	//예외 처리 부분
	public SimpleMappingExceptionResolver exceptionResolver() {
		SimpleMappingExceptionResolver ser = new SimpleMappingExceptionResolver();
		Properties pr = new Properties();
		pr.put("exception.CartEmptyException","exception");// 발생 예외 클래스 , 호출되는 뷰 이름
		pr.put("exception.LoginException","exception");
		pr.put("exception.ReservationException","exception");
		pr.put("exception.BoardException","exception");
		ser.setExceptionMappings(pr);
		return ser;
	}
//	@Override
/////	인터셉터 관련 된 설정
//	public void addInterceptors(InterceptorRegistry registry) {
//		registry.addInterceptor(new BoardInterceptor())
//		.addPathPatterns("/board/write")
//		.addPathPatterns("/board/update")
//		.addPathPatterns("/board/delete");
//	}
	//기본 웹파일 처리를 위한 설정
	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable();
	}
	
	
    @Bean
    public static JavaMailSender mailSender() {
        JavaMailSenderImpl jms = new JavaMailSenderImpl();
        jms.setHost("smtp.naver.com");//google smtp 서버 설정(고정)
        jms.setPort(465);//네이버는 465(고정) //메일 포트587
        jms.setUsername("g2ve_jeong@naver.com");
        jms.setPassword("zheldcjswo");

	//세부사항
        Properties prop = new Properties();
        prop.setProperty("mail.smtp.starttls.enable", "true");
        prop.setProperty("mail.smtp.auth", "true"); 
 //       prop.setProperty("mail.transport.protocol", "smtp");
        prop.setProperty("mail.debug", "true");
 //       prop.setProperty("mail.smtp.ssl.trust", "smtp.gmail.com");
        prop.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
        prop.setProperty("mail.smtp.socketFactory.port", "465"); //
        prop.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); // 
        prop.setProperty("mail.smtp.socketFactory.fallback", "false"); // 
        jms.setJavaMailProperties(prop);

        return jms;
    }
	
	
}
