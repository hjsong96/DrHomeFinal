package com.drhome.hospitaldetail;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.json.JSONArray;

@Mapper
public interface HospitalDetailDAO {

	Map<String, Object> findHospitalByHno(int hno);

	ArrayList<Map<String, Object>> findDoctorByHno(int hno);

	ArrayList<Map<String, Object>> findReviewByHno(int hno);


	Map<String, Object> countReviewByRate(int hno);
	
	void hospitalUnlike(Map<String, Object> map);

	void hospitalLike(Map<String, Object> map);

	ArrayList<Map<String, Object>> sortReviewByNew(int hno);

	ArrayList<Map<String, Object>> sortReviewByOld(int hno);

	ArrayList<Map<String, Object>> sortReviewByHighRate(int hno);

	ArrayList<Map<String, Object>> sortReviewByLowRate(int hno);

	void countUpReviewLike(String reviewer);



}
