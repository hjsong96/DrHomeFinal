package com.drhome.join;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface JoinDAO {

	int midCheck(String mid);

	void join(Map<String, Object> map);

	int mrrnCheck(String mrrn);

}
