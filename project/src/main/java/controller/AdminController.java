package controller;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import logic.User;
import logic.UserService;


@Controller
@RequestMapping("admin")
public class AdminController {
	@Autowired
	private UserService userservice;

	
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

}
