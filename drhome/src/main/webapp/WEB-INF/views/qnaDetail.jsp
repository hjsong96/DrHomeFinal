<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="./js/jquery-3.7.0.min.js"></script>
<meta name="viewport" content="initial-scale=1, width=device-width, user-scalable=no"/> 
<link rel="stylesheet" href="./css/qnaDetail.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
	

<title>Insert title here</title>
</head>
<body>
	<%@ include file="loginAlert.jsp"%>
	
<header>
     <i class="xi-angle-left xi-x" onclick="location.href = '/qnaBoard'"></i>
    <div class="headerTitle">상담하기</div>
    <div class="blank"></div>
</header>

<main>

<div class="space">
	<div class="question">
	<!-- <div class="boardNum">${qnaQuestion.bno}</div> -->	
		<div class="btitle">${qnaQuestion.btitle}</div>
		<div class="mname">${qnaQuestion.mname}</div>
		<div class="dot">•</div>
		<div class="bdate">${qnaQuestion.bdate}</div>
		
			<c:if test="${qnaQuestion.mno ne mno}">
		<img id="reportButton" src='https://cdn-icons-png.flaticon.com/512/2760/2760618.png'/>
	</c:if>
	<div class="line"></div>
		
		<div class="bdetail">${qnaQuestion.bcontent}</div>
			<div class="line"></div>	
			
			<div class="kindLike">
		 <c:if test="${qnaQuestion.dpkind ne 'unknown'}">
		<div class="dpkind">#&nbsp ${qnaQuestion.dpkind}</div>
		 </c:if>
		 
		 
		   <div class="button-container right">
<c:if test="${qnaQuestion.mno eq mno}">
<form id="requestEditForm" action="/editQna" method="POST">
<input type="hidden" name="bno" id="bno"
			value="${qnaQuestion.bno}">
			<input type="hidden" name="btitle" id="btitle"
			value="${qnaQuestion.btitle}">
			<input type="hidden" name="bcontent" id="bcontent"
			value="${qnaQuestion.bcontent}">
			<input type="hidden" name="dpkind" id="dpkind"
			value="${qnaQuestion.dpkind}">
<button class="xi-pen-o xi-x" id="editButton"></button>
</form>
</c:if>

	<c:if test="${qnaQuestion.mno eq mno}">
		<form action="deleteQnaQuestion" method="post" id="deleteQnaQuestion">
			<input type="hidden" name="bno" id="bno" value="${qnaQuestion.bno}">
			<button class="xi-trash-o xi-x" id="deleteButton" class="bdelete"></button>
		</form>
	</c:if>
</div>
		 
		 
		 <c:if test="${isDibsTrue eq false}">
		<form id="callDibsForm" action="/qnaCallDibs" method="POST">
			<input type="hidden" id="callDibsInput" name="callDibsInput"
				value="false"> <input type="hidden" name="bno" id="bno"
				value="${qnaQuestion.bno}">
			<button type="submit" id="dibsButtonFalse">공감&nbsp&nbsp<i class="xi-heart-o"></i></button>
		</form>
	</c:if>

	<c:if test="${isDibsTrue eq true}">
		<form id="callDibsForm" action="/qnaCallDibs" method="POST">
			<input type="hidden" id="callDibsInput" name="callDibsInput"
				value="true"> <input type="hidden" name="bno" id="bno"
				value="${qnaQuestion.bno}">
			<button type="submit" id="dibsButtonTrue">공감&nbsp&nbsp<i class="xi-heart"></i></button>
		</form>
	</c:if>
		 </div>
		 
		 
	</div>



