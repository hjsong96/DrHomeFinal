<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Calendar, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<title>hospitalLike</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/hospital.css">
<script src="../js/jquery-3.7.0.min.js"></script> 
<script type="text/javascript">
	$(function(){
		/* 뒤로가기 버튼 */
		$(document).on("click", ".xi-angle-left", function(){
			history.back();
		});
		
		/* 병원 총 개수 세기 */
	    hospitalCount();

		/* 접수 여부 표시하기 */
		$(".hospitalStatus_text").each(function() {
	        let $this = $(this);
	        let text = $this.text().trim();
	        if (text === '진료 중') {
	            $this.closest(".hospitalList").find(".receptionStatus").text('접수 가능');
	            $this.closest(".hospitalList").find(".receptionStatus").addClass('reservationStatus');
	        } else {
	            $this.closest(".hospitalList").find(".receptionStatus").text('접수 마감');
	            $this.closest(".hospitalList").find(".receptionStatus").removeClass('reservationStatus');
	        }
	    });

		/* 병원 찜하기 */
		$(document).on("click", ".hospitalLike", function(){
			
			let hospitalName = '';
			let hospitalDelName = '';
			let hospitalCount = '';
			
			/* 빈 하트 눌렀을 때 -> 채워진 하트 */
			if ( $(this).hasClass("xi-heart-o") ) {
				hospitalName = $(this).siblings().find($(".hospitalName")).text();
				$(this).addClass("xi-heart").removeClass("xi-heart-o")
				
			/* 채워진 하트 눌렀을 때 -> 빈 하트 */
			} else {
				event.preventDefault();
				 $("#dh-modal-alert").addClass("active").fadeIn();
				    setTimeout(function() {
				        $("#dh-modal-alert").fadeOut(function(){
				            $(this).removeClass("active");
				        });
				    }, 1500);
				    
				$(this).parent().parent($(".hospitalListContainer")).hide();
				hospitalCount = $(".hospitalListContainer:visible").length;
				hospitalDelName = $(this).siblings().find($(".hospitalName")).text();
			}
			$.ajax({
		         url: "../hospital",
		         type: "post",
		         dataType: "json",
		         data: {hospitalName : hospitalName, hospitalDelName : hospitalDelName},
		         success: function(data){
		     		$(".countNumber").text("총 " + hospitalCount + "개");
		         },
		         error: function(error){
		            alert("Error");
		         }
		      });
		    
		});
		  
 		/* 접수 페이지 이동 */
		$(document).on("click", ".receptionStatus", function(){
			let hno = $(this).siblings().val();
			let treatmentText = $(this).text().trim();
			if (treatmentText === '접수 가능') {
				return location.href= '../reception/' + hno;
			} else {
				alert("접수가 마감되었습니다.")
				return false;
			}
		});
 		
	});

	/* Collection of functions */
	
	/* 병원 상세보기 페이지 이동 */
	function hospitalDetail(hno) {
		location.href= '/hospitalDetail/' + hno;
	}

	/* 예약 상세보기 페이지 이동 */
	function hospitalAppointment(hno) {
		location.href= '/appointment/' + hno;
	}

	/* 목록에 있는 병원 개수 세기 */
	function hospitalCount() {
		let divCount = $(".hospitalListContainer:visible").length;
		$(".countNumber").text("총 " + divCount + "개");
	}
	
</script>

