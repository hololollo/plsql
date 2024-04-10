package org.gangreung.dto;

public class Introduce {
	private String comment1;
	private String photo;
	private String locat;
	public Introduce() {}
	public Introduce(String comment1, String photo, String locat) {
		super();
		this.comment1 = comment1;
		this.photo = photo;
		this.locat = locat;
	}
	public String getComment1() {
		return comment1;
	}
	public void setComment1(String comment1) {
		this.comment1 = comment1;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getLocat() {
		return locat;
	}
	public void setLocat(String locat) {
		this.locat = locat;
	}
	@Override
	public String toString() {
		return "Introduce [comment1=" + comment1 + ", photo=" + photo + ", locat=" + locat + "]";
	}
	
	
}
