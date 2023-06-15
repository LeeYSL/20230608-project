package logic;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.BoardDao;
import dao.RestaurantDao;
import dao.UserDao;

@Service
public class ShopService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private RestaurantDao restaurantDao;
	@Autowired
	private BoardDao boardDao;
	


	public void userInsert(@Valid User user) {
		userDao.insert(user);
		
	}



	public void restauinsert(@Valid Restaurant restaurant) {
		restaurantDao.insert(restaurant);
	}

	public void dayoffInsert(@Valid Dayoff dayoff) {
		restaurantDao.insertDayoff(dayoff);
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

}
