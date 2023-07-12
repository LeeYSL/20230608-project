package dao.mapper;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.annotations.Delete;

import logic.Dayoff;
import logic.Reservation;
import logic.Restaurant;
import logic.Menu;

public interface RestaurantMapper {

	@Insert("insert into restaurant (rest_num, user_id, license_num, name, address, picture, maxpeople,open,close, rest_phoneNo ) "
			+ " values (#{restNum}, #{userId}, #{licenseNum}, #{name} ,#{address}, #{fileurl},#{maxpeople},#{open},#{close},#{restPhoneNo})")
	void insert(@Valid Restaurant restaurant);

	@Insert("insert into dayoff (rest_num, Mon, Tue, Wed, Thur, Fri, Sat, Sun, holiday) "
			+ " values (#{restNum}, #{mon}, #{tue},#{wed}, #{thur},#{fri},#{sat},#{sun},#{holiday})")
	void insertDayoff(@Valid Dayoff dayoff);

	@Insert("insert into menu (seq, rest_num, menu_name, price) "
			+ " values ((SELECT NVL(MAX(seq), 0) + 1 FROM menu A), #{restNum}, #{menuName}, #{price})")
	void insertMenu(@Valid Menu menu);

	@Select("SELECT NVL(MAX(rest_num),0) + 1 as rest_num FROM restaurant ")
	Restaurant maxSelect();

	// @Select("select * from restaurant ")
	// List<Restaurant> restList(Map<String, Object> param);

	@Select({ "<script>",
			" select rest_num, user_id, license_num, name, address, picture fileurl, maxpeople,open,close, rest_phoneNo  from restaurant ",
			" where delYn IS NULL ", 
			" <if test='searchcontent != null'>", 
			" <choose>",
			" <when test=\"type.equalsIgnoreCase('menu')\">",
			"and rest_num IN (select rest_num from menu where menu_name like '%${searchcontent}%')", 
			" </when>",
			" <otherwise>", 
			"and ${type} like '%${searchcontent}%'", 
			" </otherwise>", 
			" </choose>", 
			"</if>",
			" <if test='limit != null'> order by rest_num desc limit #{pageNum}, #{limit} </if>", "</script>" })
	List<Restaurant> restList(Map<String, Object> param);

	@Select("select * from restaurant where user_id=#{userId} and delYn IS NULL")
	List<Restaurant> ownerRest(@Param("userId") String userId, @Param("delYn") String delYn);

	@Select({ "<script>", "select count(*) from restaurant",
			" where delYn IS NULL ", 
			" <if test='searchcontent != null'>", 
			" <choose>",
			" <when test=\"type.equalsIgnoreCase('menu')\">",
			"and rest_num IN (select rest_num from menu where menu_name like '%${searchcontent}%')", 
			" </when>",
			" <otherwise>", 
			"and ${type} like '%${searchcontent}%'", 
			" </otherwise>", 
			" </choose>", 
			"</if>",
			"</script>" })
	int restListcount(Map<String, Object> param);

	@Select("select rest_num, user_id, license_num, name, address, picture fileurl, maxpeople,open,close, rest_phoneNo from restaurant where rest_num=#{num}")
	Restaurant restInfo(int num);

	@Select("select * from menu  where rest_num=#{num} ")
	List<Menu> menuList(int num);

//	@Select("select * from dayoff  where rest_num=#{num} and COALESCE(Mon,Tue,Wed,Thur,Fri,Sat,Sun) is not null")
//	Dayoff dayoffList(int num);

	@Select("select * from dayoff  where rest_num=#{num}")
	Dayoff dayoffList(int num);

	@Update("update restaurant set delYn=#{delYn} where rest_num=#{num} ")
	void deleteRest(@Param("delYn") String delYn, @Param("num") int num);

	@Update({ "<script>",
			"update restaurant set name=#{name}, address=#{address}, maxpeople=#{maxpeople},open=#{open},close=#{close},rest_phoneNo=#{restPhoneNo}",
			"<if test='fileurl != null'> ,picture=#{fileurl}</if>", "where rest_num = #{restNum}", "</script>" })
	void restUpdate(@Valid Restaurant restaurant);

	@Delete("delete from dayoff where rest_num=#{num}")
	void deleteDayoff(int num);

	@Delete("delete from menu where rest_num=#{num}")
	void deleteMenu(int num);

	@Select("select round(ifnull(avg(POINT),0),1) from reservation where rest_num=#{num}")
	double pointAvg(@Param("num") int num);

	//정주리
	@Select({"<script>",
		"select count(*) from restaurant ",
		"<if test='type != null'> where ${type} like '%${searchcontent}%'</if>",
		"</script>"})
	int restcount(Map<String, Object> param);


	//정주리
	@Select({"<script>",
		"select * from restaurant ",
		"<if test='searchcontent != null'> where ${type} like '%${searchcontent}%' </if>",
		"<if test='limit != null'> order by name limit #{startrow},#{limit} </if>",
		"</script>"})
	List<Restaurant> restaurantlist(Map<String, Object> param);

	@Update("update restaurant set delYn='Y' where rest_num=#{restNum}")
	void restdelete(String restNum);

//	@Select("select * from restaurant where user_id=#{userId} and delYn IS NULL ")
//	List<Restaurant> MyRest(String userId, String delYn);
}
