package logic;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class Mail {
	private String naverid;
	private String naverpw;
	//보내는 사람은 안함 
	private String recipient;
	private String title;
	private String mtype;
	private List<MultipartFile> file1;
	//스프링으로 파일 업로드 할때는  파일1에서 업로드한 내용은 MultipartFile이 가지고 있으면 되는데
	//file1이 2개라 List 처리 해줘야함 : 메일 전송시 첨부파일 2개 가능
	private String contents;
}
 