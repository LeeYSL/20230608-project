package controller;

import java.net.http.HttpResponse;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServlet;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class UserController {

	@PostMapping("join")

	public ModelAndView join(HttpServlet servlet,HttpResponse response) {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
}
