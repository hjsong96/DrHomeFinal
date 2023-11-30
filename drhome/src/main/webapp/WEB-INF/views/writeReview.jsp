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
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="./css/writeReview.css">
<script src="./js/jquery-3.7.0.min.js"></script>

<script type="text/javascript">
	$(function() {
		/* 뒤로가기 버튼 */
		$(document).on("click", ".xi-angle-left", function() {
			history.back();
		});

		let rate;
		let dno;
		let keyword;
		let keyword1;
		let keyword2;

	

		$('.xi-star-o').click(function() {
			$('.totalDoctor').show();
			rate = parseInt($(this).children('#rate').val());
			for (let i = 1; i <= rate; i++) {
				$('.star' + i).addClass('xi-star')
				$('.star' + i).removeClass('xi-star-o')
			}
			;
			for (let i = (rate + 1); i <= 5; i++) {
				$('.star' + i).addClass('xi-star-o')
				$('.star' + i).removeClass('xi-star')
			}
			;

		})

		$('.selectDoctorInfo').click(function() {
			dno = $(this).children('#doctor').val()
			$('.selectDoctorInfo').removeClass('selectedDoc')
			$('.doctor' + dno).addClass('selectedDoc')
			$('.totalTreatment').show();
		});

		$('.treatment').click(function() {
			keyword1 = $(this).val();
			$('.treatment').removeClass('selectedTreatment')
			$(this).addClass('selectedTreatment')
			$('.totalFeedback').show();

		});
		$('.feedback').click(function() {
			keyword2 = $(this).val()
			keyword = keyword1 + ',' + keyword2;
			$('.feedback').removeClass('selectedFeedback')
			$(this).addClass('selectedFeedback')

			$('.reviewContent').show()
			$('#finish').show()
		});

		$(document).on('input', '#content', function() {
			if ($(this).val().length >= 10) {
				$('#finish').addClass('submit-btn-css');
			} else {
				$('#finish').removeClass('submit-btn-css');
			}
		});

		$('#finish').click(
				function() {
					if (rate !== undefined && dno !== undefined
							&& keyword !== undefined
							&& $('#content').val().length > 10) {
						let form = $('<form></form>');
						form.attr("action", "./writeReview");
						form.attr("method", "post");
						form.append($("<input>", {
							type : 'hidden',
							name : "rate",
							value : rate
						}));
						form.append($("<input>", {
							type : 'hidden',
							name : "dno",
							value : dno
						}));
						form.append($("<input>", {
							type : 'hidden',
							name : "keyword",
							value : keyword
						}));
						form.append($("<input>", {
							type : 'hidden',
							name : "content",
							value : $('#content').val()
						}));
						form.append($("<input>", {
							type : 'hidden',
							name : "hno",
							value : $('#hno').val()
						}));
						form.append($("<input>", {
							type : 'hidden',
							name : "mno",
							value : $('#mno').val()
						}));
						form.appendTo("body");
						form.submit();
					} else {
						$("#dh-modal-alert").addClass("active").fadeIn();
						setTimeout(function() {
							$("#dh-modal-alert").fadeOut(function() {
								$(this).removeClass("active");
							});
						}, 1000);
						return false; // 버튼 클릭 이벤트를 중단합니다.
					}
				});

		function slideUpAndShrink() {
			$('.hospitalInfo').slideUp().animate({
				width : '0px',
				height : '0px'
			}, 500);
		}
	});
</script>

</head>
<body>
	<header>
		<i class="xi-angle-left xi-x"></i>
		<div class="headerTitle">리뷰 작성</div>
		<div class="blank"></div>
	</header>
	<input id="mno" type="hidden" value="${parameter.mno }">
	<input id="hno" type="hidden" value="${parameter.hno }">

	<main class="total container">

		<div class="goUp">
			<div class="hospitalImg">
				<img alt=""
					src="../img/hospital-building.png">
			</div>
			<div id="hospitalName">
				<span>${hospital.hname }</span>

				<div class="selectStars">
					<c:forEach var="i" begin="1" end="5">
						<i class="star${i } xi-star-o"> <input id="rate" type="hidden"
							value="${i }"></i>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="grayLine"></div>

		<div class="totalDoctor">
			<div class="title">진료 받으신 의사를 선택해 주세요.</div>
			<div class="selectDoctor">
				<c:forEach var="doctor" items="${doctor}">
					<div class="selectDoctorInfo doctor${doctor.dno }">
						<div class="imgBox">
							<img alt="의사사진" src="${doctor.dimg }">
						</div>
						${doctor.dname } <input type="hidden" id="doctor"
							value="${doctor.dno }">
					</div>
				</c:forEach>
			</div>
		</div>

		<div class="totalTreatment questionBox">
			<div class="title">진료 결과는 어때요?</div>
			<div class="reviewAnswerBox">
				<button class="treatment t1" value="효과 없어요">
					<img src="./img/bad.png">효과 없어요
				</button>
				<button class="treatment t2" value="보통이에요">
					<img src="./img/fine.png">보통이에요
				</button>
				<button class="treatment t3" value="효과 좋아요">
					<img src="./img/good.png">효과 좋아요
				</button>
			</div>
		</div>

		<div class="totalFeedback questionBox">
			<div class="title">선생님은 친절하셨나요?</div>
			<div class="reviewAnswerBox">
				<button class="feedback f1" value="불친절해요">
					<img src="./img/unkind.png">불친절해요
				</button>
				<button class="feedback f2" value="보통이에요">
					<img src="./img/normal.png">보통이에요
				</button>
				<button class="feedback f3" value="친절해요">
					<img src="./img/kind.png">친절해요
				</button>
			</div>
		</div>

		<div class="reviewContent questionBox">
			<div class="title">상세한 리뷰를 써주세요</div>
			<textarea id="content" placeholder="최소 10자 이상 입력해 주세요."></textarea>
		</div>
		<div style="height: 9vh"></div>
	</main>
	<footer>
		<button id="finish">완료</button>
	</footer>

	<!-- 알림창 -->
	<div id="dh-modal-alert">
		<div class="dh-modal">
			<div class="dh-modal-content">
				<div class="dh-modal-title">
					<img class="dh-alert-img"
						src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
					알림
				</div>
				<div class="dh-modal-text">10글자 이상 입력해 주세요.</div>
			</div>
		</div>
		<div class="dh-modal-blank"></div>
	</div>
</body>
</html>