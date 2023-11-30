package com.drhome.hospitaldetail;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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

@Controller 
public class HospitalDetailController {
	@Autowired
	private HospitalDetailService hospitalDetailService;

	@Autowired
	private HospitalDetailUtil util;

	// 병원 상세페이지
	@GetMapping("/hospitalDetail/{hno}") 
	public String hospitalDetail(@PathVariable int hno, Model model) {

		Map<String, Object> hospital = hospitalDetailService.findHospitalByHno(hno);
		ArrayList<Map<String, Object>> doctorList = hospitalDetailService.findDoctorByHno(hno);

		ArrayList<Map<String, Object>> reviewList = hospitalDetailService.findReviewByHno(hno);
		
		//그래프
		Map<String, Object> reviewCount = hospitalDetailService.countReviewByRate(hno);

		// 병원 평균 평점가져오기
		String averageHospitalRate = util.getHospitalAverageRate(reviewList);

		Map<String, Object> now = new HashMap<>();
		now.put("dayOfWeek", util.getDayOfWeek(util.getDayOfWeek()));
		now.put("time", util.getTime());
		System.out.println(now);
		model.addAttribute("hospital", hospital);
		model.addAttribute("doctorList", doctorList);
		model.addAttribute("now", now);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("averageHospitalRate", averageHospitalRate);
		model.addAttribute("reviewCount", reviewCount);
		
		return "/hospitalDetail";
	}


	// 댓글 정렬하기 (신규, 오래된순, 별점 높은순, 별점 낮은순)
	@ResponseBody
	@GetMapping("/sort/{hno}")
	public String sort(@PathVariable int hno, @RequestParam("sortValue") int sortValue, Model model) {
		if (sortValue == 1) {
			ArrayList<Map<String, Object>> sort1 = hospitalDetailService.sortReviewByNew(hno);

			JSONObject review = new JSONObject();
			review.put("review", sort1);
			return review.toString();

		} else if (sortValue == 2) {
			ArrayList<Map<String, Object>> sort2 = hospitalDetailService.sortReviewByOld(hno);

			JSONObject review = new JSONObject();
			review.put("review", sort2);

			return review.toString();

		} else if (sortValue == 3) {
			ArrayList<Map<String, Object>> sort3 = hospitalDetailService.sortReviewByHighRate(hno);

			JSONObject review = new JSONObject();
			review.put("review", sort3);

			return review.toString();

		} else if (sortValue == 4) {
			ArrayList<Map<String, Object>> sort4 = hospitalDetailService.sortReviewByLowRate(hno);

			JSONObject review = new JSONObject();
			review.put("review", sort4);

			return review.toString();

		} else {
			ArrayList<Map<String, Object>> sort0 = hospitalDetailService.findReviewByHno(hno);

			JSONObject review = new JSONObject();
			review.put("review", sort0);
			return review.toString();
		}
	}

	// 댓글 좋아요 수 올리기
	@ResponseBody
	@PostMapping("/countReviewLike")
	public String countReviewLike(@RequestParam("reviewer") String reviewer) {
		hospitalDetailService.countUpReviewLike(reviewer);
		return "";
	}

	// 병원 즐겨찾기 해제
	@ResponseBody
	@PostMapping("/unlike")
	public String unlike(@RequestParam("hospitalname") String hname, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>(); 
		map.put("hname", hname);
		map.put("mno", session.getAttribute("mno"));
		hospitalDetailService.hospitalUnlike(map);
		return "";
	}

	// 병원 즐겨찾기 추가
	@ResponseBody
	@PostMapping("/like")
	public String like(@RequestParam("hospitalname") String hname, HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("hname", hname);
		map.put("mno", session.getAttribute("mno"));
		hospitalDetailService.hospitalLike(map);
		return "";
	}
}
