package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.BoardMapper;
import logic.Board;


@Repository
public class BoardDao {
@Autowired
private SqlSessionTemplate template; //SqlSessionFactory랑 비슷한 거 자동으로 커밋 롤백 수행함
private Map<String,Object> param = new HashMap<>();
private Class<BoardMapper> cls = BoardMapper.class;



public int maxNum() {
	return template.getMapper(cls).maxNum();
}

public void write(@Valid Board board) {
	template.getMapper(cls).write(board);
	
}

public Board detail(Integer num) {
	return template.getMapper(cls).detail(num);
}

public void addReadcnt(Integer num) {
	param.clear();
	param.put("num", num);
	template.getMapper(cls).addReadcnt(num);
	
}


public void update(@Valid Board board) {
	 template.getMapper(cls).update(board);	
}

public void delete(Integer num) {
	template.getMapper(cls).delete(num);
	
}

public List<Board> boardlist(String boardId, int limit, Integer pageNum, String type, String searchcontent) {
	param.clear();
	param.put("boardId", boardId);
	param.put("limit", limit);
	param.put("startrow",(pageNum-1) * limit);
	param.put("type", type);
	param.put("searchcontent", searchcontent);
	return template.getMapper(cls).boardlist(param);
}

public int boardcount(String boardId, String type, String searchcontent) {
	param.clear();
	param.put("boardId", boardId);
	param.put("type", type);
	param.put("searchcontent", searchcontent);
	return template.getMapper(cls).boardcount(param);
}
/*
public List<Board> myblist(String userId) {
	return template.getMapper(cls).myblist(userId);
}
*/
public int myblistcount(String userId) {
	return template.getMapper(cls).myblistcount(userId);
}



public void updateGrpStep(@Valid Board board) {
	param.clear();
	param.put("grp", board.getGrp());
	param.put("grpstep", board.getGrpStep());
	template.getMapper(cls).updateGrpStep(param);
	
}

public List<Board> myblist(String userId, int limit, Integer pageNum) {
	param.clear();
	param.put("userId", userId);
	param.put("limit", limit);
	param.put("startrow",(pageNum-1) * limit);
	return template.getMapper(cls).myblist(param);
} 


}
