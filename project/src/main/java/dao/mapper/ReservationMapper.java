package dao.mapper;

import java.util.List;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Reservation;

public interface ReservationMapper {

	@Insert("insert into reservation(num, rest_num, rsrvt_date, people, reg_date, confirm, "
			+ " phone_no,rsrvt_name,user_id ) "
			+ " values ((SELECT NVL(MAX(num), 0) + 1 FROM reservation A),#{restNum},#{rsrvtDate},#{people},now(),#{confirm},#{phoneNo},#{rsrvtName},#{userId})")
	void bookInsert(@Valid Reservation reservation);

	@Select("SELECT LEFT(A.rsrvt_date,8) AS rsrvt_date, RIGHT(A.rsrvt_date,2) AS rsrvt_time, A.num, A.rsrvt_name,A.phone_no,A.people,A.confirm,B.name "
			+ " FROM reservation A "
			+ " JOIN restaurant B "
			+ "  ON A.rest_num = B.rest_num "
			+ " WHERE A.user_id =#{userId}"
			+ " ORDER BY reg_date")
	List<Reservation> myListSelect(String userId);

	@Select(" SELECT LEFT(A.rsrvt_date,8) AS rsrvt_date, RIGHT(A.reg_date,2) AS rsrvt_time, A.num, A.user_id, A.rsrvt_name, "
	 		+ "	 A.phone_no,A.people,A.confirm,B.rest_num, B.name "
	 		+ "	  FROM reservation A "
	 		+ "	  JOIN restaurant B "
	 		+ "	  ON A.rest_num = B.rest_num "
	 		+ "	     WHERE B.user_id = #{userId} "
	 		+ "	     ORDER BY rest_num, reg_date")		  
	List<Reservation> ownerListSelect(String userId);

	@Select("SELECT LEFT(A.rsrvt_date,8) AS rsrvt_date, RIGHT(A.rsrvt_date,2) AS rsrvt_time, A.num, A.rsrvt_name,A.phone_no,A.people,A.confirm,B.name "
			+ " FROM reservation A "
			+ " JOIN restaurant B "
			+ "  ON A.rest_num = B.rest_num "
 		    + " WHERE A.num =#{num}"
			+ " ORDER BY reg_date")
	Reservation selectOne(int num);

    @Update("updat reservation set rsrvt_name=#{rsrvtNmae},phone_no=#{phoneNo} ")
	void myListUpdate(@Valid Reservation reservation);

	
}

