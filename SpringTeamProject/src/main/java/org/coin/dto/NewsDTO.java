package org.coin.dto;

import org.apache.ibatis.type.Alias;

@Alias("news")
public class NewsDTO {
	private int nno;
	private String headline;
	private String ndate;

	public NewsDTO() {
	}

	public NewsDTO(int nno, String headline, String ndate) {
		this.nno = nno;
		this.headline = headline;
		this.ndate = ndate;
	}

	public int getNno() {
		return nno;
	}

	public void setNno(int nno) {
		this.nno = nno;
	}

	public String getHeadline() {
		return headline;
	}

	public void setHeadline(String headline) {
		this.headline = headline;
	}

	public String getNdate() {
		return ndate;
	}

	public void setNdate(String ndate) {
		this.ndate = ndate;
	}

	@Override
	public String toString() {
		return "NewsDTO [nno=" + nno + ", headline=" + headline + ", ndate=" + ndate + "]";
	}
	
}
