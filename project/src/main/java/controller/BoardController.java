package controller;


import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import logic.Board;
import logic.UserService;
import util.CipherUtil;

@Controller
@RequestMapping("board")
public class BoardController {
	@Autowired
	private UserService userservice;
	@Autowired
	private CipherUtil util;
	
	
	@RequestMapping("*")
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView();
		mav.addObject(new Board());
		return mav;
	}
	
	@PostMapping("write")
	public ModelAndView write(@Valid Board board, BindingResult bresult , HttpSession session) {
		ModelAndView mav = new ModelAndView();	
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		String boardId = (String)session.getAttribute("boardId"); //형변환 왜 해줘야하는지
		if(boardId == null) {
			boardId="1";
		}
		session.setAttribute("boardId", boardId);
//		User loginUser = (User)session.getAttribute("loginUser");
		try {
	//		mav.addObject("userId",loginUser.getUserId());
			mav.addObject("boardId",boardId);
			userservice.write(board,session);
			mav.setViewName("redirect:list?boardId="+boardId);
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("redirect:write?boardId="+boardId);
		}
		return mav;
	}
	@RequestMapping("list")
	public ModelAndView list(String boardId, HttpSession session) {
		ModelAndView mav =new ModelAndView();
		List<Board> blist = userservice.blist(boardId);
		mav.addObject("blist", blist);
		return mav;	
	}
	
	@GetMapping("detail")
	public ModelAndView detail(Integer num) {
		ModelAndView mav = new ModelAndView();
		Board board = userservice.detail(num);
		userservice.addReadcnt(num);
		mav.addObject("board",board);
		if(board.getBoardId() == null|| board.getBoardId().equals("1")) 
			mav.addObject("boardName","공지사항");
		else if (board.getBoardId().equals("2")) 
			mav.addObject("boardName","QNA");
		return mav;
	}
}
