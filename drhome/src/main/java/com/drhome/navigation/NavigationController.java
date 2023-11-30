package com.drhome.navigation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class NavigationController {

	@Autowired
	private NavigationService navigationService;

	@Autowired
	private NavigationUtil navigationUtil;

	private Map<String, Object> conditions = new HashMap<String, Object>();

	@GetMapping("/navigation")
	public String navigation(Model model) {
		return "/navigation";

	}

	@ResponseBody
	@GetMapping("/getQuestion")
	public String getQuestion(@RequestParam("ncgoto") int ncgoto) {
		JSONObject result = new JSONObject();

		if (ncgoto >= 7 && ncgoto <= 19) {
			conditions.put("dpkind", navigationUtil.getDepartmentKind(ncgoto));
		}
 
		if (ncgoto >= 29 && ncgoto <= 40) {
			conditions.put("dspeicallist", navigationUtil.getCheckConditions(ncgoto).get("dspeicallist"));
			conditions.put("dgender", navigationUtil.getCheckConditions(ncgoto).get("dgender"));
			conditions.put("sort", navigationUtil.getCheckConditions(ncgoto).get("sort"));
			
			ArrayList<Map<String, Object>> hospitalList = navigationService.findHospitalTop5(conditions);
			result.put("hospitalList", new JSONArray(hospitalList));
		}

		Map<String, Object> nextQuestion = navigationService.getNextQuestion(ncgoto);
		ArrayList<Map<String, Object>> nextChoices = navigationService.getNextChoices(ncgoto);

		result.put("nextQuestion", new JSONObject(nextQuestion));
		result.put("nextChoices", new JSONArray(nextChoices));

		return result.toString();
	}
}
