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

	public void update(User user) {
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


	public String search(User user) {
		String col = "userId";
		if(user.getUserId() != null) col = "pw";
		param.clear();
		param.put("col", col);
		param.put("userId", user.getUserId());
		param.put("email", user.getEmail());
		param.put("name", user.getName());
		return template.getMapper(cls).search(param);
	}

	public void chgpass(String userId, String chgpass) {
		param.clear();
		param.put("userId", userId);
		param.put("pw", chgpass);
		template.getMapper(cls).chgpass(param);
		
	}

	public List<User> emailList(String email) {
		return template.getMapper(cls).emailList(email);
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

	public User selectOneEmail(String email) {
		return template.getMapper(cls).selectOneEmail(email);
	}

	public User selectOneTel(String tel) {
		return template.getMapper(cls).selectOneTel(tel);
	}

	public User selectOneNickname(String nickname) {
		return template.getMapper(cls).selectOneNickname(nickname);
	}

	public User selectTel(String tel, String userId) {
		return template.getMapper(cls).selectTel(tel,userId);
	}

	public User selectNickname(String nickname, String userId) {
		return template.getMapper(cls).selectNickname(nickname,userId);
	}

	public List<User> list(String[] idchks) {
		param.clear();
		param.put("userids", idchks);
		return template.getMapper(cls).select(param);
	}
	
	public void deleteUser(String delYn, String userId) {
		template.getMapper(cls).deleteUser(delYn,userId);
		
	}

	public int admincount(String type, String searchcontent) {
		param.clear();
		param.put("type", type);
		param.put("searchcontent", searchcontent);
		return template.getMapper(cls).admincount(param);
	}

	public List<User> adminlist(int limit, Integer pageNum, String type, String searchcontent) {
		param.clear();
		param.put("limit", limit);
		param.put("startrow",(pageNum-1)*limit);
		param.put("type",type);
		param.put("searchcontent", searchcontent);
		return template.getMapper(cls).adminlist(param); 
	}

	public int nicknameCount(String nickname) {
		return template.getMapper(cls).nicknameCount(nickname);
	}

	public int userIdCount(String userId) {
		return template.getMapper(cls).userIdCount(userId);
	}

	public int telCount(String tel) {
		return template.getMapper(cls).telCount(tel);
	}

	public int emailCount(String email) {
		return template.getMapper(cls).emailCount(email);
	}

	public int deladmincount() {
		return template.getMapper(cls).deladmincount();
	}

	public int delusercount() {
		return template.getMapper(cls).delusercount();
	}

	public String dbpw(String userId) {
		return template.getMapper(cls).dbpw(userId);
	}
}