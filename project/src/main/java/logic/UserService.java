package logic;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDao;
import dao.CommentDao;
import dao.UserDao;

@Service
public class UserService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private BoardDao boardDao;
	@Autowired
	private CommentDao commDao;
	

	public void userInsert(@Valid User user) {
		userDao.insert(user);
		
	}


	public User selectOne(String userId) {
		return userDao.selectOne(userId); 
	}



	public void update(@Valid User user) {
		userDao.update(user);
		
	}




	public void delete(String userId) {
		userDao.delete(userId);
		
	}




	public List<User> list() {
		return userDao.list();
	}



	public void write(@Valid Board board, HttpSession session) {
		int maxnum = boardDao.maxNum();
		board.setNum(++maxnum);
		board.setGrp(maxnum);
		if(board.getFile1() != null && !board.getFile1().isEmpty()) {
			 String path = session.getServletContext().getRealPath("/") + "board/file/";
			 this.uploadFileCreate(board.getFile1(),path);
			 board.setFileurl(board.getFile1().getOriginalFilename());
		}
		boardDao.write(board); 
		
	}


	private void uploadFileCreate(MultipartFile file, String path) {
		String orgFile=file.getOriginalFilename();
		File f= new File(path);
		if(!f.exists()) {
			f.mkdirs();
		}
		try  {
			file.transferTo(new File(path+orgFile));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}


	public Board detail(Integer num) {
		return boardDao.detail(num);
	}


	public void addReadcnt(Integer num) {
		boardDao.addReadcnt(num);
		
	}


	public void update(@Valid Board board, HttpSession session) {
		if(board.getFile1() != null && !board.getFile1().isEmpty()) {
			String path = session.getServletContext().getRealPath("/") + "board/file/";
			this.uploadFileCreate(board.getFile1(), path);  
			board.setFileurl(board.getFile1().getOriginalFilename());
		}
		boardDao.update(board);
	}


	public void delete(Integer num) {
		boardDao.delete(num);
		
	}


	public List<Comment> commlist(Integer num) {
		
		return commDao.commlist(num);
	}


	public void commInsert(@Valid Comment comm) {
		commDao.commInsert(comm);
		
	}


	public int commmaxseq(int num) {
		return commDao.commmaxseq(num);
	}


	public void commdelete(int num, int seq) {
		commDao.commdelete(num,seq);
		
	}


	public int boardcount(String boardId, String type, String searchcontent) {
		return boardDao.boardcount(boardId,type,searchcontent);
	}


	public List<Board> boardlist(String boardId, int limit, Integer pageNum, String type, String searchcontent) {
		return boardDao.boardlist(boardId, limit, pageNum, type, searchcontent);
	}


	public List<Board> myblist(String userId) {
		return boardDao.myblist(userId);
	}


	public List<Comment> myclist(String userId) {
		return commDao.myclist(userId);
	}


}
