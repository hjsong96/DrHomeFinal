package com.drhome.admin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {

	@Autowired
	private AdminDAO adminDAO;
	
	public List<Map<String, Object>> memberList() {
		return adminDAO.memberList();
	}

	public int gradeChange(Map<String, String> map) {
		return adminDAO.gradeChange(map);
	}

	public Map<String, Object> adminLogin(Map<String, Object> map) {
		return adminDAO.adminLogin(map);
	}

	public List<Map<String, Object>> manageBoardList() {
		return adminDAO.manageBoardList();
	}

	public List<Map<String, Object>> report(Map<String, Object> map) {
		return adminDAO.report(map);
	}

	public int resultChange(Map<String, String> map) {
		adminDAO.resultChange(map);
		return adminDAO.getMno(map);
	}

	public void memberRcount(int getMno) {
		adminDAO.memberRcount(getMno);
	}

	public List<Map<String, Object>> reportList(Map<String, Object> map) {
		return adminDAO.reportList(map);
	}

	public List<Map<String, Object>> aApprove(Map<String, Object> map) {
		return adminDAO.aApprove(map);
	}

	public int appointmentChange(Map<String, String> map) {
		return adminDAO.appointmentChange(map);
	}

	public Map<String, Object> adminInfo(Map<String, Object> map) {
		return adminDAO.adminInfo(map);
	}


	public int insertRegisterHos(Map<String, Object> map) {
		return adminDAO.insertRegisterHos(map);
	}

	public List<Map<String, Object>> hList() {
		return adminDAO.hList();
	}

	public List<Map<String, Object>> hospitalOpen(Map<String, Object> map) {
		return adminDAO.hospitalOpen(map);
	}

	public int insertRegisterDoc(Map<String, Object> map) {
		return adminDAO.insertRegisterDoc(map);
	}

	public int resultCh(Map<String, String> map) {
		return adminDAO.resultCh(map);
	}

	public List<Map<String, Object>> detail(int rhno) {
		return adminDAO.detail(rhno);
	}

	public List<Map<String, Object>> approvalHospital(Map<String, Object> map) {
		return adminDAO.approvalHospital(map);
	}

	public int deleteHospital(int rhno) {
		return adminDAO.deleteHospital(rhno);
	}

	public int insertHospital(Map<String, Object> map) {
		return adminDAO.insertHospital(map);
	}

	public List<Map<String, Object>> finalHospital() {
		return adminDAO.finalHospital();
	}

	public List<Map<String, Object>> newHospital(int hno) {
		return adminDAO.newHospital(hno);
	}

	public Map<String, Object> realDetail(int rhno) {
		return adminDAO.realDetail(rhno);
	}

	public List<Map<String, Object>> search(Map<String, Object> map) {
		return adminDAO.search(map);
	}

	public List<Map<String, Object>> viewDoctor(int rdno) {
		return adminDAO.viewDoctor(rdno);
	}

	public List<Map<String, Object>> searchHos(Map<String, Object> map) {
		return adminDAO.searchHos(map);
	}

	public int deleteHos(int rhno) {
		return adminDAO.deleteHos(rhno);
	}

	public Map<String, Object> detailDoctor(int rdno) {
		return adminDAO.detailDoctor(rdno);
	}

	public int insertDoctor(Map<String, Object> map) {
		return adminDAO.insertDoctor(map);
	}

	public int deleteDoctor(int rdno) {
		return adminDAO.deleteDoctor(rdno);
	}

	public List<Map<String, Object>> newDoctor(int rdno) {
		return adminDAO.newDoctor(rdno);
	}

	public int insertRegisterDocom(Map<String, Object> map) {
		return adminDAO.insertRegisterDocom(map);
	}

	public Map<String, Object> detailOne(int rhno) {
		return adminDAO.detailOne(rhno);
	}

	public Map<String, Object> hospitalDetail(int rhno) {
		return adminDAO.hospitalDetail(rhno);
	}

	public List<Map<String, Object>> doctorDetail(int rhno) {
		// TODO Auto-generated method stub
		return adminDAO.doctorDetail(rhno);
	}

	public Map<String, Object> detailTwo(int rdno) {
		return adminDAO.detailTwo(rdno);
	}

	/*
	 * public List<Map<String, Object>> hospitalList(int rhno) { return
	 * adminDAO.hospitalList(rhno); }
	 */

}
