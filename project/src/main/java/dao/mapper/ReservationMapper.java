package dao.mapper;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Reservation;
import logic.Restaurant;

public interface ReservationMapper {

	@Insert("insert into reservation(num, rest_num, rsrvt_date, people, reg_date, confirm, "
			+ " phone_no,rsrvt_name,user_id ) "
			+ " values ((SELECT NVL(MAX(num), 0) + 1 FROM reservation A),#{restNum},#{rsrvtDate},#{people},now(),#{confirm},#{phoneNo},#{rsrvtName},#{userId})")
	void bookInsert(@Valid Reservation reservation);

	@Select({ "<script>",
			" SELECT LEFT(A.rsrvt_date,8) AS rsrvt_date, RIGHT(A.rsrvt_date,2) AS rsrvt_time, A.num, A.rsrvt_name,A.phone_no,A.people,A.confirm,B.name ",
			" FROM reservation A ", " JOIN restaurant B ", "  ON A.rest_num = B.rest_num ",
			" WHERE A.user_id =#{userId}",
			" ORDER BY reg_date", 
			" <if test='limit != null'> limit #{pageNum}, #{limit} </if> ",
			"</script>" })
	List<Reservation> myListSelect(Map<String, Object> param);

	//@Select(" SELECT LEFT(A.rsrvt_date,8) AS rsrvt_date, RIGHT(A.reg_date,2) AS rsrvt_time, A.num, A.user_id, A.rsrvt_name, "
	//		+ "	  A.phone_no,A.people,A.confirm,B.rest_num, B.name " + "	  FROM reservation A "
	///		+ "	  JOIN restaurant B " + "	  ON A.rest_num = B.rest_num " + "	     WHERE B.user_id = #{userId} "
	//		+ "	     ORDER BY rest_num, reg_date")
	//List<Reservation> ownerListSelect(String userId);

	@Select("SELECT LEFT(A.rsrvt_date,8) AS rsrvt_date, RIGHT(A.rsrvt_date,2) AS rsrvt_time, A.num, A.rsrvt_name,A.phone_no,A.people,A.confirm,B.rest_phoneNo,B.name "
			+ " FROM reservation A " + " JOIN restaurant B " + "  ON A.rest_num = B.rest_num " + " WHERE A.num =#{num}"
			+ " ORDER BY reg_date")
	Reservation selectOne(int num);

	@Update("update reservation set rsrvt_name=#{rsrvtName},phone_no=#{phoneNo} where num = #{num}")
	void myListUpdate(@Valid Reservation reservation);

	@Update("update reservation set confirm= #{confirm} where num = #{num}")
	void ownerconfirm(@Param("num") int num, @Param("confirm") int confirm);

	@Select("select count(*) from reservation")
	int listCount();
    
	
	@Select({ "<script>",
	        " SELECT LEFT(A.rsrvt_date,8) AS rsrvt_date, RIGHT(A.rsrvt_date,2) AS rsrvt_time, A.num, A.user_id, A.rsrvt_name, ",
			"	  A.phone_no,A.people,A.confirm,B.rest_num, B.name " ,
			"	  FROM reservation A ",
			"	  JOIN restaurant B " ,
		    "	  ON A.rest_num = B.rest_num " ,
			"	  WHERE B.user_id = #{userId} ",
			"	  ORDER BY rest_num, reg_date" ,
			"    <if test='limit != null'> limit #{pageNum}, #{limit} </if> ",
        	"    </script>" })
	List<Reservation> ownerListSelect(Map<String, Object> param);

	@Select("select * from restaurant where rest_num=#{num}")
	Restaurant restInfoadd(int num);


	



}
