package org.coin.dto;

import org.apache.ibatis.type.Alias;

@Alias("board")
public class BoardDTO {
	private int bno;
	private String title;
	private String writer;
	private String bdate;
	private String bcontent;
	private int bcount;
	private int blike;
	private int bhate;
	private String code;
	public BoardDTO() {
		super();
	}
	public BoardDTO(int bno, String title, String writer, String bdate, String bcontent, int bcount, int blike,
			int bhate, String code) {
		super();
		this.bno = bno;
		this.title = title;
		this.writer = writer;
		this.bdate = bdate;
		this.bcontent = bcontent;
		this.bcount = bcount;
		this.blike = blike;
		this.bhate = bhate;
		this.code = code;
	}
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getBdate() {
		return bdate;
	}
	public void setBdate(String bdate) {
		this.bdate = bdate;
	}
	public String getBcontent() {
		return bcontent;
	}
	public void setBcontent(String bcontent) {
		this.bcontent = bcontent;
	}
	public int getBcount() {
		return bcount;
	}
	public void setBcount(int bcount) {
		this.bcount = bcount;
	}
	public int getBlike() {
		return blike;
	}
	public void setBlike(int blike) {
		this.blike = blike;
	}
	public int getBhate() {
		return bhate;
	}
	public void setBhate(int bhate) {
		this.bhate = bhate;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	@Override
	public String toString() {
		return "BoardDTO [bno=" + bno + ", title=" + title + ", writer=" + writer + ", bdate=" + bdate + ", bcontent="
				+ bcontent + ", bcount=" + bcount + ", blike=" + blike + ", bhate=" + bhate + ", code=" + code + "]";
	}
	
}
