package com.drhome.telehealth;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.drhome.hospitaldetail.HospitalDetailService;
import com.drhome.search.SearchUtil;

@Controller
public class TelehealthController {
	
	@Autowired 
	private TelehealthService telehealthService;
	@Autowired 
	private SearchUtil searchUtil;
	
	@Autowired
	private HospitalDetailService hospitalDetailService;
	
	// 비대면 진료 검색 페이지
	@GetMapping("/telehealthSearch")
	public String telehealthSearch(Model model) {
		
		// 증상 가져오기
		List<Map<String, Object>> departmentKeyword = telehealthService.departmentKeyword();
		// {dpno=1, dpkind=소아과, dpsymptom=소아 질환, dpkeyword=감기,예방접종,성장판검사,신생아황달, dpexample=소아소화기 등}

		// 모든 진료과 뽑아내기
		List<String> alldpkind = searchUtil.changeTypeToString(departmentKeyword, "dpkind");
		model.addAttribute("departmentKeyword",departmentKeyword);
		
		// 진료과 랜덤으로 뽑아서 모델에 담기
		Random random = new Random();
		List<String> departmentRandomKeyword = new ArrayList<>();
		Set<Integer> selectedDepartment = new HashSet<>();
		for (int i = 0; i < 7; i++) {
			int randomIndex;
			do {
				randomIndex = random.nextInt(alldpkind.size());
			} while (selectedDepartment.contains(randomIndex));
			
			selectedDepartment.add(randomIndex);
			departmentRandomKeyword.add(alldpkind.get(randomIndex));
		}
		model.addAttribute("departmentRandomKeyword",departmentRandomKeyword);
		
		// 증상 랜덤으로 뽑아서 모델에 담기
		List<String> allKeyword = searchUtil.changeTypeToStringByComma(departmentKeyword, "dpkeyword");
		List<String> symptomRandomKeyword = new ArrayList<>();
		Random randomSymptom = new Random();
		Set<Integer> selectedSymptom = new HashSet<>();
		for (int i = 0; i < 7; i++) {
			int randomIndex;
			do {
				randomIndex = randomSymptom.nextInt(allKeyword.size());
			} while (selectedSymptom.contains(randomIndex));
			selectedSymptom.add(randomIndex);
			symptomRandomKeyword.add(allKeyword.get(randomIndex));
		}
		model.addAttribute("symptomRandomKeyword",symptomRandomKeyword);
		return "/telehealthSearch";
	}
	
	// 비대면 진료 검색하면 페이지 보내기
	@PostMapping("/telehealthSearch")
	public String telehealthSearch(@RequestParam Map<String, Object> map) throws Exception {
		//System.out.println(map); {keyword=내과}
		
		List<Map<String, Object>> keywordKind = telehealthService.departmentKeyword();
		// {dpno=1, dpkind=소아과, dpsymptom=소아 질환, dpkeyword=감기,예방접종,성장판검사,신생아황달, dpexample=소아소화기 등}
		
		// 진료과별 [소아과, 치과, 내과, 이비인후과, 피부과, 산부인과, 안과, 정형외과, 한의원, 비뇨기과, 신경과, 외과, 정신의학과]
		List<String> kindKeyword = searchUtil.changeTypeToString(keywordKind, "dpkind");
		
		// 증상별 [감기, 예방접종, 성장판검사, 신생아황달, 치아교정, 충치치료, 치아미백, 치통, ...]
		List<String> symptomKeyword = searchUtil.changeTypeToStringByComma(keywordKind, "dpkeyword");
		
		// 기타 키워드별 [주차, 주차 가능, 전문의, 여의사, 공휴일 진료, 일요일 진료, 공휴일, 일요일, 야간진료]
		//String otherKeyword = "전문의";
		
		String keyword = (String) map.get("keyword");
		
		// 한글로 들어올 때 인코딩 해주기
        String encodedKeyword = URLEncoder.encode(keyword, StandardCharsets.UTF_8.toString());
        // 디코딩
        String decodedKeyword = URLDecoder.decode(encodedKeyword, StandardCharsets.UTF_8.toString());
        
    	if (kindKeyword.contains(decodedKeyword)) {
        	return "redirect:/telehealth?kindKeyword=" + encodedKeyword;
        } else if (symptomKeyword.contains(decodedKeyword)) {
        	return "redirect:/telehealth?symptomKeyword=" + encodedKeyword;
        } else if (decodedKeyword.contains("전체") || decodedKeyword.contains("비대면") || decodedKeyword.contains("비대면 진료") || decodedKeyword.contains("비대면진료") ||decodedKeyword == "") {    
        	return "redirect:/telehealth";
        } else {
        	return "redirect:/telehealth?keyword=" + encodedKeyword;
        }
	}
	
