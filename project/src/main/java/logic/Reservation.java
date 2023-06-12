package logic;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class Reservation {
	private int num; 
	private String userId;
	private String rsrvtDate;
	private int people;
	private Date currentTime;
	private int confirm;
	private int rervtNum;
	private String phoneNo;
	private String rsrvtName;
	

}
