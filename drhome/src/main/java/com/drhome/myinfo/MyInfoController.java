package com.drhome.myinfo;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MyInfoController {

	@Autowired
	private MyInfoService myInfoService;
	
	@GetMapping("/myInfo/{mno}")
	public String myInfo(@PathVariable int mno, Model model) {
		Map<String, Object> myInfo = myInfoService.myInfo(mno);
		model.addAttribute("myInfo", myInfo);
		
		return "/myInfo";
	}
	
	@PostMapping("/changePW/{mno}")
	public String changePW(@RequestParam Map<String, Object> map, @PathVariable int mno) {
		map.put("mno", mno);
		myInfoService.changePW(map);
		
		return "redirect:/myInfo/{mno}";
	}
	
	@PostMapping("/changeHomeAddr/{mno}")
	public String changeHomeAddr(@RequestParam Map<String, Object> map, @PathVariable int mno) {
		map.put("mno", mno);
		myInfoService.changeHomeAddr(map);
		
		return "redirect:/myInfo/{mno}";
	}
	
	@PostMapping("/changeCompanyAddr/{mno}")
	public String changeCompanyAddr(@RequestParam Map<String, Object> map, @PathVariable int mno) {
		map.put("mno", mno);
		myInfoService.changeCompanyAddr(map);
		
		return "redirect:/myInfo/{mno}";
	}
	
	@PostMapping("/changePhoneNumber/{mno}")
	public String changePhoneNumber(@RequestParam Map<String, Object> map, @PathVariable int mno) {
		map.put("mno", mno);
		myInfoService.changePhoneNumber(map);
		
		return "redirect:/myInfo/{mno}";
	}
	
	@PostMapping("/changeAllMyInfo/{mno}")
	public String changeAllMyInfo(@RequestParam Map<String, Object> map, @PathVariable int mno) {
		map.put("mno", mno);
		myInfoService.changeAllMyInfo(map);
		
		return "redirect:/myInfo/{mno}";
	}
	
	@GetMapping("/myWriting/{mno}")
	public String myWriting(@PathVariable int mno, Model model) {
		List<Map<String, Object>> callDibs = myInfoService.callDibs(mno);
		model.addAttribute("callDibs", callDibs);
		
		List<Map<String, Object>> myWriting = myInfoService.myWriting(mno);
		model.addAttribute("myWriting", myWriting);
		
		List<Map<String, Object>> myComment = myInfoService.myComment(mno);
		model.addAttribute("myComment", myComment);
		
		return "/myWriting";
	}
	
	@GetMapping("/medicalHistory/{mno}")
	public String medicalHistory(@PathVariable int mno, Model model) {
		
		List<Map<String, Object>> appointmentHistory = myInfoService.appointmentHistory(mno);
		model.addAttribute("appointmentHistory", appointmentHistory);
		
		List<Map<String, Object>> telehealthHistory = myInfoService.telehealthHistory(mno);
		model.addAttribute("telehealthHistory", telehealthHistory);
		
		return "/medicalHistory";
	}
	
	@GetMapping("/healthRecord/{mno}")
	public String healthRecord(@PathVariable int mno, Model model) {
		Map<String, Object> healthRecord = myInfoService.healthRecord(mno);
		int selectHealthRecord = myInfoService.selectHealthRecord(mno);
		
		//클릭 시 만약 값 있다면 불러오기 그렇지 않으면 생성해주기
		if(selectHealthRecord == 1) {
			model.addAttribute("healthRecord", healthRecord);
		} else {
			myInfoService.registerHealthRecord(mno);
	        healthRecord = myInfoService.healthRecord(mno);
	        model.addAttribute("healthRecord", healthRecord);
		}
		return "/healthRecord";
		}
	
	@PostMapping("/changeHealthRecord/{mno}")
	public String changeHealthRecord(@RequestParam Map<String, Object> map, @PathVariable int mno) {
		map.put("mno", mno);
		myInfoService.changeHealthRecord(map);
		
		return "redirect:/healthRecord/{mno}";
	}
	
}
