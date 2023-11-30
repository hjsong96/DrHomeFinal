package com.drhome.writeReview;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface WriteReviewDAO {


	ArrayList<Map<String, Object>> findDoctorByHno(Object hno);

	Map<String, Object> findHospitalByHno(Object hno);

	void writeReview(Map<String, Object> write);

}
