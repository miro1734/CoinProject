package org.coin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.coin.dto.BoardDTO;
import org.coin.dto.CommentDTO;
import org.coin.mapper.CommentMapper;
import org.springframework.stereotype.Service;
@Service
public class CommentService {
	private CommentMapper mapper;

	public CommentService(CommentMapper mapper) {
		this.mapper = mapper;
	}
	public ArrayList<CommentDTO> selectComment(int bno) {
		return mapper.selectComment(bno);
	}

	public int insertCcontent(CommentDTO dto) {
		int cno = mapper.selectCommentNo();
		dto.setCno(cno);
		mapper.insertComment(dto);
		return cno;
	}
	public void updateComment(int cno,String ccontent ) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cno", cno);
		map.put("ccontent", ccontent);
		mapper.updateComment(map);
	}
	public void deleteComment(int cno) {
		mapper.deleteComment(cno);
	}

}
