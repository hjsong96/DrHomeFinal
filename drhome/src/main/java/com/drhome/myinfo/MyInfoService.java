package com.drhome.myinfo;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MyInfoService {

	@Autowired
	private MyInfoDAO myInfoDAO;

	public Map<String, Object> myInfo(int mno) {
		return myInfoDAO.myInfo(mno);
	}

	public void changePW(Map<String, Object> map) {
		myInfoDAO.changePW(map);
	}

	public void changeHomeAddr(Map<String, Object> map) {
		myInfoDAO.changeHomeAddr(map);		
	}

	public void changeCompanyAddr(Map<String, Object> map) {
		myInfoDAO.changeCompanyAddr(map);	
		
	}

	public void changePhoneNumber(Map<String, Object> map) {
		String mphonenumber = String.valueOf(map.get("firstNumber")) +"-"+ String.valueOf(map.get("MiddleNumber"))+"-"+ String.valueOf(map.get("lastNumber"));
		System.out.println(mphonenumber);
		map.put("mphonenumber", mphonenumber);
		myInfoDAO.changePhoneNumber(map);	
	}
	
	public void changeAllMyInfo(Map<String, Object> map) {
		String mphonenumber = String.valueOf(map.get("firstNumber")) +"-"+ String.valueOf(map.get("MiddleNumber"))+"-"+ String.valueOf(map.get("lastNumber"));
		System.out.println(mphonenumber);
		map.put("mphonenumber", mphonenumber);
		myInfoDAO.changeAllMyInfo(map);
	}

	public List<Map<String, Object>> myWriting(int mno) {
		return myInfoDAO.myWriting(mno);
	}

	public List<Map<String, Object>> myComment(int mno) {
		return myInfoDAO.myComment(mno);
	}

	public Map<String, Object> healthRecord(int mno) {
		return myInfoDAO.healthRecord(mno);
	}

	public void changeHealthRecord(Map<String, Object> map) {
		myInfoDAO.changeHealthRecord(map);	
	}

	public int registerHealthRecord(int mno) {
		return myInfoDAO.registerHealthRecord(mno);
	}

	public int selectHealthRecord(int mno) {
		return myInfoDAO.selectHealthRecord(mno);
	}

	public List<Map<String, Object>> callDibs(int mno) {
		return myInfoDAO.callDibs(mno);
	}

	public List<Map<String, Object>> appointmentHistory(int mno) {
		return myInfoDAO.appointmentHistory(mno);
	}

	public List<Map<String, Object>> telehealthHistory(int mno) {
		return myInfoDAO.telehealthHistory(mno);
	}
	
}
