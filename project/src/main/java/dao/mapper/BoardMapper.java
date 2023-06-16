package dao.mapper;

import javax.validation.Valid;

import org.apache.ibatis.annotations.Insert;

import logic.Board;

public interface BoardMapper {

	@Insert("insert into board (num, user_id, title, content, file1, reg_date, read_cnt, board_id, grp, grp_level, grp_step, comm_cnt) "
			+ " values (#{num}, #{userId}, #{content}, #{file1}, now(), #{readCnt}, #{boardId}, #{grp}, #{grpLevel}, #{grpStep}, #{commCnt} ")
	void write(@Valid Board board);

}
