package logic;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDao;
import dao.UserDao;

@Service
public class UserService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private BoardDao boardDao;
	

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


	public List<Board> boardlist(String boardId) {
		return boardDao.boardlist(boardId);
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


}
