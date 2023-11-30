package com.drhome.main;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MainDAO {

	Map<String, Object> findQuizByRandom(int randomNumber);

	List<Map<String, Object>> findNewQna();

	void raisePointByQuiz(Map<String, Object> data);

	List<Map<String, Object>> getNotification(Object mno);

	Map<String, Object> countNotification(Object mnomno);

	void updateNotificationNum(int nno);

	void raisePointByQuizToPoint(Map<String, Object> data);
	
	Map<String, Object> userInfo(Object mno);


}