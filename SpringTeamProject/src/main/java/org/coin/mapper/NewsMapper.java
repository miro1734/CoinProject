package org.coin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.coin.dto.NewsDTO;

@Mapper
public interface NewsMapper {

	public List<NewsDTO> selectAllNews();

	public int insertNews(String headline);

	public int deleteNews(int nno);

}
