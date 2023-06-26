package controller;

import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import logic.Board;
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
			reservation.setRsrvtDate(reservation.getRsrvtDate() + reservation.getRsrvtTime());
			reservation.setRestNum(1); // 가게번호
			// reservation.setConfirm(1); // 확정여부-예약대기(1)로 고정
			service.bookinsert(reservation);
		} catch (Exception e) {
			e.printStackTrace();
		}
		mav.setViewName("redirect:myList");
		return mav;

	}

	@GetMapping("myList")
	public ModelAndView myList(@RequestParam Map<String, String> param, HttpSession session) { // key,value 둘 다 // map으로
																								// // 전달해라
		ModelAndView mav = new ModelAndView();

		User user = (User) session.getAttribute("loginUser");

		Integer pageNum = null;
		if (param.get("pageNum") != null)
			pageNum = Integer.parseInt(param.get("pageNum"));

		if (param.get("pageNum") == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}

		int limit = 10;
		int listcount = service.listcount();

		List<Reservation> rsrvtList = service.myList(user.getUserId(), pageNum, limit); // reservation에 있는 정보를 list로 저장
																						// 로그인 되어 있는 id를 가지고 리스트를 조회하러가라
		int maxpage = (int) ((double) listcount / limit + 0.95);
		int startpage = (int) ((pageNum / 10.0 + 0.9) - 1) * 10 + 1;
		int endpage = startpage + 9; // 화면에 보여줄 페이지 끝 번호
		if (endpage > maxpage)
			endpage = maxpage;

		mav.addObject("rsrvtList", rsrvtList); // jsp에서 items="${rsrvtList} 랑 이름 맞춰줘야 됨
		mav.addObject("listcount", listcount);
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);

		return mav;
	}

	@PostMapping("myList")
	public ModelAndView confirm(@RequestParam Map<String, Object> param, HttpSession session, int confirm, int num) { // key,value
																														// 둘
																														// 다
		// 전달해라
		ModelAndView mav = new ModelAndView();

		User user = (User) session.getAttribute("loginUser");

		service.ownerconfirm(num, confirm);

//		List<Reservation> rsrvtList = service.myList(user.getUserId(), pageNum, limit); // reservation에 있는 정보를 list로 저장,
//																						// 로그인 되어 있는 id를 가지고 리스트를 조회하러가라
//		mav.addObject("rsrvtList", rsrvtList); // jsp에서 items="${rsrvtList} 랑 이름 맞춰줘야 됨

		mav.setViewName("redirect:myList?num=" + num);
		return mav;
	}

//	@RequestMapping("kakao")
//	@ResponseBody
//	public Map<String, Object> kakao(HttpSession session,Integer num) {
//		Map<String, Object> map = new HashMap<>();
//
//		User loginUser = (User) session.getAttribute("loginUser");
//		Reservation reservation = service.selectOne(num); 
//
//		map.put("merchant_uid", loginUser.getUserId() + "-" + session.getId());
//	
//		map.put("buyer_name", reservation.getName());
//		map.put("buyer_tel", reservation.getPhoneNo());
//		map.put("buyer_addr", reservation.getUserId());
//	
//		return map; // 클라이언트는 json 객체로 전달
//	}

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
		int pageNum = 0;

		if (pageNum == 0) {
			pageNum = 1;
		} else {
			pageNum = (int) param.get("pageNum");
		}

		int limit = 10;
		int listcount = service.listcount();

		List<Reservation> rsrvtList = service.ownerList(user.getUserId(), pageNum, limit);

		int maxpage = (int) ((double) listcount / limit + 0.95);
		int startpage = (int) ((pageNum / 10.0 + 0.9) - 1) * 10 + 1;
		int endpage = startpage + 9; // 화면에 보여줄 페이지 끝 번호
		if (endpage > maxpage)
			endpage = maxpage;

		mav.addObject("rsrvtList", rsrvtList);
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);

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