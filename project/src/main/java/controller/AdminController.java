package controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import exception.LoginException;
import logic.Mail;
import logic.Reservation;
import logic.ReservationService;
import logic.Restaurant;
import logic.User;
import logic.UserService;


@Controller
@RequestMapping("admin")
public class AdminController {
	@Autowired
	private UserService userservice;
	@Autowired
	private ReservationService service;

	
	@RequestMapping("*")
	public ModelAndView list() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new User());
		return mav;
	}
	@RequestMapping("list")
	public ModelAndView list (@RequestParam Map<String,String> param,HttpSession session) {
		ModelAndView mav = new ModelAndView();
		Integer pageNum = null;
		if(param.get("pageNum") != null)
			pageNum = Integer.parseInt(param.get("pageNum"));
		String type = param.get("type");
		String searchcontent = param.get("searchcontent");
		
		if(pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if(type == null || type.trim().equals("") ||searchcontent == null|| searchcontent.trim().equals("")) {
			type = null;
			searchcontent = null;
		}
		int limit = 10;
		int listcount = userservice.usercount(type,searchcontent);
		int maxpage = (int)((double)listcount/limit +0.95);
		int startpage = (int)((pageNum/10.0+0.9)-1)*10 +1;
		int endpage = startpage +9;
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		int boardno = listcount - (pageNum-1) *limit;	
		List<User> userlist = userservice.userlist(limit,pageNum,type,searchcontent);  
		mav.addObject("userlist",userlist);
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage",maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("listcount",listcount);
		mav.addObject("boardno", boardno);
		return mav;
	}
	/*
	@PostMapping("list")
	public ModelAndView list(User user, String delYn, String userId) {
		ModelAndView mav = new ModelAndView();

		userservice.deleteUser(delYn, userId);
		System.out.println(userId);

		mav.addObject("deleteUser", userId);
		System.out.println(userId);

		return mav;

	}
	*/
	@RequestMapping("restaurantlist")
	ModelAndView restist(@RequestParam Map<String, String> param, HttpSession session, String delYn,Restaurant restaurant,Reservation reservation) {
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
	@PostMapping("restaurantlist")
	public ModelAndView restaurantlist(Restaurant restaurant, String delYn, int num) {
		ModelAndView mav = new ModelAndView();
		
		service.deleteRest(delYn, num);
		System.out.println(num);

		mav.addObject("deleteRest", num);
		System.out.println(num);

		return mav;

	}
/*	
	@RequestMapping("maileForm")
	public ModelAndView mailForm(String[] idchks, HttpSession session) {
		ModelAndView mav = new ModelAndView("admin/mail");
		if(idchks == null || idchks.length == 0) {	
			throw new LoginException("메일을 보낼 대상자를 선택하세요","list");
		}
		List<User> list = userservice.getUserList(idchks);
		mav.addObject("list",list);
		return mav;
	}
	@RequestMapping("mail")
	public ModelAndView mail (Mail mail, HttpSession session) {
		ModelAndView mav = new ModelAndView("alert");
		Properties prop = new Properties();
		try {
			//mail.properties : resources 폴더에 생성
			//java,resources 폴더의 내용은 : WEB-INF/classes에 복사됨
			FileInputStream fis = new FileInputStream
					(session.getServletContext().getRealPath("/")+"/WEB-INF/classes/mail.properties");
			prop.load(fis);
			prop.put("mail.smtp.user", mail.getNaverid());
		}catch(IOException e) {
			e.printStackTrace();
		}
		mailSend(mail,prop);
		mav.addObject("message","메일 전송이 완료 되었습니다.");
		mav.addObject("url","list");
		return mav;
	}


	private void mailSend(Mail mail,Properties prop) {
		MyAuthenticator auth = new MyAuthenticator(mail.getNaverid(),mail.getNaverpw());
		Session session = Session.getInstance(prop,auth);
		MimeMessage msg = new MimeMessage(session);
		try {
			//보내는메일
			msg.setFrom(new InternetAddress(mail.getNaverid() + "@naver.com"));
			//받는 메일 정보
			List<InternetAddress> addrs = new ArrayList<InternetAddress>();
			String[] emails = mail.getRecipient().split(",");
			for(String email : emails) {
				try {
					addrs.add(new InternetAddress (new String (email.getBytes("utf-8"), "8859_1")));
				} catch(UnsupportedEncodingException ue) {
					ue.printStackTrace();
				}
			}
			
			InternetAddress[] arr = new InternetAddress[emails.length];
			for(int i=0;i<addrs.size();i++) {
				arr[i]=addrs.get(i);
			}
			msg.setRecipients(Message.RecipientType.TO,arr); //수신메일 설정
			msg.setSentDate(new Date()); //전송일자
			msg.setSubject(mail.getTitle()); //제목
			// ================== 여기까지가 헤더부분
			//================여기서부터 내용
			MimeMultipart multipart = new MimeMultipart(); //내용, 첨부파일...
			//multipart 가 내용 따로 첨부파일 따로 해준다?
			MimeBodyPart message = new MimeBodyPart(); //바디파트 하나만듬 이름이 message인 이유는 text내용이라 ?
			message.setContent(mail.getContents(),mail.getMtype());
			multipart.addBodyPart(message); //multipart에 message 넣어줌
			//첨부파일 파일 추가
			for(MultipartFile mf : mail.getFile1()) {
				//mail.getFile1의 자료형은 List
				//mf :  첨부된 파일의 내용 중 한개
				if((mf != null) && (!mf.isEmpty())) {
					//첨부파일이 들어옴
					multipart.addBodyPart(bodyPart(mf));
					//multipart 에 내용, 첨부파일 들어있음
				}
			}
			msg.setContent(multipart);
			Transport.send(msg);
			//msg : 메일 전체 객체(전송메일주소, 수신메일주소들, 제목, 전송일자, 내용, 첨부파일들)
		} catch (MessagingException me) {
			me.printStackTrace();
		}
	}

	private BodyPart bodyPart(MultipartFile mf) {
		//mf : 업로드된 내용
		MimeBodyPart body = new MimeBodyPart();
		String orgFile = mf.getOriginalFilename();;
		//파일을 첨부하기 위해 서버에서 임시로 만들어 놓은 파일
		//사용자가 파일을 업로드 하고 그 파일을 메일에 첨부하여 보내짐??
		String path= "c:/mailupload/";
		File f1 = new File(path);
		if(!f1.exists()) f1.mkdirs();
		File f2 = new File(path + orgFile);
		try {
			mf.transferTo(f2); //여러개 파일업로드
			body.attachFile(f2); //이메일 첨부
			body.setFileName(new String(orgFile.getBytes("UTF-8"),"8859_1"));
			//인식할 수 있도록 8859_1로 바꿔서  fileName 에 넣어준다? 첨부된 파일의 파일명
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return body;
	}

	//AdminController 클래스의 내부 클래스로 구현
	private final class MyAuthenticator extends Authenticator {
		//class 앞에는 private 못하는데 붙을 수 있는 이유는 내부 클래스라서
		//이 클래스는 AdminController에서만 사용가능
		//final 이라 상속 못함
		//외부로 만들어도 상관은 없음
		private String id;
		private String pw;
		public MyAuthenticator(String id, String pw) {
			this.id = id;
			this.pw = pw;
		}
		@Override
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(id, pw);
		}
		
	}
	*/
}
