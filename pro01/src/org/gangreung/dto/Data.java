package org.gangreung.dto;

public class Data {
	private String no;
	private String plevel;
	private String content;
	private String datafile;
	private String resdate;
	private int visited;
	public Data() {}
	public Data(String no, String plevel, String content, String datafile, String resdate, int visited) {
		super();
		this.no = no;
		this.plevel = plevel;
		this.content = content;
		this.datafile = datafile;
		this.resdate = resdate;
		this.visited = visited;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getPlevel() {
		return plevel;
	}
	public void setPlevel(String plevel) {
		this.plevel = plevel;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDatafile() {
		return datafile;
	}
	public void setDatafile(String datafile) {
		this.datafile = datafile;
	}
	public String getResdate() {
		return resdate;
	}
	public void setResdate(String resdate) {
		this.resdate = resdate;
	}
	public int getVisited() {
		return visited;
	}
	public void setVisited(int visited) {
		this.visited = visited;
	}
	@Override
	public String toString() {
		return "Data [no=" + no + ", plevel=" + plevel + ", content=" + content + ", datafile=" + datafile
				+ ", resdate=" + resdate + ", visited=" + visited + "]";
	}
	
	
}
