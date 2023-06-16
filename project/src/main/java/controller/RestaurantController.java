package controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


import logic.ReservationSerivce;
import logic.Restaurant;
import logic.User;

@Controller
@RequestMapping("restaurant")
public class RestaurantController {
	  
		@Autowired
		private ReservationSerivce service;
	  
	  @GetMapping("*") 
	  public ModelAndView add() {
		  ModelAndView mav = new ModelAndView();
		  mav.addObject(new Restaurant());
		  return mav;
	  }
	
	  
	@PostMapping("restaurantadd")
	public ModelAndView restaurantAdd(@Valid Restaurant restaurant, BindingResult bresult,HttpSession session) throws Exception {

		ModelAndView mav = new ModelAndView();
		if (bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.restaurant");
			bresult.reject("error.input.check");
			return mav;
					
		}
		try {
			User user = (User)session.getAttribute("loginUser"); 
			restaurant.setUserId(user.getUserId());
			restaurant.setRestNum(1);
			//가게정보 저장
			service.restauinsert(restaurant);
			
			restaurant.getDayoff().setRestNum(1);
			restaurant.getDayoff().setUserId(user.getUserId());
			//휴무일 저장
			service.dayoffInsert(restaurant.getDayoff());
			mav.addObject("restaurant",restaurant);
			
		}catch (Exception e) {
			 e.printStackTrace();
			 
		}
		mav.setViewName("redirect:list");
		return mav;
	}

}
