package logic;

import java.util.Date;

import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter; 
import lombok.ToString;
@Setter
@Getter
@ToString
public class Board {
	private int num;
	private String userId;
	@NotNull(message="제목은 필수입니다.")
	private String title;
	@NotNull(message="내용은 필수입니다.")
	private String content;
	private String file1;
	private Date regDate;
	private int readCnt;
	private int boardId;
	private int grp;
	private int grpLevel;
	private int grpStep;
	private int commCnt;
	private String nickname;
}
