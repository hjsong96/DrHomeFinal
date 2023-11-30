<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
/* 로그인 모달 */
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

.dh-modal-login {
	width: 100%;
	background-color: white;
	display: flex;
	flex-direction: column;
	padding: 20px;
	align-items: center;
	border-radius: 8px;
	margin: 25px;
	z-index: 1500;
}

.dh-modal-header {
	display: flex;
	height: 70px;
	align-items: center;
}

.dh-modal-header img {
	width: 60px;
	margin-right: 10px;
}

.dh-modal-body {
	display: flex;
	flex-direction: column;
	justify-content: space-evenly;
}

.h4 {
	font-size: 14px;
	font-weight: 700;
	margin-top: 3px;
}

.h6 {
	font-size: 11px;
	font-weight: 400;
	margin-top: 3px;
	color: #5c5c5c;
}

.dh-modal-footer {
	display: flex;
	width: 100%;
	justify-content: center;
}

.dh-modal-button {
	width: 50%;
	height: 30px;
	margin: 15px 0 0 15px;
	background-color: #00C9FF;
	color: white;
	border: 1px solid #00C9FF;
	border-radius: 10px;
}

.dh-close-modal {
	color: #505050;
	border: 1px solid #d9d9d9;
	background-color: #F5F5F5;
	margin: 15px 0 0 0;
}
</style>

<script type="text/javascript">
	$(document).on("click", ".dh-close-modal", function() {
		$('.dh-modal-wrapper').hide();
	});
</script>
</head>

<body>
	<!-- 로그인알림차 모달 -->
	<div class="dh-modal-wrapper" style="display: none">
		<div class="dh-modal-login">
			<div class="dh-modal-header">
				<img src="https://cdn-icons-png.flaticon.com/512/7960/7960597.png">
				<div class="dh-modal-body">
					<span class="h4">로그인 후에<br> 이용하실 수 있는 서비스입니다.
					</span> <span class="h6">닥터홈 로그인 후 많은 서비스를 경험해 보세요.</span>
				</div>
			</div>
			<div class="dh-modal-footer">
				<button class="dh-modal-button dh-close-modal">취소</button>
				<button class="dh-modal-button" onclick="location.href='/login'">로그인</button>
			</div>
		</div>
	</div>

</body>
</html>