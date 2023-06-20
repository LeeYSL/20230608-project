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

import logic.Reservation;
import logic.ReservationService;

import logic.User;

@Controller
@RequestMapping("reservation")
public class ReservationController {
	@Autowired
	private ReservationService service;

	@GetMapping("*")
	public ModelAndView add() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Reservation());
		return mav;
	}

	@PostMapping("reservationadd")
	public ModelAndView reservation(@Valid Reservation reservation, BindingResult bresult, HttpSession session)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		System.out.println("????");
		if (bresult.hasErrors()) {
			System.out.println("error");
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.reservation");
			bresult.reject("error.input.check");
			return mav;
		}
		try {
			User user = (User) session.getAttribute("loginUser");
			reservation.setUserId(user.getUserId());
			reservation.setRestNum(2); // 가게번호
			// reservation.setConfirm(1); // 확정여부-예약대기(1)로 고정
			service.bookinsert(reservation);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mav.setViewName("redirect:myList");
		return mav;

	}

	@RequestMapping("myList")
	public ModelAndView myList(@RequestParam Map<String, Object> param, HttpSession session) { // key,value 둘 다 // map으로
																								// 전달해라
		ModelAndView mav = new ModelAndView();

		User user = (User) session.getAttribute("loginUser");

//		if(user != null && user.getUserId().equals(ownerList(param, session))){

		List<Reservation> rsrvtList = service.myList(user.getUserId()); // reservation에 있는 정보를 list로 저장, 로그인 되어 있는 id를
																		// 가지고 리스트를 조회하러가라
		mav.addObject("rsrvtList", rsrvtList); // jsp에서 items="${rsrvtList} 랑 이름 맞춰줘야 됨
//		}

		return mav;
	}

	@RequestMapping("ownerList") 
	public ModelAndView ownerList(@RequestParam Map<String, Object> param, HttpSession session) {
	  	ModelAndView mav = new ModelAndView();
	
		  
		  User user = (User)session.getAttribute("loginUser");
		
		  List<Reservation> rsrvtList = service.ownerList(user.getUserId()); 
		  mav.addObject("rsrvtList",rsrvtList);
	
	      return mav;
	}
  
	@PostMapping("myListInfo") 
	public ModelAndView myListInfo(@Valid Reservation reservation, BindingResult bresult,HttpSession session,Integer num) {
		ModelAndView mav = new ModelAndView();
				
		User user = (User)session.getAttribute("loginUser");
		
		
		if (bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.reservation");
			return mav;
		}
		if(user.getUserId() != null) {
			System.out.println("1"+user.getUserId());
			Reservation reservation2  = service.selectOne(num); // 이렇게 해서 reservation2로 보내줘도 됨
			service.selectOne(num);
			service.myListUpdate(reservation);
		    mav.addObject("rsrvt",reservation2);
		    System.out.println("2"+reservation2.getNum());
			mav.setViewName("redirect:myListInfo?id="+reservation2.getNum());
		
		}
	return mav;
	}
	  @GetMapping("myListInfo")
  	public ModelAndView myListInfo (Integer num,Reservation reservatio) {
  	ModelAndView mav = new ModelAndView();
  	Reservation reservation2  = service.selectOne(num);
  	mav.addObject("rsrvt",reservation2);
  	mav.setViewName("redirect:myListInfo?id="+reservation2.getNum());
  	return mav;
  }
  
}