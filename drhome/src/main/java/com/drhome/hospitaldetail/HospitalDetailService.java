package com.drhome.hospitaldetail;

import java.util.ArrayList;
import java.util.Map;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HospitalDetailService {
	@Autowired
	private HospitalDetailDAO hospitalDetailDAO;

	public Map<String, Object> findHospitalByHno(int hno) {
		return hospitalDetailDAO.findHospitalByHno(hno);
	}

	public ArrayList<Map<String, Object>> findDoctorByHno(int hno) {

		return hospitalDetailDAO.findDoctorByHno(hno);
	}

	public ArrayList<Map<String, Object>> findReviewByHno(int hno) {

		return hospitalDetailDAO.findReviewByHno(hno);
	}
	
	public Map<String, Object> countReviewByRate(int hno) {
		return hospitalDetailDAO.countReviewByRate(hno);
	}
	
	public void hospitalUnlike(Map<String, Object> map) {
		hospitalDetailDAO.hospitalUnlike(map);
	}

	public void hospitalLike(Map<String, Object> map) {
		hospitalDetailDAO.hospitalLike(map);
	}


	public ArrayList<Map<String, Object>> sortReviewByNew(int hno) {
		// TODO Auto-generated method stub
		return hospitalDetailDAO.sortReviewByNew(hno);
	}

	public ArrayList<Map<String, Object>> sortReviewByOld(int hno) {
		return hospitalDetailDAO.sortReviewByOld(hno);
	}

	public ArrayList<Map<String, Object>> sortReviewByHighRate(int hno) {
		return  hospitalDetailDAO.sortReviewByHighRate(hno);
	}
	
	public ArrayList<Map<String, Object>> sortReviewByLowRate(int hno) {
		return  hospitalDetailDAO.sortReviewByLowRate(hno);
	}

	public void countUpReviewLike(String reviewer) {
		hospitalDetailDAO.countUpReviewLike(reviewer);
	}




}
