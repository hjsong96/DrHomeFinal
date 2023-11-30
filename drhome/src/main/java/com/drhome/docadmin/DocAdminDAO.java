package com.drhome.docadmin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DocAdminDAO {

	List<Map<String, Object>> telehealthHistory(int dno);

	List<Map<String, Object>> searchMname(Map<String, Object> map);

	int getHno(Map<String, Object> map);

	List<Map<String, Object>> dpKind(Map<String, Object> map);

	Map<String, Object> docMainDetail(int dno);

	int updateRows(List<Integer> tnoArr);

	Map<String, Object> patientDetail(Map<String, Object> map);

	int hospitalCount(Map<String, Object> map);

	void updateTelehealth(Map<String, Object> map);

	Map<String, Object> findHospitalByHno(Map<String, Object> map);

	Map<String, Object> findHospitalImg(int dno);

	void updateNotification(Map<String, Object> map);

}
