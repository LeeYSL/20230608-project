package controller;


import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import logic.Board;
import logic.UserService;
import util.CipherUtil;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired
	private UserService userservice;
	@Autowired
	private CipherUtil util;
	
	
	@RequestMapping("*")
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Board());
		return mav;
	}

}