	// 비대면 진료 의사 리스트 페이지
	@GetMapping("/telehealth")
	public String telehealth(@RequestParam(required = false) Map<String, Object> map, Model model) {
		// {kindKeyword=이비인후과, symptomKeyword=감기, keyword=이국종}
		
		// 종류 {dpkind=소아과, dpsymptom=소아 질환, dpkeyword=감기,예방접종,성장판검사,신생아황달}
		List<Map<String, Object>> departmentKeyword = telehealthService.departmentKeyword();
		model.addAttribute("departmentKeyword", departmentKeyword);
		
		// 현재 요일, 시간
		model.addAttribute("currentDay", searchUtil.currentDayOfTheWeek());
		model.addAttribute("currentTime", searchUtil.currentTime());
		
		//[{dpkind=피부과, hholidayendtime=12:00:00, hparking=1, dpno=5, hnightday=수요일, dno=1, dpsymptom=피부 질환, hno=1, dpkeyword=티눈,아토피,안면홍조, dspecialist=0, dgender=0, reviewCount=4, hopentime=09:00:00, hnightendtime=23:00:00, hname=연세세브란스, haddr=서울특별시 서대문구 신촌동 연세로 50-1, hclosetime=18:00:00, hholiday=0, reviewAverage=4.2}
		
		// 기본
		List<Map<String, Object>> doctorList = telehealthService.doctorList();
		
		// 진료과별
		List<Map<String, Object>> kindDoctorList = telehealthService.kindDoctorList(map);
		
		// 증상별
		List<Map<String, Object>> symptomDoctorList = telehealthService.symptomDoctorList(map);
		
		// 의사 이름별
		List<Map<String, Object>> doctorNamelList = telehealthService.doctorNamelList(map);
		
		if (map.containsKey("kindKeyword")) {
			model.addAttribute("doctorList", kindDoctorList);
		} else if (map.containsKey("symptomKeyword")) {
			model.addAttribute("doctorList", symptomDoctorList);
		} else if (map.containsKey("keyword")) {
			model.addAttribute("doctorList", doctorNamelList);
		} else {
			model.addAttribute("doctorList", doctorList);
		}
		
		return "/telehealth";
	}
	
	// 비대면 진료 의사 상세 페이지
	@GetMapping("/doctorDetail/{dno}")
	public String doctorDetail(@PathVariable int dno, Model model) {
		 
		Map<String, Object> reviewCount = telehealthService.countReviewByRate(dno);
		model.addAttribute("reviewCount", reviewCount);
		
		// 현재 요일, 시간
		model.addAttribute("currentDay", searchUtil.currentDayOfTheWeek());
		model.addAttribute("currentTime", searchUtil.currentTime());
		
		// 의사 소개
		Map<String, Object> doctor = telehealthService.doctor(dno);
		model.addAttribute("doctor", doctor);

		// 의사 리뷰
		List<Map<String, Object>> doctorReview = telehealthService.doctorReview(dno);
		model.addAttribute("doctorReview",doctorReview);
		
		if ( doctor == null ) {
			return "redirect:/main";
		} else {
			return "/doctorDetail";
		}
	}
	
