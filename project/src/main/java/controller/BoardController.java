package controller;

import java.text.SimpleDateFormat;
import java.util.Date;
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
	public ModelAndView loginCheckWrite(@Valid Board board, BindingResult bresult, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		if (bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		String boardId = (String) session.getAttribute("boardId"); // 형변환 왜 해줘야하는지
		System.out.println("boardId write=" + boardId);
		if (boardId == null) {
			boardId = "2";
		}

		System.out.println("boardId write null=" + boardId);
		board.setBoardId(boardId);
		try {
			mav.addObject("boardId", boardId);
			userservice.write(board, session);
			mav.setViewName("redirect:list");
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName("redirect:write?boardId=" + boardId);
		}
		return mav;
	}

	@RequestMapping("list")
	public ModelAndView list(@RequestParam Map<String, String> param, HttpSession session) {
		Integer pageNum = null; // 왜 ...int 가 아니고 Integer...
		if (param.get("pageNum") != null)
			pageNum = Integer.parseInt(param.get("pageNum"));
		String type = param.get("type");
		String searchcontent = param.get("searchcontent");
		String boardId = param.get("boardId");

		ModelAndView mav = new ModelAndView();
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		if (boardId == null || boardId.equals("")) {
			boardId = "1";
		}
		session.setAttribute("boardId", boardId);

		if (type == null || type.trim().equals("") || searchcontent == null || searchcontent.trim().equals("")) {
			type = null;
			searchcontent = null;
		}

		String boardName = null;
		switch (boardId) {
		case "1":
			boardName = "Notice";
			break;
		case "2":
			boardName = "QnA";
			break;
		}
		int limit = 10;
		int listcount = userservice.boardcount(boardId, type, searchcontent);
		List<Board> boardlist = userservice.boardlist(boardId, limit, pageNum, type, searchcontent);
		int maxpage = (int) ((double) listcount/limit + 0.95);
		int startpage = (int) ((pageNum / 10.0 + 0.9) - 1) * 10 + 1;
		int endpage = startpage + 9;
		if (endpage > maxpage) {
			endpage =maxpage;
		}
		int boardno = listcount - (pageNum - 1) * limit;
		String today = new SimpleDateFormat("yyyyMMdd").format(new Date());
		mav.addObject("boardId", boardId);
		mav.addObject("boardName", boardName);
		mav.addObject("boardlist", boardlist);
		mav.addObject("pageNum", pageNum);
		mav.addObject("maxpage", maxpage);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);
		mav.addObject("listcount", listcount);
		mav.addObject("boardno", boardno);
		mav.addObject("today", today);
		return mav;
	}

	@RequestMapping("detail")
	public ModelAndView detail(@RequestParam Map<String, String> param, Integer num) {
		ModelAndView mav = new ModelAndView();
		Board board = userservice.detail(num);
		userservice.addReadcnt(num);
		mav.addObject("board", board);
		if (board.getBoardId() == null || board.getBoardId().equals("1"))
			mav.addObject("boardName", "Notice");
		else if (board.getBoardId().equals("2"))
			mav.addObject("boardName", "QnA");

//comment 리스트		
		Integer pageNum =null;
		if(param.get("pageNum") != null) {
			pageNum = Integer.parseInt(param.get("pageNum"));
		}
		if (pageNum == null || pageNum.toString().equals("")) {
			pageNum = 1;
		}
		int limit = 10; //한페이지에 10개
		int commcount = userservice.commcount(num); //리스트개수
		int maxpage = (int)((double)commcount/limit + 0.95); 
		int startpage = (int) ((pageNum/10.0+0.9)-1)*10+1; //조회하는페이지
		
		int endpage = startpage + 9;
		
		
		if (endpage > maxpage) {
			endpage =maxpage;
		}	
		int commno = commcount - (pageNum -1) * limit;
		String today = new SimpleDateFormat("yyyyMMdd").format(new Date());
		mav.addObject("pageNum",pageNum);
		mav.addObject("maxpage", maxpage);

		mav.addObject("startpage", startpage);
		mav.addObject("endpage", endpage);

		mav.addObject("commcount", commcount);

		mav.addObject("commno", commno);				
		mav.addObject("today", today);
		
		
		
		List<Comment> commlist = userservice.commlist(num,limit, pageNum);
		mav.addObject("commlist", commlist);
		
		Comment comm = new Comment();
		comm.setNum(num);
		mav.addObject("comment", comm);
		return mav;

	}

	@GetMapping({"update","reply"})
	public ModelAndView boardupdate(Integer num, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		String boardId = (String) session.getAttribute("boardId");
		Board board = userservice.detail(num); 
		mav.addObject("board", board);
		if (boardId == null || boardId.equals("1")) {
			mav.addObject("boardName", "Notice");
		} else if (boardId == null || boardId.equals("2")) {
			mav.addObject("boardName", "QnA");
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
			userservice.update(board, session);
			// System.out.println("1:"+board.getNum());
			mav.setViewName("redirect:detail?num=" + board.getNum());
		} catch (Exception e) {
			e.printStackTrace();

			throw new LoginException("수정 실패", "update?num=" + board.getNum());
		}
		return mav;
	}

	@RequestMapping("delete")
	public String delete(Integer num) {
		try {
			userservice.delete(num);
			return "redirect:list";
		} catch (Exception e) {
			e.printStackTrace();
			throw new LoginException("삭제 실패", "detail?num=" + num);
		}

	}

	@RequestMapping("comment")
	public ModelAndView comment(@Valid Comment comm, BindingResult bresult) {
		ModelAndView mav = new ModelAndView("board/detail");

		if (bresult.hasErrors()) {
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}

		int seq = userservice.commmaxseq(comm.getNum());
		comm.setSeq(++seq);
		userservice.commInsert(comm);
		mav.setViewName("redirect:detail?num=" + comm.getNum());
		return mav;
	}

	@RequestMapping("commdelete")
	public String commdelete(Comment comm) {
		userservice.commdelete(comm.getNum(), comm.getSeq());
		return "redirect:detail?num=" + comm.getNum();

	}
	@PostMapping("reply")
	public ModelAndView reply(@Valid Board board, BindingResult bresult ) {
		ModelAndView mav = new ModelAndView();
		if(bresult.hasErrors()) {
			Board dbboard = userservice.detail(board.getNum());
			Map<String,Object> map = bresult.getModel();
			Board b = (Board)map.get("board");
			b.setTitle(dbboard.getTitle());
			mav.getModel().putAll(bresult.getModel());
			return mav;
		}
		try {
			userservice.reply(board);
			mav.setViewName("redirect:list?boardId="+board.getBoardId());
		} catch(Exception e) {
			e.printStackTrace();
			throw new LoginException ("답변등록시 오류 발생","reply?num="+board.getNum());
		}
			return mav;
	}
	
	

}
