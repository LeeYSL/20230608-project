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
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;


import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.Board;
import logic.Comment;
import logic.User;
import logic.UserService;
import util.CipherUtil;

@Controller
@RequestMapping("user")
public class UserController {
	@Autowired
	private UserService userservice;
	@Autowired
	private CipherUtil util;

//	@Autowired
//	private MailSendService mailService;
	
	@RequestMapping("*")
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}
	@PostMapping("join")
	public ModelAndView userAdd(@Valid User user, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			//reject 메서드 : global error에 추가
			return mav;
		}
		User dbId = userservice.selectOne(user.getUserId());
		User dbEmail = userservice.selectOneEmail(user.getEmail());
		User dbTel = userservice.selectOneTel(user.getTel());
		User dbNickname = userservice.selectOneNickname(user.getNickname());
		
		try {
			if(dbId != null) {
				mav.getModel().putAll(bresult.getModel());
				bresult.reject("error.duplicate.user");
				return mav;
			}
			if(dbEmail != null) {
				mav.getModel().putAll(bresult.getModel());
				bresult.reject("error.duplicate.email"); 
				return mav;
			}
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
			if(!user.getPw().equals(user.getPw1())) {
				mav.getModel().putAll(bresult.getModel());
				bresult.reject("error.pw.check"); 
				user.setPw(null);
				user.setPw1(null);
				return mav;
			}
			user.setPw(pwHash(user.getPw()));
			mav.addObject("user",user);
			userservice.userInsert(user,session);
			mav.setViewName("redirect:login");
		}catch(DataIntegrityViolationException e) {
	//DataIntegrityViolationException : db에서 중복 key 오류시 발생되는 예외 객체
			e.printStackTrace();
			bresult.reject("error.pw.check"); //global 오류 등록
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
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
	
	
	@GetMapping("login")  	
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
			user.setPw(pwHash(jsondetail.get("name").toString()));
			user.setChannel("naver");
			userservice.userInsert(user,session);
			session.setAttribute("loginUser", user);
			return "redirect:update?userId="+user.getUserId();
		}
		session.setAttribute("loginUser", user);
		return "redirect:mypage?userId="+user.getUserId();
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
			mav.setViewName("redirect:userinfo?userId="+user.getUserId());
		} else {
			throw new LoginException("회원정보가 없습니다.", "login");
		}
		return mav;
	}
	@RequestMapping("userinfo")
	public ModelAndView idCheckUserinfo(String userId, HttpSession session) {
		ModelAndView mav = new ModelAndView();

//		user = (User)session.getAttribute("loginUser");	
//		System.out.println("loginuser info : " +session.getAttribute("loginUser"));
//		System.out.println(user);
//		mav.addObject("user",user);
//		System.out.println(user);
//		mav.setViewName("redirect:userintro?userId="+user.getUserId());
//		return mav;
		
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
			System.out.println("tel:" + dbTel);
			System.out.println("nick:" +dbNickname);
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
			mav.setViewName("redirect:mypage?userId="+user.getUserId()); 

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
	public ModelAndView idCheckPwchange(@Valid User user, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		User loginUser = (User)session.getAttribute("loginUser");
		if(!loginUser.getPw().equals(pwHash(user.getPw()))) {
			throw new LoginException("비밀번호가 일치하지 않습니다.", "pwchange");
		} else {
			if(!user.getPw1().equals(user.getPw2())) {
				throw new LoginException("변경할 비밀번호가 서로 맞지않습니다.", "pwchange");
			} else {				
				user.setPw(pwHash(user.getPw1()));
				mav.addObject("user",user);
				userservice.userChgpass(loginUser.getUserId(),pwHash(user.getPw1()));
				loginUser.setPw(pwHash(user.getPw1()));
				mav.setViewName("redirect:userinfo?userId="+loginUser.getUserId());
				return mav;
			}
		}
		
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
	public ModelAndView idCheckMypage(@RequestParam Map<String, String> param, String userId, HttpSession session) {
		ModelAndView mav = new ModelAndView();
				
		List<User> myulist = userservice.myulist(userId);
		mav.addObject("myulist",myulist);
				
				
		List<Board> myblist = userservice.myblist(userId);
		mav.addObject("myblist",myblist);
		
		List<Comment> myclist =userservice.myclist(userId);
		mav.addObject("myclist",myclist);
		
		Integer pageNum =null;
		if(param.get("pageNum") != null) {
			pageNum = Integer.parseInt(param.get("pageNum"));
		}
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 10;
		int myblistcount = userservice.myblistcount(userId);
		int maxpage = (int)((double)myblistcount/limit + 0.95);
		int startpage = (int) ((pageNum/10.0+0.9)-1)*10+1;
		int endpage = startpage + 9;
		if (endpage > maxpage) {
			endpage =maxpage;
		}
		int boardno = myblistcount - (pageNum -1) * limit;
		
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("myulistcount", myblistcount);
		mav.addObject("boardno", boardno);
		
		
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
	

	
    /* 이메일 인증 */
//    @GetMapping("/userIdCheck")
//    @ResponseBody
//	public String userIdCheck(String userId){
//		
//		/* 뷰(View)로부터 넘어온 데이터 확인 */
//    	System.out.println("이메일 데이터 전송 확인");
//    	System.out.println("이메일 : " + userId);
//				
//		return mailService.joinEmail(userId);
//	}
	
//	@PostMapping("idsearch")
//	public ModelAndView idsearch(User user, BindingResult bresult) {
//		ModelAndView mav = new ModelAndView();
//		if(user.getTel()==null || user.getTel().trim().equals("")) {
//			bresult.rejectValue("tel", "error.required");
//		}
//		if(user.getName()==null || user.getName().trim().equals("")) {			
//			bresult.rejectValue("name", "error.required");
//		}
//		if(bresult.hasErrors()) {
//			mav.getModel().putAll(bresult.getModel());
//			return mav;
//		}
//		
//		String dbUserId = userservice.idsearch(user.getTel(),user.getName());
//		System.out.println(dbUserId);
//		
//		if(dbUserId != null) {
//			
//			mav.addObject("dbUserId",dbUserId);
//			mav.setViewName("idsearch");
//			
//
//		}
//		if(dbUserId == null) {
//			mav.getModel().putAll(bresult.getModel());
//			bresult.reject("error.userId.search");
//			return mav;
//		}
//		
//		
//		return mav;
//	}
}
