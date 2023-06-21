package controller;

 
import java.security.NoSuchAlgorithmException;
import java.util.List;

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
import logic.Board;
import logic.Comment;
import logic.User;
import logic.UserService;
import util.CipherUtil;

@Controller
@RequestMapping("user")
public class UserController {
	@Autowired
	private UserService userservice;
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
		User dbUser = userservice.selectOne(user.getUserId());
		try {
			/*
			 * password : SHA-512 해쉬값 변경
			 */
			if(dbUser != null) {
				mav.getModel().putAll(bresult.getModel());
				bresult.reject("error.duplicate.userId");
				return mav;
			}
			if(!user.getPw().equals(user.getPw1())) {
				mav.getModel().putAll(bresult.getModel());
				bresult.reject("error.pw.check"); //global 오류 등록
				return mav;
			}
			user.setPw(pwHash(user.getPw()));
			userservice.userInsert(user);	//db에 insert
			mav.addObject("user",user);
		}catch(DataIntegrityViolationException e) {
	//DataIntegrityViolationException : db에서 중복 key 오류시 발생되는 예외 객체
			e.printStackTrace();
			bresult.reject("error.pw.check"); //global 오류 등록
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
		User dbUser = userservice.selectOne(user.getUserId());
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
		User user = userservice.selectOne(userId);
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
			userservice.update(user);
			if(user.getUserId() == loginUser.getUserId()) {
				session.setAttribute("loginUser", user);
			}
			mav.setViewName("redirect:mypage?userId="+user.getUserId()); 
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
		User user =userservice.selectOne(userId);
		user.setPw(null);
		mav.addObject("user", user);
		return mav;
	}
	
	
	@PostMapping("delete")
	public String delete (String userId, String pw, String pw1, HttpSession session) {
		User loginUser = (User)session.getAttribute("loginUser");		

		try {
			if(pw.equals(pw1) || (loginUser.getPw() == pwHash(pw))) {
				System.out.println("loginUser.getUserId()"+loginUser.getUserId());
				userservice.delete(loginUser.getUserId());			
				session.invalidate();
				System.out.println("loginUser.getUserId()"+loginUser.getUserId());

				return "redirect:login";
			}else {
				throw new LoginException("비밀번호가 일치하지 않습니다.","delete?userId="+loginUser.getUserId());			
			}
		} catch (Exception e) {
			throw new LoginException("탈퇴 실패","userinfo?userId="+loginUser.getUserId());
		}
	}
	@RequestMapping("logout")
	public String logout (String userId, HttpSession session) {
		session.invalidate();
		return "redirect:login";
	}
	
	@RequestMapping("list")
	public ModelAndView list (HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<User> list = userservice.list();  
		mav.addObject("list",list);
		return mav;
	}
	@RequestMapping("mypage")
	public ModelAndView mypage(String userId, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<Board> myblist = userservice.myblist(userId);
		mav.addObject("myblist",myblist);
		
		List<Comment> myclist =userservice.myclist(userId);
		mav.addObject("myclist",myclist);
		
		
		return mav;
		
	}
}
