package com.drhome.admin;

import java.util.Base64;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mysql.cj.Session;

@Controller
public class AdminController {

	@Autowired
	private AdminService adminService;

	@Autowired
	private Util util;

	@GetMapping("/admin/adminMain")
	public String adminmain(@RequestParam Map<String, Object> map, Model model, HttpSession session) {

		if (session.getAttribute("mid") == null) {

			String mname = String.valueOf(session.getAttribute("mname"));
			Map<String, Object> infoList = adminService.adminInfo(map);
			model.addAttribute("infoList", infoList);

			return "admin/adminMain";
		} else {
			return "redirect:/admin/adminMain";
		}
	}

	@RequestMapping(value = "/boardManage", method = RequestMethod.GET)
	public String BoardList(Model model, @RequestParam Map<String, Object> map, HttpSession session) {

		if (session.getAttribute("mid") == null) {

			List<Map<String, Object>> manageBoardList = adminService.manageBoardList();
			model.addAttribute("manageBoardList", manageBoardList);

			List<Map<String, Object>> reportList = adminService.reportList(map);
			model.addAttribute("reportList", reportList);

			return "admin/boardManage";
		} else {
			return "redirect:/admin/index";
		}
	}

	// member
	@RequestMapping(value = "/admin/member", method = RequestMethod.GET)
	public ModelAndView member(HttpSession session) {

		ModelAndView mv = new ModelAndView("admin/member");
		mv.addObject("memberList", adminService.memberList());

		return mv;
	}

	@RequestMapping(value = "/report", method = RequestMethod.GET)
	public String report(Map<String, Object> map, Model model, HttpSession httpSession) {

		List<Map<String, Object>> report = adminService.report(map);
		model.addAttribute("report", report);

		return "admin/report";
	}
 
	// gradeChange
	@RequestMapping(value = "/admin/gradeChange", method = RequestMethod.GET)
	public String gradeChange(@RequestParam Map<String, String> map) {
		


		int result = adminService.gradeChange(map);
		return "redirect:/admin/member";
	}

	// resultChange
	@RequestMapping(value = "/resultChange", method = RequestMethod.GET)
	public String resultChange(@RequestParam Map<String, String> map) {
		System.out.println(map);
		int getMno = adminService.resultChange(map);
		System.out.println(getMno);

		if (map.get("rpresult").equals("1")) {
			adminService.memberRcount(getMno);
		}

		return "redirect:/admin/report";
	}

	// appointmentChange
	@RequestMapping(value = "/appointmentChange", method = RequestMethod.GET)
	public String appointmentChange(@RequestParam Map<String, String> map) {
		int getAno = adminService.appointmentChange(map);
		System.out.println(getAno);

		return "redirect:/admin/appointmentApprove";
	}

	@GetMapping("/newHospital")
	public String newHospital() {

		return "/newHospital";
	}

	@PostMapping("/newDoctor")
	public String newHospital(@RequestParam Map<String, Object> map) {
		System.out.println(map.get("rhno"));
		
		System.out.println(map.containsKey("rhholiday"));
		if (!(map.containsKey("rhholiday"))) {
			map.put("rhholiday", 0);
		}

		System.out.println(map.containsKey("rhparking"));
		if (!(map.containsKey("rhparking"))) {
			map.put("rhparking", 0);
		}
		System.out.println(map);

		int insertRegisterHos = adminService.insertRegisterHos(map);
		System.out.println(insertRegisterHos);

		return "redirect:/newDoctor?rhno="+map.get("rhno");
	}

	@GetMapping("/newDoctor")
	public String newDoctor(@RequestParam(name = "rhno", required = false, defaultValue = "0") int rhno, Map<String, Object> map) {
		Map<String, Object> rhnoDoctor = adminService.realDetail(rhno);
		map.put("rhnoDoctor", rhnoDoctor);
		System.out.println(rhnoDoctor);
		return "/newDoctor";
	}
	
