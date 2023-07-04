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

	@Insert("insert into user (user_id, pw, nickname, name, address, tel, batch, file1, reg_date,channel,email,delYn) "
			+ " values (#{userId}, #{pw}, #{nickname}, #{name}, #{address}, #{tel}, #{batch},#{fileurl}, now(),#{channel},#{email},'N')")
	void insert(@Valid User user);

	
	@Update("update user set nickname=#{nickname}, address=#{address}, tel=#{tel}, file1=#{fileurl} where user_id=#{userId}")
	void update(User user);

	@Update("update user set delYn='Y', del_date=now() where user_id=#{userId}")
	void delete(String userId);

	@Select("select user_id, pw, nickname, name, address, tel, batch, file1 fileurl, reg_date,channel,email from user")
	List<User> list();

	@Select("select user_id, pw, nickname, name, address, tel, batch, file1 fileurl, reg_date from user where user_id=#{userId}")
	List<User> myulist(String userId);


	@Select("select user_id from user where email=#{email} and name=#{name}")
	String idsearch(@Param("email")String email, @Param("name")String name);

	@Update("update user set pw=#{pw} where user_id=#{userId}")
	void chgpass(Map<String, Object> param);

	@Select({"<script>","select ${col} from user where name=#{name} and email=#{email} "
			+ " <if test='userId !=null'> and user_id=#{userId}</if> ",
				"</script>"})
	String search(Map<String, Object> param);


	@Select("select * from user where email=#{email}")
	List<User> emailList(String email);

	@Select({"<script>",
				"select count(*) from user ",
				"<if test='type != null'> where ${type} like '%${searchcontent}%'</if>",
				"</script>"})
	int usercount(Map<String, Object> param);

	@Select({"<script>",
			"select * from user where delYn='N'",
			"<if test='searchcontent != null'> and ${type} like '%${searchcontent}%' </if>",
			"<if test='limit != null'> order by user_id asc limit #{startrow},#{limit} </if>",
			"</script>"})
	List<User> userlist(Map<String, Object> param);

	
	@Select("select email from user where email=#{email}")
	User selectOneEmail(String email);

	@Select("select tel from user where tel=#{tel}")
	User selectOneTel(String tel);

	@Select("select nickname from user where nickname=#{nickname}")
	User selectOneNickname(String nickname);


	@Select("select user_id, pw, nickname, name, address, tel, batch, file1 fileurl, reg_date,channel,email from user where user_id=#{userId} and delYn='N'")
	User selectOne(String userId);

	@Select("SELECT * FROM user WHERE tel=#{tel} AND  user_id != #{userId}")
	User selectTel(@Param("tel")String tel, @Param("userId")String userId);

	@Select("SELECT * FROM user WHERE nickname=#{nickname} AND   user_id != #{userId}")
	User selectNickname(@Param("nickname")String nickname, @Param("userId")String userId);

	@Select({"<script>",
		"select * from user ", 
		"<if test='userId != null'> where user_id=#{userId}</if>",
		"<if test='userIds != null'> where user_id in "
		+ "<foreach collection='userIds' item='id' separator=',' open='(' close=')'>#{id}" 
		+ "</foreach></if>",
		"</script>"})
	List<User> select(Map<String,Object> param);


	@Update("update user set delYn=#{delYn} where user_id=#{userId}")
	void deleteUser(@Param("delYn")String delYn,@Param("userId") String userId);









	
}