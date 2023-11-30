package com.drhome.chatting;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class ChattingController {
	@Autowired
	private ChattingDAO chattingDAO;
	
	@RequestMapping("/chatting")
	public ModelAndView chatting(Model model) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("chatting");
		List<Map<String, Object>> doctor = chattingDAO.getDoctor(); 
		
		model.addAttribute("doctor", doctor);
		return mv; 
	}
	
	@PostMapping("/alertDoctor")
	public String alertDoctor(@RequestParam Map<String, Object> data) {
		chattingDAO.alertDoctor(data);
		return "";
	}

}
