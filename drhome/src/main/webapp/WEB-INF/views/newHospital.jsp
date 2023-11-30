<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<title>신규 병원 등록</title>
<link rel="stylesheet" href="../css/hosDoc.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		let rhholiday = $("#rhholiday");
		let rhholidayendtime = $("#rhholidayendtime");
		let rhparking = $("#rhparking");
		let rhnightday = $("#rhnightday").val();
		let rhnightendtime = $("#rhnightendtime");
		let rhbreaktime = $("#rhbreaktime").val();
		let rhbreakendtime = $("#rhbreakendtime");

		rhholidayendtime.hide();
		rhholiday.change(function() {
			if ($(this).is(":checked")) { rhholiday.val(1);
				rhholidayendtime.show();
			} else {
				rhholidayendtime.hide();
			}
		});
		rhparking.change(function() {
			if ($(this).is(":checked")) {
				rhparking.val(1);
			}
		});

		if (rhnightday == "") {
			rhnightendtime.hide();
		} else {
			rhnightendtime.show();
		}

		$("#rhnightday").change(function() {
			if ($(this).val() != "") {
				rhnightendtime.show();
			} else {
				rhnightendtime.hide();
			}
		});

		if (rhbreaktime == "") {
			rhbreakendtime.hide();
		} else {
			rhbreakendtime.show();
		}

		$("#rhbreaktime").change(function() {
			if ($(this).val() != "") {
				rhbreakendtime.show();
			} else {
				rhbreakendtime.hide();
			}
		});
	
		let ni = document.getElementById("noInput");
		ni.addEventListener("submit", function(e){
			$("#dh-modal-alert").addClass("active").fadeIn();
			let noName = document.getElementById("rhname");
			let noNewOpen = document.getElementById("rhopendate");
			let noAddr = document.getElementById("rhaddr");
			let noNumber = document.getElementById("rhtelnumber");
			let noImg = document.getElementById("rhimg");
			let noInfo = document.getElementById("rhinfo");
			let noOpenTime = document.getElementById("rhopentime");
			let noCloseTime = document.getElementById("rhclosetime");
			let noNightDay = document.getElementById("rhnightday");
			let noNightEndTime = document.getElementById("rhnightendtime");
			let noBreakTime = document.getElementById("rhbreaktime");
			if (noName.value.length == "" || 
				noNewOpen.value.length == "" || 
				noAddr.value.length == "" || 
				noNumber.value.length == "" || 
				noImg.value.length == "" || 
				noInfo.value.length == "" || 
				noOpenTime.value.length == "" || 
				noCloseTime.value.length == "" ||
				noNightDay.value.length == "" ||
				noNightEndTime.value.length == "") {
				setTimeout(function() {
			           $("#dh-modal-alert").fadeOut(function(){
			               $(this).removeClass("active");
			           });
			    }, 1000);
				e.preventDefault();
			}
		});
		
		/* $("#noInput").submit(function(e) {
		    e.preventDefault(); // 기본 이벤트 동작 방지 (페이지 새로고침 방지)
		    
		    // 각 필드의 값을 가져와서 공백 여부를 확인
		    let noName = $("#rhname").val();
		    let noNewOpen = $("#rhopendate").val();
		    let noAddr = $("#rhaddr").val();
		    let noNumber = $("#rhtelnumber").val();
		    let noImg = $("#rhimg").val();
		    let noInfo = $("#rhinfo").val();
		    let noOpenTime = $("#rhopentime").val();
		    let noCloseTime = $("#rhclosetime").val();
		    let noNightDay = $("#rhnightday").val();
		    let noNightEndTime = $("#rhnightendtime").val();
		    let noBreakTime = $("#rhbreaktime").val();

		    // 필드 중 하나라도 비어있으면 알람을 보여줌
		    if (
		        noName.trim() === "" || noNewOpen.trim() === "" || noAddr.trim() === "" ||
		        noNumber.trim() === "" || noImg.trim() === "" || noInfo.trim() === "" ||
		        noOpenTime.trim() === "" || noCloseTime.trim() === "" ||
		        noNightDay.trim() === "" || noNightEndTime.trim() === "" || noBreakTime.trim() === ""
		    ) {
		        $("#dh-modal-alert").fadeIn(); // 모달 표시
		        setTimeout(function() {
		            $("#dh-modal-alert").fadeOut(); // 1초 후에 모달 숨김
		        }, 1000);
		    } else {
		        // 모든 필드가 채워져 있으면 폼을 제출함
		        this.submit();
		    }
		}); */
	});
