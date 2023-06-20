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

import exception.LoginException;
import logic.Board;
import logic.Comment;
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
		System.out.println("boardId write="+boardId);
		if(boardId == null) {
			boardId="1";
		}
		System.out.println("boardId write null="+boardId);
		board.setBoardId(boardId);
		try {
			mav.addObject("boardId",boardId);
			userservice.write(board,session);
			mav.setViewName("redirect:list");
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("redirect:write?boardId="+boardId);
		}
		return mav;
	}
	@RequestMapping("list")
	public ModelAndView list(@RequestParam Map<String,String> param, HttpSession session) {
//		ModelAndView mav =new ModelAndView();
//		String boardId = (String)session.getAttribute("boardId");
//		board.setBoardId(boardId);
//		System.out.println("boardId list="+boardId);
//		List<Board> blist = userservice.blist(boardId);
//		mav.addObject("blist", blist);
//		return mav;
		String boardId = param.get("boardId");
		ModelAndView mav =  new ModelAndView();
		if(boardId == null || boardId.equals("")) {
			boardId = "1";
		}
		session.setAttribute("boardId", boardId);
	
	String boardName=null;
	switch(boardId) {
		case "1" : boardName = "Notice"; break;
		case "2" : boardName = "QnA"; break;
		}
	List<Board> boardlist = userservice.boardlist(boardId);
	mav.addObject("boardId","boardId");
	mav.addObject("boardName", boardName);
	mav.addObject("boardlist",boardlist);
	return mav;
	}
	
	
	@GetMapping("detail")
	public ModelAndView detail(Integer num) {
		ModelAndView mav = new ModelAndView();
		Board board = userservice.detail(num);
		userservice.addReadcnt(num);
		mav.addObject("board",board);
		if(board.getBoardId() == null|| board.getBoardId().equals("1")) 
			mav.addObject("boardName","Notice");
		else if (board.getBoardId().equals("2")) 
			mav.addObject("boardName","QnA");
		
		List<Comment> commlist = userservice.commlist(num);
		mav.addObject("commlist",commlist);
		Comment comm = new Comment();
		comm.setNum(num);
		mav.addObject("comment",comm);
		return mav;

	}
	
	
	
	@GetMapping("update")
	public ModelAndView boardupdate(Integer num, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String boardId = (String)session.getAttribute("boardId");
		Board board = userservice.detail(num);
		mav.addObject("board",board);
		if (boardId == null || boardId.equals("1")) {
			mav.addObject("boardName","Notice");
		} else if (boardId == null || boardId.equals("2")) {
			mav.addObject("boardName","QnA");
		}
		return mav;
		}
	
	@PostMapping("update")
	public ModelAndView update(@Valid Board board, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if (bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		 try {
			userservice.update(board,session);
	//		System.out.println("1:"+board.getNum());
			mav.setViewName("redirect:detail?num="+board.getNum());
		}catch (Exception e) {
			e.printStackTrace();

			throw new LoginException("수정 실패","update?num="+board.getNum());
		}
		return mav;
	}
	@RequestMapping("delete")
	public String delete(Integer num) {
		try{
			userservice.delete(num);
			return "redirect:list";
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("삭제 실패","detail?num="+num);
		}

	}
	@RequestMapping("comment")
	public ModelAndView comment(@Valid Comment comm, BindingResult bresult) {
		ModelAndView mav = new ModelAndView("board/detail");
		
		if(bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		
		int seq = userservice.commmaxseq(comm.getNum());
		comm.setSeq(++seq);
		userservice.commInsert(comm);
		mav.setViewName("redirect:detail?num="+comm.getNum());
		return mav;
	}
	@RequestMapping("commdelete")
	public String commdelete(Comment comm) {
		Comment dbcomm = userservice.selectOne
		userservice.commdelete();
	}
	 
}
