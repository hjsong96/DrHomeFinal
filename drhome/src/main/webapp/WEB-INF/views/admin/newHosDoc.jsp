<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>의사 등록 관리</title>
<link rel="stylesheet" href="../css/newHosDoc.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
    let hname = "";
	let dname = "";
    
	
	$("#searchHos").click(function() {
		$("#searchDiv").html("");
		searchN = $("#searchN option:selected").val();     
		searchV = $("input[name=searchV]").val();
		
		$.ajax({
			url : "./search",
			type : "POST",
			data : {
				"searchN" : searchN,
				"searchV" : searchV,
			},
			dataType: "json",
			success : function(data) {
				let search = data.search;
				let tableMake = "";
								
				$("#searchTable").empty();
						
				for (let i = 0; i < search.length; i++) {
					tableMake += "<div class='chkData' id='searchTable'>";
					tableMake += "<div style='display: none;'>"+search[i].rdno+"</div>";
					tableMake += "<div style='text-align: left; margin-left: 10px; font-weight: bold;' id='data-dname'>"+search[i].rdname+"</div>";
					tableMake += "<div style='text-align: left; margin-left: 10px; font-size: 12px;' id='data-dspecialist'>"+(search[i].rdspecialist == 0 ? '일반의' : '전문의')+"</div>";
					tableMake += "<div style='text-align: left; margin-left: 10px; font-size: 12px;'>"+search[i].rdpkind;
					tableMake += "<hr style='height: 2px; background-color: black; margin-top: 5px;'></div>";
				}
				
				$("#searchDiv").append(tableMake);
				
			},
			error : function(error) {
				alert("잘못된 에러입니다.");
			}
		});
	});

	$(document).on("click", ".chkData" ,function() {
		
		let rdno = $(this).children().first().html();
		
		$.ajax({
			url : "./doctorView",
			type : "POST",
			data : {
				"rdno" : rdno,
			},
			dataType: "json",
			success : function(data) {
				let viewDoctor = data.viewDoctor;
				let doctorMake = "";
				
				$(".modal-body").empty();

				for (let i = 0; i < viewDoctor.length; i++) {
					doctorMake += "<h1 class='modal-title' id='exampleModalLabel' id='data-rdname' style='margin-bottom: 30px;'>"+viewDoctor[i].rdname+"</h1>";
					doctorMake += "<div class='modal-body view-body'>";
					doctorMake += "<div class='title' style='text-decoration: underline; font-size: 18px;'>번호<span class='answer' style='font-weight: bold; font-size: 18px; text-align: right; margin-left: 200px;' id='data-rdno'>"+viewDoctor[i].rdno+"</span></div><br>";
					doctorMake += "<div class='title' style='font-size: 15px;'>이미지<span class='answer' style='font-weight: bold; font-size: 18px; text-align: right; margin-left: 200px;' id='data-rdimg'>"+viewDoctor[i].rdimg+"</span></div><br>";
					doctorMake += "<div class='title' style='font-size: 15px;'>소개<span class='answer' style='font-weight: bold; font-size: 18px; text-align: right; margin-left: 200px;' id='data-rdinfo'>"+viewDoctor[i].rdinfo+"</span></div><br>";
					doctorMake += "<div class='title' style='font-size: 15px;'>성별<span class='answer' style='font-weight: bold; font-size: 14px; text-align: right; margin-left: 207px;' id='data-dgender'>"+(viewDoctor[i].rdgender == 0 ? '남자' : '여자')+"</span></div><br>";
					doctorMake += "<div class='title' style='font-size: 15px;'>학력</div><span class='answer' style='font-weight: bold; font-size: 14px; text-align: left; margin-right: 200px;' id='data-dcareer'>"+viewDoctor[i].rdcareer+"</span><br><br>";
					doctorMake += "<div class='title' style='font-size: 15px;'>전문 여부<span class='answer' style='font-weight: bold; font-size: 14px; text-align: right; margin-left: 164px;' id='data-dspecialist'>"+(viewDoctor[i].rdspecialist == 0 ? '일반의' : '전문의')+"</span></div><br>";
					doctorMake += "<div class='title' style='font-size: 15px;'>비대면 진료 여부<span class='answer' style='font-weight: bold; font-size: 18px; text-align: right; margin-left: 139px;' id='data-dtelehealth'>"+(viewDoctor[i].rdtelehealth == 0 ? 'X' : 'O')+"</span></div></div>";
				}

				$(".modal-body").append(doctorMake);
				
				$("#viewModal").modal("show");
			
			},
			error : function(error) {
				alert("잘못된 에러입니다.");
			}
		});
	});
});
</script>
</head>

