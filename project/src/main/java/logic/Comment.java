package logic;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Comment {
	private int num;
	private int seq;
	private String userId;
	private Date date;
	private String content;	
	private String nickname;
}
