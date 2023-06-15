package logic;

import java.util.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
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
	@Pattern(regexp="(?=.*[a-z])(?=\\S+$).{6,12}",
			message="영문 소문자가 적어도 1개 이상씩 포함 6~12자")
	private String userId;
	@Pattern(regexp="(?=.[0-9])(?=.*[a-z])(?=\\S+$).{8,16}",
			message="영문와 숫자 1개 이상씩 포함 8~16자")
	private String pw;
	@NotNull(message="닉네임을 입력해주세요.")
	private String nickname;
	@NotNull(message="이름을 입력해주세요.")
	private String name;
	@Past(message="생일을 입력해주세요")
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date birthday;	
	private String address;
	@Email(message="이메일 형식으로 입력하세요.")
	private String email;
	@NotNull(message="휴대전화번호를 입력해주세요.")
	private String tel;
	private int batch;
}
