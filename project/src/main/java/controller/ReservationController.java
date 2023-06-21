package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.taglibs.standard.lang.jstl.test.beans.PublicBean1;
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
import lombok.val;

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

	@PostMapping("ownerList")
	public ModelAndView confirm(int num, int confirm) {
		ModelAndView mav = new ModelAndView();

		System.out.println("1");
		System.out.println("num : " + num);
		System.out.println("confirm : " + confirm);

		service.ownerconfirm(num, confirm);
		// System.out.println("1:" + reservation.getConfirm());
		// reservation.getConfirm(); // reservation에서 쓸 수 있게 ownerconfirm에서 가져온 걸 set
		// 해줌?

		System.out.println();
		mav.addObject("num", num);

		return mav;

	}

	@GetMapping("ownerList")
	public ModelAndView ownerList(@RequestParam Map<String, Object> param, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		User user = (User) session.getAttribute("loginUser");

		List<Reservation> rsrvtList = service.ownerList(user.getUserId());
		mav.addObject("rsrvtList", rsrvtList);

		return mav;
	}

	// 예약상세페이지 수정
	@PostMapping("myListInfo")
	public ModelAndView myListInfo(@Valid Reservation reservation, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user = (User) session.getAttribute("loginUser");

		// post인 경우엔 form에서 보낸 객체를 사용해야함.
		int num = reservation.getNum();

		if (user.getUserId() != null) {
			service.myListUpdate(reservation);
			mav.setViewName("redirect:myListInfo?num=" + num);
			// mav.setViewName("myList");
		}
		return mav;
	}

	// 예약 상세페이지로 이동
	@GetMapping("myListInfo")
	public ModelAndView Info(Integer num, Reservation reservatio) {
		// http://localhost:8080/project/reservation/myListInfo?num=3
		System.out.println("!!!");
		ModelAndView mav = new ModelAndView();
		Reservation reservation2 = service.selectOne(num);
		mav.addObject("rsrvt", reservation2);
		return mav;
	}

}