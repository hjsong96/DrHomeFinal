package com.drhome.docadmin;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DocAdminService {

	@Autowired
	private DocAdminDAO docAdminDAO;

	public List<Map<String, Object>> telehealthHistory(int dno) {
		return docAdminDAO.telehealthHistory(dno);
	}

	public List<Map<String, Object>> searchMname(Map<String, Object> map) {
		return docAdminDAO.searchMname(map);
	}

	public int getHno(Map<String, Object> map) {
		return docAdminDAO.getHno(map);
	}

	public List<Map<String, Object>> dpKind(Map<String, Object> map) {
		return docAdminDAO.dpKind(map);
	}

	public Map<String, Object> docMainDetail(int dno) {
		return docAdminDAO.docMainDetail(dno);
	}

	public int updateRows(List<Integer> tnoArr) {
		return docAdminDAO.updateRows(tnoArr);

	}

	public Map<String, Object> patientDetail(Map<String, Object> map) {
		return docAdminDAO.patientDetail(map);
	}

	public int hospitalCount(Map<String, Object> map) {
		return docAdminDAO.hospitalCount(map);
	}

	public void updateTelehealth(Map<String, Object> map) {
		docAdminDAO.updateTelehealth(map);
		
	}

	public void updateNotification(Map<String, Object> map) {
		docAdminDAO.updateNotification(map);
	}
	
	public Map<String, Object> findHospitalByHno(Map<String, Object> map) {
		return docAdminDAO.findHospitalByHno(map);
	}

	public Map<String, Object> findHospitalImg(int dno) {
		return docAdminDAO.findHospitalImg(dno);
	}

	
}
