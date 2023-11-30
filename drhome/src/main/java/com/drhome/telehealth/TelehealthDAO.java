package com.drhome.telehealth;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TelehealthDAO {

	List<Map<String, Object>> departmentKeyword();

	List<Map<String, Object>> doctorList();

	List<Map<String, Object>> kindDoctorList(Map<String, Object> map);

	List<Map<String, Object>> symptomDoctorList(Map<String, Object> map);

	List<Map<String, Object>> doctorNamelList(Map<String, Object> map);

	Map<String, Object> doctor(int dno);

	List<Map<String, Object>> doctorReview(int dno);

	void doctorReviewWrite(Map<String, Object> map);

	void reviewLike(int rno);

	int rlikeUpdate(int rno);

	void reviewDelete(int rno);

	void reviewEdit(Map<String, Object> map);
	
	Map<String, Object> telehealthApply(int dno);
	
	void apply(Map<String, Object> map);

	Map<String, Object> userInfo(Object mno);

	Map<String, Object> countReviewByRate(int dno);

}
