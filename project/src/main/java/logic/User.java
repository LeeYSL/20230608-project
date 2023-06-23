package logic;

import java.util.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Past;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Setter
@Getter
@ToString
public class User {
	private String myphoto;
	@Pattern(regexp="[a-zA-Z0-9]{6,12}",
			message="영문,숫자 포함 6~12자")
	private String userId;
	@Pattern(regexp="(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]|.*[0-9]).{8,16}",
			message="영문과 숫자 1개 이상씩 포함 8~16자")
	private String pw;
	@Pattern(regexp="(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]|.*[0-9]).{8,16}",
			message="영문과 숫자 1개 이상씩 포함 8~16자")
	private String pw1;
	private String pw2;
	@NotEmpty(message="별명을 입력해주세요.")
	private String nickname;
	@Pattern(regexp="[가-힣]+$",message="이름을 입력해주세요.")
	private String name;
	@Past(message="생일을 입력해주세요")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date birthday;	
	private String address;
	@NotEmpty(message="이메일을 입력해주세요.")
	@Email(regexp="([\\w-]+(?:\\.[\\w-]+)*)@((?:[\\w-]+\\.)*\\w[\\w-]{0,66})\\.([a-z]{2,6}(?:\\.[a-z]{2})?)",message="이메일 형식으로 입력하세요.")
	private String email;
	@Pattern(regexp="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}",
			message="휴대전화번호를 입력해주세요.(xxx-xxxx-xxxx)")
	private String tel;
	private int batch;
}
