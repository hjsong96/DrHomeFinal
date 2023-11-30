package com.drhome.myinfo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MyInfoDAO {

	Map<String, Object> myInfo(int mno);

	void changePW(Map<String, Object> map);

	void changeHomeAddr(Map<String, Object> map);

	void changeCompanyAddr(Map<String, Object> map);

	void changePhoneNumber(Map<String, Object> map);

	List<Map<String, Object>> myWriting(int mno);

	List<Map<String, Object>> myComment(int mno);

	Map<String, Object> healthRecord(int mno);

	void changeHealthRecord(Map<String, Object> map);

	int registerHealthRecord(int mno);

	int selectHealthRecord(int mno);

	List<Map<String, Object>> callDibs(int mno);

	List<Map<String, Object>> appointmentHistory(int mno);

	List<Map<String, Object>> telehealthHistory(int mno);

	void changeAllMyInfo(Map<String, Object> map);

}
