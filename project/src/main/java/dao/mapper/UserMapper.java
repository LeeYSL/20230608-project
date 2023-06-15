package dao.mapper;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.User;

public interface UserMapper {

	@Insert("insert into user (user_id, pw, nickname, name, birthday, address, email, tel, batch) "
			+ " values (#{userId}, #{pw}, #{nickname}, #{name}, #{birthday}, #{address}, #{email}, #{tel}, #{batch})")
	void insert(@Valid User user);

	@Select("select * from user where user_id=#{userId}")
	User selectOne(String userId);
}
