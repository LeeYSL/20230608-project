package logic;

import java.util.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Setter
@Getter
@ToString
public class User {
	@NotEmpty(message="아이디는 필수입니다.")
	@Pattern(regexp="[a-z]+[a-z0-9]{5,11}",
	message="영어로 시작, 숫자 포함 가능, 6~12자 ")
	private String userId;
	@Pattern(regexp="(?=.*\\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}",
			message="영문과 숫자 1개 이상씩 포함 8~16자")
	private String pw;
	@Pattern(regexp="(?=.*\\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}",
			message="영문과 숫자 1개 이상씩 포함 8~16자")
	private String pw1;
	@Pattern(regexp="(?=.*\\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}",
			message="영문과 숫자 1개 이상씩 포함 8~16자")
	private String pw2;
	@NotEmpty(message="별명을 입력해주세요.")
	private String nickname;
	@Pattern(regexp="[가-힣]+$",message="이름을 입력해주세요.")
	private String name;
	private String address;
	@Pattern(regexp="01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}",
			message="휴대전화번호를 입력해주세요.(xxx-xxxx-xxxx)")
	private String tel;
	private int batch;
	private Date regDate;
	private MultipartFile file1;
	private String fileurl;
	private String authKey;
	private String channel;
	@NotEmpty(message="이메일을 입력해주세요.")
	@Email(regexp="([\\w-]+(?:\\.[\\w-]+)*)@((?:[\\w-]+\\.)*\\w[\\w-]{0,66})\\.([a-z]{2,6}(?:\\.[a-z]{2})?)",message="이메일 형식으로 입력하세요.")
	private String email;
	
}
