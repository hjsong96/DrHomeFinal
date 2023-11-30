package com.drhome.pay;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PayService {

	@Autowired
	private PayDAO payDAO;

	public Map<String, Object> payMoney(Map<String, Object> map) {
		return payDAO.payMoney(map);
	}

	public Map<String, Object> cardCheck(Map<String, Object> map) {
		return payDAO.cardCheck(map);
	}

	public Map<String, Object> myPoint(Map<String, Object> map) {
		return payDAO.myPoint(map);
	}

	public void minusCdbalance(Map<String, Object> map) {
		payDAO.minusCdbalance(map);
	}

	public void minusPtpoint(Map<String, Object> map) {
		payDAO.minusPtpoint(map);
		
	}

	public void plusPtpoint(Map<String, Object> map) {
		payDAO.plusPtpoint(map);
		
	}
	public int nowPtpoint(Map<String, Object> map) {
		return payDAO.nowPtpoint(map);
	}

	public void minusMpoint(Map<String, Object> map) {
		payDAO.minusMpoint(map);
	}

	public void plusMpoint(Map<String, Object> map) {
		payDAO.plusMpoint(map);
	}

	public void updatePaystatus(Map<String, Object> map) {
		payDAO.updatePaystatus(map);
	}
	
}
