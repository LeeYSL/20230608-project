package logic;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ReservationDao;
import dao.RestaurantDao;

@Service
public class ReservationSerivce {
	
	@Autowired
	private RestaurantDao restaurantDao;
	@Autowired
	private ReservationDao reservationDao;


	
	public void restauinsert(@Valid Restaurant restaurant) {
		restaurantDao.insert(restaurant);
	}

	public void dayoffInsert(@Valid Dayoff dayoff) {
		restaurantDao.insertDayoff(dayoff);
	}

	public void bookinsert(@Valid Reservation reservation) {
		reservationDao.bookinsert(reservation);
		
	}
}
