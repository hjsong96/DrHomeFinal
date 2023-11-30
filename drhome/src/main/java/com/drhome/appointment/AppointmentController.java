package com.drhome.appointment;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.drhome.hospitaldetail.HospitalDetailUtil;

@Controller
public class AppointmentController {
	@Autowired
	private AppointmentService appointmentService;

	@Autowired 
	private AppointmentUtil util;

	@Autowired
	private HospitalDetailUtil hospitalDetailUtil;

	@GetMapping("/appointmentToday/{hno}")
	public String appointmentToday(@PathVariable Map<String, Object> hno, Model model) {
		// 병원 가져오기
		Map<String, Object> hospital = appointmentService.findHospitalDeatilByHno(hno);
		// 진료과 가져오기
		String dayOfToday = hospitalDetailUtil.getDayOfWeek(hospitalDetailUtil.getDayOfWeek());


		// 오늘 시간 가져오기
		// 선택된 요일 조건문에 넣어서 오픈,엔드 시간 찾기 / util에서 시작 끝 시간을 30분씩 짜르기
		if ((dayOfToday.equals("토요일") || dayOfToday.equals("일요일")) && (hospital.get("hholiday") + "").equals("1")) {
			model.addAttribute("timeSlots",
					util.splitTimeRange((Date) hospital.get("hopentime"), (Date) hospital.get("hholidayendtime")));
		} else if ((dayOfToday.equals("토요일") || dayOfToday.equals("일요일"))
				&& (hospital.get("hholiday") + "").equals("0")) {
			model.addAttribute("timeSlots", "");

		} else if (dayOfToday.equals(hospital.get("hnightday"))) {
			model.addAttribute("timeSlots",
					util.splitTimeRange((Date) hospital.get("hopentime"), (Date) hospital.get("hnightendtime")));

		} else {
			model.addAttribute("timeSlots",
					util.splitTimeRange((Date) hospital.get("hopentime"), (Date) hospital.get("hclosetime")));
		}
		// 현재 시간 넣기
		model.addAttribute("nowTime", hospitalDetailUtil.getTime());
		model.addAttribute("hospital", hospital);
		model.addAttribute("hospitalDepartments", appointmentService.findHospitalDepartmentsByHno(hno));
		model.addAttribute("today", util.now.format(util.formatter));
		model.addAttribute("dayOfToday", dayOfToday);

		return "/appointmentToday";
	}

	@GetMapping("/appointment/{hno}")
	public String appointment(@PathVariable Map<String, Object> hno, Model model) {
		// 병원 정보 가져오기
		Map<String, Object> hospital = appointmentService.findHospitalDeatilByHno(hno);

		// 의사 정보 가져오기
		ArrayList<Map<String, Object>> doctor = appointmentService.findDoctorByHno(hno);

		model.addAttribute("hospital", hospital);
		model.addAttribute("doctor", doctor); 
		model.addAttribute("day", util.daysOfWeek());
		model.addAttribute("date", util.dateOfWeek());

		return "/appointment";
	}

	@PostMapping("/appointmentToday")
	public String appointmentToday(@RequestParam Map<String, Object> data) {
		appointmentService.appointmentTodayFinish(data);
		return "redirect:/completeAppointment/"+data.get("ano");
	}

	@PostMapping("/appointment")
	public String appointment(@RequestParam Map<String, Object> data) { 
		appointmentService.appointmentFinish(data); 
		return "redirect:/completeAppointment/" + data.get("ano");
	}
 
	@GetMapping("/completeAppointment/{ano}")
	public String completeAppointment(@PathVariable int ano, Model model) {
		Map<String, Object> appointment = appointmentService.findAppointmentDetailByAno(ano);
		model.addAttribute("appointment", appointment); 
		return "/completeAppointment";
	}

	@ResponseBody
	@GetMapping("/getTime")
	public String getTime(@RequestParam Map<String, Object> data) {

		// 예약 선택 요일 가져오기 "일요일"
		String day = (String) data.get("day");

		// 병원 시간 가져오기 (야간진료, 공휴일, 평일)
		Map<String, Object> hospital = appointmentService.findHospitalDeatilByHno(data);

		// 병원 고유번호,예약 원하는 날짜 넘겨주고 예약된 시간 가져오기
		List<Map<String, Object>> checkTime = appointmentService.checkTimeStatus(data);

		JSONObject json = new JSONObject();
		// 예약된 시간 넣기
		json.put("checkTime", checkTime);
		// 오늘 날짜 클릭시 시간 안보이고 진료 예약 으로 보내기
		if (data.get("date").equals(util.now.format(util.formatter))) {
			json.put("timeSlots", "오늘");
		} else {

			// 선택된 요일 조건문에 넣어서 오픈,엔드 시간 찾기 / util에서 시작 끝 시간을 30분씩 짜르기
			if ((day.equals("토요일") || day.equals("일요일")) && (hospital.get("hholiday") + "").equals("1")) {
				json.put("timeSlots",
						util.splitTimeRange((Date) hospital.get("hopentime"), (Date) hospital.get("hholidayendtime")));
			} else if ((day.equals("토요일") || day.equals("일요일")) && (hospital.get("hholiday") + "").equals("0")) {
				json.put("timeSlots", "");

			} else if (day.equals(hospital.get("hnightday"))) {
				json.put("timeSlots",
						util.splitTimeRange((Date) hospital.get("hopentime"), (Date) hospital.get("hnightendtime")));

			} else {
				json.put("timeSlots",
						util.splitTimeRange((Date) hospital.get("hopentime"), (Date) hospital.get("hclosetime")));
			}

		}

		return json.toString();
	}
}