	@PostMapping("/completeHosDoc")
	public String newDoctor(@RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes) {
		System.out.println(map);
		
		System.out.println(map.containsKey("rdgender"));
		if (!(map.containsKey("rdgender"))) {
			map.put("rdgender", 0);
		}
		
		if (!(map.containsKey("rdspecialist"))) {
			map.put("rdspecialist", 0);
		}
		
		if (!(map.containsKey("rdtelehealth"))) {
			map.put("rdtelehealth", 0);
		}
		
		/*
		 * if (String.valueOf(map.containsKey("rdspecialist")) == "on") {
		 * map.put("rdspecialist", 1); } else { map.put("rdspecialist", 0); }
		 * System.out.println(map.containsKey("rdspecialist"));
		 * 
		 * if (String.valueOf(map.containsKey("rdtelehealth")) == "on") {
		 * map.put("rdtelehealth", 1); } else { map.put("rdtelehealth", 0); }
		 * System.out.println(map.containsKey("rdtelehealth"));
		 */
		
		int insertRegisterDoc = adminService.insertRegisterDoc(map);
		System.out.println(insertRegisterDoc);
		
		System.out.println(map.get("rhno"));
		System.out.println(map.get("rhname"));
		// Base64.getEncoder().encodeToString(map.get("hname").getBytes())
		
		redirectAttributes.addAttribute("rhno", map.get("rhno"));
		
		return "redirect:/completeHosDoc";
	}
	
	@RequestMapping(value = "/admin/hospitalOpen", method = RequestMethod.GET)
	public String hospitalOpen(Map<String, Object> map, Model model) {

		List<Map<String, Object>> hospitalOpen = adminService.hospitalOpen(map);
		System.out.println(hospitalOpen);
		map.put("hospitalOpen", hospitalOpen);
		
		  //@RequestParam("rhno") int rhno,
		  //List<Map<String, Object>> hospitalList = adminService.hospitalList(rhno);
		  //map.put("hospitalList", hospitalList);
		
		return "admin/hospitalOpen";
	}
	
	@GetMapping("/completeHosDoc")
	public String completeHosDoc(@RequestParam("rhno") int rhno) {
		
		return "completeHosDoc";
	}
	
