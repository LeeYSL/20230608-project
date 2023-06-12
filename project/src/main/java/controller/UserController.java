package controller;



import javax.servlet.http.HttpServlet;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("user")
public class UserController {

	@RequestMapping("join")
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
}
