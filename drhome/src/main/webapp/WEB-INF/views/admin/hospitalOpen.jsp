<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>hospitalOpen</title>
<link rel="stylesheet" href="../css/hospitalOpen.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script src="../js/jquery-3.7.0.min.js"></script>

<style type="text/css">
.dh-modal-wrapper {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	display: flex;
	justify-content: center;
	align-items: center;
	z-index: 1499;
}

.dh-modal-body {
	width: 85%;
	background-color: white;
	display: flex;
	flex-direction: column;
	padding: 20px;
	align-items: center;
	border-radius: 8px;
	margin: 25px;
	z-index: 1500;
	height: 67%;
}

.swiper {
	width: 300px;
	height: 90%;
	z-index: 2000;
}
</style>



<script type="text/javascript">
	$(document)
			.ready(
					function() {
						let rhno = 0;
						let rdno = 0;

						$(document)
								.on(
										"click",
										".chkData",
										function() {
											rhno = $(this).children().first()
													.html();

											$
													.ajax({
														url : "./detail",
														type : "get",
														data : {
															"rhno" : rhno,
														},
														dataType : "json",
														success : function(data) {

															let hos = data.hospitalDetail;
															let doc = data.doctorDetail;

															$('#rhno').text(
																	hos.rhno);
															$('#rhname').text(
																	hos.rhname);
															$('#rhopendate')
																	.text(
																			hos.rhopendate);
															$('#rhaddr').text(
																	hos.rhaddr);
															$('#rhtelnumber')
																	.text(
																			hos.rhtelnumber);
															$('#rhinfo').text(
																	hos.rhinfo);
															$('#rhopentime')
																	.text(
																			hos.rhopentime);
															$('#rhclosetime')
																	.text(
																			hos.rhclosetime);
															$('#rhnightday')
																	.text(
																			hos.rhnightday);
															$('#rhnightendtime')
																	.text(
																			hos.rhnightendtime);
															$('#rhbreaktime')
																	.text(
																			hos.rhbreaktime);
															$('#rhbreakendtime')
																	.text(
																			hos.rhbreakendtime);
															$('#rhholiday')
																	.text(
																			hos.rhholiday == 0 ? '진료 X'
																					: '진료 O');
															$(
																	'#rhholidayendtime')
																	.text(
																			hos.rhholidayendtime);
															$('#rhparking')
																	.text(
																			hos.rhparking == 0 ? '불가능'
																					: '가능');
															$("#approve1").val(
																	hos.rhno);
															$("#approve2").val(
																	doc.rdno);
															$('#rhimg').text(
																	hos.rhimg);

															for (let i = 0; i < doc.length; i++) {
																let oneDoc = doc[i];

																let item = "<div class='swiper-slide'>";
																item += "<div class= 'detailTitle' id= 'rdname'>"
																		+ oneDoc.rdname
																		+ "</div>";
																item += "<span class='xi-close xi-x'></span>";
																item += "<div class='Docs'></div>";
																item += "<div class='wrapper'><div class='tagTitle1'>소개</div><span class='rdinfo'>"
																		+ oneDoc.rdinfo
																		+ "</span></div>";
																item += "<div class='wrapper'><div class='tagTitle1'>성별</div><span class='rdgender'>"
																		+ (oneDoc.rdgender == 0 ? '남자'
																				: '여자')
																		+ "</span></div>";
																item += "<div class='wrapper'><div class='tagTitle1'>학력</div><span class='rdcareer'>"
																		+ oneDoc.rdcareer
																		+ "</span></div>";
																item += "<div class='wrapper'><div class='tagTitle1'>전문 여부</div><span class='rdspecialist'>"
																		+ (oneDoc.rdspecialist == 0 ? '일반인'
																				: '전문의')
																		+ "</span></div>";
																item += "<div class='wrapper'><div class='tagTitle1'>비대면 여부</div><span class='rdtelehealth'>"
																		+ (oneDoc.rdtelehealth == 0 ? '진료 X'
																				: '진료 O')
																		+ "</span></div>";
																item += "<div class='wrapper'><div class='tagTitle1'>진료과</div><span class='dpno'>"
																		+ oneDoc.dpkind
																		+ "</span></div>";
																item += "<div class='wrapper'><div class='tagTitle1'>등록 병원</div><span class='rhno'>"
																		+ oneDoc.rhname
																		+ "</span></div>";
																item += "<div class='wrapper'><div class='tagTitle1'>이미지</div><span class='rdimg'>"
																		+ oneDoc.rdimg
																		+ "</span></div>";
																item += "</div>";
																$(
																		'.swiper-wrapper')
																		.append(
																				item);
															}

															$(
																	'.dh-modal-wrapper')
																	.show();

														},
														error : function(error) {
															alert("잘못된 에러입니다.");
														}
													});
										});

						$("#searchHos")
								.click(
										function() {
											$("#searchDiv").html("");
											searchN = $(
													"#searchN option:selected")
													.val();
											searchV = $("input[name=searchV]")
													.val();

											$.ajax({
														url : "./searchHos",
														type : "POST",
														data : {
															"searchN" : searchN,
															"searchV" : searchV,
														},
														dataType : "json",
														success : function(data) {
															let searchHos = data.searchHos;
															let tableMake = "";

															tableMake += "<div id='searchDiv'>";
															$("#searchTable")
																	.empty();

															for (let i = 0; i < searchHos.length; i++) {
																tableMake += "<div class='chkData' id='searchTable'>";
															
																tableMake += "<div class='bold'>"
																		+ searchHos[i].rhname
																		+ "</div>";
																tableMake += "<div class='locate'>"
																		+ searchHos[i].rhaddr
																		+ "</div>";
																tableMake += "<div>"
																		+ searchHos[i].rhtelnumber;
																tableMake += "<span class='mini'>"
																		+ searchHos[i].rhopendate
																		+ "</span></div>";
																tableMake += "<div class='graySeperate'></div></div>";
															tableMake += "<div class='oneData'></div>";
															}


															$("#searchDiv")
																	.append(
																			tableMake);

														},
														error : function(error) {
															alert("잘못된 에러입니다.");
														}
													});
										});

						$(document).on("click", "#cancel", function() {
							rhno = $("#data-rhno").html();
							alert(rhno);

							if (confirm("삭제하시겠습니까?")) {
								$.ajax({
									url : "./deleteHos",
									type : "POST",
									data : {
										"rhno" : rhno,
									},
									dataType : "json",
									success : function(data) {
										location.reload();
									},
									error : function(error) {
										alert("잘못된 에러입니다.");
									}
								});
							} else {
								return false;
							}
						});

						$(document).on('click', '.xi-close', function() {
							$('.dh-modal-wrapper').hide();
						});
					});
