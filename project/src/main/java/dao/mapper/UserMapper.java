package dao.mapper;

import java.util.List;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.User;

public interface UserMapper {

	@Insert("insert into user (user_id, pw, nickname, name, birthday, address, email, tel, batch) "
			+ " values (#{userId}, #{pw}, #{nickname}, #{name}, #{birthday}, #{address}, #{email}, #{tel}, #{batch})")
	void insert(@Valid User user);
  
	@Select("select * from user where user_id=#{userId}")
	User selectOne(String userId);
	
	@Update("update user set nickname=#{nickname}, address=#{address}, email=#{email}, tel=#{tel} where user_id=#{userId}")
	void update(@Valid User user);

	@Delete("delete from user where user_id=#{userId}")
	void delete(String userId);

	@Select("select * from user")
	List<User> list();
}