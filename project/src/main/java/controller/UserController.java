package controller;


import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import logic.ShopService;
import logic.User;

@Controller
@RequestMapping("user")
public class UserController {
	@Autowired
	private ShopService service;
	
	@RequestMapping("*")
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	@PostMapping("join")
	public ModelAndView useradd(@Valid User user, BindingResult bresult) {
		ModelAndView mav = new ModelAndView();
		service.userInesert(user);
		return mav;
		
	}
}
