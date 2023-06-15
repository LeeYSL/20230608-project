package controller;

 
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
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
		System.out.println("dbUser : " +dbUser);
		if(dbUser == null) {
			throw new LoginException("아이디 오류입니다.","login");
		}
		if(pwHash(user.getPw()).equals(dbUser.getPw())) {
			session.setAttribute("loginUser", dbUser);
			System.out.println("loginuser : " +session.getAttribute("loginUser"));
			mav.setViewName("redirect:userinfo?userId="+user.getUserId());
		} else {
			throw new LoginException("비밀번호 오류입니다.", "login");
		}
		return mav;
	}
	@RequestMapping("userinfo")
	public ModelAndView userinfo(String userId, HttpSession session) {
		ModelAndView mav = new ModelAndView();

//		user = (User)session.getAttribute("loginUser");	
//		System.out.println("loginuser info : " +session.getAttribute("loginUser"));
//		System.out.println(user);
//		mav.addObject("user",user);
//		System.out.println(user);
//		mav.setViewName("redirect:userintro?userId="+user.getUserId());
//		return mav;
		
		System.out.println(userId);
		User user = service.selectOne(userId);
		mav.addObject("user",user);
		return mav;
	}
	
	@PostMapping("update")
	public ModelAndView update (@Valid User user, BindingResult bresult, String userId, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			//reject 메서드 : global error에 추가
			bresult.reject("error.input.check");
			mav.setViewName("redirect:update?userId="+user.getUserId());
			return mav;
		}
		User loginUser = (User)session.getAttribute("loginUser");		
		if(!pwHash(user.getPw()).equals(loginUser.getPw())) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.pw");
			mav.setViewName("redirect:update?userId="+user.getUserId());
			return mav;
		}
		try {
			user.setPw(pwHash(user.getPw()));
			service.update(user);
			if(user.getUserId() == loginUser.getUserId()) {
				session.setAttribute("loginUser", user);
			}
			mav.setViewName("redirect:mypage?userid="+user.getUserId());
		} catch (Exception e) {
			e.printStackTrace();
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.update");
			mav.setViewName("redirect:update?userId="+user.getUserId());
			return mav;
			
		}
		
		return mav;
	}
	@GetMapping("update")
	public ModelAndView userupdate (String userId) {
		ModelAndView mav = new ModelAndView();
		User user =service.selectOne(userId);
		mav.addObject("user", user);
		return mav;
	}
	
	
	@PostMapping("delete")
	public String delete (User user, String userId, String pw, HttpSession session) {
		User loginUser = (User)session.getAttribute("loginUser");
		if(!pwHash(user.getPw()).equals(loginUser.getPw())) {
			throw new LoginException("비밀번호를 확인해 주세요.","delete?userId="+userId);
		}
		try {
		service.delete(userId);		
		session.invalidate();
		return "redirect:login";
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("탈퇴 실패","userinfo?userId="+userId);
			
		}
	}
	@RequestMapping("logout")
	public String logout (String userId, HttpSession session) {
		session.invalidate();
		return "redirect:login";
	}
}
