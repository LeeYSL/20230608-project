package aop;

import javax.servlet.http.HttpSession;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import exception.LoginException;
import logic.User;

@Component
@Aspect
public class UserLoginAspect {
	@Before("execution(* controller.User*.idCheck*(..)) && args(..,userId,session)")
	public void idCheck(String userId, HttpSession session)throws Throwable {
		User loginUser = (User)session.getAttribute("loginUser");
		if(loginUser == null) {
			throw new LoginException("로그인이 필요합니다.","../user/login");
		}
		if((loginUser.getBatch() != 1) && (!loginUser.getUserId().equals(userId))   ) {
			throw new LoginException("본인만 사용가능합니다.","../board/list");
			
		}
	}
	@Before("execution(* controller.User*.loginCheck*(..)) && args(..,session)")
	public void loginCheck(HttpSession session) throws Throwable{
		User loginUser = (User)session.getAttribute("loginUser");
		
		if(loginUser == null) {
			throw new LoginException("로그인이 필요합니다.","../user/login");
		}
	}
}