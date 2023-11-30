package com.drhome.writeReview;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class WriteReviewController {

	@Autowired
	private WriteReviewService writeReviewService;

	@GetMapping("/writeReview")
	public String writeReview(@RequestParam Map<String, Object> parameter, Model model) {
		System.out.println(parameter);
		
		ArrayList<Map<String, Object>> doctor = writeReviewService.findDoctorByHno(parameter.get("hno"));
		Map<String, Object> hospital = writeReviewService.findHospitalByHno(parameter.get("hno"));
		System.out.println(doctor);
		model.addAttribute("doctor", doctor);
		model.addAttribute("hospital", hospital);
		model.addAttribute("parameter", parameter);
		return "/writeReview";
	}

	@PostMapping("/writeReview")
	public String writeReview(@RequestParam Map<String, Object> write) {
		writeReviewService.writeReview(write);
		return "redirect:/hospitalDetail/"+write.get("hno");
	}
}
