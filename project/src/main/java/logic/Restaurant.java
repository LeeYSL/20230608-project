package logic;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;

import org.springframework.web.multipart.MultipartFile;


import java.util.List;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Restaurant {
    private String userId;
    @NotEmpty(message="전화번호를 입력하세요.")
    private String restPhoneNo; // 가게 전화번호
    @NotEmpty(message="이름을 입력하세요")
	private String name;
    @NotEmpty(message="가게 주소를 입력하세요")
	private String address;
    @NotEmpty(message="사업자번호를 입력하세요.")
	private String licenseNum; 
	private int restNum;
	@Positive(message="인원을 선택해주세요.")
	private int maxpeople;
	private String open;
	private String close;
	private Dayoff dayoff;
    private String tel;
    private List<Menu> menuList; //메뉴
    private String delYn; // 가게 삭제
    private MultipartFile picture; // 사진 등록해서 전송할 때 쓰는거
	private String fileurl;
	private double point; //별점
   
	
}
