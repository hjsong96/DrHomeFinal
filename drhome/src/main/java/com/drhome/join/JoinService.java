package com.drhome.join;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class JoinService {

	@Autowired
	private JoinDAO joinDAO;

	public int midCheck(String mid) {
		return joinDAO.midCheck(mid);
	}
	
	public String mnickname() {
		String[] arr01 = {"운동하는", "건강한", "활기찬", "스쿼트하는", "pt받는", "비타민 먹는", "프로틴 먹는", "약국 가는", "병원 가는", "러닝하는"};
		String[] arr02 = { "앵무새", "토끼", "다람쥐", "강아지", "미어캣", "쿼카", "임팔라", "기린", "호랑이" };
		int random1 = (int) (Math.random() * arr01.length);
		int random2 = (int) (Math.random() * arr02.length);
		String mnickname =  arr01[random1] + " " + arr02[random2];
		return mnickname;
	}

	public void join(Map<String, Object> map) {
		String mrrn = String.valueOf(map.get("firstMrrn")) +"-"+ String.valueOf(map.get("lastMrrn"));
		map.put("mrrn", mrrn);
		String mphonenumber = String.valueOf(map.get("firstNumber")) +"-"+ String.valueOf(map.get("MiddleNumber"))+"-"+ String.valueOf(map.get("lastNumber"));
		map.put("mphonenumber", mphonenumber);
		map.put("mnickname", mnickname());
		joinDAO.join(map);
	}

	public int mrrnCheck(String mrrn) {
		return joinDAO.mrrnCheck(mrrn);
	}

	
}
