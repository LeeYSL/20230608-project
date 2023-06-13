package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;

import logic.Restaurant;
import logic.ShopService;

@Controller
@RequestMapping("restaurant")
public class RestaurantControlle {
	  
		@Autowired
		private ShopService service;
	  
	  @GetMapping("*") 
	  public ModelAndView add() {
		  ModelAndView mav = new ModelAndView();
		  mav.addObject(new Restaurant());
		  return mav;
	  }
	
	  
	@PostMapping("add")
	public ModelAndView restaurantadd() {
		ModelAndView mav = new ModelAndView();
		return mav;
	}

}
