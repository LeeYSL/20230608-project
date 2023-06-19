package logic;

import java.util.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;

import ch.qos.logback.classic.spi.STEUtil;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Reservation {
	private int num;  // 예약번호
	private int restNum; //가게번호
	@NotEmpty(message="예약날짜를 선택하세요.")
	private String rsrvtDate; //예약날짜
	@NotEmpty(message="예약시간을 선택하세요.")
	private String rsrvtTime; //예약시간
	@Positive(message="인원을 선택하세요.")
	private int people; //인원수
	private Date regDate; //현재시간
	private String userId; //아이디
	private int confirm; //확정여부
	@NotEmpty(message="전화번호를 입력하세요.")
	private String phoneNo; //전화번호
    @NotEmpty(message="이름을 입력하세요")
	private String rsrvtName; //예약자 이름
    private String restPhoneNo; // 가게 전화번호
	

}
