package dao;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Builder
public class SmsRequestDao {
	String type;
	String contentType;
	String countryCode;
	String from;
	String content;
	List<MessageDao> messages;

}