</script>
</head>
<body>


<div id="dh-modal-alert" style="display: none">
      <div class="dh-modal">
         <div class="dh-modal-content">
            <div class="dh-modal-title">
               <img class="dh-alert-img"
                  src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
               알림
            </div>
            <div class="dh-modal-text">비어있는 값을 빠짐없이 입력해주세요.</div>
         </div>
      </div>
      <div class="dh-modal-blank"></div>
   </div>



<form action="/newDoctor" method="POST" id="noInput">

	<header>

		<a href="/login"><i class="xi-angle-left xi-x"></i></a>
		<div class="headerTitle">병원개설</div>
		<div class="blank"></div>
	</header>

<main>
    <div class="main-area">
	<div class="article">
		<span><img src="../img/DrHome_logo_side.png" /></span>
		<div class="content">
			닥터홈에 오신것을 환영합니다!<br> 
			병원 개설을 위해 아래 내용을 입력해주세요.
		</div>
			<div class="Group">
				<p>병원명</p>
				<input class="vector" type="text" placeholder="병원명" id="rhname" name="rhname">
			</div>
			<div class="Group">
				<p>설립연도</p>	
				<input class="vector" type="date" name="rhopendate" id="rhopendate">
			</div>
			<div class="Group">
				<p>주 소</p>	
				<input class="vector" type="text" placeholder="주 소" name="rhaddr" id="rhaddr">
			</div>
			<div class="Group">
				<p>전화번호</p>
				<input class="vector" type="text" placeholder="전화번호" name="rhtelnumber" id="rhtelnumber">
			</div>
			<div class="Group">
				<p>소 개</p>
				<input class="vector" type="text" placeholder="소 개" name="rhinfo" id="rhinfo">
			</div>
			<div class="Group">
				<p>시작시간</p>
				<input class="vector" type="text" placeholder="시작시간" name="rhopentime" id="rhopentime">
			</div>
			<div class="Group">
				<p>종료시간</p>
				<input class="vector" type="text" placeholder="종료시간" name="rhclosetime" id="rhclosetime">
			</div>
			<div class="Group">
				<p>야간 진료 요일</p>
				<input class="vector" id="rhnightday" type="text" placeholder="야간 진료요일" name="rhnightday" id="rhnightday">
			</div>
			<div class="Group" id="rhnightendtime">
				<p>야간 종료시간</p>
				<input class="vector" type="text" placeholder="야간 종료시간" name="rhnightendtime">
			</div>
			<div class="Group">
				<p>브레이크 타임</p>
				<input class="vector" id="rhbreaktime" type="text" placeholder="브레이크 타임" name="rhbreaktime" id="rhbreaktime">
			</div>
			<div class="Group" id="rhbreakendtime">
				<p>브레이크 종료시간</p>
				<input class="vector" type="text" placeholder="브레이크 종료시간" name="rhbreakendtime">
			</div>
			<div class="Group">
				<p>공휴일 진료여부</p>
				<input type="checkbox" id="rhholiday" name="rhholiday" class="vector cm-toggle">
			</div>
			<div class="Group" id="rhholidayendtime">
				<p>공휴일 종료시간</p>
				<input class="vector" type="text" placeholder="공휴일 종료시간" name="rhholidayendtime">
			</div>
			<div class="Group">
				<p>주차 여부</p>
				<input type="checkbox" id="rhparking" name="rhparking" class="vector cm-toggle">
			</div>
		</div>
		</div>
	<div style="height: 9vh"></div>
</main>
<footer>
	<button class="btn" type="submit">병원 개설하기 ▷</button>
</footer>
</form>
</body>
</html>
