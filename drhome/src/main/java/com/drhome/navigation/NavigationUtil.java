package com.drhome.navigation;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

@Component
public class NavigationUtil {

	public String getDepartmentKind(int ncgoto) {
		switch (ncgoto) {
		case 7:
			return "소아과";
		case 8:
			return "치과";
		case 9:
			return "내과";
		case 10:
			return "이비인후과";
		case 11:
			return "피부과";
		case 12:
			return "산부인과";
		case 13:
			return "안과";
		case 14:
			return "정형외과";
		case 15:
			return "한의원";
		case 16:
			return "비뇨기과";
		case 17:
			return "신경과";
		case 18:
			return "외과";
		case 19:
			return "정신의학과";
		default:
			return "";
		}
	}

	public Map<String, Object> getCheckConditions(int ncgoto) {
		Map<String, Object> check = new HashMap<String, Object>();
		if (ncgoto >= 29 && ncgoto <= 31) {
			check.put("dspeicallist", 1);
			check.put("dgender", 1);
		} else if (ncgoto >= 32 && ncgoto <= 34) {
			check.put("dspeicallist", 1);
			check.put("dgender", 0);
		} else {
			check.put("dspeicallist", 0);
			check.put("dgender", 0);
		}

		if (ncgoto == 29 || ncgoto == 32 || ncgoto == 35 || ncgoto == 38) {
			check.put("sort", "reviewAverage");
		} else if (ncgoto == 30 || ncgoto == 33 || ncgoto == 36 || ncgoto == 39) {
			check.put("sort", "reviewCount");
		} else {
			check.put("sort", "hopenDate");

		}

		return check;
	}

}
