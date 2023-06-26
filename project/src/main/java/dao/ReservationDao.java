package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import controller.RestaurantController;
import dao.mapper.ReservationMapper;
import logic.Reservation;
import logic.Restaurant;


@Repository
public class ReservationDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	private Class<ReservationMapper> cls = ReservationMapper.class;
	
	

	public void bookInsert(@Valid Reservation reservation) {
		template.getMapper(cls).bookInsert(reservation);
	}

	 public List<Reservation> myList(String userId, Integer pageNum, int limit) {
		param.clear();
		param.put("userId", userId);
		param.put("pageNum", (pageNum-1) * limit); 
		param.put("limit", limit);

		return template.getMapper(cls).myListSelect(param); //내가 담아 놓은 걸 가져가야 되니까 매개변수에 param
	}

		public List<Reservation> ownerRest(String userId, int pageNum, int limit) {
		param.clear();
		param.put("userId", userId);
		param.put("pageNum", (pageNum-1) * limit); 
		param.put("limit", limit);
		return template.getMapper(cls).ownerListSelect(param);
	}

	public Reservation selectOne(int num) {
		return template.getMapper(cls).selectOne(num);
	}

	public void myListUpdate(@Valid Reservation reservation) {
		param.clear();
	//	param.put("name",reservation.getName());
	//	param.put("restPhoneNo",reservation.getRestPhoneNo());
		param.put("rsrvtName",reservation.getRsrvtName());
	//	param.put("rsrvtDate",reservation.getRsrvtDate());
	//	param.put("rsrvtTime",reservation.getRsrvtTime());
		param.put("phoneNo", reservation.getPhoneNo());
	    template.getMapper(cls).myListUpdate(reservation);
		
	}

	public void ownerconfirm(int num,int confirm) {
		template.getMapper(cls).ownerconfirm(num,confirm);
		
	}

	public int listCount() {
		return template.getMapper(cls).listCount();
	}

}
