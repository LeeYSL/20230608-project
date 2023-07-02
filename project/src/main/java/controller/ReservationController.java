package controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import logic.Reservation;
import logic.ReservationService;
import logic.Restaurant;
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
	public ModelAndView reservation(@Valid Reservation reservation, BindingResult bresult, HttpSession session,Restaurant restaurant)
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
			System.out.println(restaurant.getRestNum());
			reservation.setUserId(user.getUserId());
			reservation.setRsrvtDate(reservation.getRsrvtDate() + reservation.getRsrvtTime());		
	    //    reservation.setRestNum(restaurant.getRestNum());
		
			
			
		//	 reservation.setConfirm(1); // 확정여부-예약대기(1)로 고정
		//	mav.addObject("restNum",restaurant.getRestNum());
			
	//		System.out.println(reservation);
			
		 service.bookinsert(reservation);		 

		mav.addObject("reservation", reservation);
	//	mav.addObject("restNum",num);
	
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(restaurant.getRestNum());
		}
	
		mav.setViewName("redirect:myList?num="+restaurant.getRestNum());
		return mav;

	}
	@GetMapping("reservationadd") 
	public ModelAndView goReservation(Reservation reservation, int num) {
		ModelAndView mav = new ModelAndView();
		
//		service.restInfoadd(reservation.getRestNum());
		Restaurant restaurant = service.restInfoadd(num);
		mav.addObject("dayoff", service.dayoffList(num)); 
		mav.addObject("restNum", num);
		mav.addObject("restaurant", restaurant);
		return mav;

	}
	
	

	@GetMapping("myList")
	public ModelAndView myList(@RequestParam Map<String, String> param, HttpSession session,String delYn) { // key,value 둘 다 // map으로
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
		int listcount = service.myListCount(user.getUserId());

		List<Reservation> rsrvtList = service.myList(user.getUserId(), pageNum, limit,delYn); // reservation에 있는 정보를 list로 저장
																						// 로그인 되어 있는 id를 가지고 리스트를 조회하러가라
		int maxpage = (int) ((double) listcount / limit + 0.95);
		System.out.println("maxpage : " + maxpage);
		int startpage = (int) ((pageNum / 10.0 + 0.9) - 1) * 10 + 1;
		System.out.println("startpage : " + startpage);
		int endpage = startpage + 9; // 화면에 보여줄 페이지 끝 번호
		
		if (endpage > maxpage)
			endpage = maxpage;
		System.out.println("endpage : " + endpage);
		
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
		mav.addObject("num", num); //조회해온 num을 넘기는건가??

		return mav;

	}

	@GetMapping("ownerList")
	public ModelAndView ownerList(@RequestParam Map<String, String> param, HttpSession session,String delYn) {
		ModelAndView mav = new ModelAndView();

		User user = (User) session.getAttribute("loginUser");
		Integer pageNum = null;
		if (param.get("pageNum") != null)
			pageNum = Integer.parseInt(param.get("pageNum"));

		if (param.get("pageNum") == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}

		int limit = 10;
		int listcount = service.ownerListCount(user.getUserId());
		List<Reservation> rsrvtList = service.ownerList(user.getUserId(), pageNum, limit ,delYn);

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
	
	@GetMapping("kakaopay")
	@ResponseBody
	public String kakaopay() {
		try {
			// 보내는 부분
			URL address = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection connection = (HttpURLConnection) address.openConnection(); // 서버연결
			connection.setRequestMethod("POST");
			connection.setRequestProperty("Authorization", "KakaoAK 7458e92c8043a98aa0a6088e820de564"); // 어드민 키
			connection.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			connection.setDoOutput(true); // 서버한테 전달할게 있는지 없는지
			String parameter = "cid=TC0ONETIME" // 가맹점 코드
					+ "&partner_order_id=partner_order_id" // 가맹점 주문번호
					+ "&partner_user_id=partner_user_id" // 가맹점 회원 id
					+ "&item_name=초코파이" // 상품명
					+ "&quantity=1" // 상품 수량
					+ "&total_amount=5000" // 총 금액
					+ "&vat_amount=200" // 부가세
					+ "&tax_free_amount=0" // 상품 비과세 금액
					+ "&approval_url=http://localhost:8000/" // 결제 성공 시
					+ "&fail_url=http://localhost:8000/" // 결제 실패 시
					+ "&cancel_url=http://localhost:8000/"; // 결제 취소 시
			OutputStream send = connection.getOutputStream(); // 이제 뭔가를 를 줄 수 있다.
			DataOutputStream dataSend = new DataOutputStream(send); // 이제 데이터를 줄 수 있다.
			dataSend.writeBytes(parameter); // OutputStream은 데이터를 바이트 형식으로 주고 받기로 약속되어 있다. (형변환)
			dataSend.close(); // flush가 자동으로 호출이 되고 닫는다. (보내고 비우고 닫다)
			
			int result = connection.getResponseCode(); // 전송 잘 됐나 안됐나 번호를 받는다.
			InputStream receive; // 받다
			
			if(result == 200) {
				receive = connection.getInputStream();
			}else {
				receive = connection.getErrorStream(); 
			}
			// 읽는 부분
			InputStreamReader read = new InputStreamReader(receive); // 받은걸 읽는다.
			BufferedReader change = new BufferedReader(read); // 바이트를 읽기 위해 형변환 버퍼리더는 실제로 형변환을 위해 존제하는 클레스는 아니다.
			// 받는 부분
			System.out.println(change.readLine());
			return change.readLine(); // 문자열로 형변환을 알아서 해주고 찍어낸다 그리고 본인은 비워진다.
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "";
	}

}