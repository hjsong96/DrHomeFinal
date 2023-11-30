<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyInfo</title>
<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link href="/css/modal.css" rel="stylesheet" />
<link href="/css/myInfo.css" rel="stylesheet" />
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link href="/css/aram.css" rel="stylesheet" />
<script src="/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				/* 뒤로가기 버튼 */
				$(document).on("click", ".xi-angle-left", function(){
					history.back();
				});
				$('.health-area i').on(
						'click',
						function() {
							$('input').toggleClass('active');
							if ($('input').hasClass('active')) {
								$(this).attr('class', "xi-eye xi-2x").prev(
										'input').attr('type', "text");
							} else {
								$(this).attr('class', "xi-eye-off xi-2x").prev(
										'input').attr('type', 'password');
							}
						});
			});

	$(function() {
		let mphonenumber = "${myInfo.mphonenumber}";

		let phoneNumberParts = mphonenumber.split('-');

		$('#firstNumber').val(phoneNumberParts[0]);
		$('#MiddleNumber').val(phoneNumberParts[1]);
		$('#lastNumber').val(phoneNumberParts[2]);

		$("#changePWBtn").click(function() {

			$("#pwInfo").text("");

			let mpw = $("#mpw").val();

			if (mpw == "") {
				$("#mpw").focus();
				$("#pwInfo").text("비밀번호를 입력해주세요.");
				$("#pwInfo").css("color", "red");
				return false;
			}

			if (mpw.length < 4) {
				$("#mpw").focus();
				$("#pwInfo").text("비밀번호를 4글자 이상 입력해주세요.");
				$("#pwInfo").css("color", "red");
				return false;
			} else {
				// 폼 엘리먼트 생성
				let form = document.createElement('form');
				form.action = "../changePW/${sessionScope.mno}"; // 폼이 전송될 URL
				form.method = "post"; // 전송 방식

				// 폼에 추가할 input 엘리먼트 생성
				let passwordInput = document.createElement('input');
				passwordInput.type = "password"; // 입력 필드 타입
				passwordInput.name = "mpw"; // 폼 데이터 이름
				passwordInput.value = $("#mpw").val(); // 입력된 비밀번호 값

				// 생성한 input 엘리먼트를 폼에 추가
				form.appendChild(passwordInput);

				// 생성한 폼을 문서에 추가
				document.body.appendChild(form);

				$("#dh-modal-alert").addClass("active").fadeIn();
				setTimeout(function() {
					$("#dh-modal-alert").fadeOut(function() {
						$(this).removeClass("active");
						// 폼 전송
						form.submit();
					});
				}, 1000); //알람창

				/* $("#changePW").submit(); */
			}
		});//changePWBtn 끝

		$("#changeHomeAddr").click(function() {

			$("#homeAddrInfo").text("");

			let mhomeaddr = $("#mhomeaddr").val();

			if (mhomeaddr === "") {
				$("#mhomeaddr").focus();
				$("#homeAddrInfo").text("주소를 입력하세요.");
				$("#homeAddrInfo").css("color", "red");
				return false;
			} else {
				let form = document.createElement('form');
				form.action = "../changeHomeAddr/${sessionScope.mno}";
				form.method = "post";

				let input1 = document.createElement('input');
				input1.type = "text";
				input1.name = "mhomeaddr";
				input1.value = $("#mhomeaddr").val();

				let input2 = document.createElement('input');
				input2.type = "text";
				input2.name = "mhomeaddr2";
				input2.value = $("#mhomeaddr2").val();

				form.appendChild(input1);
				form.appendChild(input2);

				document.body.appendChild(form);

				$("#dh-modal-alert2").addClass("active").fadeIn();
				setTimeout(function() {
					$("#dh-modal-alert").fadeOut(function() {
						$(this).removeClass("active");
						// 폼 전송
						form.submit();
					});
				}, 1000); //알람창

			}
		});//changeHomeAddr 끝

		$("#changeCompanyAddr").click(function() {

			$("#companyAddrInfo").text("");

			let mcompanyaddr = $("#mcompanyaddr").val();

			if (mcompanyaddr === "") {
				$("#mcompanyaddr").focus();
				$("#companyAddrInfo").text("주소를 입력하세요.");
				$("#companyAddrInfo").css("color", "red");
				return false;
			} else {
				let form = document.createElement('form');
				form.action = "../changeCompanyAddr/${sessionScope.mno}";
				form.method = "post";

				let input1 = document.createElement('input');
				input1.type = "text";
				input1.name = "mcompanyaddr";
				input1.value = $("#mcompanyaddr").val();

				let input2 = document.createElement('input');
				input2.type = "text";
				input2.name = "mcompanyaddr2";
				input2.value = $("#mcompanyaddr2").val();

				form.appendChild(input1);
				form.appendChild(input2);

				document.body.appendChild(form);

				$("#dh-modal-alert3").addClass("active").fadeIn();
				setTimeout(function() {
					$("#dh-modal-alert").fadeOut(function() {
						$(this).removeClass("active");
						// 폼 전송
						form.submit();
					});
				}, 1000); //알람창

			}
		});//changeCompanyAddr 끝

		$("#changePhoneNumber")
				.click(
						function() {

							$("#phoneInfo").text("");

							let firstNumber = $("#firstNumber").val();
							let MiddleNumber = $("#MiddleNumber").val();
							let lastNumber = $("#lastNumber").val();
							let phoneNumber = $("#firstNumber").val()
									+ $("#MiddleNumber").val()
									+ $("#lastNumber").val();
							let notNum = /[^0-9]/g; //숫자아닌지 확인

							if (phoneNumber == "") {
								$("#phoneInfo").text("전화번호를 입력해주세요.");
								$("#phoneInfo").css("color", "red");
								return false;
							}

							if (notNum.test(phoneNumber)
									|| phoneNumber.length !== 11) {
								$("#phoneInfo").text("올바른 전화번호를 입력해주세요.");
								$("#phoneInfo").css("color", "red");
								return false;
							}

							let form = document.createElement('form');
							form.action = "../changePhoneNumber/${sessionScope.mno}";
							form.method = "post";

							let input1 = document.createElement('input');
							input1.type = "text";
							input1.name = "firstNumber";
							input1.value = firstNumber;

							let input2 = document.createElement('input');
							input2.type = "text";
							input2.name = "MiddleNumber";
							input2.value = MiddleNumber;

							let input3 = document.createElement('input');
							input3.type = "text";
							input3.name = "lastNumber";
							input3.value = lastNumber;

							form.appendChild(input1);
							form.appendChild(input2);
							form.appendChild(input3);

							document.body.appendChild(form);

							$("#dh-modal-alert4").addClass("active").fadeIn();
							setTimeout(function() {
								$("#dh-modal-alert").fadeOut(function() {
									$(this).removeClass("active");
									// 폼 전송
									form.submit();
								});
							}, 1000); //알람창

						});//changePhoneNumber 끝

		$("#changeMyInfoBtn")
				.click(
						function() {

							$("#phoneInfo").text("");

							let firstNumber = $("#firstNumber").val();
							let MiddleNumber = $("#MiddleNumber").val();
							let lastNumber = $("#lastNumber").val();
							let phoneNumber = $("#firstNumber").val()
									+ $("#MiddleNumber").val()
									+ $("#lastNumber").val();
							let notNum = /[^0-9]/g; //숫자아닌지 확인

							let form = document.createElement('form');
							form.action = "../changeAllMyInfo/${sessionScope.mno}";
							form.method = "post";

							let passwordInput = document.createElement('input');
							passwordInput.type = "password";
							passwordInput.name = "mpw";
							passwordInput.value = $("#mpw").val();

							let input1 = document.createElement('input');
							input1.type = "text";
							input1.name = "mhomeaddr";
							input1.value = $("#mhomeaddr").val();

							let input2 = document.createElement('input');
							input2.type = "text";
							input2.name = "mhomeaddr2";
							input2.value = $("#mhomeaddr2").val();

							let input3 = document.createElement('input');
							input3.type = "text";
							input3.name = "mcompanyaddr";
							input3.value = $("#mcompanyaddr").val();

							let input4 = document.createElement('input');
							input4.type = "text";
							input4.name = "mcompanyaddr2";
							input4.value = $("#mcompanyaddr2").val();

							let input5 = document.createElement('input');
							input5.type = "text";
							input5.name = "firstNumber";
							input5.value = $("#firstNumber").val();

							let input6 = document.createElement('input');
							input6.type = "text";
							input6.name = "MiddleNumber";
							input6.value = $("#MiddleNumber").val();

							let input7 = document.createElement('input');
							input7.type = "text";
							input7.name = "lastNumber";
							input7.value = $("#lastNumber").val();

							form.appendChild(passwordInput);
							form.appendChild(input1);
							form.appendChild(input2);
							form.appendChild(input3);
							form.appendChild(input4);
							form.appendChild(input5);
							form.appendChild(input6);
							form.appendChild(input7);

							document.body.appendChild(form);

							$("#dh-modal-alert5").addClass("active").fadeIn();
							setTimeout(function() {
								$("#dh-modal-alert").fadeOut(function() {
									$(this).removeClass("active");
									// 폼 전송
									form.submit();
								});
							}, 1000); //알람창
						});

	});

	function searchAddr() {
		$("#modal").modal("show");
	}

	function searchComAddr() {
		$("#modal2").modal("show");
	}
