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

	@RequestMapping("myList")
	public ModelAndView myList() {
		ModelAndView mav = new ModelAndView();
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
			reservation.setRestNum(1); // 가게번호
			reservation.setConfirm(1); // 확정여부-예약대기(1)로 고정
			service.bookinsert(reservation);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mav.setViewName("redirect:list");
		return mav;

	}

	@RequestMapping("ownerList")
	public ModelAndView ownerList(@RequestParam Map<String, Object> param, HttpSession session) { // key,value 둘 다
																									// map으로 전달해라
		ModelAndView mav = new ModelAndView();

		List<Reservation> rsrvtList = service.rsrvtList(); // reservation에 있는 정보를 list로 저장
		mav.addObject("rsrvtList", rsrvtList); // jsp에서 items="${rsrvtList} 랑 이름 맞춰줘야 됨
		return mav;
	}
}
