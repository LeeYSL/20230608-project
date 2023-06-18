package dao.mapper;

import java.util.List;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Reservation;

public interface ReservationMapper {
   
	 @Insert("insert into reservation(num, rest_num, rsrvt_date, people, reg_date, confirm, "
			  + " phone_no,rsrvt_name,user_id ) "
			  + " values (#{num},#{restNum},#{rsrvtDate},#{people},now(),#{confirm},#{phoneNo},#{rsrvtName},#{userId})")
	void bookinsert(@Valid Reservation reservation);

	 @Select("select * from reservation order by num desc")
	 
	List<Reservation> rsrvtselect();



	

}

