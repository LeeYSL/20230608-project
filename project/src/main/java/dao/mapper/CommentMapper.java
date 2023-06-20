package dao.mapper;

import java.util.List;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import logic.Comment;

public interface CommentMapper {

	@Select("select * from comment where num=#{num}")
	List<Comment> commlist(Integer num);

	@Insert("insert into comment (num, seq, user_id, date, content) values (#{num}, #{seq}, #{userId}, now(),#{content})")
	void commInsert(@Valid Comment comm);

	@Select("select ifnull(max(seq),0) from comment where num=#{num}")
	int commmaxseq(int num);

}
