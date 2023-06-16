package dao;

import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.BoardMapper;
import dao.mapper.UserMapper;
import logic.User;

@Repository
public class UserDao {
	@Autowired
	private SqlSessionTemplate template;
	private Map<String,Object> param = new HashMap<>();
	private Class<UserMapper> cls = UserMapper.class;
	
	
	
	public void insert(@Valid User user) {
		template.getMapper(cls).insert(user);
		
		
	}

	public User selectOne(String userId) {
		return template.getMapper(cls).selectOne(userId);
	}

	public void update(@Valid User user) {
		template.getMapper(cls).update(user);
		
	}

	public void delete(String userId) {
		template.getMapper(cls).delete(userId);
		
	}

}
