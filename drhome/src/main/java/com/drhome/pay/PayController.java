package com.drhome.pay;

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

@Controller
public class PayController {

	@Autowired
	private PayService payService;
	
	@GetMapping("/pay/{mno}")
	public String pay(@PathVariable int mno, Model model, @RequestParam Map<String, Object> map) {
		map.put("mno", mno);
		Map<String, Object> payMoney = payService.payMoney(map);
		model.addAttribute("payMoney", payMoney);
		
		Map<String, Object> myPoint = payService.myPoint(map);
		model.addAttribute("myPoint", myPoint);
		
		return "/pay";
	}
	
	@ResponseBody
	@PostMapping("/cardCheck/{mno}")
	public String cardCheck(@RequestParam Map<String, Object> map, @PathVariable int mno) {
		map.put("mno", mno);		
		Map<String, Object> cardCheck = payService.cardCheck(map);
		JSONObject json = new JSONObject();
		json.put("cardCheck", cardCheck);

		return json.toString();
	}
	
	@GetMapping("/completePay/{mno}")
	public String completePay(@PathVariable int mno, Map<String, Object> map) {
		map.put("mno", mno);
		
		return "/completePay";
	}
	
	@PostMapping("/completePay/{mno}")
	public String completePay(@RequestParam Map<String, Object> map, @PathVariable int mno) {
		//카드 잔액 차감하기
		map.put("mno", mno);
		int intCdBalance = Integer.parseInt((String)map.get("cdbalance")) - Integer.parseInt((String)map.get("finalPay"));
		map.put("intCdBalance", intCdBalance);
		payService.minusCdbalance(map);
		
		//포인트 차감내역
		int intTotalPoint = Integer.parseInt((String)map.get("totalPoint"));
		int intPtpoint = Integer.parseInt((String)map.get("myPoint")) - Integer.parseInt((String)map.get("totalPoint"));
		map.put("intTotalPoint", intTotalPoint);
		map.put("intPtpoint", intPtpoint);
		payService.minusPtpoint(map);
		
		//포인트 차감하기
		payService.minusMpoint(map);
		
		
		//포인트 지급내역
		int nowPtpoint = payService.nowPtpoint(map);
		double doublePoint = Integer.parseInt((String)map.get("totalPay")) * 0.01;
		int changePoint = (int)doublePoint;
		int sumPtpoint = nowPtpoint + changePoint;
		map.put("changePoint", changePoint);
		map.put("sumPtpoint", sumPtpoint);
		payService.plusPtpoint(map);
		
		//포인트 지급하기
		payService.plusMpoint(map);
		
		//결제상태 변경하기
		payService.updatePaystatus(map);
		
		return "/completePay";
	}
	
}