<header>
    <div class="xi-arrow x"></div>
    
    <i class="xi-angle-left xi-x" onclick="history.back()"></i>

	<div><h3 style="width: 110px; text-align: center; margin-left: 80px;">의사 관리</h3></div>
	
	<div class="headerTitle"><i class="xi-user xi-2x"></i></div>
</header>

<body>
	<main>
	<h1 style="text-align: center;">의사 등록 관리</h1>
	<div class="content">
		<div style="text-align: center;">
			<select id="searchN" name="searchN" style="width: 60px;">
				<option value="" selected="selected">전체</option>
				<option value="hname">병원명</option>
				<option value="dname">의사명</option>
			</select>
			<input type="text" name="searchV" maxlength="2" style="width: 70px;" />
			<button id="searchHos" type="button">검색</button>
			<div id="searchDiv">
				<c:forEach items="${newDoctor}" var="nh">
					<div class="chkData" id="searchTable">
						<div style="display: none;">${nh.rdno }</div>
						<div style="text-align: left; margin-top: 5px; margin-left: 10px; font-weight: bold;" id="data-dname">${nh.rdname }</div>
						<div style="text-align: left; margin-left: 10px; font-size: 12px;">
							<c:choose>
								<c:when test="${nh.rdspecialist eq 0}">
									일반의
								</c:when>
								<c:otherwise>
									전문의
								</c:otherwise>
							</c:choose>
						</div>
						<div style="text-align: left; margin-left: 10px; font-size: 12px;" id="data-htelnumber">${nh.rdcareer}</div>
						<div style="text-align: left; margin-left: 10px; font-size: 12px;" id="data-dpkind">${nh.rdpkind}
						
							<div style="text-align: right; margin-right: 320px; font-weight: bold;" id="data-hname">${nh.hname }</div>
						</div>
						
						<hr style="height: 2px; background-color: #00C9FF; margin-top: 5px;">
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	
	<div class="modal" id="viewModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true"
		data-bs-backdrop="static" data-keyboard="false">
		<!-- 모달 내용 -->
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="edit-header">
					<h1 class="modal-title" id="exampleModalLabel" id="data-dname"></h1>
					<span style="margin-right: -230px;" class="xi-close xi-x" data-bs-dismiss="modal"></span>
				</div>
				<div class="modal-body view-body">
					<table border="1" style="margin: 0 auto;" class="view-table">
						<tr>
							<td colspan="6" class="td2" id="data-dname"><b></b></td>
						</tr>
						<tr>
							<td class="td3">번호</td>
							<td colspan="2" id="data-hno" class="td4"></td>
							<td class="td3">사진</td>
							<td colspan="2" class="td4" id="data-dimg"></td>
						</tr>
               			<tr>
               				<td colspan="6" class="td2"><b>의사 정보</b></td>
               			</tr>
               			<tr>
               				<td class="td3">소개</td>
               				<td colspan="6" class="td4" id="data-dinfo"></td>
               			</tr>
               			<tr>
               				<td class="td3">성별</td>
               				<td class="td4" id="data-dgender"></td>
               				<td class="td3">학력</td>
               				<td class="td4" id="data-dcareer"></td>
               				<td class="td3">전문 여부</td>
               				<td class="td4" id="data-dspecialist"></td>
               			</tr>
               			<tr>
               				<td class="td3">진료과</td>
               				<td class="td4" id="data-dpkind"></td>
               				<td class="td3">증상</td>
               				<td class="td4" id="data-dpsymptom"></td>
               				<td class="td3">키워드</td>
               				<td class="td4" id="data-dpkeyword"></td>
               			</tr>
               			<tr id="tr-atregcomment1">
               				<td colspan="6" class="td2"><b>비대면 진료 여부</b></td>
               			</tr>
               			<tr id="tr-atregcomment2">
               				<td colspan="6" id="data-dtelehealth"></td>
               			</tr>
               		</table>
				</div>
				<form action="/admin/newHosDoc" method="POST">
					<input type="hidden" id="approve" name="rhno" value="" />
					<button type="submit" class="dhBtn" id="confirm">승인</button>
				</form>
					<button type="button" class="dhBtn" id="cancel">삭제</button>	
			</div>
		</div>
	</div>
	<div style="height: 9vh"></div>
	</main>
	<footer>
	
	</footer>
</body>
</html>
