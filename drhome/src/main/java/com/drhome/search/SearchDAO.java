package com.drhome.search;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SearchDAO {

	List<Map<String, Object>> departmentKeyword();

	List<Map<String, Object>> hospitalList();

	List<Map<String, Object>> kindHospitalList(Map<String, Object> map);

	List<Map<String, Object>> symptomHospitalList(Map<String, Object> map);

	List<Map<String, Object>> otherHospitalList(Map<String, Object> map);

	List<Map<String, Object>> hospitaNamelList(Map<String, Object> map);

	void hospitalLike(Map<String, Object> map);

	String hospitalLikeList(int mno);

}
