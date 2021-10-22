package org.coin.service;

import java.util.List;

import org.coin.dto.NewsDTO;
import org.coin.mapper.NewsMapper;
import org.springframework.stereotype.Service;

@Service
public class NewsService {
	private NewsMapper mapper;

	public NewsService(NewsMapper mapper) {
		this.mapper = mapper;
	}

	public List<NewsDTO> selectAllNews() {
		return mapper.selectAllNews();
	}

	public int insertNews(String headline) {
		return mapper.insertNews(headline);
	}

	public int deleteNews(int nno) {
		return mapper.deleteNews(nno);
	}

}
