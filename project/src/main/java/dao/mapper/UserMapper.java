package dao.mapper;

import java.util.List;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.User;

public interface UserMapper {

	@Insert("insert into user (user_id, pw, nickname, name, address, tel, batch, file1, reg_date) "
			+ " values (#{userId}, #{pw}, #{nickname}, #{name}, #{address}, #{tel}, #{batch},#{fileurl}, now())")
	void insert(@Valid User user);
  
	@Select("select * from user where user_id=#{userId}")
	User selectOne(String userId);
	
	@Update("update user set nickname=#{nickname}, address=#{address}, tel=#{tel}, file1=#{fileurl} where user_id=#{userId}")
	void update(@Valid User user);

	@Delete("delete from user where user_id=#{userId}")
	void delete(String userId);

	@Select("select * from user")
	List<User> list();

	@Select("select user_id, pw, nickname, name, address, tel, batch, file1 fileurl, reg_date from user where user_id=#{userId}")
	List<User> myulist(String userId);
	
	
}