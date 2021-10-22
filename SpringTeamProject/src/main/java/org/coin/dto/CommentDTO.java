package org.coin.dto;

import org.apache.ibatis.type.Alias;

@Alias("comment")
public class CommentDTO {
	private int cno;
    private String ccontent; 
    private String cdate;
    private int bno;
    private String cwriter;
	public CommentDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CommentDTO(int cno, String ccontent, String cdate, int bno, String cwriter) {
		super();
		this.cno = cno;
		this.ccontent = ccontent;
		this.cdate = cdate;
		this.bno = bno;
		this.cwriter = cwriter;
	}
	public int getCno() {
		return cno;
	}
	public void setCno(int cno) {
		this.cno = cno;
	}
	public String getCcontent() {
		return ccontent;
	}
	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}
	public String getCdate() {
		return cdate;
	}
	public void setCdate(String cdate) {
		this.cdate = cdate;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getCwriter() {
		return cwriter;
	}
	public void setCwriter(String cwriter) {
		this.cwriter = cwriter;
	}
	@Override
	public String toString() {
		return "CommentDTO [cno=" + cno + ", ccontent=" + ccontent + ", cdate=" + cdate + ", bno=" + bno + ", cwriter="
				+ cwriter + "]";
	}
	
}
