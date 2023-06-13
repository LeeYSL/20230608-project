package dao.mapper;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Restaurant;

public interface RestaurantMapper {

	@Insert("insert into restaurant (rest_num, user_id, tel, license_num, name, address, picture) "
			+ " values (#{restNum}, #{userId}, #{tel}, #{licenseNum}, #{name} ,#{address}, #{picture})")
	void insert(@Valid Restaurant restaurant);
	

}
