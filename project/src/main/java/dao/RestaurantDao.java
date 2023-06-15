package dao;

import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.RestaurantMapper;
import logic.Dayoff;
import logic.Restaurant;


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

}
