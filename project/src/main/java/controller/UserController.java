package controller;

 
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.ShopService;
import logic.User;
import util.CipherUtil;

@Controller
@RequestMapping("user")
public class UserController {
	@Autowired
	private ShopService service;
	@Autowired
	private CipherUtil util;
	
	
	@RequestMapping("*")
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}
	@PostMapping("join")
	public ModelAndView userAdd(@Valid User user, BindingResult bresult) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			//reject 메서드 : global error에 추가
			bresult.reject("error.input.check");
			return mav;
		}
		try {
			/*
			 * password : SHA-512 해쉬값 변경
			 */
		
			user.setPw(pwHash(user.getPw()));

			service.userInsert(user);	//db에 insert
			mav.addObject("user",user);
		}catch(DataIntegrityViolationException e) {
	//DataIntegrityViolationException : db에서 중복 key 오류시 발생되는 예외 객체
			e.printStackTrace();
			bresult.reject("error.duplicate.user"); //global 오류 등록
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		mav.setViewName("redirect:login");
		return mav;
		
	}
	private String pwHash(String pw) {
		try {
			return util.makehash(pw, "SHA-512");
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return null;
	}
	@PostMapping("login")
	public ModelAndView login(User user, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User dbUser = service.selectOne(user.getUserId());
		if(dbUser == null) {
			throw new LoginException("아이디 오류입니다.","login");
		}
		if(pwHash(user.getPw()).equals(dbUser.getPw())) {
			session.setAttribute("loginUser", dbUser);
			session.getAttribute("loginUser");
			System.out.println(session.getAttribute("loginUser"));
			mav.setViewName("redirect:userinfo?userId="+user.getUserId());
		} else {
			throw new LoginException("비밀번호 오류입니다.", "login");
		}
		return mav;
	}
	@RequestMapping("info")
	public ModelAndView userinfo(String userId, HttpSession session) {
		ModelAndView mav = new ModelAndView();
/*왜안되는지.
		user = (User)session.getAttribute("loginUser");		
		mav.addObject("user",user);
		System.out.println(user);
		mav.setViewName("redirect:userintro?userId="+user.getUserId());
		return mav;
*/
		User user = service.selectOne(userId);
		mav.addObject("user",user);
		return mav;
	}
	@PostMapping("delete")
	public String delete () {
		
		return "login";
	}
}
