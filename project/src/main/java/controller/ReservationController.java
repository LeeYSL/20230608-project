package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;

@Controller
@RequestMapping("reservation")
public class ReservationController {
	
	@RequestMapping("myList")
	public ModelAndView myList() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
}
