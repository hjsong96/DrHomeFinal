package com.drhome.navigation;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NavigationDAO {
	Map<String, Object> getFirstQuestion();

	ArrayList<Map<String, Object>> getFirstChoices();

	Map<String, Object> getNextQuestion(int ncgoto);

	ArrayList<Map<String, Object>> getNextChoices(int ncgoto);

	ArrayList<Map<String, Object>> findHospitalTop5(Map<String, Object> conditions);
}
