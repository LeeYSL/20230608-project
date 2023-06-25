package dao.mapper;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Board;

public interface BoardMapper {
	
	

	@Insert("insert into board (num, user_id, title, content, file1, reg_date, read_cnt, board_id, grp, grp_level, grp_step, comm_cnt, open) "
			+ " values (#{num}, #{userId},#{title}, #{content}, #{fileurl}, now(), #{readCnt}, #{boardId}, #{grp}, #{grpLevel}, #{grpStep}, #{commCnt}, #{open}) ")
	void write(@Valid Board board);

	


	@Select("select ifnull(max(num),0) from board")
	int maxNum();

	@Select("select * from board where num=#{num}")
	Board detail(Integer num);

	@Update ("update board set read_cnt= read_cnt+1 where num=#{num}")
	void addReadcnt(Integer num);
	




	@Update("update board set title=#{title},content=#{content},file1=#{fileurl} where num=#{num}")
	void update(@Valid Board board);



	@Delete("delete from board where num=#{num}")
	void delete(Integer num);



	@Select({"<script>",
				"select count(*) from board where board_id=#{boardId}",
				"<if test='type != null'> and ${type} like '%${searchcontent}%'</if>",
			"</script>"})
	int boardcount(Map<String, Object> param);


	String select = "select num, user_id, title, content, file1 fileurl, "
			+ " reg_date, read_cnt, grp, grp_level, grp_step, board_id from board";

	@Select({"<script>",
		select,
		"<if test='num != null'> where num = #{num} </if>",
		"<if test='boardId != null'> where board_id = #{boardId} </if>",
		" <if test='searchcontent != null'> and ${type} like '%${searchcontent}%'</if>",
		"<if test='limit != null'> order by grp desc, grp_step asc limit #{startrow}, #{limit} </if>",
		"</script>"})
	List<Board> boardlist(Map<String, Object> param);



	@Select("select * from board where user_id=#{userId}")
	List<Board> myblist(String userId);

}
