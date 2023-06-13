package logic;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class Restaurant {
	
	

	private String userId;
    @NotNull(message="전화번호를 입력하세요.")
	private int tel;
    @NotEmpty(message="이름을 입력하세요")
	private String name;
    @NotEmpty(message="가게 주소를 입력하세요")
	private String address;
    @NotEmpty(message="사업자번호를 입력하세요.")
	private String licenseNum; 
	private String picture;
	private int restNum;
	
	

}
