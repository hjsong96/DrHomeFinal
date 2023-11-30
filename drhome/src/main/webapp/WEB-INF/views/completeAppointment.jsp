<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<title>CompletePay</title>
<link href="/css/completeAppointment.css" rel="stylesheet" />
<script src="../js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	
</script>

</head>
<body>
	<div class="complete-area">
		<div class="img-area">
			<img class="img" alt="없음" src="/img/checkBlue.png">
		</div>
		<div id="completeTitle">접수가 완료되었습니다</div>
		<div class="comment-area">
		
			<div id="hospitalName">${appointment.hname }</div>
			
			<div class="wrapper" id="name">
				<div class="subTitle">진료자</div>
				<div>${appointment.mname }</div>
			</div>

			<div class="wrapper" id="doctor">
				<div class="subTitle">진료 의사</div>
				<div>${appointment.dname } 의사</div>
			</div>

			<div class="wrapper" id="appointmentDate">
				<div class="subTitle">진료 희망날짜</div>
				<div>${appointment.adate } (${appointment.aday })</div>
			</div>
			
			<div class="wrapper" id="appointmentTime">
				<div class="subTitle">진료 희망시간</div>
				<div>${appointment.atime }</div>
			</div>

		</div>
	</div>

	<footer>
		<button type="button" onclick="location.href='/main'">확인</button>
	</footer>

</body>
</html>