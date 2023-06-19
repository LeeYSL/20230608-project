package logic;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;

import ch.qos.logback.classic.spi.STEUtil;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Restaurant {
    private String userId;
    @NotEmpty(message="전화번호를 입력하세요.")
	private String tel;
    @NotEmpty(message="이름을 입력하세요")
	private String name;
    @NotEmpty(message="가게 주소를 입력하세요")
	private String address;
    @NotEmpty(message="사업자번호를 입력하세요.")
	private String licenseNum; 
	private String picture;
	private int restNum;
	@Positive(message="인원을 선택해주세요.")
	private int maxpeople;
	private String open;
	private String close;
	private Dayoff dayoff;
    private String restPhoneNo; // 가게 전화번호
	

}
