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
import logic.Dayoff;
import logic.Menu;
import logic.Reservation;
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
			service.restauInsert(restaurant, session);

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
		// 수정 필요 , 가게 등록 후 화면 이동하는 곳 바꾸기
		mav.setViewName("redirect:ownerRest");
		System.out.println("rest : " + restaurant);
		return mav;
	}

	@RequestMapping("restaurantList")
	ModelAndView restList(@RequestParam Map<String, String> param, HttpSession session, String delYn,Restaurant restaurant,Reservation reservation) {
		ModelAndView mav = new ModelAndView();

		Integer pageNum = null;
		if (param.get("pageNum") != null)
			pageNum = Integer.parseInt(param.get("pageNum"));
		String type = param.get("type");
		String searchcontent = param.get("searchcontent");

		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (type == null || type.trim().equals("") || searchcontent == null || searchcontent.trim().equals("")) {
			type = null;
			searchcontent = null;
		}

		int limit = 10;
		int restListcount = service.restListcount(type, searchcontent);
		
	    int num = restaurant.getRestNum();
	    
		//Integer pointNum = service.PointAvg(num);
		
		List<Restaurant> restList = service.restList(pageNum, limit, type, searchcontent, delYn);
		for(Restaurant rest : restList) {
			rest.setPoint(service.PointAvg(rest.getRestNum()));
		}
//		for(int i = 0; i < restList.size(); i++) {
//			Restaurant rest = restList.get(i);
//		}
		int maxpage = (int) ((double) restListcount / limit + 0.95);// 등록 건수에 따른 최대 페이지
		int startpage = (int) ((pageNum / 10.0 + 0.9) - 1) * 10 + 1;// 페이지의 시작 번호
		int endpage = startpage + 9; // 화면에 보여줄 페이지 끝 번호
		if (endpage > maxpage)
			endpage = maxpage; // 페이지의 끝 번호는 최대 페이지 클 수 없다.

		// System.out.println("1"+pageNum);
		// System.out.println("2"+restListcount);
		// System.out.print("3"+restList);
		// System.out.println("4"+maxpage);
		// System.out.println("5"+startpage);
		// System.out.println("6"+endpage);

		mav.addObject("pageNum", pageNum);
		mav.addObject("restList", restList);
		mav.addObject("restListcount", restListcount);
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		//mav.addObject("pointNum", pointNum);

		return mav;
	}

	@GetMapping("ownerRest")
	public ModelAndView ownerRest(HttpSession session, Restaurant restaurant) {
		ModelAndView mav = new ModelAndView();

		User user = (User) session.getAttribute("loginUser");

		List<Restaurant> ownerRest = service.ownerRest(user.getUserId(), restaurant.getDelYn());

		mav.addObject("ownerRest", ownerRest);

		return mav;
	}

	@PostMapping("ownerRest")
	public ModelAndView ownerRest(Restaurant restaurant, String delYn, int num) {
		ModelAndView mav = new ModelAndView();

		service.deleteRest(delYn, num);
		System.out.println(num);

		mav.addObject("deleteRest", num);
		System.out.println(num);

		return mav;

	}

	@GetMapping("restaurantInfo")
	public ModelAndView restaurantInfo(Restaurant restaurant, int num) {
		// 가게리스트에서 이동할 때 보낸 num을 사용한다.
		ModelAndView mav = new ModelAndView();

		Restaurant restInfo = service.restInfo(num);
		List<Menu> memuList = service.menuList(num);
		Dayoff dayoff = service.dayoffList(num);
		Integer pointNum = service.PointAvg(num);

		restaurant.setRestNum(num);

		System.out.println("restaurant" + restaurant.getRestNum());

		mav.addObject("pointNum", pointNum);
		System.out.println("pointNum :" + pointNum);
		mav.addObject("dayoff", dayoff);
		mav.addObject("memuList", memuList);
		mav.addObject("restInfo", restInfo);

		return mav;
	}

	@PostMapping("review")
	public ModelAndView review() {
		ModelAndView mav = new ModelAndView();

		return mav;

	}

	@GetMapping("restUpdate")
	public ModelAndView restInfo(Restaurant restaurant, int num) {
		ModelAndView mav = new ModelAndView();

		Restaurant restInfo = service.restInfo(num);
		Dayoff dayoff = service.dayoffList(num);
		List<Menu> memuList = service.menuList(num);

		System.out.println(restInfo);

		mav.addObject("restInfo", restInfo);
		mav.addObject("dayoff", dayoff); // jsp에서 dayoff 받는게 없는데 어떻게 쓰나?
		mav.addObject("memuList", memuList);

		return mav;
	}

	@PostMapping("restUpdate")
	public ModelAndView restUpdate(@Valid Restaurant restaurant, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		if (bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.restaurant");
			bresult.reject("error.input.check");
			return mav;

		}
		int num = restaurant.getRestNum();
		// 가게정보 업데이트
		service.restUpdate(restaurant, session);

		// 휴무일 삭제하고 insert
		service.deleteDayoff(num);
		restaurant.getDayoff().setRestNum(num);
		service.dayoffInsert(restaurant.getDayoff());

		// 메뉴 삭제하고 insert
		service.deleteMenu(num);
		for (Menu menu : restaurant.getMenuList()) {
			menu.setRestNum(num); // restNum 세팅해줌.
			service.menuInsert(menu); // 메뉴 개수만큼 insert해줌.
		}

		mav.setViewName("redirect:restUpdate?num=" + num);
		return mav;
	}

}
