package com.drhome.chatting;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChattingDAO {


	List<Map<String, Object>> getDoctor();

	void alertDoctor(Map<String, Object> data);

}
