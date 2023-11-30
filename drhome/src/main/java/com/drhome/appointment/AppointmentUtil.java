package com.drhome.appointment;

import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class AppointmentUtil {
	LocalDate now = LocalDate.now();
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	// 일주일 요일뽑기
	public List<String> daysOfWeek() {

		List<String> daysOfWeek = new ArrayList<>();

		for (int i = 0; i < 20; i++) {
			DayOfWeek day = now.plusDays(i).getDayOfWeek();

			switch (day.name()) {
			case "SUNDAY":
				daysOfWeek.add("일요일");
				break;
			case "MONDAY":
				daysOfWeek.add("월요일");
				break;
			case "TUESDAY":
				daysOfWeek.add("화요일");
				break;
			case "WEDNESDAY":
				daysOfWeek.add("수요일");
				break;
			case "THURSDAY":
				daysOfWeek.add("목요일");
				break;
			case "FRIDAY":
				daysOfWeek.add("금요일");
				break;
			case "SATURDAY":
				daysOfWeek.add("토요일");
				break;
			default:
				daysOfWeek.add("");
				break;
			}
		}

		return daysOfWeek;
	}

	// 일주일 날짜 뽑기
	public List<String> dateOfWeek() {
		LocalDate now = LocalDate.now();
		List<String> dateOfWeek = new ArrayList<String>();

		for (int i = 0; i < 20; i++) {
			LocalDate date = now.plusDays(i);
			dateOfWeek.add(date.format(formatter));
		}
		return dateOfWeek;
	}

	public List<String> splitTimeRange(Date startTime, Date endTime) {

		List<String> timeSlots = new ArrayList<>();

		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");

		// 30분
		long interval = 30 * 60 * 1000;

		for (long time = startTime.getTime(); time < endTime.getTime(); time += interval) {
			Date slotDate = new Date(time);
			timeSlots.add(sdf.format(slotDate));
		}

		return timeSlots;
	}
}
