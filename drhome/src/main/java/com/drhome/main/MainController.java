package com.drhome.main;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.drhome.search.SearchService;

@Controller
public class MainController {
	@Autowired
	MainService mainService;
	@Autowired
	SearchService searchService;

	@GetMapping(value = { "/", "/main" })
	public String main(Model model, HttpSession session) {
		int randomNumber = (int) (Math.random() * 30) + 1;
		Map<String, Object> todayQuiz = mainService.findQuizByRandom(randomNumber);
		List<Map<String, Object>> newQna = mainService.findNewQna();
		if (session.getAttribute("mno") != null && session.getAttribute("mno") != "") {
			List<Map<String, Object>> notification = mainService.getNotification(session.getAttribute("mno"));
			Map<String, Object> countNotification = mainService.countNotification(session.getAttribute("mno"));
			Map<String, Object> userInfo = mainService.userInfo(session.getAttribute("mno"));
			model.addAttribute("userInfo", userInfo);
			model.addAttribute("notification", notification);
			model.addAttribute("countNotification", countNotification);
		}
		
		// 진료과별 모달
		List<Map<String, Object>> departmentKeyword = searchService.departmentKeyword();
		model.addAttribute("departmentKeyword", departmentKeyword);

		model.addAttribute("newQna", newQna);
		model.addAttribute("quiz", todayQuiz);
		return "/main";
	}
	
	
	
	@PostMapping("/point")
	public String point(@RequestParam Map<String, Object> data) {
		mainService.raisePointByQuiz(data);
		return "redirect:/main";
	}

	
	@ResponseBody
	@PostMapping("updateNotificationNum")
	public String updateNotificationNum(@RequestParam("nno") int nno) {
		mainService.updateNotificationNum(nno);

		return "";
	}
	


}
