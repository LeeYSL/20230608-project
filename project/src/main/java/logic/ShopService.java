package logic;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.RestaurantDao;
import dao.UserDao;

@Service
public class ShopService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private RestaurantDao restaurantDao;
	


	public void userInsert(@Valid User user) {
		userDao.insert(user);
		
	}

}
