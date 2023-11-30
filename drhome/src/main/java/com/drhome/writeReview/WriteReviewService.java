package com.drhome.writeReview;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WriteReviewService {
	@Autowired
	private WriteReviewDAO writeReviewDAO;

	public ArrayList<Map<String, Object>> findDoctorByHno(Object hno) {
		// TODO Auto-generated method stub
		return writeReviewDAO.findDoctorByHno(hno);
	}

	public Map<String, Object> findHospitalByHno(Object hno) {
		return writeReviewDAO.findHospitalByHno(hno);
	}

	public void writeReview(Map<String, Object> write) {
		writeReviewDAO.writeReview(write);
	}
}
