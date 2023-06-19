package dao.mapper;

import java.util.List;

import javax.validation.Valid; 

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import logic.Board;

public interface BoardMapper {

	@Insert("insert into board (num, user_id, title, content, file1, reg_date, read_cnt, board_id, grp, grp_level, grp_step, comm_cnt) "
			+ " values (#{num}, #{userId},#{title}, #{content}, #{fileurl}, now(), #{readCnt}, #{boardId}, #{grp}, #{grpLevel}, #{grpStep}, #{commCnt}) ")
	void write(@Valid Board board);

	@Select("select * from board where board_id=#{boardId}")
	List<Board> blist(String boardId);

	@Select("select ifnull(max(num),0) from board")
	int maxNum();

	@Select("select * from board where num=#{num}")
	Board detail(Integer num);

	@Update ("update board set read_cnt= +1 where num=#{num}")
	void addReadcnt(Integer num);

}
