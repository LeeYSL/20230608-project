package controller;


import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
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
	
	@PostMapping("write")
	public ModelAndView write(@Valid Board board, BindingResult bresult ,HttpSession session) {
		ModelAndView mav = new ModelAndView();
	
		
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		try {
			userservice.write(board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return mav;
	}

}
