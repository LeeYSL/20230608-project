package controller;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.Board;
import logic.Comment;
import logic.Reservation;
import logic.ReservationService;
import logic.User;
import logic.UserService;
import util.CipherUtil;

@Controller
@RequestMapping("user")
public class UserController {
	@Autowired
	private UserService userservice;
	@Autowired
	private ReservationService reservationService;
	@Autowired
	private CipherUtil util;
	@Autowired
	private JavaMailSender mailSender;
//	@Autowired
//	private MailSendService mailService;
	
	@RequestMapping("*")
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}
	// mailSending 코드
	@RequestMapping("mailSender.do")
	@ResponseBody
	public String mailSending(String email) {

		//뷰에서 넘어왔는지 확인
		System.out.println("이메일 전송");		
		//난수 생성(인증번호)
		Random r = new Random();
		int num = r.nextInt(888888) + 111111;  //111111 ~ 999999
		System.out.println("인증번호:" + num);
		
		/* 이메일 보내기 */
        String setFrom = "g2ve_jeong@naver.com"; //보내는 이메일
        String toMail = email; //받는 사람 이메일
        String title = "회원가입 인증 이메일 입니다.";
        String content = 
                "밥티켓 홈페이지를 방문해주셔서 감사합니다." +
                "<br><br>" + 
                "인증 번호는 " + num + "입니다." + 
                "<br>" + 
                "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        
        try {
            
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content,true);
            mailSender.send(message);
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        
        String rnum = Integer.toString(num);  //view로 다시 반환할 때 String만 가능
        
        return rnum;		
	}
	@RequestMapping("userIdChk")
	@ResponseBody
	public int userIdChk(String userId) {// 받을 데이터타입이 텍스트라 스트링으로함 반드시 리퀘스트바디를 붙힐것! ajax 통신시
		int cnt = userservice.userIdCount(userId);
		return cnt;	
	}	
	@RequestMapping("nicknameChk")
	@ResponseBody
	public int nicknameChk(String nickname) {// 받을 데이터타입이 텍스트라 스트링으로함 반드시 리퀘스트바디를 붙힐것! ajax 통신시	
		int cnt = userservice.nicknameCount(nickname);
		return cnt;	
	}
	@RequestMapping("telChk")
	@ResponseBody
	public int telChk(String tel) {// 받을 데이터타입이 텍스트라 스트링으로함 반드시 리퀘스트바디를 붙힐것! ajax 통신시	
		int cnt = userservice.telCount(tel);
		return cnt;	
	}
	@RequestMapping("emailChk")
	@ResponseBody
	public int emailChk(String email) {// 받을 데이터타입이 텍스트라 스트링으로함 반드시 리퀘스트바디를 붙힐것! ajax 통신시	
		int cnt = userservice.emailCount(email);
		return cnt;	
	}	
	@RequestMapping("pwChk")
	@ResponseBody
	public boolean pwChk(String pw, String userId) {// 받을 데이터타입이 텍스트라 스트링으로함 반드시 리퀘스트바디를 붙힐것! ajax 통신시	
		String dbpw = userservice.dbpw(userId);
		boolean result = dbpw.equals(pwHash(pw));
		return result;		
	}
	@PostMapping("join")
	public ModelAndView userAdd(User user,  HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
	
			user.setPw(pwHash(user.getPw()));
			mav.addObject("user",user);
			userservice.userInsert(user,session);
			mav.setViewName("redirect:joinlast");
		
		return mav;	
	}
	private String pwHash(String pw) {
		try {
			return util.makehash(pw, "SHA-512");
		} catch(NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return null;
	}   
	
	
	@GetMapping({"login","intro"})  	
	public ModelAndView loginForm(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String clientId = "nIAFMm2abcBu8GYgkVrO";
		String redirectURL = null;
		try {
			redirectURL = URLEncoder.encode("http://localhost:8080/project/user/naverlogin","UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		SecureRandom random = new SecureRandom();
		String state = new BigInteger(130,random).toString();
		String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
		apiURL += "&client_id="+clientId;
		apiURL += "&redirect_uri="+redirectURL;
		apiURL += "&state="+state;
		mav.addObject(new User());
		mav.addObject("apiURL",apiURL);
		mav.addObject(new User());
		session.getServletContext().setAttribute("session", session);
		System.out.println("1.session.id="+session.getId());
		return mav;
	}
	@RequestMapping("naverlogin")
	public String naverlogin(String code, String state, HttpSession session) {
		System.out.println("3.session.id="+session.getId());
		String clientId = "nIAFMm2abcBu8GYgkVrO"; //애플리케이션 클라이언트 아이디값
		String clientSecret = "kHR75dkPRV";
		
		
		String redirectURI = null;
		try {
			redirectURI = URLEncoder.encode("YOUR_CALLBACK_URL","UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
		apiURL += "client_id=" + clientId;
		apiURL += "&client_secret=" + clientSecret;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&code=" + code;	//네이버에서 전달해준 파라미터값
		apiURL += "&state=" + state;	//네이버에서 전달해준 파라미터값. 초기에는 로그인 시작시 개발자가 전달한 임의의 수
		System.out.println("code="+code+",state="+state);
		String access_token = "";
		String refresh_token = "";
		StringBuffer res = new StringBuffer();
		System.out.println("apiURL="+apiURL);
		try{
			URL url = new URL(apiURL);
			//네이버에 접속. => 토큰 전달
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			System.out.print("responseCode="+responseCode);
			if(responseCode==200) { //정상호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { //에러발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			//res : JSON 형태의 문자열
			//			{"access_token" : "AAA..."
			if(responseCode == 200) {
				System.out.println("\n===========res 1:");	//네이버에서 첫번째 요청에 대한 응답 메세지
				System.out.println("res:" + res.toString());
			}
		} catch(Exception e) {
			System.out.println(e);
		}
		//JSON 형태의 문자열 데이터 => json 객체로 변경하기 위한 객체 생성
		JSONParser parser = new JSONParser();	//json-simple-1.1.1.jar 파일 설정
		JSONObject json = null;
		try {
			json = (JSONObject)parser.parse(res.toString());
		} catch (ParseException e) {
			e.printStackTrace();
		}	//네이버 응답데이터를 json 객체로 생성.
		String token = (String)json.get("access_token");	//정상적인 로그인 요청인 경우 네이버가 발생한 코드값
		System.out.println("\n======token:"+token);
		String header = "Bearer " + token; //Bearer  다음에 공백 추가
		try{
			apiURL = "https://openapi.naver.com/v1/nid/me";	//2번째 요청 URL. 토큰값 전송
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", header); //인증정보
			int responseCode = con.getResponseCode();
			BufferedReader br;
			res = new StringBuffer();
			if(responseCode == 200) {
				System.out.println("로그인 정보 정상 수신");
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				System.out.println("로그인 정보 오류 수신");
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));			
			}
			String inputLine;
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			System.out.println(res.toString());
		} catch(Exception e) {
			e.printStackTrace();
		}
		try {
			json = (JSONObject)parser.parse(res.toString());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		System.out.println(json);	//네이버 사용자의 정보 수신.
		JSONObject jsondetail = (JSONObject)json.get("response");	
		System.out.println(jsondetail.get("id"));
		System.out.println(jsondetail.get("email"));
		//=======================================================
		String userId = jsondetail.get("id").toString();
		User user = userservice.selectOne(userId);
		if(user == null) {
			user = new User();
			user.setBatch(3);
			user.setUserId(userId);
			user.setName(jsondetail.get("name").toString());
			user.setEmail(jsondetail.get("email").toString());
			user.setNickname(jsondetail.get("nickname").toString());
			user.setTel(jsondetail.get("mobile").toString());
			user.setChannel("naver");
			userservice.userInsert(user,session);
			session.setAttribute("loginUser", user);
			return "redirect:../restaurant/restaurantList";
		}
		session.setAttribute("loginUser", user);
		return "redirect:../restaurant/restaurantList";
	}
	
	
	
	
	
	@PostMapping("login")
	public ModelAndView login(User user, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User dbUser = userservice.selectOne(user.getUserId());
		System.out.println("dbUser : " +dbUser);
		if(dbUser == null) {
			throw new LoginException("회원정보가 없습니다.","login");
		}
		if(pwHash(user.getPw()).equals(dbUser.getPw())) {
			session.setAttribute("loginUser", dbUser);
			System.out.println("loginuser : " +session.getAttribute("loginUser"));
			mav.setViewName("redirect:../restaurant/restaurantList");
		} else {
			throw new LoginException("회원정보가 없습니다.", "login");
		}
		return mav;
	}
	@RequestMapping("userinfo")
	public ModelAndView idCheckUserinfo(String userId, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println(userId);
		User user = userservice.selectOne(userId);
		mav.addObject("user",user);
		return mav;
	}
	
	@PostMapping("update")
	public ModelAndView idCheckUpdate (@Valid User user, BindingResult bresult, String userId, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
//			mav.setViewName("redirect:update?userId="+user.getUserId());
			return mav;
		}
		User loginUser = (User)session.getAttribute("loginUser");
		User dbTel = userservice.selectTel(user.getTel(),user.getUserId());
		User dbNickname = userservice.selectNickname(user.getNickname(), user.getUserId());
		try {
			if(dbTel != null) {
				mav.getModel().putAll(bresult.getModel());
				bresult.reject("error.duplicate.tel"); 
				return mav;
			}
			if(dbNickname != null) {
				mav.getModel().putAll(bresult.getModel());
				bresult.reject("error.duplicate.nickname"); 
				return mav;
			}
				
				
			if(!pwHash(user.getPw()).equals(loginUser.getPw())) {
				mav.getModel().putAll(bresult.getModel());
				bresult.reject("error.input.pw"); 
				user.setPw(null);
				return mav;
			}
			user.setPw(pwHash(user.getPw()));
			mav.addObject("user", user);
			userservice.update(user,session);
			if(user.getUserId().equals(loginUser.getUserId())) {
				session.setAttribute("loginUser", user);
			}
			mav.setViewName("redirect:mypage?userId="+user.getUserId()+"&info=binfo"); 

		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException
			("고객 정보 수정 실패","update?userId="+user.getUserId());
			
		}		
		return mav;
	}
	@GetMapping({"update","delete"})
	public ModelAndView idCheckUserupdate (String userId, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User user =userservice.selectOne(userId);
		user.setPw(null);
		user.setPw1(null);
		mav.addObject("user", user);
		return mav;
	}
	@PostMapping("pwchange")
	public ModelAndView idCheckPwchange(User user, BindingResult bresult,String pw,String pw1, String pw2, String userId, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		
		User loginUser = (User)session.getAttribute("loginUser");
		System.out.println("loginUser===" + loginUser.getUserId());
		System.out.println("loginUser===" + loginUser.getPw());
		
		if(!pwHash(pw).equals(loginUser.getPw())) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.input.pw");
			user.setPw(null);
			return mav;
			}				
		if(!pw1.equals(pw2)) {
			mav.getModel().putAll(bresult.getModel());
			bresult.reject("error.pw.check");
			user.setPw2(null);					
			return mav;
		}
		try {

				userservice.userChgpass(loginUser.getUserId(),pwHash(pw1));
				loginUser.setPw(pwHash(pw1));
			
				mav.setViewName("redirect:userinfo?userId="+loginUser.getUserId());
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException ("비밀번호 수정 실패","pwchange?userId="+user.getUserId());
			
		}		
		return mav;
	}
		
	
	
	
	@PostMapping("delete")
	public ModelAndView delete (String pw, String pw1,String userId,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser");		
		if(!pw.equals(pw1) && (loginUser.getPw() != pwHash(pw))) { 
			System.out.println("1번통과");
			System.out.println("pwHash(pw)="+pwHash(pw));
			System.out.println("loginUser.getPw()="+loginUser.getPw());
			System.out.println("userId="+userId);
			System.out.println("loginUser.getUserId()="+loginUser.getUserId());
			throw new LoginException("비밀번호가 일치하지 않습니다.","delete?userId="+loginUser.getUserId());	
		}	
		try {
			if(loginUser.getUserId().equals(userId)) {
					System.out.println("2번통과");
					System.out.println("loginUser.getUserId()="+loginUser.getUserId());
					System.out.println("userId="+userId);
					userservice.delete(userId);	 		
					session.invalidate();
					System.out.println("loginUser.getUserId()"+loginUser.getUserId());
					mav.setViewName("redirect:login");	
					return mav;
				
			} else if(loginUser.getBatch() == 1) {
				System.out.println("3번통과");
				System.out.println("userId="+userId);
				userservice.delete(userId);	
				System.out.println("userId="+userId);
				mav.setViewName("redirect:../admin/list");
				return mav;
			}
						
		} catch (Exception e) {
			throw new LoginException("탈퇴 실패","userinfo?userId="+loginUser.getUserId());
		}
		return mav;
		
	}
	@RequestMapping("logout")
	public String logout (String userId, HttpSession session) {
		session.invalidate();
		return "redirect:login";
	}

	@RequestMapping("mypage")
	public ModelAndView idCheckMypage(@RequestParam Map<String, String> param,String delYn, String userId, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Integer pageNum =null;
		if(param.get("pageNum") != null) {
			pageNum = Integer.parseInt(param.get("pageNum"));
		}
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 10; //한페이지에 10개
		int myblistcount = userservice.myblistcount(userId); //리스트개수
		int myclistcount = userservice.myclistcount(userId); //리스트개수
		int myrlistcount = reservationService.myrlistcount(userId); //리스트개수
		
		
		int maxpage = (int)((double)myblistcount/limit + 0.95); 
		int cmaxpage = (int)((double)myclistcount/limit + 0.95); 
		int rmaxpage = (int)((double)myrlistcount/limit + 0.95); 
		
		
		int startpage = (int) ((pageNum/10.0+0.9)-1)*10+1; //조회하는페이지
		
		int endpage = startpage + 9;
		int cendpage = startpage + 9;
		int rendpage = startpage + 9;
		
		
		if (endpage > maxpage) {
			endpage =maxpage;
		}
		if (cendpage > cmaxpage) {
			cendpage =cmaxpage;
		}
		if (rendpage > rmaxpage) {
			rendpage =rmaxpage;
		}	
		
		
		int boardno = myblistcount - (pageNum -1) * limit;
		int commentno = myclistcount - (pageNum-1) *limit;
		int rsrvtno = myrlistcount - (pageNum-1) *limit;
		
		
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("cmaxpage", cmaxpage);
		mav.addObject("rmaxpage", rmaxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("cendpage", cendpage);
		mav.addObject("rendpage", rendpage);
		mav.addObject("myblistcount", myblistcount);
		mav.addObject("myclistcount", myclistcount);
		mav.addObject("myrlistcount", myrlistcount);
		mav.addObject("boardno", boardno);
		mav.addObject("commentno", commentno);		
		mav.addObject("rsrvtno", rsrvtno);		
		
		
		List<User> myulist = userservice.myulist(userId);
		mav.addObject("myulist",myulist);
								
		List<Board> myblist = userservice.myblist(userId, limit, pageNum);
		mav.addObject("myblist",myblist);
		
		List<Comment> myclist =userservice.myclist(userId, limit, pageNum);
		mav.addObject("myclist",myclist);
		
		List<Reservation> Myrsrvt = reservationService.Myrsrvt(userId,limit, pageNum);
		mav.addObject("Myrsrvt",Myrsrvt);
		
		
		
		System.out.println(Myrsrvt);
		
		
		
		return mav;		
	}
	@PostMapping("{url}search")
	public ModelAndView search(User user, BindingResult bresult, @PathVariable String url ) {
		ModelAndView mav = new ModelAndView();
		String code = "error.userId.search";
		String title="아이디";
		if(url.equals("pw")) {
			title = "비밀번호 초기화";
			code= "error.pw.search";
			if(user.getUserId() == null || user.getUserId().trim().equals("")) {
				bresult.rejectValue("userId", "error.required");
			}
		}
		if(user.getEmail() == null || user.getEmail().trim().equals("")) {
			bresult.rejectValue("email","error.required");
		}
		if(user.getName() == null || user.getName().trim().equals("")) {
			bresult.rejectValue("name","error.required");
		}		
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		if(user.getUserId()!= null && user.getUserId().trim().equals("")) {
			user.setUserId(null);
		}
		String result=null;
		
		if(user.getUserId() == null) {
			List<User> list = userservice.emailList(user.getEmail());
			System.out.println(list);
			for(User u :list) {
				if(u.getName().equals(user.getName())) {
					result = u.getUserId();					
				}
			}
			
		} else {
		
			result = userservice.getSearch(user);
		
			if(result != null ) {
				String pw = null;
				try {
						pw = util.makehash(user.getUserId(), "SHA-512");
			} catch(NoSuchAlgorithmException e) {
				e.printStackTrace();
			}
			int index = (int)(Math.random()*(pw.length()-10));
			result = pw.substring(index,index+8);
			userservice.userChgpass(user.getUserId(),pwHash(result));
			}
		}	
		if(result == null) {
			bresult.reject(code);
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		System.out.println("result=" + result);
		mav.addObject("result",result);
		mav.addObject("title",title);
		mav.setViewName("search");
		return mav;
		
	}
	

}
