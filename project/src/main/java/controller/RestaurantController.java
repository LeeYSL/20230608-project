package controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;

import logic.Restaurant;
import logic.ShopService;
import lombok.val;

@Controller
@RequestMapping("restaurant")
public class RestaurantController {
	  
		@Autowired
		private ShopService service;
	  
	  @GetMapping("*") 
	  public ModelAndView add() {
		  ModelAndView mav = new ModelAndView();
		  mav.addObject(new Restaurant());
		  return mav;
	  }
	
	  
	@PostMapping("restaurantadd")
	public ModelAndView restaurantAdd(@Valid Restaurant restaurant, BindingResult bresult) throws Exception {
		System.out.println("??????");
		ModelAndView mav = new ModelAndView();
		if (bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.restaurant");
			bresult.reject("error.input.check");
			return mav;
					
		}
		try {
			restaurant.setUserId("test1");
			restaurant.setRestNum(1);
			service.restauinsert(restaurant);
			mav.addObject("restaurant",restaurant);
			
		}catch (Exception e) {
			 e.printStackTrace();
			 
		}
		mav.setViewName("redirect:list");
		return mav;
	}

}
