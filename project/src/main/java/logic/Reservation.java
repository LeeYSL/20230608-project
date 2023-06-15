package logic;

import java.util.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Reservation {
	private int num;  // 예약번호
	private int rervtNum; //가게번호
	private String rsrvtDate; //예약날짜
	private String rsrvtTime; //예약시간
	private int people; //인원수
	private Date regDate; //현재시간
	private String userId; //아이디
	private int confirm; //확정여부
    @NotNull(message="전화번호를 입력하세요.")
	private String phoneNo; //전화번호
    @NotEmpty(message="이름을 입력하세요")
	private String rsrvtName; //예약자 이름

	

}
