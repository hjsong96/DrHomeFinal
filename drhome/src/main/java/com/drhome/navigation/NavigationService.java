package com.drhome.navigation;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NavigationService {

	@Autowired
	private NavigationDAO navigationDAO;

	public Map<String, Object> getFirstQuestion() {
		return navigationDAO.getFirstQuestion(); 
	}

	public ArrayList<Map<String, Object>> getFirstChoices() {
		return navigationDAO.getFirstChoices();
	}

	public Map<String, Object> getNextQuestion(int ncgoto) {
		return navigationDAO.getNextQuestion(ncgoto);
	}

	public ArrayList<Map<String, Object>> getNextChoices(int ncgoto) {
		return navigationDAO.getNextChoices(ncgoto);
	}

	public ArrayList<Map<String, Object>> findHospitalTop5(Map<String, Object> conditions) {
		System.out.println(conditions);
		return navigationDAO.findHospitalTop5(conditions);
	}
	
}
