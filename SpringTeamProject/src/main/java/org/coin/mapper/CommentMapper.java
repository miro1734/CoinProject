package org.coin.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.coin.dto.CommentDTO;

@Mapper
public interface CommentMapper {
	int selectCommentNo();
	void insertComment(CommentDTO dto);
	ArrayList<CommentDTO> selectComment(int bno);
	void updateComment(HashMap<String, Object> map);
	void deleteComment(int cno);
}
