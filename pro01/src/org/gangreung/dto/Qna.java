package org.gangreung.dto;

public class Qna {
	private String no;
	private String plevel;
	private int parno;
	private String title;
	private String content;
	private int visited;
	private String aid;
	public Qna() {}
	public Qna(String no, String plevel, int parno, String title, String content, int visited, String aid) {
		super();
		this.no = no;
		this.plevel = plevel;
		this.parno = parno;
		this.title = title;
		this.content = content;
		this.visited = visited;
		this.aid = aid;
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
	public int getParno() {
		return parno;
	}
	public void setParno(int parno) {
		this.parno = parno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getVisited() {
		return visited;
	}
	public void setVisited(int visited) {
		this.visited = visited;
	}
	public String getAid() {
		return aid;
	}
	public void setAid(String aid) {
		this.aid = aid;
	}
	@Override
	public String toString() {
		return "Qna [no=" + no + ", plevel=" + plevel + ", parno=" + parno + ", title=" + title + ", content=" + content
				+ ", visited=" + visited + ", aid=" + aid + "]";
	}
	
	
}
