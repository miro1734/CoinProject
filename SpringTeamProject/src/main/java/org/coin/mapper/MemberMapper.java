package org.coin.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.coin.dto.MemberDTO;

@Mapper
public interface MemberMapper {
	public int insertCoinMember(HashMap<String, Object> map);

	public MemberDTO idCheck(String id);
	
	public MemberDTO login(HashMap<String, Object> map);

	public int insertPosition(HashMap<String, Object> map);

	public List<MemberDTO> selectPosition(HashMap<String, Object> map);

	public int updatePositionBuy(HashMap<String, Object> map);

	public void deletePrice(int price);

	public void updatePriceBuy(HashMap<String, Object> map);

	public MemberDTO selectMember(String id);

	public String selectPrice(HashMap<String, Object> map);

	public int updatePositionSell(HashMap<String, Object> map);

	public void updatePriceSell(HashMap<String, Object> map);

	public List<String> selectPositionMoney(String id);

	public List<String> selectAllPrice(String id);

	public String selectPositionCount(HashMap<String, Object> map);

	public int updatePositionCount(String id);

	public int insertFavoriteCoin(HashMap<String, Object> map);

	public int deleteFavoriteCoin(HashMap<String, Object> map);

	public List<String> selectFavoriteCoin(HashMap<String, Object> map);
	
	
	public List<Map<String, Object>> selectAllPosition(String id);

	public List<Map<String, Object>> selectAllFavorite(String id);

	public int deleteFavorite(int ino);

	
	public void updateMember(HashMap<String, Object> map);
}