</script>

<!-- <script type="text/javascript">
window.onload = function(){
    document.getElementById("mhomeaddr").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("mhomeaddr").value = data.address; // 주소 넣기
                document.querySelector("input[name=mhomeaddr2]").focus(); //상세입력 포커싱
            }
        }).open();
    });
    
    document.getElementById("mcompanyaddr").addEventListener("click", function(){
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById("mcompanyaddr").value = data.address;
                document.querySelector("input[name=mcompanyaddr2]").focus();
            }
        }).open();
    });
}

new daum.Postcode({
    oncomplete: function(data) {
        console.log("Selected address:", data.address); // 주소가 올바르게 선택되었는지 확인
        document.getElementById("mhomeaddr").value = data.address; // 주소 넣기
        console.log("mhomeaddr value:", document.getElementById("mhomeaddr").value); // 값을 올바르게 설정했는지 확인
        document.querySelector("input[name=mhomeaddr2]").focus(); // 상세입력 포커싱
    }
});
</script> -->


</head>
<body>
	<header>
		<i class="xi-angle-left xi-x"></i>
		<div class="headerTitle">내 정보</div>
		<div class="blank"></div>
	</header>

	<main>
		<div class="main-area">
			<p class="top-title">🙆‍♂️ 내 정보 확인하기</p>
			<div class="health-area">
				<p class="p-title">이름</p>
				<p class="p-detail">${myInfo.mname}</p>
			</div>
			<div class="health-area">
				<p class="p-title">닉네임</p>
				<p class="p-detail">${myInfo.mnickname}</p>
			</div>
			<div class="health-area">
				<p class="p-title">아이디</p>
				<p class="p-detail">${myInfo.mid}</p>
			</div>
			<div class="health-area">
				<div class="password-area">
					<%--  <form action="../changeAllMyInfo/${sessionScope.mno}" method="post"> --%>
					<%-- <form action="../changePW/${sessionScope.mno}" method="post" id="changePW"> --%>
					<div class="title-button">
						<span class="p-title">패스워드</span>
						<button class="button" id="changePWBtn">비밀번호 변경</button>
					</div>
					<input type="password" id="mpw" name="mpw"
						placeholder="비밀번호를 입력해주세요." maxlength="8" value="${myInfo.mpw }">
					<i class="xi-eye-off xi-2x"></i>
					<p id="pwInfo" class="info"></p>
					<!-- </form> -->
				</div>
			</div>
			<div class="health-area">
				<p class="p-title">이메일</p>
				<p class="p-detail">${myInfo.memail}</p>
			</div>
			<div class="health-area">
				<%-- <form action="../changeHomeAddr/${sessionScope.mno}" method="post"> --%>
				<div class="title-button">
					<span class="p-title">집주소</span>
					<button class="button" id="changeHomeAddr">집주소 변경</button>
				</div>
				<input type="text" id="mhomeaddr" name="mhomeaddr"
					placeholder="집주소를 입력해주세요." value="${myInfo.mhomeaddr}"
					onclick="searchAddr()"> <input type="text" id="mhomeaddr2"
					name="mhomeaddr2" placeholder="상세주소를 입력해주세요."
					value="${myInfo.mhomeaddr2}"> <span id="homeAddrInfo"></span>
				<!-- </form> -->
			</div>
			<div class="health-area">
				<%-- <form action="../changeCompanyAddr/${sessionScope.mno}" method="post"> --%>
				<div class="title-button">
					<span class="p-title">회사주소(선택)</span>
					<button class="button" id="changeCompanyAddr">회사주소 변경</button>
				</div>
				<input type="text" id="mcompanyaddr" name="mcompanyaddr"
					placeholder="회사 주소를 입력해주세요." value="${myInfo.mcompanyaddr}"
					onclick="searchComAddr()"> <input type="text"
					id="mcompanyaddr2" name="mcompanyaddr2" placeholder="상세주소를 입력해주세요."
					value="${myInfo.mcompanyaddr2}"> <span id="companyAddrInfo"></span>
				<!-- </form> -->
			</div>
			<div class="health-area">
				<p class="p-title">생년월일</p>
				<p class="p-detail">${myInfo.mbirth }</p>
			</div>
			<div class="health-area">
				<%-- <form action="../changePhoneNumber/${sessionScope.mno}" method="post"> --%>
				<div class="title-button">
					<span class="p-title">전화번호</span>
					<button id="changePhoneNumber">전화번호 변경</button>
				</div>
				<input type="text" id="firstNumber" name="firstNumber" maxlength="3"
					placeholder="010"> - <input type="text" id="MiddleNumber"
					name="MiddleNumber" maxlength="4" placeholder="xxxx"> - <input
					type="text" id="lastNumber" name="lastNumber" maxlength="4"
					placeholder="xxxx"> <span id="phoneInfo"></span>
				<!-- </form> -->
			</div>
		</div>
	</main>

	<!-- 비밀번호 알람모달 -->

	<div id="dh-modal-alert">
		<div class="dh-modal">
			<div class="dh-modal-content">
				<div class="dh-modal-title">
					<img class="dh-alert-img"
						src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
					알림
				</div>
				<div class="dh-modal-text">비밀번호가 변경되었습니다.</div>
			</div>
		</div>
		<div class="dh-modal-blank"></div>
	</div>

	<!-- 집주소 알람모달 -->

	<div id="dh-modal-alert2">
		<div class="dh-modal">
			<div class="dh-modal-content">
				<div class="dh-modal-title">
					<img class="dh-alert-img"
						src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
					알림
				</div>
				<div class="dh-modal-text">집주소가 변경되었습니다.</div>
			</div>
		</div>
		<div class="dh-modal-blank"></div>
	</div>

	<!-- 회사주소 알람모달 -->

	<div id="dh-modal-alert3">
		<div class="dh-modal">
			<div class="dh-modal-content">
				<div class="dh-modal-title">
					<img class="dh-alert-img"
						src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
					알림
				</div>
				<div class="dh-modal-text">회사주소가 변경되었습니다.</div>
			</div>
		</div>
		<div class="dh-modal-blank"></div>
	</div>

	<!-- 전화번호 알람모달 -->

	<div id="dh-modal-alert4">
		<div class="dh-modal">
			<div class="dh-modal-content">
				<div class="dh-modal-title">
					<img class="dh-alert-img"
						src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
					알림
				</div>
				<div class="dh-modal-text">전화번호가 변경되었습니다.</div>
			</div>
		</div>
		<div class="dh-modal-blank"></div>
	</div>

	<!-- 전체변경 알람모달 -->

	<div id="dh-modal-alert5">
		<div class="dh-modal">
			<div class="dh-modal-content">
				<div class="dh-modal-title">
					<img class="dh-alert-img"
						src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
					알림
				</div>
				<div class="dh-modal-text">내 정보가 변경되었습니다.</div>
			</div>
		</div>
		<div class="dh-modal-blank"></div>
	</div>

	<div style="height: 9vh"></div>


	<footer>
		<button id="changeMyInfoBtn">변경하기</button>
	</footer>
	<!-- </form> -->

	<!-- 모달1 start -->
	<div class="modal" id="modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true"
		data-bs-backdrop="static">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="header">
					<h5 class="title" id="exampleModalLabel"></h5>
				</div>
				<div class="modal-body">
					<!-- 내용 start -->
					<div class="card-body">
						<h5 class="card-title">우편번호 찾기</h5>
					</div>
					<!-- 내용 end -->
				</div>
				<div>
					<input type="text" id="sample2_postcode" placeholder="우편번호">
					<input class="input-button" onclick="sample2_execDaumPostcode()"
						value="주소 찾기"><br> <input type="text"
						id="sample2_address" placeholder="주소"><br> <input
						type="text" id="sample2_detailAddress" placeholder="상세주소">
					<input type="text" id="sample2_extraAddress" placeholder="참고항목">
				</div>
				<button type="button" class="btn btn-info" data-bs-dismiss="modal"
					aria-label="Close">X 닫기</button>
				<div id="layer"
					style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
					<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
						id="btnCloseLayer"
						style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
						onclick="closeDaumPostcode()" alt="닫기 버튼">
				</div>
				<!-- <button type="button" class="btn btn-info" data-bs-dismiss="modal" aria-label="Close">X 닫기</button> -->
			</div>
		</div>
	</div>
	<!-- 모달1 end -->

	<!-- 모달2 start -->
	<div class="modal" id="modal2" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true"
		data-bs-backdrop="static">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="header">
					<h5 class="title" id="exampleModalLabel"></h5>
				</div>
				<div class="modal-body">
					<!-- 내용 start -->
					<div class="card-body">
						<h5 class="card-title">우편번호 찾기</h5>
					</div>
					<!-- 내용 end -->
				</div>
				<div>
					<input type="text" id="sample2_postcode2" placeholder="우편번호">
					<input class="input-button" type="button"
						onclick="sample2_execDaumPostcode2()" value="주소 찾기"><br>
					<input type="text" id="sample2_address2" placeholder="주소"><br>
					<input type="text" id="sample2_detailAddress2" placeholder="상세주소">
					<input type="text" id="sample2_extraAddress2" placeholder="참고항목">
				</div>
				<button type="button" class="btn btn-info" data-bs-dismiss="modal"
					aria-label="Close">X 닫기</button>
				<div id="layer2"
					style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
					<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
						id="btnCloseLayer"
						style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
						onclick="closeDaumPostcode2()" alt="닫기 버튼">
				</div>
				<!-- <button type="button" class="btn btn-info" data-bs-dismiss="modal" aria-label="Close">X 닫기</button> -->
			</div>
		</div>
	</div>
	<!-- 모달2 end -->

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>

