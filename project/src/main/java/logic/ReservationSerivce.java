package logic;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;

import dao.RestaurantDao;

public class ReservationSerivce {
	
	@Autowired
	private RestaurantDao restaurantDao;

	
	public void restauinsert(@Valid Restaurant restaurant) {
		restaurantDao.insert(restaurant);
	}

	public void dayoffInsert(@Valid Dayoff dayoff) {
		restaurantDao.insertDayoff(dayoff);
	}
}