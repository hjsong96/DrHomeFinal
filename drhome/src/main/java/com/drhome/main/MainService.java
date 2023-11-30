package com.drhome.main;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MainService {
	
	@Autowired
	private MainDAO mainDAO;
	
	public Map<String, Object> findQuizByRandom(int randomNumber) {
		return mainDAO.findQuizByRandom(randomNumber);
	}

	public List<Map<String, Object>> findNewQna() {
		return mainDAO.findNewQna();
	}


	public void raisePointByQuiz(Map<String, Object> data) {
		mainDAO.raisePointByQuiz(data);
		mainDAO.raisePointByQuizToPoint(data);
		
	}

	public List<Map<String, Object>> getNotification(Object mno) {
		return mainDAO.getNotification(mno);
	}

	public Map<String, Object> countNotification(Object mno) {
		return mainDAO.countNotification(mno);
	}

	public void updateNotificationNum(int nno) {
		mainDAO.updateNotificationNum(nno);
	}
	

	public Map<String, Object> userInfo(Object mno) {
		return mainDAO.userInfo(mno);
	}



}
