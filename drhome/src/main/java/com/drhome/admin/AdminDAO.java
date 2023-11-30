package com.drhome.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface AdminDAO {

	List<Map<String, Object>> memberList();

	int gradeChange(Map<String, String> map);

	Map<String, Object> adminLogin(Map<String, Object> map);

	List<Map<String, Object>> manageBoardList();

	List<Map<String, Object>> report(Map<String, Object> map);

	int resultChange(Map<String, String> map);

	void memberRcount(int getMno);

	int getMno(Map<String, String> map);

	List<Map<String, Object>> reportList(Map<String, Object> map);

	List<Map<String, Object>> aApprove(Map<String, Object> map);

	int appointmentChange(Map<String, String> map);

	Map<String, Object> adminInfo(Map<String, Object> map);

	List<Map<String, Object>> hospitalOpen(Map<String, Object> map);

	int insertRegisterHos(Map<String, Object> map);

	List<Map<String, Object>> hList();

	int insertRegisterDoc(Map<String, Object> map);

	int resultCh(Map<String, String> map);

	List<Map<String, Object>> detail(int rhno);

	List<Map<String, Object>> approvalHospital(Map<String, Object> map);

	int deleteHospital(int rhno);

	int insertHospital(Map<String, Object> map);

	List<Map<String, Object>> finalHospital();

	List<Map<String, Object>> newHospital(int hno);

	Map<String, Object> realDetail(int rhno);

	List<Map<String, Object>> search(Map<String, Object> map);

	List<Map<String, Object>> viewDoctor(int rdno);

	List<Map<String, Object>> searchHos(Map<String, Object> map);

	int deleteHos(int rhno);

	Map<String, Object> detailDoctor(int rdno);

	int insertDoctor(Map<String, Object> map);

	int deleteDoctor(int rdno);

	List<Map<String, Object>> newDoctor(int rdno);

	int insertRegisterDocom(Map<String, Object> map);

	Map<String, Object> detailOne(int rhno);

	Map<String, Object> hospitalDetail(int rhno);

	List<Map<String, Object>> doctorDetail(int rhno);

	Map<String, Object> detailTwo(int rdno);

	/* List<Map<String, Object>> hospitalList(int rhno); */

}
