package dao.mapper;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Dayoff;
import logic.Restaurant;

public interface RestaurantMapper {
  
	@Insert("insert into restaurant (rest_num, user_id, tel, license_num, name, address, picture, maxpeople,open,close ) "
			+ " values (#{restNum}, #{userId}, #{tel}, #{licenseNum}, #{name} ,#{address}, #{picture},#{maxpeople},#{open},#{close})")
	void insert(@Valid Restaurant restaurant);
	
	@Insert("insert into dayoff (rest_num, user_id, Mon, Tue, Wed, Thur, Fri, Sat, Sun, holiday) "
			+ " values (#{restNum}, #{userId}, #{mon}, #{tue},#{wed}, #{thur},#{fri},#{sat},#{sun},#{holiday})")
	void insertDayoff(@Valid Dayoff dayoff);

}
