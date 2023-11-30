package com.drhome.search;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Component;

@Component
public class SearchUtil {
	
	// 요일 변환
	public String convertDayOfWeek(int dayOfWeek) {
	    String dayString = "";

	    switch (dayOfWeek) {
	        case Calendar.SUNDAY:
	            dayString = "일요일";
	            break;
	        case Calendar.MONDAY:
	            dayString = "월요일";
	            break;
	        case Calendar.TUESDAY:
	            dayString = "화요일";
	            break;
	        case Calendar.WEDNESDAY:
	            dayString = "수요일";
	            break;
	        case Calendar.THURSDAY:
	            dayString = "목요일";
	            break;
	        case Calendar.FRIDAY:
	            dayString = "금요일";
	            break;
	        case Calendar.SATURDAY:
	            dayString = "토요일";
	            break;
	        default:
	            dayString = "요일을 알 수 없음";
	            break;
	    }

	    return dayString;
	}
	
	// 리스트 안에 있는 Map 꺼내기
	public List<String> changeTypeToString(List<Map<String, Object>> departmentList, String getKeyword) {
		List<String> dpKindList = new ArrayList<>();
		for (Map<String, Object> item : departmentList) {
			String dpKind = (String) item.get(getKeyword);
			dpKindList.add(dpKind);
		}
		return dpKindList;
	}
	
	// 반점 기준으로 잘라서 배열
	public List<String> changeTypeToStringByComma(List<Map<String, Object>> departmentKeyword, String getKeyword) {
        List<String> allKeywords = new ArrayList<>();

        for (Map<String, Object> item : departmentKeyword) {
            String dpKeyword = (String) item.get(getKeyword);
            String[] keywords = dpKeyword.split(",");
            for (String keyword : keywords) {
                allKeywords.add(keyword);
            }
        }
        return allKeywords;
    }
	
	// hno 중복 제거하기
	public List<Map<String, Object>> hnoUnique(List<Map<String, Object>> hospitalList) {
		List<Map<String, Object>> hnoDistinct = hospitalList.stream()
				.collect(Collectors.toMap(m -> m.get("hno"), m -> m, (m1, m2) -> m1))
		        .values()
		        .stream()
		        .collect(Collectors.toList());
		return hnoDistinct;
	}
	
	// 현재 요일
	public String currentDayOfTheWeek() {
		Calendar cal = Calendar.getInstance();
		String currentDay = convertDayOfWeek(cal.get(Calendar.DAY_OF_WEEK)); // 현재 요일 (1일, 2월, 3화, 4수, 5목, 6금, 7토)
		return currentDay;
	}
	
	// 현재 시간 
	public String currentTime() {
		Calendar cal = Calendar.getInstance();
		Date currentTime = cal.getTime(); // 현재 시간
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss"); // 시간 형식 
		String formattedTime = sdf.format(currentTime); // 포맷된 시간 (10:44:55)
		return formattedTime;
	}
	
}
