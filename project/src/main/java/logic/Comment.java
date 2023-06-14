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
	private String userid;
	private Date date;
	private String content;	
}
