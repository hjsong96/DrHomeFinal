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
<link rel="stylesheet" href="../css/chatting.css">
<script src="../js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">

</head>
<body>
	<header>
		<a href="./main"><i class="xi-angle-left xi-x"></i></a>
		<div class="headerTitle">실시간 채팅</div>
		<div id="blank"></div>
	</header>

	<main>
		<!-- 의사 선택 하는 모달 -->
		<div class="modal-wrapper">
			<div class="modal">
				<div id="modalHeader">
					<div>의사를 선택해주세요.</div>
					<div onclick="location.href='../main'">X</div>
				</div>
				<div id="doctorWrapper">
					<div style="height: 4vh;"></div>
					<c:forEach var="doctor" items="${doctor }">
						<div class="selectDoctor">
							<img alt="" src="${doctor.dimg }">
							<div class="doctorName">
								의사 ${doctor.mname }
								<div class="dpKind">${doctor.dpkind }</div>
							</div>
							<input id="doctorRoomNum" type="hidden" value="${doctor.mno }">

						</div>
					</c:forEach>
				</div>
			</div>
		</div>


		<div id='chatt'>
			<c:choose>
				<c:when test="${sessionScope.mgrade gt 4 }">
					<input type='hidden' id='mid' value="의사 ${sessionScope.mname}">
				</c:when>
				<c:otherwise>
					<input type='hidden' id='mid' value="${sessionScope.mname}">
				</c:otherwise>
			</c:choose>
			<input type='hidden' id='mgrade' value="${sessionScope.mgrade}">
			<div id='talk'></div>
		</div>
	</main>

	<footer>
		<div id='sendZone'>
			<textarea id='msg'></textarea>
			<div id='btnSend'>
				<i class="xi-send xi-2x"></i>
			</div>
		</div>
	</footer>
	<script type="text/javascript">
		$(function() {
			let ws;
			let mid = getId('mid');
			let btnSend = getId('btnSend');
			let talk = getId('talk');
			let msg = getId('msg');
			let data = {};//전송 데이터(JSON)
			let mgrade = $('#mgrade').val();

			//mgrade로 의사인지 판별하기, 
			if (mgrade == 5 || mgrade == 6) {
				let mno = "${sessionScope.mno}";
				$('.modal-wrapper').hide();
				//의사는 자기 방 mno로 들어가기
				ws = new WebSocket("ws://" + location.host + "/chatting/" + mno);

				ws.onmessage = function(msg) {
					let data = JSON.parse(msg.data);
					//누가 보냈는지 구분하기
					let className = data.mid == mid.value ? 'me' : 'other'

					//메세지 띄워주기
					let item = "<div class='" + className + "'><div class='date'>"
							+ data.date + "</div>";
					item += "<div class='message'>";
					if (data.mid != mid.value) {
						item += "<span><b>" + data.mid + "</b></span><br>";
					}
					item += "<div id='content'>" + data.msg
							+ "</div></div></div>";

					talk.innerHTML += item;

					// 스크롤바 하단으로 이동
					talk.scrollTop = talk.scrollHeight;
				}

			} else {

				//의사 선택후 채팅방 들어가기
				$(document).on('click','.selectDoctor',function() {
					//의사 mno값
					let roomNum = $(this).children('#doctorRoomNum').val();
					$.ajax({
						type : "POST",
						url : "./alertDoctor",
						//방번호 & 요청하는 사람이름 보내주기
						data : {
							"roomNum" : roomNum,
							"manme" : mid.value
						},
						success : function(response) {
							console.log(
									"Data sent successfully:",
									response);
						},
						error : function(error) {
							console.error(
									"Error sending data:",
									error);
						}
					});

					ws = new WebSocket("ws://" + location.host
							+ "/chatting/" + roomNum);

					//의사 에게 알림 보내주기
					$('.modal-wrapper').hide();

					ws.onmessage = function(msg) {
						let data = JSON.parse(msg.data);
						//누가 보냈는지 구분하기
						let className = data.mid == mid.value ? 'me'
								: 'other'

						//메세지 띄워주기
						let item = "<div class='" + className + "'><div class='date'>"
								+ data.date + "</div>";
						item += "<div class='message'>";
						if (data.mid != mid.value) {
							item += "<span><b>" + data.mid
									+ "</b></span><br>";
						}
						item += "<div id='content'>" + data.msg
								+ "</div></div></div>";

						talk.innerHTML += item;

						// 스크롤바 하단으로 이동
						talk.scrollTop = talk.scrollHeight;
					}
				});
			}

			//enter눌러도 메세지 보내기
			$('#msg').keyup(function(a) {
				if (a.keyCode === 13) {
					send();
				}
			});

			//버튼 눌러도 메세지 보내기
			$('#btnSend').click(function() {
				send();
			});

			//보내는 법
			function send() {
				if (msg.value.trim() != '') {
					data.mid = mid.value;
					data.msg = msg.value;
					data.date = new Date().toLocaleTimeString('ko-KR', {
						hour : '2-digit',
						minute : '2-digit'
					});
					let temp = JSON.stringify(data);
					ws.send(temp);
				}
				msg.value = '';
			}

			function getId(id) {
				return document.getElementById(id);
			}
		})
	</script>
</body>
</html>
