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

<link rel="stylesheet" href="../css/appointment.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="../js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		let time = '';
		let hno = '';
		let day = '';
		let date = '';
		let dno = '';
		let dpkind ='';
		
		//처음 시작시 진료 선택 content 열어주기
		$('.departmentKind .content').show();
		
		//arrow클릭시 content열리고 arrow위아래 바꿔주기
		$(document).on('click','.arrow',function(){
			$(this).parent().siblings('.content').toggle('slide');
			updateArrow(this)
		})
		
		//진료 종류 선택시 해당 content 닫고 arrow위아래 바꿔주기-> 다음 content 열어주기, arrow update
		$('#normalKind').click(function(){
			dpkind = '일반진료'
			$(this).parents().siblings().children('.appointmentTitle').html('<i class="xi-check xi-x status"></i> 일반진료')
			
			updateArrow($('.departmentKind .arrow'));
			$(this).parent('.content').toggle('slide');
			
			$('.doctor .content').show('slide');
			upArrow($('.doctor .arrow'));
			checkFinish()
			
			
		})
		
		
		//의사 선택시 의사 선택 효과 / 의사 선택 제목 및 체크 표시
		$('.selectDoctorInfo').click(function() {
			dno = $(this).children('#doctor').val();
			let dname = $(this).text();
			$(this).siblings().removeClass('selectedDoc');
			$(this).addClass('selectedDoc');
			$(this).parents().siblings().children('.appointmentTitle').html('<i class="xi-check xi-x status"></i>의사 ' + dname);
			
			updateArrow($('.doctor .arrow'));
			$(this).parents('.content').toggle('slide');
			
			$('.date .content').show('slide');
			upArrow($('.date .arrow'));
		});
		
		
		
		//날짜 고르면 실행
		$('.chooseDate').click(function() {
      		$(this).siblings().children('.circle').removeClass('selectedDate');
    		$(this).children('.circle').addClass('selectedDate');
     		hno = $('#hno').val();
      		day = $(this).children('.day').val();
      		date = $(this).children('.date').val();
      		checkFinish();
      		
      		$(this).parents().siblings().children('.appointmentTitle').html('<i class="xi-check xi-x status"></i>' + date + '&nbsp&nbsp&nbsp' + day);
      		
    		updateArrow($('.date .arrow'));
			$(this).parents('.content').toggle('slide');
			
			$('.time .content').show('slide');
			upArrow($('.time .arrow'));
      		
      		$.ajax({
        		url : "../getTime",
        		type : "GET",
        		data : {"hno" : hno,  "day" : day,  "date" : date },
        		
        		success: function(data) {
        			  let newdata = JSON.parse(data);
        			  let item = '';
        			  $('.timeContainer').empty();
        			  
        			  //오늘일 경우 진료접수로 보내기
        			  if(newdata.timeSlots == "오늘"){
        				  item += "진료접수를 확인하세요"
        			  }else{
							
	        			  // 해당 날짜에 진료 여부 체크
	        			  if (newdata.timeSlots != null && newdata.timeSlots.length > 0) {
	        			    let morning = false; // 오전 라벨이 이미 추가되었는지 여부를 체크하는 변수
	        			    let afternoon = false; // 오전 라벨이 이미 추가되었는지 여부를 체크하는 변수
	
	        			    // 시작 ~ 끝 30분으로 쪼개서 true로 만들기
	        			    for (let i = 0; i < newdata.timeSlots.length; i++) {
	        			      let isTimeAvailable = true;
	
	        			      // 예약된 시간이란 쪼갠 시간이 같으면 false로 만들기
	        			      for (let j = 0; j < newdata.checkTime.length; j++) {
	        			        if (newdata.timeSlots[i] == newdata.checkTime[j].atime) {
	        			          isTimeAvailable = false;
	        			          break;
	        			        }
	        			      }
	
	
	        			      // 오전 라벨이 추가되지 않았을 때만 추가
	        			      if (!morning) {
	        			        if (parseInt(newdata.timeSlots[i].split(":")[0]) < 12) {
	        			          item += "<div class='morning'>오전</div>";
	        			          morning = true; // 오전 라벨이 추가되었음을 표시
	        			        }
	        			      }
	
	        			      // 시간이 12:00보다 작으면 오전, 그 이상이면 오후로 표시
	        			      if (!afternoon) {
		        			      if (parseInt(newdata.timeSlots[i].split(":")[0]) >= 12) {
		        			    	  item += "<div class='afternoon'>오후</div>";
		        			    	  afternoon =true;
		        			      }
	        			      }
	
	        			      if (isTimeAvailable) {
	        			        item += "<button class='timeAvailable'>" + newdata.timeSlots[i] + "</button>";
	        			      } else {
	        			        item += "<button class='timeUnavailable' disabled='disabled'>" + newdata.timeSlots[i] + "</button>";
	        			      }
	        			    }
	
	        			  } else {
	        			    item += "휴진입니다."; 
	        			  }

					}
        			  $('.timeContainer').append(item);
        			},
		        	error : function(error) {
		         		console.log(error);
		        	}
		      });
		
		  })
		  
		//시간 클릭시 
		$(document).on('click', '.timeAvailable', function() {
			time = $(this).text();
			
			$(this).parents().siblings().children('.appointmentTitle').html('<i class="xi-check xi-x status"></i>' + time.split(':')[0] + '시 ' +time.split(':')[1] + '분' );
			
			$(this).siblings().removeClass('selectedTime');
			$(this).addClass('selectedTime');
			
			updateArrow($('.time .arrow'));
			$(this).parents('.content').toggle('slide');
			 checkFinish()
		})

		$('.finish').click(function() {
			let form = $('<form></form>');
			form.attr("action", "../appointment");
			form.attr("method", "post");
			form.append($("<input>", {type : 'hidden',name : "hno",value : hno}));
			form.append($("<input>", {type : 'hidden',name : "dno",value : dno}));
			form.append($("<input>", {type : 'hidden',name : "date",value : date}));
			form.append($("<input>", {type : 'hidden',name : "day",value : day}));
			form.append($("<input>", {type : 'hidden',name : "time",value : time}));
			form.append($("<input>", {type : 'hidden',name : "content",value : $('#noteText').val()}));
			form.append($("<input>", {type : 'hidden',name : "mno",value : ${sessionScope.mno}}));
			form.appendTo("body");
			form.submit();
		})
		
		// arrow toggle
		function updateArrow(element){
			$(element).children('.xi-angle-down, .xi-angle-up').toggleClass('xi-angle-down xi-angle-up');
		} 
		
		//arrow up으로만 만들기
		function upArrow(element){
			$(element).children('.xi-angle-down').removeClass('xi-angle-down').addClass('xi-angle-up');

		}
		
		function checkFinish(){
			if(!(dpkind=='' || date =='' || dno == '' || time== '') ){
				$('.finish').addClass('selectedFinish')
				$('.finish').prop('disabled', false);
			}
			
		}
		
	});
