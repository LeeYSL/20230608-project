package controller;

import java.security.Provider.Service;

import javax.mail.Session;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



import logic.Reservation;
import logic.ReservationSerivce;
import logic.User;

@Controller
@RequestMapping("reservation")
public class ReservationController {
	 @Autowired
	 private ReservationSerivce serive;
	 
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
	public ModelAndView reservation(@Valid Reservation reservation, BindingResult bresult, HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		User user = (User)session.getAttribute("loginUser");
		reservation.setUserId(user.getUserId());
	//	reservation.setRestNum(2);
		
		
		serive.bookinsert(reservation);
		mav.setViewName("redirect:list");
		
		
		return mav;
		
}
}