<!-- 신고하기 모달 -->
	<div id="reportModal" class="modal">
		<div class="modal-content">
			<span class="close" id="closeModal">&times;</span>
			<h2>신고하기</h2>
			<form action="/reportPost" method="post" id="reportForm">
				<input type="hidden" name="rpdate" id="rpdate"> <input
					type="hidden" name="bno" id="bno" value="${qnaQuestion.bno}">
				<textarea rows="5" cols="13" name="rpcontent" id="rpcontent"
				placeholder="신고사유를 작성해주세요."></textarea>
				<button type="submit" id="submitReport">신고하기</button>
			</form>

		</div>
	</div>


	




	<c:if test="${not empty dno}">
		<button type="button" id="answerToggleButton">답변 작성하기</button>
	</c:if>

	<div id="formContainer" style="display: none;">
		<form action="./writeQnaAnswer" method="post" id="qnaAnswerForm">
			<div>
	
				<textarea rows="5" cols="13" name="ccontent" id="ccontent"
					style="display: none;"></textarea>
			</div>
			<input type="hidden" name="cdate" id="cdate"> <input
				type="hidden" name="bno" id="bno" value="${qnaQuestion.bno}">
				<div class="buttonBox">
			<button type="button" id="cancelAnswerButton">취소</button>
			<button type="submit" id="submitAnswerButton">완료</button>
			</div>
		</form>
	</div>
	</div>
	<div class="graySeperate"></div>


		<c:forEach items="${qnaAnswer}" var="answer">
	<div class="answerTitle">
	<div class="space doctorAnswer">
	<img src='https://cdn-icons-png.flaticon.com/512/3304/3304567.png' />
	의료인 답변
	<div class="cdate">${answer.cdate}</div></div></div>
	
	<div class="space">
	<div class="answer">
			<input type="hidden" name="hospitalNum" value="${answer.hno}">
			<input type="hidden" name="doctorNum" value="${answer.dno}">
			
			<div class="cdetail">${answer.ccontent}</div>
			<div class="cContainer">
			
			
			<c:if test="${answer.dno eq dno}">
				<form action="deleteQnaAnswer" method="post" id="deleteQnaAnswer">
					<input type="hidden" name="cno" id="cno" value="${answer.cno}">
					<input type="hidden" name="bno" id="bno" value="${qnaQuestion.bno}">
					<button class="xi-trash-o xi-x" id="cDeleteButton"></button>
				</form>
			</c:if>
					</div>
	</div>
	</div>
	
			<c:forEach items="${doctorInfo}" var="doctor">
			   <c:if test="${doctor.dno eq answer.dno}">
	<div class="space">
			   <div class="line"></div>
	<div class="doctor" onclick="location.href='/doctorDetail/${doctor.dno}'">
				<img class="doctorImg" src="${doctor.dimg}" alt="의사 이미지" height="75">
			   <div class="doctorInfo">
				<div class="doctorName">${doctor.dname} 의사</div>
				<div class="doctorDpkind">${doctor.dpkind}</div>
				<div class="hospital">${doctor.hname}</div>
				</div>
				</div>
				</div>
				<div class="cinfoLine_bottom"></div>
				 </c:if>
			</c:forEach>
		</c:forEach>


<!-- 삭제 확인 모달 -->
	<div class="del-modal-wrapper">
		<div class="del-modal-delete">
			<div class="del-modal-header">
				<div class="del-modal-body">
					<span class="h3">삭제하시겠습니까?</span>
				</div>
			</div>
			<div class="del-modal-footer">
				<button class="del-modal-button-no">아니오</button>
				<button class="del-modal-button-yes">예</button>
			</div>
		</div>
     </div>


<!-- 로그인 알림 -->
	<div class="dh-modal-wrapper">
		<div class="dh-modal-login">
			<div class="dh-modal-header">
				<img src="https://cdn-icons-png.flaticon.com/512/7960/7960597.png">
				<div class="dh-modal-body">
					<span class="h4">로그인 후에<br> 이용하실 수 있는 서비스입니다.</span>
					<span class="h6">닥터홈 로그인 후 많은 서비스를 경험해 보세요.</span>
				</div>
			</div>
			<div class="dh-modal-footer">
				<button class="dh-modal-button dh-close-modal">취소</button>
				<button class="dh-modal-button" onclick="location.href='/login'">로그인</button>
			</div>
		</div>
     </div>

     	<!-- 댓글 알림 -->
     <div id="dh-modal-alert">
		<div class="dh-modal">
			<div class="dh-modal-content">
				<div class="dh-modal-title">
					<img class="dh-alert-img" src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
					알림
				</div>
				<div class="dh-modal-text">내용을 입력해주세요.</div>
			</div>
		</div>
		<div class="dh-modal-blank"></div>
	</div>




