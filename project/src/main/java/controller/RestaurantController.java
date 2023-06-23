package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import logic.ReservationService;
import logic.Restaurant;
import logic.Menu;
import logic.User;

@Controller
@RequestMapping("restaurant")
public class RestaurantController {

	@Autowired
	private ReservationService service;

	@GetMapping("*")
	public ModelAndView add() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Restaurant());
		return mav;
	}

	@PostMapping("restaurantadd")
	public ModelAndView restaurantAdd(@Valid Restaurant restaurant, BindingResult bresult, HttpSession session)
			throws Exception {
		System.out.println("rest : " + restaurant);
		ModelAndView mav = new ModelAndView();
		if (bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.restaurant");
			bresult.reject("error.input.check");
			return mav;

		}
		try {
			User user = (User) session.getAttribute("loginUser");
			restaurant.setUserId(user.getUserId());

			// restaurant 시퀀스 받아옴
			int num = service.maxSelect().getRestNum();
			// 가게정보 저장
			restaurant.setRestNum(num);
			service.restauInsert(restaurant);

			// 휴무일 저장
			restaurant.getDayoff().setRestNum(num);
			service.dayoffInsert(restaurant.getDayoff());

			// 메뉴 저장
			for (Menu menu : restaurant.getMenuList()) {
				menu.setRestNum(num); // restNum 세팅해줌.
				service.menuInsert(menu); // 메뉴 개수만큼 insert해줌.
			}
			mav.addObject("restaurant", restaurant);

		} catch (Exception e) {
			e.printStackTrace();

		}
		mav.setViewName("/reservation/myList");
		return mav;
	}

	@RequestMapping("restaurantList")
	ModelAndView restList(@RequestParam Map<String, Object> param, HttpSession session) {
		ModelAndView mav = new ModelAndView();
//		String type = param.get("type");
//		String searchcontent = param.get("searchcontent");

//		if (type == null || type.trim().equals("") || searchcontent == null || searchcontent.trim().equals("")) {
//			type = null;
//			searchcontent = null;

		List<Restaurant> restList = service.restList();
		System.out.println(restList);

		mav.addObject("restList", restList);

		return mav;
	}

	@RequestMapping("ownerRest") 
	public ModelAndView ownerRest(HttpSession session,Restaurant restaurant) { 
		ModelAndView mav = new ModelAndView();
     
		User user = (User) session.getAttribute("loginUser");
 
		 List<Restaurant> ownerRest = service.ownerRest(user.getUserId());
	
		 mav.addObject("ownerRest",ownerRest);
		 return mav;
	}
}