</body>
</html>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 우편번호 찾기 화면을 넣을 element
	var element_layer2 = document.getElementById('layer2');

	function closeDaumPostcode2() {
		// iframe을 넣은 element를 안보이게 한다.
		element_layer2.style.display = 'none';
	}

	function sample2_execDaumPostcode2() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr2 = ''; // 주소 변수
						var extraAddr2 = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr2 = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr2 = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr2 += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr2 += (extraAddr2 !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr2 !== '') {
								extraAddr2 = ' (' + extraAddr2 + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("sample2_extraAddress2").value = extraAddr2;
							document.getElementById("mcompanyaddr2").value = extraAddr2;

						} else {
							document.getElementById("sample2_extraAddress2").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample2_postcode2').value = data.zonecode;
						document.getElementById("sample2_address2").value = addr2;
						document.getElementById("mcompanyaddr").value = addr2;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("mcompanyaddr2").focus();

						// iframe을 넣은 element를 안보이게 한다.
						// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
						element_layer2.style.display = 'none';
					},
					width : '100%',
					height : '100%',
					maxSuggestItems : 5
				}).embed(element_layer2);

		// iframe을 넣은 element를 보이게 한다.
		element_layer2.style.display = 'block';

		// iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
		initLayerPosition2();
	}

	// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
	// resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
	// 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
	function initLayerPosition2() {
		var width = 300; //우편번호서비스가 들어갈 element의 width
		var height = 400; //우편번호서비스가 들어갈 element의 height
		var borderWidth = 5; //샘플에서 사용하는 border의 두께

		// 위에서 선언한 값들을 실제 element에 넣는다.
		element_layer2.style.width = width + 'px';
		element_layer2.style.height = height + 'px';
		element_layer2.style.border = borderWidth + 'px solid';
		// 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
		element_layer2.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth)
				+ 'px';
		element_layer2.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth)
				+ 'px';
	}

	// 우편번호 찾기 화면을 넣을 element
	var element_layer = document.getElementById('layer');

	function closeDaumPostcode() {
		// iframe을 넣은 element를 안보이게 한다.
		element_layer.style.display = 'none';
	}

	function sample2_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("sample2_extraAddress").value = extraAddr;
							document.getElementById("mhomeaddr2").value = extraAddr;

						} else {
							document.getElementById("sample2_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample2_postcode').value = data.zonecode;
						document.getElementById("sample2_address").value = addr;
						document.getElementById("mhomeaddr").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("mhomeaddr2").focus();

						// iframe을 넣은 element를 안보이게 한다.
						// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
						element_layer.style.display = 'none';
					},
					width : '100%',
					height : '100%',
					maxSuggestItems : 5
				}).embed(element_layer);

		// iframe을 넣은 element를 보이게 한다.
		element_layer.style.display = 'block';

		// iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
		initLayerPosition();
	}

	// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
	// resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
	// 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
	function initLayerPosition() {
		var width = 300; //우편번호서비스가 들어갈 element의 width
		var height = 400; //우편번호서비스가 들어갈 element의 height
		var borderWidth = 5; //샘플에서 사용하는 border의 두께

		// 위에서 선언한 값들을 실제 element에 넣는다.
		element_layer.style.width = width + 'px';
		element_layer.style.height = height + 'px';
		element_layer.style.border = borderWidth + 'px solid';
		// 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
		element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth)
				+ 'px';
		element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth)
				+ 'px';
	}
</script>
