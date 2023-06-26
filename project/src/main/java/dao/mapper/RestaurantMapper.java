package dao.mapper;

import java.util.List;
import java.util.Map;

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

	//@Select("select * from restaurant ")
	//List<Restaurant> restList(Map<String, Object> param);

	@Select({"<script>",
		   "select * from restaurant ",
		   " <if test='searchcontent != null'> where ${type} like '%${searchcontent}%'</if>",
		   " <if test='limit != null'> order by rest_num desc limit #{pageNum}, #{limit} </if>",
	       "</script>"})
	List<Restaurant> restList(Map<String, Object> param);
	
	@Select("select * from restaurant where user_id=#{userId}")
	List<Restaurant> ownerRest(String userId);
	
	
	@Select({"<script>",
			  "select count(*) from restaurant",
			  "<if test='type != null'> where ${type} like '%${searchcontent}%'</if>",
	          "</script>"})
	int restListcount(Map<String, Object> param);

	@Select("select * from restaurant where rest_num=#{num}")
	Restaurant restInfo(int num);

	@Select("select * from menu  where rest_num=#{num} ")
	List<Menu> menuList(int num);
 
	@Select("select * from dayoff  where rest_num=#{num} ")
	Dayoff dayoffList(int num);



	


}
