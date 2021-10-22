package org.coin.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.coin.dto.MemberDTO;
import org.coin.mapper.MemberMapper;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
	private MemberMapper mapper;
	
	public MemberService(MemberMapper mapper) {
		this.mapper = mapper;
	}

	public int insertCoinMember(MemberDTO dto) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", dto.getId());
		map.put("passwd", dto.getPasswd());
		map.put("name", dto.getName());
		map.put("email", dto.getEmail());
		System.out.println("map은" + map.toString());
		return mapper.insertCoinMember(map);
	}

	public MemberDTO idCheck(String id) {
		return mapper.idCheck(id);
	}

	public MemberDTO login(String id, String passwd) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("passwd", passwd);
		return mapper.login(map);
	}

	public int insertPosition(String code, String id, double count, int price, int trade_price) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		map.put("id", id);
		map.put("count", count);
		map.put("price", price);
		map.put("trade_price", trade_price);
		return mapper.insertPosition(map);
	}

	public List<MemberDTO> selectPosition(String code, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		map.put("id", id);
		return mapper.selectPosition(map);
	}

	public int updatePositionBuy(String code, String id, double count, int price, int trade_price) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		map.put("id", id);
		map.put("count", count);
		map.put("price", price);
		map.put("trade_price", trade_price);
		return mapper.updatePositionBuy(map);
	}

	public void updatePriceBuy(int price, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("price", price);
		mapper.updatePriceBuy(map);
	}

	public MemberDTO selectMember(String id) {
		return mapper.selectMember(id);
	}

	public String selectPrice(String id, String code) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("code", code);
		System.out.println("id : " + id + " " + "code : " + code);
		return mapper.selectPrice(map);
	}

	public int updatePositionSell(String code, String id, double count, int price) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		map.put("id", id);
		map.put("count", count);
		map.put("price", price);
		return mapper.updatePositionSell(map);
	}

	public void updatePriceSell(int price, String id) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("price", price);
		mapper.updatePriceSell(map);
	}

	public List<String> selectPositionMoney(String id) {
		return mapper.selectPositionMoney(id);
	}

	public List<String> selectAllprice(String id) {
		return mapper.selectAllPrice(id);
	}

	public String selectPositionCount(String id, String code) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("code", code);
		return mapper.selectPositionCount(map);
	}

	public int updatePositionCount(String id) {
		return mapper.updatePositionCount(id);
	}

	public int insertFavoriteCoin(String id, String code) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("code", code);
		return mapper.insertFavoriteCoin(map);
	}

	public int deleteFavoriteCoin(String id, String code) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("code", code);
		return mapper.deleteFavoriteCoin(map);
	}

	public List<String> selectFavoriteCoin(String id, String code) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("code", code);
		return mapper.selectFavoriteCoin(map);
	}

	
	public List<Map<String, Object>> selectAllPosition(String id) {
		return mapper.selectAllPosition(id);
	}

	public List<Map<String, Object>> selectAllFavorite(String id) {
		return mapper.selectAllFavorite(id);
	}

	public int deleteFavorite(int ino) {
		return mapper.deleteFavorite(ino);
	}
	
	
	public void updateMember(String id, String passwd, String name, String email) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("passwd", passwd);
		map.put("name", name);
		map.put("email", email);
		mapper.updateMember(map);
	}
}