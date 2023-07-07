package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;

@Component
@Aspect
public class BoardLoginAspect {
	@Before("execution(* controller.Board*.loginCheck*(..)) && args(..,session)")
	public void loginCheck(HttpSession session) throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser");
		String boardId = (String) session.getAttribute("boardId");
		if(loginUser == null) {
			throw new LoginException("로그인이 필요합니다.","../user/login");
		}
		if((boardId == "1") && (loginUser.getBatch()!=1)) {
			throw new LoginException("관리자만 사용가능합니다.","../board/list");
		}
	
	}
}