package dao.mapper;

import java.util.List;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Dayoff;
import logic.Reservation;
import logic.Restaurant;
import logic.Menu;

public interface RestaurantMapper {
  
	@Insert("insert into restaurant (rest_num, user_id, license_num, name, address, picture, maxpeople,open,close, rest_phoneNo ) "
			+ " values (#{restNum}, #{userId}, #{licenseNum}, #{name} ,#{address}, #{picture},#{maxpeople},#{open},#{close},#{restPhoneNo})")
	void insert(@Valid Restaurant restaurant);
	
	@Insert("insert into dayoff (rest_num, Mon, Tue, Wed, Thur, Fri, Sat, Sun, holiday) "
			+ " values (#{restNum}, #{mon}, #{tue},#{wed}, #{thur},#{fri},#{sat},#{sun},#{holiday})")
	void insertDayoff(@Valid Dayoff dayoff);
	
	@Insert("insert into menu (seq, rest_num, menu_name, price) "
			+ " values ((SELECT NVL(MAX(seq), 0) + 1 FROM menu A), #{restNum}, #{menuName}, #{price})")
	void insertMenu(@Valid Menu menu);


	
	@Select("SELECT NVL(MAX(rest_num),0) + 1 as rest_num FROM restaurant ")
	Restaurant maxSelect();

	@Select("select * from restaurant ")
	List<Restaurant> restList();

	
	@Select("select * from restaurant where user_id=#{userId}")
	List<Restaurant> ownerRest(String userId);
	
	

}
