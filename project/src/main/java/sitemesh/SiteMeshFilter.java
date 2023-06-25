package sitemesh;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

@WebFilter("/*")
public class SiteMeshFilter extends ConfigurableSiteMeshFilter {
	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain)
	//servletRequest 가 request 객체의 부모 클래스임
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)servletRequest;
		//형변환임
		String url = request.getRequestURI();
		//요청된 url 정보
		if(url.contains("/user/")) url = "user";
		if(url.contains("/admin/")) url = "user";
		else if(url.contains("/board/")) url="board";
		else if(url.contains("/item/")) url="item";
		else if(url.contains("/cart/")) url="item";
		else if(url.contains("/chat/")) url="chat";
		else url=""; //외에는 전부 빈문자열로 넣는다
		request.setAttribute("url", url); //속성 등록
		super.doFilter(servletRequest, servletResponse, filterChain);
		//다음 프로세스로 진행
	}

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		builder.addDecoratorPath("/*", "/layout/mainlayout.jsp")
		.addExcludedPath("/reservation/myList*")
		.addExcludedPath("/restaurant/restaurantadd*")
		.addExcludedPath("/ajax/*");
		
	}
}