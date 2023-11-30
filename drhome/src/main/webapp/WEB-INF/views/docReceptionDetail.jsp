<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet"href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<title>DocReceptionDetail</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="/css/docReceptionDetail.css">
<link href="/css/aram.css" rel="stylesheet" />
<script src="/js/jquery-3.7.0.min.js"></script> 
<script src="/js/wnInterface.js"></script> 
<script src="/js/mcore.min.js"></script> 
<script src="/js/mcore.extends.js"></script> 
<script type="text/javascript">

		
$(function() {
	
	let offsetSubMenu = $(".subMenu").offset().top;
	
	let offsetPatient = $("#patientInfo").offset().top - (18 * window.innerHeight / 100);
	let offsetSymtom = $("#symptomInfo").offset().top - (18 * window.innerHeight / 100);
	let offsetDiagnosis = $("#diagnosisInfo").offset().top - (18 * window.innerHeight / 100);
	
	$(window).scroll(function() {
	    let scrollPos = $(window).scrollTop();
	    if (scrollPos >= offsetSubMenu - (7 * window.innerHeight / 100)) {
	    	 $(".subMenu").addClass("fixed");
	         $('#placeHolderDiv').show();
	    } else {
	    	 $(".subMenu").removeClass("fixed");
	         $('#placeHolderDiv').hide();
	    }
	    
	    if (scrollPos >= offsetPatient && scrollPos < offsetSymtom) {
	        $('#subMenu1').addClass('selectedSubMenu').siblings().removeClass('selectedSubMenu');
	    }
	    if (scrollPos >= offsetSymtom && scrollPos < offsetDiagnosis) {
	        $('#subMenu2').addClass('selectedSubMenu').siblings().removeClass('selectedSubMenu');
	    }
	    if (scrollPos >= offsetDiagnosis) {
	        $('#subMenu3').addClass('selectedSubMenu').siblings().removeClass('selectedSubMenu');
	    } 
	});
	
	$('.subMenu>ul>li').click(function() {
	    let offset;
	    
	    if ($(this).text() == '환자정보') {
	        offset = $("#patientInfo").offset().top - (15 * window.innerHeight / 100);
	    } else if ($(this).text() == '증상기록') {
	        offset = $("#symptomInfo").offset().top - (15 * window.innerHeight / 100);
	    } else {
	        offset = $("#diagnosisInfo").offset().top - (15 * window.innerHeight / 100);
	    }
	    
	    $("html, body").animate({
	        scrollTop: offset
	    }, 450);
	});
	
	$("#completeDiagnosis").click(function(){
		
		let tdiagnosisdetail = $("#tdiagnosisdetail").val();
		if(tdiagnosisdetail === "" ) {
			//진단기록 입력 alert
			$("#dh-modal-alert").addClass("active").fadeIn();
    		setTimeout(function() {
        		$("#dh-modal-alert").fadeOut(function(){
            		$(this).removeClass("active");
        		});
    		}, 1000);
			$("#tdiagnosisdetail").focus();
			return false;
		}
	});

	//모피어스 콜
	document.getElementById("callIcon").addEventListener("click", function() {
	  let phoneNumber = $("#phoneNumber").text();
	  M.sys.call(phoneNumber);
	});
	
});

</script>

</head>
<body>
	<header>
		<a href="/docReception/${sessionScope.mno}/${sessionScope.dno}"><i class="xi-angle-left xi-x"></i></a>
		<div class="headerTitle">${docMainDetail.hname}</div>
		<div class="blank"></div>
	</header>
	
	<main>
		<div class="subMenu">
			<ul>
				<li id="subMenu1" class="selectedSubMenu" >환자정보</li>
				<li id="subMenu2">증상기록</li>
				<li id="subMenu3">진단기록</li>
			</ul>
		</div>	
	
	<div id="placeHolderDiv" style="height: 7vh; display: none;"></div>
	
	<div class="patientInfo-area">
		<div class="title" id="patientInfo">환자정보</div>
		    <div class="patient-area">
			    <p class="p-title">이름</p>
				<p class="p-detail">${patientDetail.mname}</p>
		    </div>
		    <div class="patient-area">
				<p class="p-title">생년월일</p>
				<p class="p-detail">${patientDetail.mbirth}</p>
		    </div>
		    <div class="patient-area">
				<p class="p-title">휴대폰 번호</p>
				<p class="p-detail" id="phoneNumber">${patientDetail.mphonenumber}</p>
			</div>
	 		<div class="patient-area">		
				<p class="p-title">이메일 주소</p>
				<p class="p-detail">${patientDetail.memail}</p>
			</div>
			<div class="patient-area">
				<p class="p-title">질병 특이사항</p>
				<c:choose>
				    <c:when test="${empty patientDetail.hrissue}">
				        <p class="p-detail">없음</p>
				    </c:when>
				    <c:otherwise>
				    	<p class="p-detail">${patientDetail.hrissue}</p>
				    </c:otherwise>
				</c:choose>
			</div>
			<div class="patient-area">
				<p class="p-title">우리병원 이용 횟수</p>
				<p class="p-detail">${hospitalCount} 회</p>
			</div>
	</div>	

	
	<div class="graySeperate"></div>
	
	<div class="symptomInfo-area">
		<div class="title" id="symptomInfo">증상기록</div>
			<span class="write">${patientDetail.tsymptomdetail}</span>
	</div>
	
	<div class="graySeperate"></div>

	<form action="/updateTelehealth/${sessionScope.mno}/${sessionScope.dno}" method="post">
	<div class="diagnosisInfo-area">
		<div class="title" id="diagnosisInfo">진단기록</div>
			<textarea id="tdiagnosisdetail" name="tdiagnosisdetail"></textarea>
				<div class="bottom">
					<p class="bottom-title">※ 진단기록 작성 시 유의사항</p>
					<p class="bottom-detail">1. 진단기록은 최대 150자 이내로 작성 가능합니다.</p>
					<p class="bottom-detail">2. 진단기록은 반드시 전화 진단 결과를 바탕으로 작성해주세요.</p>
					<p class="bottom-detail2">(허위 진단 시 법적 책임을 물을 수 있습니다.)</p>
					<p class="bottom-detail">3. 진단기록은 구체적으로 작성 부탁드립니다.</p>
					<p class="bottom-detail">4. 비대면 진료 대상자가 아닌 경우 진료처리 취소를 해주세요.</p>
					<p class="bottom-detail">5. 환자의 개인정보는 캡처 및 보관이 불가능합니다.</p>
				</div>
				
				<div class="center-circle-area">
					<div class="center-circle">
						<div class="center-img">
							<img id="callIcon" alt="없음" src="/img/phone-call.png">
						</div>
					</div>
				</div>
			<input type="hidden" id="tno" value="${patientDetail.tno}" name="tno">
	</div>	
	
	<footer>
		<button id="completeDiagnosis" type="submit">진료완료</button>
	</footer>
	</form>
	</main>
	
				<!-- 알람모달 -->
	
	<div id="dh-modal-alert">
		<div class="dh-modal">
			<div class="dh-modal-content">
				<div class="dh-modal-title">
					<img class="dh-alert-img" src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
					알림
				</div>
				<div class="dh-modal-text">진단기록을 입력해주세요.</div>
			</div>
		</div>
		<div class="dh-modal-blank"></div>
	</div>
	
	
</body>
</html>