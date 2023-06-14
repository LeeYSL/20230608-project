package logic;

import java.util.Date;

import lombok.Getter;
import lombok.Setter; 
import lombok.ToString;
@Setter
@Getter
@ToString
public class Board {
	private int num;
	private String userId;
	private String title;
	private String content;
	private String file1;
	private Date regDate;
	private int readCnt;
	private int boardId;
	private int grp;
	private int grpLevel;
	private int grpStep;
	private int commCnt;
}
