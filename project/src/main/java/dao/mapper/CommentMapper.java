package dao.mapper;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import logic.Comment;
import logic.User;

public interface CommentMapper {

	@Select("select * from comment where num=#{num}")
	List<Comment> commlist(Integer num);

	@Insert("insert into comment (num, seq, user_id, date, content) values (#{num}, #{seq}, #{userId}, now(),#{content})")
	void commInsert(@Valid Comment comm);

	@Select("select ifnull(max(seq),0) from comment where num=#{num}")
	int commmaxseq(int num);

	@Delete("delete from comment where num=#{num} and seq=#{seq} ")
	void commdelete(@Param("num")int num, @Param("seq")int seq);
/*
	@Select("select * from comment c join board b  on c.num = b.num where c.user_id=#{userId} ")
	List<Comment> myclist(String userId);
*/
	@Select("select count(*) from comment where user_id=#{userId}")
	int myclistcount(String userId);

	@Select({"<script>",
		"select num, seq, user_id, date, content from comment",
		"<if test='num != null'> where num = #{num} </if>",
		"<if test='userId != null'> where user_id = #{userId} </if>",
		"<if test='limit != null'> order by date desc limit #{startrow}, #{limit} </if>",
		"</script>"})	
	List<Comment> myclist(Map<String, Object> param);


}
