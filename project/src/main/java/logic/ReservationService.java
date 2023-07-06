package logic;

import java.awt.Point;
import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import dao.ReservationDao;
import dao.RestaurantDao;

@Service
public class ReservationService {
	
	@Autowired
	private RestaurantDao restaurantDao;
	@Autowired
	private ReservationDao reservationDao;


	
	public void restauInsert(@Valid Restaurant restaurant, HttpSession session) {
		if(restaurant.getPicture() != null && !restaurant.getPicture().isEmpty()) {
			 String path = session.getServletContext().getRealPath("/") + "restaurant/file/";
			 this.uploadFileCreate(restaurant.getPicture(),path);
			 restaurant.setFileurl(restaurant.getPicture().getOriginalFilename());
		}
		restaurantDao.insert(restaurant);
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

	public void dayoffInsert(@Valid Dayoff dayoff) {
		restaurantDao.insertDayoff(dayoff);
	}
	
	public void menuInsert(@Valid Menu menu) {
		restaurantDao.insertMenu(menu);
	}

	public void bookinsert(@Valid Reservation reservation) {
		reservationDao.bookInsert(reservation);
		
	}
	
	public List<Reservation> myList(String userId, Integer pageNum, int limit, String delYn) {
		return reservationDao.myList(userId,pageNum,limit,delYn);
		
	}

	public List<Restaurant> ownerRest(String userId,String delYn) {
	     return restaurantDao.ownerRest(userId,delYn);
		
		
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

	public List<Restaurant> restList(Integer pageNum, int limit, String type, String searchcontent, String delYn) {
		return restaurantDao.restList(pageNum,limit,type,searchcontent,delYn);
	}
	public List<Reservation> ownerList(String userId, int pageNum, int limit,String delYn, int num) {
		return reservationDao.ownerRest(userId,pageNum,limit,delYn,num);
	}

	public int myListCount(String userId) {
		return  reservationDao.myListCount(userId);
	}
	
	public int ownerListCount(String userId, int num) {
		return  reservationDao.ownerListCount(userId, num);
	}

	public int restListcount(String type, String searchcontent) {
		return restaurantDao.restListcount(type,searchcontent);
	}

	public Restaurant restInfo(int num) {
		return restaurantDao.restInfo(num);
	}

	public List<Menu> menuList(int num) {
		return restaurantDao.menuList(num);
	}

	public Dayoff dayoffList(int num) {
		return restaurantDao.dayoffList(num);
	}

	public Restaurant restInfoadd(int Num) {
	     return reservationDao.restInfoadd(Num);
		
	}

	public void deleteRest(String delYn, int num) {
		restaurantDao.deleteRest(delYn,num);
		
	}

	public void restUpdate(@Valid Restaurant restaurant, HttpSession session) {
		if(restaurant.getPicture() != null && !restaurant.getPicture().isEmpty()) {
			 String path = session.getServletContext().getRealPath("/") + "restaurant/file/";
			 this.uploadFileCreate(restaurant.getPicture(),path);
			 restaurant.setFileurl(restaurant.getPicture().getOriginalFilename());
		}
		restaurantDao.restUpdate(restaurant);
		
	}

	public void deleteDayoff(int num) {
		restaurantDao.deleteDayoff(num);
	}
	
	public void deleteMenu(int num) {
		restaurantDao.deleteMenu(num);
	}

	public void pointInsert(int num, Integer point) {
		reservationDao.pointInsert(num,point);
		
	}

	public double PointAvg(int num) {
	   return restaurantDao.pointAvg(num);
	}
	
	public Reservation checkReservation(int num, String date, String time) {
		return reservationDao.checkReservation(num, date, time);
	}

	public List<Reservation> Myrsrvt(String userId, int limit, Integer pageNum) {
		return reservationDao.Myrsrvt(userId,limit,pageNum);
//	}

//	public List<Restaurant> MyRest(String userId, String delYn) {
//		return restaurantDao.MyRest(userId,delYn);
	}
	public int myrlistcount(String userId) {
		return reservationDao.myrlistcount(userId);
	}


}
