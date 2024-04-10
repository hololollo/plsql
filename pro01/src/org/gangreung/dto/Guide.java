package org.gangreung.dto;

public class Guide {
	private int pcode;
	private String pname;
	private String ptype;
	private String paddr;
	private String ptel;
	private String pgps;
	private String pcomment;
	private String premark;
	public Guide() {}
	public Guide(int pcode, String pname, String ptype, String paddr, String ptel, String pgps, String pcomment,
			String premark) {
		super();
		this.pcode = pcode;
		this.pname = pname;
		this.ptype = ptype;
		this.paddr = paddr;
		this.ptel = ptel;
		this.pgps = pgps;
		this.pcomment = pcomment;
		this.premark = premark;
	}
	public int getPcode() {
		return pcode;
	}
	public void setPcode(int pcode) {
		this.pcode = pcode;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	public String getPaddr() {
		return paddr;
	}
	public void setPaddr(String paddr) {
		this.paddr = paddr;
	}
	public String getPtel() {
		return ptel;
	}
	public void setPtel(String ptel) {
		this.ptel = ptel;
	}
	public String getPgps() {
		return pgps;
	}
	public void setPgps(String pgps) {
		this.pgps = pgps;
	}
	public String getPcomment() {
		return pcomment;
	}
	public void setPcomment(String pcomment) {
		this.pcomment = pcomment;
	}
	public String getPremark() {
		return premark;
	}
	public void setPremark(String premark) {
		this.premark = premark;
	}
	@Override
	public String toString() {
		return "Guide [pcode=" + pcode + ", pname=" + pname + ", ptype=" + ptype + ", paddr=" + paddr + ", ptel=" + ptel
				+ ", pgps=" + pgps + ", pcomment=" + pcomment + ", premark=" + premark + "]";
	}
	
	
}
