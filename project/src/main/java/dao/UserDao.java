package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

	public List<User> list() {
		return template.getMapper(cls).list();
	}

	public List<User> myulist(String userId) {
		return template.getMapper(cls).myulist(userId);
	}



	public String idsearch(String tel, String name) {
		return template.getMapper(cls).idsearch(tel,name);
	}

	public List<User> list(String[] idchks) {
		param.clear();
		param.put("userIds", idchks);
		return template.getMapper(cls).select(param);
	}

	public String search(User user) {
		String col = "userId";
		if(user.getUserId() != null) col = "pw";
		param.clear();
		param.put("col", col);
		param.put("userId", user.getUserId());
		param.put("tel", user.getTel());
		param.put("name", user.getName());
		return template.getMapper(cls).search(param);
	}

	public void chgpass(String userId, String chgpass) {
		param.clear();
		param.put("userId", userId);
		param.put("pw", chgpass);
		template.getMapper(cls).chgpass(param);
		
	}

	public List<User> telList(String tel) {
		return template.getMapper(cls).telList(tel);
	}

	public int usercount(String type, String searchcontent) {
		param.clear();
		param.put("type", type);
		param.put("searchcontent", searchcontent);
		return template.getMapper(cls).usercount(param);
	}

	public List<User> userlist(int limit, Integer pageNum, String type, String searchcontent) {
		param.clear();
		param.put("limit", limit);
		param.put("startrow",(pageNum-1)*limit);
		param.put("type",type);
		param.put("searchcontent", searchcontent);
		return template.getMapper(cls).userlist(param);
	}



}