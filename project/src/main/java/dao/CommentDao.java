package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.mapper.CommentMapper;
import logic.Comment;

@Repository
public class CommentDao {
@Autowired 
private SqlSessionTemplate template;
private Map<String,Object> param = new HashMap<>();
private Class<CommentMapper> cls = CommentMapper.class;



	public List<Comment> commlist(Integer num) {
		param.clear();
		param.put("num", num);
		return template.getMapper(cls).commlist(num);
	}



	public void commInsert(@Valid Comment comm) {
		template.getMapper(cls).commInsert(comm);
	}



	public int commmaxseq(int num) {
		return template.getMapper(cls).commmaxseq(num); 
	}



	public void commdelete(int num, int seq) {
		template.getMapper(cls).commdelete(num,seq);
		
	}



	public List<Comment> myclist(String userId) {
		return template.getMapper(cls).myclist(userId);
	}




}
