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
<link rel="stylesheet" href="./css/doctorReview.css">
<script src="./js/jquery-3.7.0.min.js"></script>

<script type="text/javascript">

	$(function(){
		
		/* 뒤로가기 버튼 */
		$(document).on("click", ".xi-angle-left", function(){
			history.back();
		});
		
		/* url 값 가져오기 */
		let urlString = location.search;
		let urlParams = new URLSearchParams(urlString);
		let mno = urlParams.get("mno");
		let dno = urlParams.get("dno");
		
		let rrate = '';
		let rkeyword = '';
		let reviewAnswer1 = ''
		let reviewAnswer2 = ''
		
		/* 별점 매기기 */
		$(document).on("click", ".star", function(){
			rrate = $(this).val();
			$(".reviewQuestion1Box").show();
			$(".star").each(function() {
				if($(this).val() <= rrate) {
					$(this).removeClass("xi-star-o").addClass("xi-star");
				} else {
					$(this).removeClass("xi-star").addClass("xi-star-o");
				}
			});
		});
		
		/* 진료 결과 답변 누르기 */
		$(document).on("click", ".reviewAnswer1", function(){
			$(this).addClass("btn-color-css");
			$(".reviewQuestion2Box").show();
			$(".reviewAnswer1").not(this).removeClass("btn-color-css");
			reviewAnswer1 = $(this).val();
		});
		
		/* 친절도 답변 누르기 */
		$(document).on("click", ".reviewAnswer2", function(){
			$(this).addClass("btn-color-css");
			$(".reviewQuestion3Box").show();
			$(".reviewWriteSubmit").show();
			$(".reviewAnswer2").not(this).removeClass("btn-color-css");
			reviewAnswer2 = $(this).val();
		});
		
		/* 입력 다 했을 경우 버튼 효과 */
		$(document).on("input", "#rcontent", function(){
		    if ($(this).val().length >= 10) {
		    	$(".reviewWriteSubmit").addClass("submit-btn-css");
		    } else {
		    	$(".reviewWriteSubmit").removeClass("submit-btn-css");
		    }
		});
		
		/* 리뷰 보내기 */
		$(document).on("click", ".reviewWriteSubmit", function(event) {
			rkeyword = reviewAnswer1 + "," + reviewAnswer2;
			let rcontent = $("#rcontent").val();
			if ( rrate != '' && rkeyword != '' && rcontent.length >= 10) {
				$.ajax({
			         url: "./doctorReview",
			         type: "post",
			         dataType: "json",
			         data: {rrate : rrate, rkeyword : rkeyword, mno : mno, dno : dno, rcontent : rcontent},
			         success: function(data){
			        	 location.href = "/doctorDetail/"+dno;
			         },
			         error: function(error){
			            alert("Error");
			         }
			      });
			} else {
				event.preventDefault();
				 $("#dh-modal-alert").addClass("active").fadeIn();
				    setTimeout(function() {
				        $("#dh-modal-alert").fadeOut(function(){
				            $(this).removeClass("active");
				        });
				    }, 1000);
			}
		});
	});
	
</script>

</head>
<body>
	<!-- header -->
	<header>
		<i class="xi-angle-left xi-x"></i>
		<div class="headerTitle">리뷰 작성</div>
		<div class="blank"></div>
	</header>

	<main class="reviewWriteContainer container">
		<div class="doctorContainer">
			<div class="doctorImg">
				<img src="${doctor.dimg}">
			</div>
			<div class="doctorInfo">
				<div class="doctorHospitalName">${doctor.hname}</div>
				<div class="doctorSection">
					<div class="doctorName">
						<c:choose>
							<c:when test="${doctor.dpno == 9}">한의사 ${doctor.dname}</c:when>
							<c:otherwise>의사 ${doctor.dname}</c:otherwise>
						</c:choose>
					</div>
					<div class="doctorDepartment">| ${doctor.dpkind}</div>
				</div>
				<div class="reviewStar">
					<button type="button" class="star xi-star-o" value="1"></button>
					<button type="button" class="star xi-star-o" value="2"></button>
					<button type="button" class="star xi-star-o" value="3"></button>
					<button type="button" class="star xi-star-o" value="4"></button>
					<button type="button" class="star xi-star-o" value="5"></button>
				</div>
			</div>
		</div>
		<div class="grayLine"></div>
		<div class="reviewContainer">
			<div class="reviewQuestionBox">
				<div class="reviewQuestion1Box questionBox">
					<div class="reviewQuestion">진료 결과는 어때요?</div>
					<div class="reviewAnswerBox">
						<button class="reviewAnswer1" type="button" name="result"
							value="효과 없어요">
							<img src="./img/bad.png">효과 없어요
						</button>
						<button class="reviewAnswer1" type="button" name="result"
							value="보통이에요">
							<img src="./img/fine.png">보통이에요
						</button>
						<button class="reviewAnswer1" type="button" name="result"
							value="효과 없어요">
							<img src="./img/good.png">효과 좋아요
						</button>
					</div>
				</div>
				<div class="reviewQuestion2Box questionBox">
					<div class="reviewQuestion">선생님은 친절하셨나요?</div>
					<div class="reviewAnswerBox">
						<button class="reviewAnswer2" type="button" name="kind"
							value="불친절해요">
							<img src="./img/unkind.png">불친절해요
						</button>
						<button class="reviewAnswer2" type="button" name="kind"
							value="보통이에요">
							<img src="./img/normal.png">보통이에요
						</button>
						<button class="reviewAnswer2" type="button" name="kind"
							value="친절해요">
							<img src="./img/kind.png">친절해요
						</button>
					</div>
				</div>
				<div class="reviewQuestion3Box">
					<div class="reviewQuestion">상세한 리뷰를 써주세요</div>
					<div class="reviewAnswer">
						<textarea placeholder="최소 10자 이상 입력해 주세요." name="content"
							id="rcontent"></textarea>
					</div>
				</div>
			</div>
		</div>
	</main>
	
	<footer>
		<button class="reviewWriteSubmit">완료</button>
	</footer>

	<!-- 알림창 -->
	<div id="dh-modal-alert">
		<div class="dh-modal">
			<div class="dh-modal-content">
				<div class="dh-modal-title">
					<img class="dh-alert-img" src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
					알림
				</div>
				<div class="dh-modal-text">10글자 이상 입력해 주세요.</div>
			</div>
		</div>
		<div class="dh-modal-blank"></div>
	</div>
	
</body>
</html>