package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.ReservationMapper;
import logic.Reservation;


@Repository
public class ReservationDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	private Class<ReservationMapper> cls = ReservationMapper.class;
	
	

	public void bookinsert(@Valid Reservation reservation) {
		template.getMapper(cls).bookinsert(reservation);
	}

	public List<Reservation> list() {
		param.clear();
		return template.getMapper(cls).rsrvtselect(); //내가 담아 놓은 걸 가져가야 되니까 매개변수에 param
	}

}
