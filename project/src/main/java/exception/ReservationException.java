package exception;

public class ReservationException extends Exception {
	private String url;
	public ReservationException(String msg, String url) {
		super(msg);
		this.url = url;
	}
	public String getUrl() {
		return url;
	}
}