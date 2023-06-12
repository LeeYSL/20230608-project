package dao.mapper;

import org.apache.ibatis.annotations.Insert;

import logic.User;

public interface UserMapper {

	@Insert("insert into userId, pw, nickname, name, birthday, address, email, tel, batch "
			+ " values (#{userid}, #{pw}, #{nickname}, #{name}, #{birthday}, #{address}, #{email}, #{tel}, #{batch})")
	void insert(User user);
}
