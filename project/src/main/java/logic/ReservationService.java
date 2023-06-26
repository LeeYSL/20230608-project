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


	
	public void restauInsert(@Valid Restaurant restaurant) {
		restaurantDao.insert(restaurant);
	}

	public void dayoffInsert(@Valid Dayoff dayoff) {
		restaurantDao.insertDayoff(dayoff);
	}
	
	public void menuInsert(@Valid Menu menu) {
		restaurantDao.insertMenu(menu);
	}

	public void bookinsert(@Valid Reservation reservation) {
		reservationDao.bookInsert(reservation);
		
	}
	
	public List<Reservation> myList(String userId, Integer pageNum, int limit) {
		return reservationDao.myList(userId,pageNum,limit);
		
	}

	public List<Restaurant> ownerRest(String userId) {
	     return restaurantDao.ownerRest(userId);
		
		
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

	public void ownerconfirm(int num,int confirm) {
		reservationDao.ownerconfirm(num,confirm);
		
	}

	public List<Restaurant> restList(Integer pageNum, int limit, String type, String searchcontent) {
		return restaurantDao.restList(pageNum,limit,type,searchcontent);
	}
	public List<Reservation> ownerList(String userId, int pageNum, int limit) {
		return reservationDao.ownerRest(userId,pageNum,limit);
	}

	public int listcount() {
		return  reservationDao.listCount();
	}

	public int restListcount(String type, String searchcontent) {
		return restaurantDao.restListcount(type,searchcontent);
	}


	

	}
