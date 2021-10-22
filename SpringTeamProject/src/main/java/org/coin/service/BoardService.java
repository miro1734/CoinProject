package org.coin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.coin.dto.BoardDTO;
import org.coin.mapper.BoardMapper;
import org.springframework.stereotype.Service;

@Service
public class BoardService {
	private BoardMapper mapper;
	public BoardService(BoardMapper mapper) {
		super();
		this.mapper = mapper;
	}
	public int insertBoard(BoardDTO dto) {
		int bno = mapper.selectBoardNo();
		dto.setBno(bno);
		mapper.insertBoard(dto);
		return bno;
	}
	public boolean insertBoardLike(int bno, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("bno", bno);
		int count = 0;
		try {
		count = mapper.insertBoardLike(map);
		}catch (Exception e) {
			System.out.println("이미 좋아요 표시 하였음");
		}
		if(count == 0)
			mapper.deleteBoardLike(map);
		return count==1;
	}
	public boolean insertBoardHate(int bno, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("bno", bno);
		int count = 0;
		try {
			count = mapper.insertBoardHate(map);
		}catch (Exception e) {
			System.out.println("이미 싫어요 표시 하였음");
		}
		if(count == 0)
			mapper.deleteBoardHate(map);
		return count==1;
	}
	public ArrayList<BoardDTO> selectBoard(int pageNo, String code) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("pageNo", pageNo);
		map.put("code", code);
		return mapper.selectBoard(map);
	}
	public BoardDTO selectBoardContent(int bno) {
		return mapper.selectBoardContent(bno);
	}
	public int selectBoardCount() {
		return mapper.selectBoardCount();
	}
	public void addBoardCount(int bno) {
		mapper.addBoardCount(bno);
		
	}
	public void updateBoard(int bno, String title, String bcontent) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("bno", bno);
		map.put("title", title);
		map.put("bcontent", bcontent);
		mapper.updateBoard(map);
	}
	public void deleteBoard(int bno) {
		mapper.deleteBoard(bno);
		
	}
	
}
