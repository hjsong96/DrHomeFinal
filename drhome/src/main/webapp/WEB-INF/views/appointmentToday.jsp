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
<title>Insert title here</title>

<link rel="stylesheet" href="../css/appointmentToday.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="../js/jquery-3.7.0.min.js"></script>

<script>
	$(function() {
		let hno = '';
		let dpkind = '';
		let time = '';
		let date = $('#date').val()
		let day = $('#day').val()
		
		$('.department').click(function() {
			dpkind = $(this).val();
			$(this).addClass('selectedButton');
			$(this).siblings().removeClass('selectedButton');
			$('.todayTimeIntro').hide();
			$('.content').show();
		})

		$('.todayTime').click(function() {
			time = $(this).val();
			$(this).addClass('selectedButton');
			$(this).siblings().removeClass('selectedButton');
			$('.finish').addClass('selectedFinish')
			$('.finish').prop('disabled', false);
		})
		
		$('.finish').click(function(){
			let form = $('<form></form>');
			form.attr("action", "../appointmentToday");
			form.attr("method", "post");
			form.append($("<input>", {type : 'hidden',name : "hno",value : ${hospital.hno}}));
			form.append($("<input>", {type : 'hidden',name : "dpkind",value : dpkind}));
			form.append($("<input>", {type : 'hidden',name : "date",value : date}));
			form.append($("<input>", {type : 'hidden',name : "day",value : day}));
			form.append($("<input>", {type : 'hidden',name : "time",value : time}));
			form.append($("<input>", {type : 'hidden',name : "mno",value : ${sessionScope.mno}}));
			form.appendTo("body");
			form.submit();
		})
	})
	
</script>


</head>
<body>
	<header>
		<a href="../hospitalDetail/${hospital.hno }"><i
			class="xi-angle-left xi-x"></i></a>
		<div class="headerTitle">접수하기</div>
		<div id="blank"></div>
	</header>


	<main>
		<input type="hidden" id="day" value="${dayOfToday }"> <input
			type="hidden" id="date" value="${today }">
		<div class="section hospitalInfo">
			<div id="hopitalName">${hospital.hname }</div>
			<div id="hospitalLocation">
				<img alt="위치" src="../img/appointmentTodayLocation.png">
				${hospital.haddr }
			</div>
			<div id="dpKind">진료실 : &nbsp&nbsp 일반진료</div>
			<div id="date">진료일 : &nbsp&nbsp ${today } &nbsp ${dayOfToday }</div>


		</div>

		<div class="graySeperate"></div>

		<div class="section profile">
			<img alt="프로필 사진" src="../img/user.png"> ${sessionScope.mname }님
		</div>

		<div class="graySeperate"></div>

		<div class="section">
			<div class="todayTilte">진료과를 선택해주세요</div>
			<div class="chooseDepartments">
				<c:forEach var="department"
					items="${hospitalDepartments.hospitalDepartments.split(',')}">
					<button class="selectButton department" value="${department}">${department }</button>
				</c:forEach>
			</div>
		</div>

		<div class="graySeperate"></div>

		<div class="section">
			<div class="todayTilte">시간을 선택해주세요</div>
			<div class="todayTimeIntro">진료과를 먼저 선택해주세요</div>

			<div class="content">
				<div class="timeTitle">오전</div>
				<c:set var="nowHour" value="${nowTime.split(':')[0]}" />
				<c:set var="nowMinute" value="${nowTime.split(':')[1]}" />
				<c:forEach var="selecttime" items="${timeSlots}">
					<c:set var="hour" value="${fn:substring(selecttime, 0, 2)}" />
					<c:set var="minute" value="${fn:substring(selecttime, 3, 5)}" />

					<!-- 오전 오후 나누기 -->
					<c:if test="${hour lt '12'}">
						<!-- 현재시간 이전에는 버튼 선택 못하기 -->
						<c:choose>
							<c:when test="${hour lt nowHour }">
								<button class="selectButton unavailable" disabled="disabled"
									value="${selecttime}">${selecttime}</button>
							</c:when>
							<c:when test="${hour eq nowHour && minute lt nowMinute}">
								<button class="selectButton unavailable" disabled="disabled"
									value="${selecttime}">${selecttime}</button>
							</c:when>
							<c:otherwise>
								<button class="selectButton todayTime" value="${selecttime}">${selecttime}</button>

							</c:otherwise>
						</c:choose>
					</c:if>
				</c:forEach>

				<div class="timeTitle afternoon">오후</div>
				<c:forEach var="selecttime" items="${timeSlots}">
				<c:set var="hour" value="${fn:substring(selecttime, 0, 2)}" />
					<c:if test="${hour ge '12'}">
						<c:choose>
							<c:when test="${hour lt nowHour }">
								<button class="selectButton unavailable" disabled="disabled"
									value="${selecttime}">${selecttime}</button>
							</c:when>
							<c:when test="${hour eq nowHour && minute lt nowMinute}">
								<button class="selectButton unavailable " disabled="disabled"
									value="${selecttime}">${selecttime}</button>
							</c:when>
							<c:otherwise>
								<button class="selectButton todayTime" value="${selecttime}">${selecttime}</button>
							</c:otherwise>
						</c:choose>
					</c:if>
				</c:forEach>
			</div>
		</div>
		<div style="height: 9vh; width: 100%;"></div>
	</main>

	<footer>
		<button class="finish" disabled="disabled">접수완료</button>
	</footer>


</body>
</html>