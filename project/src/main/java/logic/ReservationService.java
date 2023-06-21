package logic;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ReservationDao;
import dao.RestaurantDao;

@Service
public class ReservationService {
	
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
		reservationDao.bookInsert(reservation);
		
	}
	
	public List<Reservation> myList(String userId) {
		return reservationDao.myList(userId);
		
	}

	public List<Reservation> ownerList(String userId) {
	     return reservationDao.ownerList(userId);
		
		
	}

	public Reservation selectOne(Integer num) {
		return reservationDao.selectOne(num);
		
		
	}

	public void myListUpdate(@Valid Reservation reservation) {
		 reservationDao.myListUpdate(reservation);
		
	}
	public Restaurant maxSelect() {
		return restaurantDao.maxSelect();
	}

	public void ownerconfirm(int confirm) {
		reservationDao.ownerconfirm(confirm);
		
	}

		
	}
