package logic;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class User {
	private String userid;
	private String pw;
	private String nickname;
	private String name;
	private Date birthday;
	private String address;
	private String email;
	private int tel;
	private int batch;
	 
	
	
}
