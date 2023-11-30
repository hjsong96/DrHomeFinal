package com.drhome.join;

import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class JoinController {

	@Autowired
	private JoinService joinService;
	
	@GetMapping("/join")
	public String join() {
		
		return "/join";
	}
	
	@PostMapping("/join")
	public String join(@RequestParam Map<String, Object> map) {
		joinService.join(map);
		
		return "redirect:/login";
	}
	
	@ResponseBody
	@PostMapping("/midCheck")
	public String midCheck(@RequestParam("mid") String mid) {
		int midCheck = joinService.midCheck(mid);

		JSONObject json = new JSONObject();
		json.put("midCheck", midCheck);
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/mrrnCheck")
	public String mrrnCheck(@RequestParam("mrrn") String mrrn) {
		int mrrnCheck = joinService.mrrnCheck(mrrn);

		JSONObject json = new JSONObject();
		json.put("mrrnCheck", mrrnCheck);
		return json.toString();
	}
	
}
