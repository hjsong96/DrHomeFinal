package com.drhome.map;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MapService {
	@Autowired 
	private MapDAO mapDAO;

	public List<Map<String, Object>> hospitalList() {
		return mapDAO.hospitalList();
	}

	public List<Map<String, Object>> pharmacyList() {
		return mapDAO.pharmacyList();
	}
}
