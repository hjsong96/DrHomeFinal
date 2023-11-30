package com.drhome.login;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

	@Autowired
	private LoginDAO loginDAO;

	public int IDresult(Map<String, Object> map) {
		return loginDAO.IDresult(map);
	}

	public int PWresult(Map<String, Object> map) {
		return loginDAO.PWresult(map);
	}

	public Map<String, Object> loginCheck(Map<String, Object> map) {
		return loginDAO.loginCheck(map);
	}

	public Map<String, Object> findID(Map<String, Object> map) {
		return loginDAO.findID(map);
	}

	public Map<String, Object> findPW(Map<String, Object> map) {
		return loginDAO.findPW(map);
	}

	public int getMno(Map<String, Object> map) {
		return loginDAO.getMno(map);
	}

	public int getDno(Map<String, Object> map) {
		return loginDAO.getDno(map);
	}

	public void registerHealthRecord(int getMno) {
		loginDAO.registerHealthRecord(getMno);
	}

	public int selectHealthRecord(int getMno) {
		return loginDAO.selectHealthRecord(getMno);
	}
	
}
