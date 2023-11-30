package com.drhome.docadmin;

import java.util.HashMap;
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
public class DocAdminController {
	
	@Autowired 
	private HospitalDetailUtil util;

	@Autowired
	private DocAdminService docAdminService;
	
	@GetMapping("/docMain/{mno}/{dno}")
	public String docMain(@PathVariable int dno, Model model) {
		
		Map<String, Object> hospital = docAdminService.findHospitalImg(dno);
		model.addAttribute("hospital", hospital);
		
		Map<String, Object> docMainDetail = docAdminService.docMainDetail(dno);
		model.addAttribute("docMainDetail", docMainDetail);

		List<Map<String, Object>> telehealthHistory = docAdminService.telehealthHistory(dno);
		model.addAttribute("telehealthHistory", telehealthHistory);
		
		return "/docMain";
	}
	
	@GetMapping("/docReception/{mno}/{dno}")
	public String docReception(@PathVariable int dno, @PathVariable int mno, Model model,@RequestParam Map<String,Object> map) {
		map.put("dno", dno);
		
		Map<String, Object> docMainDetail = docAdminService.docMainDetail(dno);
		model.addAttribute("docMainDetail", docMainDetail);
		
		//검색내역 뽑기
		List<Map<String, Object>> searchMname = docAdminService.searchMname(map);
		model.addAttribute("searchMname", searchMname);
		
		//진료과 뽑기(hno 통해서 count로 dpno 수 알기)
		int getHno = docAdminService.getHno(map);
		map.put("hno", getHno);
		
		List<Map<String, Object>> dpKind = docAdminService.dpKind(map);
		model.addAttribute("dpKind", dpKind);
		int dpCount = dpKind.size();
		model.addAttribute("dpCount", dpCount);
		
		//진료시간 점심시간 뽑기
		Map<String, Object> hospital = docAdminService.findHospitalByHno(map);
		Map<String, Object> now = new HashMap<>();
		now.put("dayOfWeek", util.getDayOfWeek(util.getDayOfWeek()));
		now.put("time", util.getTime());
		model.addAttribute("hospital", hospital);
		model.addAttribute("now", now);
		
		return "/docReception";
	}
	
	@ResponseBody
	@PostMapping("/updateRows")
	public String updateRows(@RequestParam(value = "row[]") List<Integer> tnoArr) {
		
		int result = docAdminService.updateRows(tnoArr);
		
		JSONObject json = new JSONObject();

		return json.toString();
	}
	
	@GetMapping("/docReceptionDetail/{mno}/{dno}")
	public String docReceptionDetail(@RequestParam Map<String, Object> map, @PathVariable int dno, Model model) {
		Map<String, Object> docMainDetail = docAdminService.docMainDetail(dno);
		model.addAttribute("docMainDetail", docMainDetail);
		
		//환자정보 뽑기
		Map<String, Object> patientDetail = docAdminService.patientDetail(map);
		model.addAttribute("patientDetail", patientDetail);
		
		//우리병원 이용횟수 뽑기
		map.put("mno", patientDetail.get("mno"));
		map.put("hno", patientDetail.get("hno"));
		Integer hospitalCount = docAdminService.hospitalCount(map);
		
		
		hospitalCount = (hospitalCount == null) ? 0 : hospitalCount;
		model.addAttribute("hospitalCount", hospitalCount);
		
		
		return "/docReceptionDetail";
	}
	
	@PostMapping("/updateTelehealth/{mno}/{dno}")
	public String updateTelehealth(@RequestParam Map<String, Object> map, @PathVariable int dno, @PathVariable int mno, Model model) {
		
		docAdminService.updateTelehealth(map);
		docAdminService.updateNotification(map);
		
		return "redirect:/docReception/{mno}/{dno}";
	}
	
}