	// 비대면 진료 의사 리뷰 페이지 보내기
	@PostMapping("/doctorDetail/{dno}")
	public String doctorDetail(@PathVariable int dno, HttpSession session) {
		// 로그인한 사용자만 리뷰 남기기
		if ( session.getAttribute("mno") != null && session.getAttribute("mno") != "") {
			return "redirect:/doctorReview?mno="+session.getAttribute("mno")+"&dno="+dno;
		}
		return "redirect:/login";
	}
	
	// 비대면 진료 의사 리뷰 페이지
	@GetMapping("/doctorReview")
	public String doctorReview(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		//	System.out.println(map);{mno=3, dno=1}
		// 로그인한 사용자만 리뷰 남기기
		if ( session.getAttribute("mno") != null && session.getAttribute("mno") != "") {
			Map<String, Object> doctor = telehealthService.doctor(Integer.parseInt((String) map.get("dno")));
			model.addAttribute("doctor", doctor);
			return "/doctorReview";
		}
		return "redirect:/main";
	}
	
	// 비대면 진료 의사 상세페이지 리뷰 남기기
	@ResponseBody
	@PostMapping("/doctorReview")
	public String doctorReview(@RequestParam Map<String, Object> map) {
		JSONObject json = new JSONObject();
		//	System.out.println(map);{rrate=3, rkeyword=보통이에요,보통이에요, mno=3, dno=1, rcontent=ㅇㅇ}
		telehealthService.doctorReviewWrite(map);
		return json.toString();
	}
	
	// 비대면 진료 의사 상세페이지 리뷰 좋아요 누르기
	@ResponseBody
	@PostMapping("/reviewRecommend")
	public String reviewRecommend(@RequestParam("rno") int rno) {
		telehealthService.reviewLike(rno);
		int rlike = telehealthService.rlikeUpdate(rno);
		JSONObject json = new JSONObject();
		json.put("rlike", rlike);
		return json.toString();
	}
	
	// 비대면 진료 의사 상세페이지 내 글 리뷰 삭제하기
	@ResponseBody
	@PostMapping("/reviewDelete")
	public String reviewDelete(@RequestParam("rno") int rno, @RequestParam("dno") int dno) {
		telehealthService.reviewDelete(rno);
		Map<String, Object> doctor = telehealthService.doctor(dno);
		JSONObject json = new JSONObject();
		json.put("doctor", doctor);
		return json.toString();
	}
	
	// 비대면 진료 의사 상세페이지 내 글 리뷰 수정하기
	@ResponseBody
	@PostMapping("/reviewEdit")
	public String reviewEdit(@RequestParam Map<String, Object> map) {
		telehealthService.reviewEdit(map);
		JSONObject json = new JSONObject();
		return json.toString();
	}
	
	// 비대면 진료 접수 페이지
	@GetMapping("/telehealthApply")
	public String telehealthApply(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		//	System.out.println(map);{mno=3, dno=1}
		// 로그인한 사용자만 접수하기
		if ( session.getAttribute("mno") != null && session.getAttribute("mno") != "") {
			Map<String, Object> telehealthApply = telehealthService.telehealthApply(Integer.parseInt((String) map.get("dno")));
			model.addAttribute("telehealthApply", telehealthApply);
			return "/telehealthApply";
		}
		return "redirect:/main";
	}
	
	@PostMapping("/telehealthApply")
	public String telehealthApply(@RequestParam Map<String, Object> map, HttpSession session) {
		// System.out.println(map);{tsymptomdetail=ㅇㅇ, hno=2, dno=2, dpno=1, pay=1}
		if (Integer.parseInt((String) map.get("pay")) == 1) {
			map.put("pay", 15000);
		} else {
			map.put("pay", 10000);
		}
		map.put("date", new Date());
		if ( session.getAttribute("mno") != null && session.getAttribute("mno") != "") {
			int mno = (int) session.getAttribute("mno");
			map.put("mno", mno);
			telehealthService.apply(map);
			return "redirect:/pay/" + mno + "?tno=" + map.get("tno");
		}
		return "redirect:/main";
	}
	
}
