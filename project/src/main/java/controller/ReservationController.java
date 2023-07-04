package controller;

import java.io.UnsupportedEncodingException;
import java.net.URI;
import java.net.URISyntaxException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.tomcat.util.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import dao.MessageDao;
import dao.SmsRequestDao;
import dao.SmsResponseDao;
import exception.LoginException;
import exception.ReservationException;
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
	public ModelAndView reservation(@Valid Reservation reservation, BindingResult bresult, HttpSession session,
			Restaurant restaurant) throws Exception {
		ModelAndView mav = new ModelAndView();
		if (bresult.hasErrors()) {
			System.out.println("error");
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.reservation");
			bresult.reject("error.input.check");
			return mav;
		}
		
		int num = reservation.getRestNum(); //가게번호
		String date = reservation.getRsrvtDate(); //예약날짜
		String time = reservation.getRsrvtTime(); //예약시간
		
		//해당 예약날짜와 예약시간에 예약이 가능한지 조회함
		Reservation rsrvt = service.checkReservation(num, date, time);
		
		if(rsrvt.getRsrvtYn().equals("N")) { 
			// N : 예약마감인 경우
			throw new ReservationException("해당 시간에 예약이 마감되었습니다.","reservationadd?num=" + num);
		}else { 
			// Y : 예약 가능한 경우
			if(reservation.getPeople() > rsrvt.getCanPeople()) {
				//선택한 예약인원이 가능한 예약인원 수를 초과한 경우 
				throw new ReservationException(
						"해당 시간에 가능한 예약 인원을 초과했습니다. (가능인원 : "+rsrvt.getCanPeople()+"명)",
						"reservationadd?num=" + num);
			}
		}
		
		try {

			User user = (User) session.getAttribute("loginUser");
			reservation.setUserId(user.getUserId());
			reservation.setRsrvtDate(date + time);

			service.bookinsert(reservation);

			mav.addObject("reservation", reservation);
			// mav.addObject("restNum",num);

		} catch (Exception e) {
			e.printStackTrace();
		}

		mav.setViewName("redirect:myList?num=" + num);
		return mav;

	}

	@GetMapping("reservationadd")
	public ModelAndView goReservation(Reservation reservation, int num, HttpSession session) {
		ModelAndView mav = new ModelAndView();

		User user = (User) session.getAttribute("loginUser");
		if (user == null) {

			throw new LoginException("로그인하세요", "/project/user/login");

		}
//		service.restInfoadd(reservation.getRestNum());
		Restaurant restaurant = service.restInfoadd(num);
		mav.addObject("dayoff", service.dayoffList(num));
		mav.addObject("restNum", num);
		mav.addObject("restaurant", restaurant);
		mav.addObject("user", user);
		return mav;

	}

	@GetMapping("myList")
	public ModelAndView myList(@RequestParam Map<String, String> param, HttpSession session, String delYn) { // key,value
																												// 둘 다
																												// //
																												// map으로
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

		List<Reservation> rsrvtList = service.myList(user.getUserId(), pageNum, limit, delYn); // reservation에 있는 정보를
																								// list로 저장
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

	@RequestMapping("kakao")
	@ResponseBody
	public Map<String, Object> kakao(HttpSession session,Integer num) {
		Map<String, Object> map = new HashMap<>();

		User loginUser = (User) session.getAttribute("loginUser");
		Reservation reservation = service.selectOne(num); 

		map.put("merchant_uid", loginUser.getUserId() + "-" + session.getId());
	
		map.put("buyer_name", reservation.getName());
		map.put("buyer_tel", reservation.getPhoneNo());
		map.put("buyer_addr", reservation.getUserId());
	
		return map; // 클라이언트는 json 객체로 전달
	}

	@PostMapping("ownerList")
	public ModelAndView confirm(int num, int confirm,Reservation reservation) {
		ModelAndView mav = new ModelAndView();
	//	String restName = reservation.getName();
	//	String tel = reservation.getPhoneNo();
	//	String name = reservation.getRsrvtName();
		
		MessageDao messageDao = new MessageDao();
		messageDao.setTo("01033252804");
		messageDao.setContent("예약 확정되었습니다.");
		try {
			sendSms(messageDao);
		} catch (JsonProcessingException | RestClientException | InvalidKeyException | NoSuchAlgorithmException
				| UnsupportedEncodingException | URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		service.ownerconfirm(num, confirm);
		// System.out.println("1:" + reservation.getConfirm());
		// reservation.getConfirm(); // reservation에서 쓸 수 있게 ownerconfirm에서 가져온 걸 set
		// 해줌?

		System.out.println();
		mav.addObject("num", num); // 조회해온 num을 넘기는건가??

		return mav;

	}
	@GetMapping("ownerList")
	public ModelAndView ownerList(@RequestParam Map<String, String> param, HttpSession session, String delYn) {
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
		
		List<Reservation> rsrvtList = service.ownerList(user.getUserId(), pageNum, limit, delYn);

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
	public String makeSignature(Long time) throws NoSuchAlgorithmException, UnsupportedEncodingException, InvalidKeyException {
		String space = " ";
        String newLine = "\n";
        String method = "POST";
        String url = "/sms/v2/services/ncp:sms:kr:311072611756:lys/messages";
        String timestamp = time.toString();
        String accessKey = "OsxUlMxn78m4DMcprwak";
        String secretKey = "hVfQpMFimfHas7hQsxLuGLy3fPwQDZ9Ez5kYeG4E";
 
        String message = new StringBuilder() //StringBuilder : 위 내용들을 하나의 문자열로 합치겠다.
                .append(method)
                .append(space)
                .append(url)
                .append(newLine)
                .append(timestamp)
                .append(newLine)
                .append(accessKey)
                .toString();
 
        SecretKeySpec signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
        Mac mac = Mac.getInstance("HmacSHA256");
        mac.init(signingKey); //init : 초기화
 
        byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8")); //바이트 형식에 담겠다.
        String encodeBase64String = Base64.encodeBase64String(rawHmac); //복호화 하겠다?
 
        return encodeBase64String;
	}
	
	public SmsResponseDao sendSms(MessageDao messageDao) throws JsonProcessingException, RestClientException, URISyntaxException, InvalidKeyException, NoSuchAlgorithmException, UnsupportedEncodingException {
		Long time = System.currentTimeMillis();
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.set("x-ncp-apigw-timestamp", time.toString());
		headers.set("x-ncp-iam-access-key", "OsxUlMxn78m4DMcprwak");
		headers.set("x-ncp-apigw-signature-v2", makeSignature(time));
		
		List<MessageDao> messages = new ArrayList<>();
		messages.add(messageDao);
		
		SmsRequestDao request = SmsRequestDao.builder()
				.type("SMS")
				.contentType("COMM")
				.countryCode("82")
				.from("01022308370")
				.content(messageDao.getContent())
				.messages(messages)
				.build();
		
		ObjectMapper objectMapper = new ObjectMapper();
		String body = objectMapper.writeValueAsString(request);
		HttpEntity<String> httpBody = new HttpEntity<>(body, headers);
		
		RestTemplate restTemplate = new RestTemplate();
	    restTemplate.setRequestFactory(new HttpComponentsClientHttpRequestFactory());
	    SmsResponseDao response = restTemplate.postForObject(new URI("https://sens.apigw.ntruss.com/sms/v2/services/"+ "ncp:sms:kr:311072611756:lys" +"/messages"), httpBody, SmsResponseDao.class);
 
	    return response;	
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
		ModelAndView mav = new ModelAndView();
		Reservation reservation2 = service.selectOne(num);
		mav.addObject("rsrvt", reservation2);
		return mav;
	}

	@PostMapping("point")
	public ModelAndView pointadd(Reservation reservation, int num, Integer point) {
		ModelAndView mav = new ModelAndView();

		service.pointInsert(num, point);

		return mav;
	}

	@GetMapping("point")
	public ModelAndView point(int num) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("num", num);
		return mav;
	}

}
