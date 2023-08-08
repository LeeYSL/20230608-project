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
	
	

	@Insert("insert into board (num, user_id, title, content, file1, reg_date, read_cnt, board_id, grp, grp_level, grp_step, comm_cnt, secret,secret2) "
			+ " values (#{num}, #{userId},#{title}, #{content}, #{fileurl}, now(), #{readCnt}, #{boardId}, #{grp}, #{grpLevel}, #{grpStep}, #{commCnt}, #{secret},#{secret2}) ")
	void write(@Valid Board board);

	


	@Select("select ifnull(max(num),0) from board")
	int maxNum();

	@Select("select b.num, b.user_id, b.title, b.content, b.file1 fileurl, b.reg_date, b.read_cnt, b.board_id, b.grp, b.grp_level, b.grp_step, b.comm_cnt, b.secret,b.secret2, u.nickname from board b join user u on b.user_id=u.user_id where b.num=#{num}")
	Board detail(Integer num);

	@Update ("update board set read_cnt= read_cnt+1 where num=#{num}")
	void addReadcnt(Integer num);
	




	@Update("update board set title=#{title},content=#{content},file1=#{fileurl} where num=#{num}")
	void update(@Valid Board board);

//	@Update({"<script>",
//			"update board ",
//		//	"<if test='comm_cnt != 0'> b join comment c set b.delYn='Y', b.del_date=now(), c.delYn='Y' where b.num=#{num}  and c.num=#{num} </if> ",
//			"<if test='comm_cnt == 0'> set delYn=Y, del_date=now() where num=#{num} </if>",			
//			"</script>"}) 
//	void delete(Integer num);
//	@Update("update board set delYn='Y', del_date=now() where num=#{num} ")	



	@Select({"<script>",
				"select count(*) from board b left join user u on b.user_id=u.user_id where board_id=#{boardId} and b.delYn IS NULL",
				"<if test='type != null'> and ${type} like '%${searchcontent}%'</if>",
			"</script>"})
	int boardcount(Map<String, Object> param);


	String select = "select num, user_id, title, content, file1 fileurl, "
			+ " reg_date, read_cnt, grp, grp_level, grp_step, board_id, secret,secret2 from board";

	@Select({"<script>",
		"select num, b.user_id, title, content, b.file1 fileurl,b.reg_date, read_cnt, board_id, grp, grp_level, grp_step, comm_cnt, secret, secret2,nickname from board b join user u on b.user_id=u.user_id where b.delYn IS NULL",
		"<if test='num != null'> and num = #{num} </if>",
		"<if test='boardId != null'> and board_id = #{boardId} </if>",
		" <if test='searchcontent != null'> and ${type} like '%${searchcontent}%'</if>",
		"<if test='limit != null'> order by grp desc, grp_step asc limit #{startrow}, #{limit} </if>",
		"</script>"})
	List<Board> boardlist(Map<String, Object> param);


/*
	@Select("select * from board where user_id=#{userId}")
	List<Board> myblist(String userId);
*/



	@Select("select count(*) from board where user_id=#{userId} and delYn IS NULL")
	int myblistcount(String userId);



	@Update ("update board set grp_step=grp_step+1 where grp=#{grp} and grp_step>#{grpStep} ")
	void updateGrpStep(Map<String, Object> param);



	@Select({"<script>",
		select ,
		" where delYn IS NULL",
		"<if test='num != null'> and num = #{num} </if>",
		"<if test='userId != null'> and user_id = #{userId} </if>",
		"<if test='limit != null'> order by grp desc, grp_step asc limit #{startrow}, #{limit} </if>",
		"</script>"})
	List<Board> myblist(Map<String, Object> param);



	@Update ("update board set comm_cnt=comm_cnt+1 where num=#{num} ")
	void updateCommCnt(Map<String, Object> param);



	@Update({"<script>",
		"update board ",
		"<if test='commCnt != 0'> b join comment c set b.delYn='Y', b.del_date=now(), c.delYn='Y' where b.num=#{num}  and c.num=#{num} </if> ",
		"<if test='commCnt == 0'> set delYn='Y', del_date=now() where num=#{num} </if>",			
		"</script>"}) 
	void delete(Map<String, Object> param);



	@Update ("update board set comm_cnt=comm_cnt-1 where num=#{num} ")
	void commDeleteCommCnt(Map<String, Object> param);

}