	@ResponseBody
	@GetMapping("/admin/detail")
	public String detail(@RequestParam("rhno") int rhno) {
		System.out.println(rhno);
		Map<String, Object> hospitalDetail = adminService.hospitalDetail(rhno);
		System.out.println(hospitalDetail);
		
		
		List<Map<String, Object>> doctorDetail = adminService.doctorDetail(rhno);
		System.out.println(doctorDetail);
		 
		
		JSONObject json = new JSONObject();
		json.put("hospitalDetail", hospitalDetail);
		json.put("doctorDetail", doctorDetail);
		
		System.out.println(json.toString());
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/admin/searchHos")
	public String searchHos(@RequestParam Map<String, Object> map) {
		System.out.println(map);
		
		List<Map<String, Object>> searchHos = adminService.searchHos(map);

		JSONObject json = new JSONObject();
		json.put("searchHos", searchHos);
		System.out.println(json.toString());
		
		return json.toString();
	}
	
	@ResponseBody
	@PostMapping("/admin/deleteHos")
	public String deleteHos(@RequestParam("rhno") int rhno) {
		
		int deleteHos = adminService.deleteHos(rhno);

		JSONObject json = new JSONObject();
		json.put("deleteHos", deleteHos);
		System.out.println(json.toString());
		
		return json.toString();
	}
	
	@GetMapping("/resultCh")
	public String resultCh(@RequestParam Map<String, String> map) {
		System.out.println(map);
		int getMno = adminService.resultCh(map);
		
		return "redirect:/admin/hospitalOpen";
	}
	
	@PostMapping("/admin/newHosDoc")
	public String realHospital(@RequestParam("rhno") int rhno, @RequestParam("rdno") int rdno) {
		System.out.println(rdno);
		
		Map<String, Object> hospitalApproval = adminService.detailOne(rhno);
		int insertHospital = adminService.insertHospital(hospitalApproval);
		System.out.println(insertHospital);
		int deleteHospital = adminService.deleteHospital(rhno);
		System.out.println(deleteHospital);
		
		Map<String, Object> doctorApproval = adminService.detailTwo(rdno);
		int insertDoctor = adminService.insertDoctor(doctorApproval);
		System.out.println(insertDoctor);
		int deleteDoctor = adminService.deleteDoctor(rdno);
		System.out.println(deleteDoctor);
		
		return "redirect:/admin/newHosDoc";
	}
	
	@PostMapping("/admin/adminMain")
	public String ApprovalHosDoc(@RequestParam("rdno") int rdno, Map<String, Object> map) {
		
		Map<String, Object> doctorApproval = adminService.detailDoctor(rdno);
		int insertDoctor = adminService.insertDoctor(doctorApproval);
		System.out.println(insertDoctor);
		int deleteDoctor = adminService.deleteDoctor(rdno);
		System.out.println(deleteDoctor);
		
		return "redirect:/admin/adminMain";
	}
	
	/*
	 * @GetMapping("/admin/newHosDoc") public String newHosDoc(Map<String, Object>
	 * map, HttpSession session, @RequestParam(name="hno", required=false,
	 * defaultValue = "0") int hno) { System.out.println(hno); List<Map<String,
	 * Object>> newHospital = adminService.newHospital(hno); map.put("newHospital",
	 * newHospital); System.out.println(newHospital); return "admin/newHosDoc"; }
	 */
	
	@GetMapping("/admin/newHosDoc")
	public String newHosDoc(Map<String, Object> map, HttpSession session, @RequestParam(name="rdno", required=false, defaultValue = "0") int rdno) {
		System.out.println(rdno);
		List<Map<String, Object>> newDoctor = adminService.newDoctor(rdno);  
		map.put("newDoctor", newDoctor);
		System.out.println(newDoctor);
		return "admin/newHosDoc";
	}
	
	@ResponseBody
	@PostMapping("/admin/doctorView")
	public String doctorView(@RequestParam("rdno") int rdno) {
		
		List<Map<String, Object>> viewDoctor = adminService.viewDoctor(rdno);

		JSONObject json = new JSONObject();
		json.put("viewDoctor", viewDoctor);
		System.out.println(json.toString());
		
		return json.toString();
}
/*	
	
	@GetMapping("/admin/realHospital")
	public String realHospital(Map<String, Object> map) {
			
		List<Map<String, Object>> finalHospital = adminService.finalHospital();
		map.put("finalHospital", finalHospital);
		
		return "admin/realHospital";
	}

	@PostMapping("/newDoctor")
	public String newDoctor(@RequestParam Map<String, Object> map) {
		System.out.println(map);
		
		System.out.println(map.containsKey("dgender"));
		if (!(map.containsKey("dgender"))) {
			map.put("dgender", 0);
		}
		
		if (String.valueOf(map.containsKey("dspecialist")) == "on") {
			map.put("dspecialist", 1);
		} else {
			map.put("dspecialist", 0);
		}
		System.out.println(map.containsKey("dspecialist"));

		if (String.valueOf(map.containsKey("dtelehealth")) == "on") {
			map.put("dtelehealth", 1);
		} else {
			map.put("dtelehealth", 0);
		}
		System.out.println(map.containsKey("dtelehealth"));
		
		int insertDoctor = adminService.insertDoctor(map);
		System.out.println(insertDoctor);
		
		System.out.println(map.get("hno"));
		System.out.println(map.get("hname"));
		// Base64.getEncoder().encodeToString(map.get("hname").getBytes())
		return "redirect:/admin/newDoctor?hno="+map.get("hno");
	}

	@GetMapping("/newHosDoc")
	public String newHosDoc(Map<String, Object> map, HttpSession session, @RequestParam(name="hno", required=false, defaultValue = "0") int hno) {
		System.out.println(hno);
		List<Map<String, Object>> newHospital = adminService.newHospital(hno);  
		map.put("newHospital", newHospital);
		System.out.println(newHospital);
		return "admin/newHosDoc";
	}
	
	@ResponseBody
	@PostMapping("/search")
	public String search(@RequestParam Map<String, Object> map) {
		System.out.println(map);
		
		List<Map<String, Object>> search = adminService.search(map);

		JSONObject json = new JSONObject();
		json.put("search", search);
		System.out.println(json.toString());
		
		return json.toString();
	}
*/

}
