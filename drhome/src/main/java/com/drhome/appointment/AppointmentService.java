package com.drhome.appointment;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AppointmentService {
	@Autowired
	private AppointmentDAO appointmentDAO;

	public Map<String, Object> findHospitalDeatilByHno(Map<String, Object> hno) {
		return appointmentDAO.findHospitalDeatilByHno(hno);
	}

	public List<Map<String, Object>> checkTimeStatus(Map<String, Object> data) {
		return appointmentDAO.checkTimeStatus(data);
	}

	public ArrayList<Map<String, Object>> findDoctorByHno(Map<String, Object> hno) {
		return appointmentDAO.findDoctorByHno(hno);
	} 

	public void appointmentFinish(Map<String, Object> data) {
		appointmentDAO.appointmentFinish(data);
		appointmentDAO.pushtoAlert(data);
	}

	public Map<String, Object> findHospitalDepartmentsByHno(Map<String, Object> hno) {
		return appointmentDAO.findHospitalDepartmentsByHno(hno);
	}

	public void appointmentTodayFinish(Map<String, Object> data) {
		appointmentDAO.appointmentTodayFinish(data);
		appointmentDAO.pushtoAlert(data);
	}

	public Map<String, Object> findAppointmentDetailByAno(int ano) {
		return appointmentDAO.findAppointmentDetailByAno(ano);
	}

}
