package logic;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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


	public void write(@Valid Board board) {
		boardDao.write(board);
		
	}


}
