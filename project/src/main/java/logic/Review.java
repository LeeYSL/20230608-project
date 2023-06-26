package logic;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Review {
	private int num;
	private int seq;
	private int restNum;
	private Date date;
	private int point;
	private String photo;
	private String content;
	private int grp;
	private int grpStep;
	private int grpLevel;
	private String userId;
}
