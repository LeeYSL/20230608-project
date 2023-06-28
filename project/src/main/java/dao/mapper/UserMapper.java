package dao.mapper;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.User;

public interface UserMapper {

	@Insert("insert into user (user_id, pw, nickname, name, address, tel, batch, file1, reg_date,channel,email) "
			+ " values (#{userId}, #{pw}, #{nickname}, #{name}, #{address}, #{tel}, #{batch},#{fileurl}, now(),#{channel},#{email})")
	void insert(@Valid User user);
  
	@Select("select * from user where user_id=#{userId}")
	User selectOne(String userId);
	
	@Update("update user set nickname=#{nickname}, address=#{address}, tel=#{tel}, file1=#{fileurl} where user_id=#{userId}")
	void update(@Valid User user);

	@Delete("delete from user where user_id=#{userId}")
	void delete(String userId);

	@Select("select * from user")
	List<User> list();

	@Select("select user_id, pw, nickname, name, address, tel, batch, file1 fileurl, reg_date from user where user_id=#{userId}")
	List<User> myulist(String userId);


	@Select("select user_id from user where tel=#{tel} and name=#{name}")
	String idsearch(@Param("tel")String tel, @Param("name")String name);

	@Update("update user set pw=#{pw} where user_id=#{userId}")
	void chgpass(Map<String, Object> param);

	@Select({"<script>","select ${col} from user where name=#{name} and tel=#{tel} "
			+ " <if test='userId !=null'> and user_id=#{userId}</if> ",
				"</script>"})
	String search(Map<String, Object> param);
	
	@Select({"<script>",
				"select * from user ",
				"<if test='userId != null'> where user_id=#{userId}</if>",
				"<if test='userids != null'> where userid in "
						+ "<foreach collection='userIds' item='id' separator=',' open='(' close=')'>#{id}" 
						+ "</foreach></if>",
						"</script>"})
	List<User> select(Map<String, Object> param);

	@Select("select * from user where tel=#{tel}")
	List<User> telList(String tel);


	
}