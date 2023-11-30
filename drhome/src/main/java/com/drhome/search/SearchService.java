package com.drhome.search;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SearchService {
	
	@Autowired 
	private SearchDAO searchDAO;

	public List<Map<String, Object>> departmentKeyword() {
		return searchDAO.departmentKeyword();
	}

	public List<Map<String, Object>> hospitalList() {
		return searchDAO.hospitalList();
	}

	public List<Map<String, Object>> kindHospitalList(Map<String, Object> map) {
		return searchDAO.kindHospitalList(map);
	}

	public List<Map<String, Object>> symptomHospitalList(Map<String, Object> map) {
		return searchDAO.symptomHospitalList(map);
	}

	public List<Map<String, Object>> otherHospitalList(Map<String, Object> map) {
		return searchDAO.otherHospitalList(map);
	}

	public List<Map<String, Object>> hospitaNamelList(Map<String, Object> map) {
		return searchDAO.hospitaNamelList(map);
	}

	public void hospitalLike(Map<String, Object> map) {
		searchDAO.hospitalLike(map);
		
	}

	public String hospitalLikeList(int mno) {
		return searchDAO.hospitalLikeList(mno);
	}

}