</script>

</head>
<body>

	<header>
		<a href="../hospitalDetail/${hospital.hno }"><i
			class="xi-angle-left xi-x"></i></a>
		<div class="headerTitle">병원 예약</div>
		<div id="blank"></div>
	</header>

	<main>
		<input id="hno" type="hidden" value="${hospital.hno }">
		<div class="section profile">
			<img alt="프로필 사진" src="../img/appointmentProfilePic.png">
			${sessionScope.mname }님
		</div>

		<div class="graySeperate"></div>


		<div class="section departmentKind">
			<div class="appointmentTitleWrapper">
				<div class="appointmentTitle">
					<img alt="진료종류" src="../img/appointmentDepartmentKind.png">
					진료 선택
				</div>
				<div class="arrow">
					<i class="xi-angle-up xi-x"></i>
				</div>
			</div>

			<div class="content">
				<div id="normalKind">
					일반진료<i class="xi-check xi-x"></i>
				</div>
			</div>


		</div>

		<div class="graySeperate"></div>


		<div class="section doctor">
			<div class="appointmentTitleWrapper">
				<div class="appointmentTitle">
					<img alt="의사icon" src="../img/appointmentDoctor.png">의사 선택
				</div>
				<div class="arrow">
					<i class="xi-angle-down xi-x"></i>
				</div>
			</div>

			<div class="content">
				<div class="chooseDoctor">
					<c:forEach var="doctor" items="${doctor}">
						<div class="selectDoctorInfo">
							<img alt="의사사진" src="${doctor.dimg }"><br>
							${doctor.dname } <input type="hidden" id="doctor"
								value="${doctor.dno }">
						</div>
					</c:forEach>
				</div>
			</div>
		</div>

		<div class="graySeperate"></div>

		<div class="section date">
			<div class="appointmentTitleWrapper">
				<div class="appointmentTitle">
					<img alt="의사icon" src="../img/appointmentCalendar.png">날짜 선택
				</div>
				<div class="arrow">
					<i class="xi-angle-down xi-x"></i>
				</div>
			</div>

			<div class="content">
				<div class="chooseDateWrapper">
					<c:forEach var="i" begin="0" end="${date.size()-1 }">
						<div class="chooseDate">
							<input type="hidden" class="day" value="${day[i] }"> <input
								type="hidden" class="date" value="${date[i] }"> <span>${day[i].substring(0,1) }
							</span>
							<c:choose>
								<c:when test="${date[i].substring(8, 9) == '0'}">
									<div class="circle">${date[i].substring(9, 10)}</div>
								</c:when>
								<c:otherwise>
									<div class="circle">${date[i].substring(8, 10)}</div>
								</c:otherwise>
							</c:choose>
						</div>
					</c:forEach>
				</div>

			</div>
		</div>

		<div class="graySeperate"></div>


		<div class="section time">
			<div class="appointmentTitleWrapper">
				<div class="appointmentTitle">
					<img alt="시간" src="../img/appointmentTime.png"> 시간 선택
				</div>
				<div class="arrow">
					<i class="xi-angle-down xi-x"></i>
				</div>
			</div>

			<div class="content">
				<div class="timeWrapper">
					<div class="timeContainer">날짜를 먼저 선택해주세요</div>
				</div>
			</div>
		</div>


		<div class="graySeperate"></div>


		<div class="section note">
			<div class="appointmentTitleWrapper">
				<div class="appointmentTitle">
					<img alt="시간" src="../img/appointmentNote.png"> 전달사항 <span>
						(선택)</span>
				</div>
			</div>

			<textarea id="noteText" maxlength="100"
				placeholder="증상을 알려주세요 (선택) (최대 100자)"></textarea>

		</div>

		<div style="height: 10vh; width: 100%;"></div>

	</main>


	<footer>
		<button class="finish" disabled="disabled">예약완료</button>
	</footer>


</body>
</html>