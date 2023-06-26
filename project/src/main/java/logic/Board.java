package logic;

import java.util.Date;

import javax.validation.constraints.NotEmpty;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Setter
@Getter
@ToString
public class Board {
	private int num;
	private String userId;
	@NotEmpty(message="제목은 필수입니다.")
	private String title;
	@NotEmpty(message="내용은 필수입니다.")
	private String content;
	private MultipartFile file1;
	private String fileurl;
	private Date regDate;
	private int readCnt;
	private String boardId;
	private int grp;
	private int grpLevel;
	private int grpStep;
	private int commCnt;
	private String nickname;
	private String secret;
}