</head>
<body>

	<!-- header -->
	<header>
		<i class="xi-angle-left xi-x"></i>
		<div class="hospitalLikeHeaderText headerTitle">즐겨찾는 병원</div>
		<div class="blank blankImg" onclick="location.href='../hospital'"><i class="xi-plus xi-x"></i></div>
	</header>
	
	<main class="hospitalBox container">
	
	<!-- title -->
	<div class="hospitalLikeBar bar">
		<div class="hospitalCount count">
			병원 <span class="countNumber"></span>
		</div>
	</div>
	
	<!-- list -->
	<div class="hospitalListContainerBox">
		<c:if test="${sessionScope.mno ne null}">
			<c:forEach items="${hospitalList}" var="row">
				<c:if test="${fn:contains(hospitalLikeList, row.hname)}">
					<div class="hospitalListContainer">
						<div class="listContainer">
						<div class="hospitalList">
							<div class="hospitalStatus">
							
							<!-- 공휴일 -->
							<c:if test="${currentDay == '토요일' || currentDay == '일요일'}">
								<c:choose>
									<c:when test="${row.hholiday == 1}">
										<c:choose>
											<c:when test="${currentTime ge row.hopentime && currentTime le row.hholidayendtime}">
												<span class="availableCircle">● </span><span class="hospitalStatus_text">진료 중</span>
											</c:when>
											<c:otherwise><span class="unavailableCircle">● </span><span class="hospitalStatus_text">진료 종료</span></c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise><span class="unavailableCircle">● </span><span class="hospitalStatus_text">휴진</span></c:otherwise>
								</c:choose>
							</c:if>
							<!-- 평일 -->
							<c:if test="${ !(currentDay == '토요일' || currentDay == '일요일') }">
								<c:choose>
									<c:when test="${row.hnightday == currentDay}">
										<c:choose>
											<c:when test="${currentTime ge row.hopentime && currentTime le row.hnightendtime}">
												<span class="availableCircle">● </span><span class="hospitalStatus_text">진료 중</span>
											</c:when>
											<c:when test="${currentTime ge row.hbreaktime && currentTime le row.hbreakendtime}">
												<span class="unavailableCircle">● </span><span class="hospitalStatus_text">점심시간</span>
											</c:when>
											<c:otherwise><span class="unavailableCircle">● </span><span class="hospitalStatus_text">진료 종료</span></c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${currentTime ge row.hopentime && currentTime le row.hclosetime}">
												<span class="availableCircle">● </span><span class="hospitalStatus_text">진료 중</span>
											</c:when>
											<c:when test="${currentTime ge row.hbreaktime && currentTime le row.hbreakendtime}">
												<span class="unavailableCircle">● </span><span class="hospitalStatus_text">점심시간</span>
											</c:when>
											<c:otherwise><span class="unavailableCircle">● </span><span class="hospitalStatus_text">진료 종료</span></c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</c:if>
							</div>
							
							<div class="hospitalHeader" onclick="hospitalDetail(${row.hno})">
								<div class="hospitalName">${row.hname}</div>
								<div class="hospitalDepartment">${row.dpkind}</div>
							</div>
							<div class="hospitalBody" onclick="hospitalDetail(${row.hno})">
								<div class="hospitalAddress">${row.haddr}</div>
							</div>
							<div class="hospitalReview" onclick="hospitalDetail(${row.hno})">
								<img src="../img/star.png" style="width: 18px;">
								<div class="reviewScore">${row.hReviewAverage}</div>
								<div class="reviewCount">(${row.hReviewCount})</div>
							</div>
							<div class="hospitalReserve">
								<div class="receptionStatus"></div>
								<input type="hidden" class="hno" value="${row.hno}">
								<div class="reservationStatus" onclick="hospitalAppointment(${row.hno})">예약 가능</div>
							</div>
						</div>
						<div class="hospitalLike xi-heart"></div>
						
					</div>
					<div class="graySeperate"></div>
					</div>
				</c:if>
			</c:forEach>
		</c:if>
	</div>
	
	<!-- 알림창 -->
	<div id="dh-modal-alert">
		<div class="dh-modal">
			<div class="dh-modal-content">
				<div class="dh-modal-title">
					<img class="dh-alert-img" src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
					알림
				</div>
				<div class="dh-modal-text">즐겨찾는 병원이 해제되었습니다.</div>
			</div>
		</div>
		<div class="dh-modal-blank"></div>
	</div>
	
   </main>
</body>
</html>