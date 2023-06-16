package dao;

import java.util.HashMap;
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


public void write(@Valid Board board) {
	template.getMapper(cls).write(board);
}


}
