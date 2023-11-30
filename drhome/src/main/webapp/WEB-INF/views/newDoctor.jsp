<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>의사 등록</title>
<link rel="stylesheet" href="../css/newDoctor.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	let man = $("#man");
	let woman = $("#woman");
	let rdgender = $("input[name='rdgender']");
	let rdspecialist = $("#rdspecialist");
    let rdtelehealth = $("#rdtelehealth");
    
    man.change(function () {
    	if ($(this).is(":checked")) {
            rdgender.val('0');
        }
    });
    
    woman.change(function () {
    	if ($(this).is(":checked")) {
            rdgender.val('1');
        }
    });
	
    rdspecialist.change(function() {
        if ($(this).is(":checked")) {
        	rdspecialist.val(1);
        } 
    });
   	
	rdtelehealth.change(function() {
        if ($(this).is(":checked")) {
        	rdtelehealth.val(1);
        }
    });
	
	let ni = document.getElementById("noInput");
	ni.addEventListener("submit", function(e){
		$("#dh-modal-alert").addClass("active").fadeIn();
		let noName = document.getElementById("rdname");
		let noInfo = document.getElementById("rdinfo");
		let noCareer = document.getElementById("rdcareer");
		let noDpno = document.getElementById("dpno");
		if (noName.value.length == "" || 
			noInfo.value.length == "" ||
			noCareer.value.length == "" || 
			noDpno.value.length == "") {
			setTimeout(function() {
		           $("#dh-modal-alert").fadeOut(function(){
		               $(this).removeClass("active");
		           });
		    }, 1000);
		e.preventDefault();
		}
	});
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


<form action="/completeHosDoc" class="GroupCenter" id="noInput" method="post">
<header>
	<a href="/login"><i class="xi-angle-left xi-x"></i></a>
	<div class="headerTitle">의사등록</div>
	<div class="blank"></div>
</header>
	<main>
		<div class="main-area">
		<span><img src="../img/DrHome_logo_side.png" style="width: 200px;" /></span>
		<div class="content">${rhnoDoctor.rhname}의
			의사 등록을 위해 <br>아래 내용을 입력해주세요.
		</div>
		<div class="Group">
			<p>성 명</p>
			<input class="vector" type="text" placeholder="성 명" id="rdname" name="rdname">
		</div>
		<div class="Group">
			<p>소 개</p>	
			<input class="vector" type="text" placeholder="소 개" id="rdinfo" name="rdinfo">
		</div>
		<div class="gender">
        	<div class="man">	
               <p>남자</p>
               <input type="radio"id="rdgender" name="rdgender" value="0" checked>
           	</div>
            <div class="woman">
               <p>여자</p>
               <input type="radio"id="rdgender" name="rdgender" value="1">
        	</div>
        </div>
		<div class="Group">
			<p>경 력</p>
			<input class="vector" type="text" placeholder="학 력" id="rdcareer" name="rdcareer">
		</div>
		<div class="selectDepartment">
			<p>진료과</p>
			<select name="dpno" class="department" id="dpno">
				<option value="">진료과를 선택해주세요.</option>
				<option value="1">소아과</option>
				<option value="2">치과</option>
				<option value="3">내과</option>
				<option value="4">이비인후과</option>
				<option value="5">피부과</option>
				<option value="6">산부인과</option>
				<option value="7">안과</option>
				<option value="8">정형외과</option>
				<option value="9">한의학과</option>
				<option value="10">비뇨기과</option>
				<option value="11">신경과</option>
				<option value="12">외과</option>
				<option value="13">정신의학과</option>
			</select>
		</div>
		<div class="Group">
			<p>전문	여부</p>
			<input type="checkbox" id="rdspecialist" name="rdspecialist" class="vector cm-toggle">
		</div>
		<input class="vector" type="hidden" placeholder="병원번호" name="rhno" id="checkRhno" value="${rhnoDoctor.rhno }">
		<input class="vector" type="hidden" placeholder="병원이름" name="rhname" value="${rhnoDoctor.rhname }">
		<div class="Group">
			<p>비대면진료 여부</p>
			<input type="checkbox" id="rdtelehealth" name="rdtelehealth" class="vector cm-toggle">
		</div>
	<div style="height: 9vh"></div>
	</div>
	</main>
	<footer>
		<button class="btn" id="btnAdd" type="submit">등록 ▷</button>
	</footer>
	</form>
</body>
</html>