</script>
</head>
<body>
	<header>

		<a href="/login"><i class="xi-angle-left xi-x"></i></a>
		<div class="headerTitle">병원 등록 관리</div>
		<div id="blank"></div>

	</header>
	<main>
		 

         <div class="grabSearch">
            <div class="searchTab">
                <select class="searchN" id="searchN" name="searchN">
					<option value="" selected="selected">전체</option>
					<option value="rhname">병원명</option>
					<option value="rhaddr">주소</option>
				</select> 
				<input type="text" name="searchV" id="searchV" placeholder="내용을 입력하세요.">
              	<button id="searchHos" type="button" class="xi-search xi-x"></button>
            </div>  	
         </div>

		<div id="searchDiv">
			<c:forEach items="${hospitalOpen}" var="hospitalOpen">
				<div class="chkData" id="searchTable">
					<div style="display: none">${hospitalOpen.rhno }</div>
					<div class="bold">${hospitalOpen.rhname }</div>
					<div class="locate">${hospitalOpen.rhaddr}</div>
					<div>${hospitalOpen.rhtelnumber}
						<span class="mini">${hospitalOpen.rhopendate}</span>
					</div>
					<div class="graySeperate"></div>
				</div>
				<div class="oneData"></div>
			</c:forEach>
		</div>

		<!-- 모달 -->
		<div class="dh-modal-wrapper" style="display: none">
			<div class="dh-modal-body">
				<div class="swiper">

					<div class="swiper-wrapper">

						<div class="swiper-slide">
							<div class="detailTitle" id="rhname"></div>
							<span class="xi-close xi-x" data-bs-dismiss="modal"></span>

							<div class="oneData"></div>

							<div class="wrapper">
								<div class="tagTitle">개원일</div>
								<span id="rhopendate">개원일</span>

							</div>

							<div class="wrapper">
								<div class="tagTitle">주소</div>
								<span id="rhaddr">주소</span>
							</div>

							<div class="wrapper">
								<div class="tagTitle">전화번호</div>
								<span id="rhtelnumber">전화번호</span>
							</div>

							<div class="wrapper">
								<div class="tagTitle">주차여부</div>
								<div id="rhparking">주차여부</div>
							</div>

							<div class="spaceBetween"></div>

							<div class="container" style="display: flex;">
								<div class="wrapper2">
									<div class="tag">진료시간</div>
									<div class="time">
										<span id="rhopentime">시작시간</span>&nbsp;~&nbsp;<span
											id="rhclosetime">종료시간</span>
									</div>
								</div>

								<div class="wrapper3">
									<div class="tag">점심시간</div>
									<div class="time">
										<span id="rhbreaktime">브레이크타임</span>&nbsp;~&nbsp;<span
											id="rhbreakendtime">브레이크 종료시간</span>
									</div>
								</div>
							</div>

							<div class="container" style="display: flex;">
								<div class="wrapper2">
									<div class="tag">야간진료</div>
									<div class="time">
										<span id="rhnightday">야간 진료요일</span>&nbsp;|&nbsp;<span
											id="rhnightendtime">야간 종료시간</span>
									</div>
								</div>

								<div class="wrapper3">
									<div class="tag">공휴일 진료시간</div>
									<div class="time">
										<span id="rhholiday"></span>&nbsp;|&nbsp; <span
											id="rhholidayendtime"></span>
									</div>
								</div>
							</div>

							<div class="spaceBetween"></div>

							<div>
								<div class="tag">병원 소개</div>
								<div id="rhinfo">병원 소개</div>
							</div>

						</div>


					</div>

					<div class="swiper-pagination"></div>



				</div>

				<!-- 		 <form action="/admin/newHosDoc" method="POST">
         	<input type="hidden" id="approve1" name="rhno" value="" />
         	<input type="hidden" id="approve2" name="rdno" value="" />
         	<button type="submit" class="dhBtn" id="confirm">승인</button>
	     </form>
	     <button type="button" class="dhBtn" id="cancel">삭제</button> -->
				<button id="goLogin" onclick="location.href='/admin/hospitalOpen'">승 인</button>
			</div>
		</div>














		<div style="height: 9vh"></div>
	</main>
	<footer> </footer>

	<script type="text/javascript">
		//스와이퍼 시작
		const swiper = new Swiper('.swiper', {
			// Optional parameters
			direction : 'horizontal',
			loop : true,
			pagination : {
				el : '.swiper-pagination',
			},
		});
	</script>



</body>
</html>