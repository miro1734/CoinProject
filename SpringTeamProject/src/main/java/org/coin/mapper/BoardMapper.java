package org.coin.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Mapper;
import org.coin.dto.BoardDTO;

@Mapper
public interface BoardMapper {
	ArrayList<BoardDTO> selectBoard(HashMap<String, Object> map);
	int selectBoardNo();
	int insertBoard(BoardDTO dto);
	int selectBoardCount();
	void addBoardCount(int bno);
	BoardDTO selectBoardContent(int bno);
	int insertBoardLike(HashMap<String, Object> map);
	int deleteBoardLike(HashMap<String, Object> map);
	int insertBoardHate(HashMap<String, Object> map);
	int deleteBoardHate(HashMap<String, Object> map);
	void updateBoard(HashMap<String, Object> map);
	void deleteBoard(int bno);

}
