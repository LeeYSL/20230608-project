package logic;

import java.util.Date;

import javax.validation.constraints.Email;
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
	private String nickname;
	private String name;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date birthday;
	private String address;
	@Email(message="이메일 형식으로 입력하세요.")
	private String email;
	
	private String tel;
	private int batch;
}
