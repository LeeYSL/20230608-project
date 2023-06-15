package controller;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



import logic.Reservation;

@Controller
@RequestMapping("reservation")
public class ReservationController {
	 @GetMapping("*") 
	  public ModelAndView add() {
		  ModelAndView mav = new ModelAndView();
		  mav.addObject(new Reservation());
		  return mav;
}
	
	@RequestMapping("myList")
	public ModelAndView myList() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}
	@RequestMapping("reservationadd")
	public ModelAndView reservation(@Valid Reservation reservation, BindingResult bresult) throws Exception {
		ModelAndView mav = new ModelAndView();
		return mav;
}
}
