package logic;

import java.util.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class User {
	@Pattern(regexp="(?=.[0-9])(?=.*[a-zA-Z])(?=\\S+$).{6,12}",
			message="영문 대,소문자와 숫자가 적어도 1개 이상씩 포함 6~12자")
	private String userId;
	@Pattern(regexp="(?=.[0-9])(?=.*[a-zA-Z])(?=.*\\W)(?=\\S+$).{8,16}",
			message="영문 대,소문자와 숫자, 특수기호가 적어도 1개 이상씩 포함 8~16자")
	private String pw;
	private String nickname;
	private String name;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date birthday;
	private String address;
	@Email(message="이메일 형식으로 입력하세요.")
	private String email;
	private int tel;
	private int batch;
}