<div style="height: 9vh"></div>
</main>
</body>
	<script>
	$("#dh-modal-alert").hide();
	
	//로그인 모달
	$(".dh-modal-wrapper").hide();
	$(document).on("click", ".dh-close-modal", function(){
		$(".dh-modal-wrapper").hide();
	});

	//질문 삭제 모달
	$(".del-modal-wrapper").hide();

	$(document).on("click", "#deleteButton", function(event) {
	    event.preventDefault();
	    
	    $(".del-modal-wrapper").show();
	    $(".del-modal-wrapper .h3").text("삭제하시겠습니까?");
	    $(".del-modal-button-yes").on("click", function() {
	        
	        $("#deleteQnaQuestion").submit();
	    });

	    $(document).on("click", ".del-modal-button-no", function() {
	        $(".del-modal-wrapper").hide();
	    });
	});
	
	//질문 수정 모달
	$(document).on("click", "#editButton", function(event) {
	    event.preventDefault();
	    
	    $(".del-modal-wrapper").show();
	    $(".del-modal-wrapper .h3").text("수정하시겠습니까?");
	    $(".del-modal-button-yes").on("click", function() {
	        
	        $("#requestEditForm").submit();
	    });

	    $(document).on("click", ".del-modal-button-no", function() {
	        $(".del-modal-wrapper").hide();
	    });
	});
	
	//댓글 삭제 모달
	$(".del-modal-wrapper").hide();

	$(document).on("click", "#cDeleteButton", function(event) {
	    event.preventDefault();
	    
	    $(".del-modal-wrapper").show();
	    $(".del-modal-wrapper .h3").text("삭제하시겠습니까?");
	    $(".del-modal-button-yes").on("click", function() {
	        
	        $("#deleteQnaAnswer").submit();
	    });

	    $(document).on("click", ".del-modal-button-no", function() {
	        $(".del-modal-wrapper").hide();
	    });
	});
	
	
	// 이름 익명처리
	$(document).ready(function() {
	    var mnameElements = document.getElementsByClassName('mname');
	    
	    for (var i = 0; i < mnameElements.length; i++) {
	        var originalText = mnameElements[i].innerText;

	        if (originalText.length >= 2) {
	            var shortenedText = originalText.charAt(0) + 'O'.repeat(originalText.length - 1);
	            mnameElements[i].innerText = shortenedText;
	        }
	    }
	});
	
	
		//날짜, 시간 변환하기
		function updateDate(element, dateString) {
			const postTime = new Date(dateString);
			const currentTime = new Date();
			const timeDiff = currentTime - postTime;
			const minutesDiff = Math.floor(timeDiff / (1000 * 60));

			if (minutesDiff < 1) {
				element.textContent = "방금 전";
			} else if (minutesDiff < 60) {
				element.textContent = minutesDiff + "분 전";
			} else if (minutesDiff < 24 * 60) {
				const hoursDiff = Math.floor(minutesDiff / 60);
				element.textContent = hoursDiff + "시간 전";
			} else {
				const year = postTime.getFullYear();
				const month = postTime.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줌
				const day = postTime.getDate();
				const formattedDate = year + "." + month + "." + day;
				element.textContent = formattedDate;
			}
		}

		document.addEventListener("DOMContentLoaded", function() {
		
			const bdateElements = document.querySelectorAll(".bdate");
			bdateElements.forEach(function(element) {
				updateDate(element, element.textContent);
			});

			const cdateElements = document.querySelectorAll(".cdate");
			cdateElements.forEach(function(element) {
				updateDate(element, element.textContent);
			});
		});

		
		 const answerToggleButton = document.getElementById('answerToggleButton');

		    if (answerToggleButton) { 
		        answerToggleButton.addEventListener('click', function () {
		            const textarea = document.getElementById('ccontent');
		            const formContainer = document.getElementById('formContainer');

		            if (textarea && formContainer) { 
		                if (textarea.style.display === 'none') {
		                    textarea.style.display = 'block';
		                    formContainer.style.display = 'block';
		                } else {
		                    textarea.style.display = 'none';
		                    formContainer.style.display = 'none';
		                }
		            }
		        });
		    }


		// 취소 버튼 클릭 시 답변 입력창 가리기 
		document
				.getElementById('cancelAnswerButton')
				.addEventListener(
						'click',
						function() {
							document.getElementById('ccontent').style.display = 'none';
							document.getElementById('formContainer').style.display = 'none';
						});

		
		
		//본문 줄바꿈 적용
		const bcontent = `${qnaQuestion.bcontent}`; 
		const formattedContent = bcontent.replace(/\r?\n/g, '<br>');
		document.querySelector('.bdetail').innerHTML = formattedContent;
	
		  const cdetailElements = document.querySelectorAll('.cdetail');
    cdetailElements.forEach((element) => {
        const ccontent = element.innerHTML;
        const formattedContent = ccontent.replace(/\r?\n/g, '<br>');
        element.innerHTML = formattedContent;
    });
		
		
		
		//찜버튼 유효성검사
		document.getElementById("dibsButtonFalse").addEventListener("click", function (event) {
    const mno = "${mno}";

    if (mno === null || mno === undefined || mno === "") {
    	
    	event.preventDefault();

        $(".dh-modal-wrapper").show();
    }
});
		
		// 신고 버튼 클릭 시 모달 열기
		document.getElementById("reportButton").addEventListener("click", function() {
		   
			const mno = "${mno}"; 
		  
		    if (mno === null || mno === undefined || mno === "") {
		    	
		    	$(".dh-modal-wrapper").show();
		      
		        } else {
		        const reportCount = ${reportCount};
		        
		        if (reportCount !== 0) {
		        	
		        	 $("#dh-modal-alert").addClass("active").fadeIn();
		        	    $("#dh-modal-alert .dh-modal-text").text("이미 신고한 게시글입니다.");
		        	    setTimeout(function() {
		        	        $("#dh-modal-alert").fadeOut(function(){
		        	            $(this).removeClass("active");
		        	        });
		        	    }, 1000);
		            
		            
		        } else {
		            document.getElementById("reportModal").style.display = "block";
		        }
		    }
		    
		});
		



		// 신고 모달 닫기 버튼 클릭 시 모달 닫기
		closeModal.addEventListener("click", function() {
			document.getElementById("reportModal").style.display = "none";
		});

		// 신고 모달 외부 클릭 시 모달 닫기
		window.addEventListener("click", function(event) {
			if (event.target == document.getElementById("reportModal")) {
				document.getElementById("reportModal").style.display = "none";
			}
		});
		
	
			
	</script>	


</html>