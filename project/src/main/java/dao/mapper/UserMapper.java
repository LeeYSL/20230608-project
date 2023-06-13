package dao.mapper;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Insert;

import logic.User;

public interface UserMapper {

	@Insert("insert into user (user_Id, pw, nickname, name, birthday, address, email, tel, batch) "
			+ " values (#{userId}, #{pw}, #{nickname}, #{name}, #{birthday}, #{address}, #{email}, #{tel}, #{batch})")
	void insert(@Valid User user);
}
