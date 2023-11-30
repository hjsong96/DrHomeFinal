package com.drhome.map;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MapDAO {

	List<Map<String, Object>> hospitalList();

	List<Map<String, Object>> pharmacyList();

}
