package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.RestaurantMapper;
import logic.Dayoff;
import logic.Restaurant;
import logic.Menu;
import logic.Reservation;


@Repository
public class RestaurantDao {
	@Autowired
	private SqlSessionTemplate template; //SqlSessionFactory랑 비슷한 거 자동으로 커밋 롤백 수행함
	private Map<String,Object> param = new HashMap<>();
	private Class<RestaurantMapper> cls = RestaurantMapper.class;
	
	
	public void insert(@Valid Restaurant restaurant) {
		template.getMapper(cls).insert(restaurant);
	}
	
	public void insertDayoff(@Valid Dayoff dayoff) {
		template.getMapper(cls).insertDayoff(dayoff);
	}
	
	public void insertMenu(@Valid Menu menu) {
		template.getMapper(cls).insertMenu(menu);
	}
	
	public Restaurant maxSelect() {
		return template.getMapper(cls).maxSelect();
	}

	public List<Restaurant> restList(Integer pageNum, int limit, String type, String searchcontent) {
		param.clear();
		param.put("pageNum", (pageNum-1) * limit); 
		param.put("limit", limit);
		param.put("type", type);
		param.put("searchcontent",searchcontent);
		
		System.out.println("pageNum" + pageNum);
		System.out.println("type"+type);
		System.out.println("searchcontent" + searchcontent);
		return template.getMapper(cls).restList(param);
	}

	public List<Restaurant> ownerRest(String userId) {
		return  template.getMapper(cls).ownerRest(userId);
	}

	public int restListcount(String type, String searchcontent) {
		param.clear();
		param.put("type", type);
		param.put("searchcontent",searchcontent);
		
		System.out.println("type" + searchcontent);
		System.out.println("searchcontent" + searchcontent);
		
		return template.getMapper(cls).restListcount(param);
	}

	public Restaurant restInfo(int num) {
		return template.getMapper(cls).restInfo(num);
	}

	public List<Menu> menuList(int num) {
		return template.getMapper(cls).menuList(num);
	}

	public Dayoff dayoffList(int num) {
		return template.getMapper(cls).dayoffList(num);
	}

	
	
}
