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
    
	//부등호를 사용하면 <![CDATA[ ]]>를 사용해야함
	@Select({ "<script>",
			" SELECT LEFT(A.rsrvt_date,8) AS rsrvt_date, RIGHT(A.rsrvt_date,2) AS rsrvt_time, A.num, A.rsrvt_name,A.rest_num,A.phone_no,A.people,A.point,B.name,B.delYn, ",
			" case when A.rsrvt_date  <![CDATA[ < ]]> to_char(NOW(),'YYYYMMDDHH') then '4' ELSE A.confirm END confirm",
			" FROM reservation A ",
			" JOIN restaurant B ",
			" ON A.rest_num = B.rest_num ",
			" WHERE A.user_id =#{userId} and B.delYn IS NULL ",
			" ORDER BY reg_date", 
			" <if test='limit != null'> limit #{pageNum}, #{limit} </if> ",
			" </script>" })
	List<Reservation> myListSelect(Map<String, Object> param);

	@Select("SELECT LEFT(A.rsrvt_date,8) AS rsrvt_date, RIGHT(A.rsrvt_date,2) AS rsrvt_time, A.num, A.rsrvt_name,A.phone_no,A.people,B.rest_phoneNo,B.name, "
			+ " case when A.rsrvt_date  <![CDATA[ < ]]> to_char(NOW(),'YYYYMMDDHH') then '4' ELSE A.confirm END confirm"
			+ " FROM reservation A " + " JOIN restaurant B " + "  ON A.rest_num = B.rest_num " + " WHERE A.num =#{num}"
			+ " ORDER BY reg_date")
	Reservation selectOne(int num);

	@Update("update reservation set rsrvt_name=#{rsrvtName},phone_no=#{phoneNo} where num = #{num}")
	void myListUpdate(@Valid Reservation reservation);

	@Update("update reservation set confirm= #{confirm} where num = #{num}")
	void ownerconfirm(@Param("num") int num, @Param("confirm") int confirm);

	@Select("select count(*) from reservation A JOIN restaurant B ON A.rest_num = B.rest_num WHERE A.user_id = #{userId} and B.delYn IS NULL")
	int myListCount(String userId);
	
	@Select("select count(*) from reservation A JOIN restaurant B ON A.rest_num = B.rest_num WHERE B.user_id = #{userId} and B.delYn IS NULL")
	int ownerListCount(String userId);
    
	@Select({ "<script>",
	        " SELECT LEFT(A.rsrvt_date,8) AS rsrvt_date, RIGHT(A.rsrvt_date,2) AS rsrvt_time, A.num, A.user_id, A.rsrvt_name, ",
			"	  A.phone_no,A.people,B.rest_num, B.name, B.delYn," ,
			" case when A.rsrvt_date  <![CDATA[ < ]]> to_char(NOW(),'YYYYMMDDHH') then '4' ELSE A.confirm END confirm",
			"	  FROM reservation A ",
			"	  JOIN restaurant B " ,
		    "	  ON A.rest_num = B.rest_num " ,
			"	  WHERE B.user_id = #{userId} and B.delYn IS NULL",
			"	  ORDER BY rest_num, reg_date" ,
			"    <if test='limit != null'> limit #{pageNum}, #{limit} </if> ",
        	"    </script>" })
	List<Reservation> ownerListSelect(Map<String, Object> param);

	@Select("select * from restaurant where rest_num=#{num}")
	Restaurant restInfoadd(int num);


/*	@Insert({"<script>",
		    " insert into reservation(point) values #{point}",
		    " select A.rest_num,B.rest_num ",
		    " from reservation A, ",
		    "      restaurant B ",
		    " where A.rest_num = B.rest_num ",
		    "</script>"	}) */
	
	@Update("update reservation set point=#{point} where num=#{num}")
	void pointInsert(@Param("num")int num, @Param("point") Integer point);

}
