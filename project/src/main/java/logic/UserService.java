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
import dao.RestaurantDao;
import dao.UserDao;

@Service
public class UserService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private BoardDao boardDao;
	@Autowired
	private CommentDao commDao;
	@Autowired
	private RestaurantDao restDao;
	

	public void userInsert(@Valid User user, HttpSession session) {
		if(user.getFile1() != null && !user.getFile1().isEmpty()) {
			 String path = session.getServletContext().getRealPath("/") + "user/file/";
			 this.uploadFileCreate(user.getFile1(),path);
			 user.setFileurl(user.getFile1().getOriginalFilename());
		}
		userDao.insert(user);	
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


	public User selectOne(String userId) {
		return userDao.selectOne(userId); 
	}


	
	
	public void update(User user, HttpSession session) {
		if(user.getFile1() != null && !user.getFile1().isEmpty()) {
			String path = session.getServletContext().getRealPath("/") + "user/file/";
			this.uploadFileCreate(user.getFile1(), path);  
			user.setFileurl(user.getFile1().getOriginalFilename());
		}		
		userDao.update(user);		
	}




	public void delete(String userId) {
		userDao.delete(userId);
		
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

/*
	public List<Comment> commlist(Integer num) {
		
		return commDao.commlist(num);
	}
*/

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

/*
	public List<Board> myblist(String userId) {
		return boardDao.myblist(userId);
	}


	public List<Comment> myclist(String userId) {
		return commDao.myclist(userId);
	}

*/
	public List<User> myulist(String userId) {
		return userDao.myulist(userId);
	}





	public String idsearch(String tel, String name) {
		return userDao.idsearch(tel,name);
	}




	public String getSearch(User user) {
		return userDao.search(user);
	}


	public void userChgpass(String userId, String chgpass) {
		userDao.chgpass(userId,chgpass);
	}


	public List<User> getUserlist() {
		return userDao.list(); 
	}


	public List<User> emailList(String email) {
		return userDao.emailList(email);
	}


	public int myblistcount(String userId) {
		return boardDao.myblistcount(userId);
	}


	public int usercount(String type, String searchcontent) {
		return userDao.usercount(type,searchcontent);
	}


	public List<User> userlist(int limit, Integer pageNum, String type, String searchcontent) {
		return userDao.userlist(limit, pageNum, type, searchcontent); 
	}


	public User selectOneEmail(String email) {
		return userDao.selectOneEmail(email);
	}


	public User selectOneTel(String tel) {
		return userDao.selectOneTel(tel);
	}


	public User selectOneNickname(String nickname) {
		return userDao.selectOneNickname(nickname);
	}


	public User selectTel(String tel, String userId) {
		return userDao.selectTel(tel,userId);
	}


	public User selectNickname(String nickname, String userId) {
		return userDao.selectNickname(nickname,userId);
	}
 

	public List<User> getUserList(String[] idchks) {
		return userDao.list(idchks);
	}


	public void reply(@Valid Board board) {
		boardDao.updateGrpStep(board);
		int max = boardDao.maxNum();
		board.setNum(++max);
		board.setGrpLevel(board.getGrpLevel()+1);
		board.setGrpStep(board.getGrpStep()+1);
		boardDao.write(board);
		
	}


	public void deleteUser(String delYn, String userId) {
		userDao.deleteUser(delYn,userId);
		
	}


	public List<Board> myblist(String userId, int limit, Integer pageNum) {
		return boardDao.myblist(userId, limit, pageNum);
	}


	public int myclistcount(String userId) {
		return commDao.myclistcount(userId);
	}


	public List<Comment> myclist(String userId, int limit, Integer pageNum) {
		return commDao.myclist(userId, limit, pageNum);
	}


	public int commcount(Integer num) {
		return commDao.commcount(num);
	}


	public List<Comment> commlist(Integer num, int limit, Integer pageNum) {
		return commDao.commlist(num, limit, pageNum);
	}


	public int restcount(String type, String searchcontent) {
		return restDao.restcount(type,searchcontent);
	}


	public List<Restaurant> restaurantlist(int limit, Integer pageNum, String type, String searchcontent) {
		return restDao.restaurantlist(limit, pageNum, type, searchcontent); 
	}


	public int admincount(String type, String searchcontent) {
		return userDao.admincount(type,searchcontent);
	}


	public List<User> adminlist(int limit, Integer pageNum, String type, String searchcontent) {
		return userDao.adminlist(limit, pageNum, type, searchcontent); 
	}


	public void restdelete(String restNum) {
		restDao.restdelete(restNum);
		
	}




}
