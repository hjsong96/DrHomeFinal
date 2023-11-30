<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1, width=device-width, user-scalable=no"/> 
<script src="./js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="./css/freeDetail.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>
</head>
<body>

	<header>
		 <i class="xi-angle-left xi-x" onclick="location.href = '/qnaBoard'"></i>
		<div class="headerTitle">자유게시판</div>
		<div class="blank"></div>
	</header>

	<main>

		<!-- <button class="toFreeBoard" onclick="location.href='freeBoard'">목록으로</button> -->
<div class="space">
		<div class="freePosting">
			<!-- <div class="boardNum">글번호 ${freePosting.bno}</div> -->

			<div class="btitle">${freePosting.btitle}</div>

			<div class="bnickname">${freePosting.mnickname}</div>
			<div class="dot">•</div>
			<div class="bdate">${freePosting.bdate}</div>
			
			<c:if test="${freePosting.mno ne mno}">
		<img id="reportButton" src='https://cdn-icons-png.flaticon.com/512/2760/2760618.png'/>
	</c:if>
	<div class="line"></div>
	
			<div class="bdetail">${freePosting.bcontent}</div>
		</div>

<!-- 공감버튼 -->
<div class="sideContainer">
		<c:if test="${isDibsTrue eq false}">
			<form id="callDibsForm" action="/freePostLike" method="POST">
				<input type="hidden" id="likePostInput" name="likePostInput"
					value="false"> <input type="hidden" name="bno" id="bno"
					value="${freePosting.bno}">
				<button type="submit" id="dibsButtonFalse">♡ ${freePosting.bcalldibsCount}</button>
			</form>
		</c:if>

		<c:if test="${isDibsTrue eq true}">
			<form id="callDibsForm" action="/freePostLike" method="POST">
				<input type="hidden" id="likePostInput" name="likePostInput"
					value="true"> <input type="hidden" name="bno" id="bno"
					value="${freePosting.bno}">
				<button type="submit" id="dibsButtonTrue">♥ ${freePosting.bcalldibsCount}</button>
			</form>
		</c:if>


  <div class="button-container right">
<!-- 글 수정 버튼 -->
		<c:if test="${freePosting.mno eq mno}">
			<form id="requestEditForm" action="/editBoard" method="POST">
				<input type="hidden" name="bno" id="bno" value="${freePosting.bno}">
				<input type="hidden" name="btitle" id="btitle"
					value="${freePosting.btitle}"> <input type="hidden"
					name="bcontent" id="bcontent" value="${freePosting.bcontent}">
				<button class="xi-pen-o xi-x" id="editButton"></button>
			</form>
		</c:if>
		

<!-- 글 삭제 버튼 -->
	<c:if test="${freePosting.mno eq mno}">
		<form action="/deleteBoard" method="post" id="deleteFreeForm">
			<input type="hidden" name="bno" id="bno" value="${freePosting.bno}">
			<button class="xi-trash-o xi-x" id="deleteButton" class="bdelete"></button>
		</form>
	</c:if>
</div>
</div>

	
	<!-- 신고하기 모달 -->

</div>


	<div class="graySeperate"></div>

		<!-- 댓글 -->
		<div class="comment">
		<div class="commentTitle"><div class="space">댓글</div></div>
		<div class="space">
			<c:forEach items="${freeComment}" var="comment">
					<div class="cnickname">${comment.mnickname}</div>
					<div class="cdate">${comment.cdate}</div>
					<div class="cdetail">${comment.ccontent}</div>

					<div class="rightSide">
						<c:if test="${comment.mno ne mno}">
							<button type="submit"
								id="commentReportButton" data-bno="${freePosting.bno}"
								data-cno="${comment.cno}">
								<img src='https://cdn-icons-png.flaticon.com/512/2760/2760618.png' style="width: 15px;"/>
								</button>
						</c:if>
						
						

					<!-- 댓글 삭제하기 -->
						<c:if test="${comment.mno eq mno}">
							<form action="/deleteFreeComment" method="post"
								id="deleteFreeComment">
								<input type="hidden" name="cno" id="cno" value="${comment.cno}">
								<input type="hidden" name="bno" id="bno"
									value="${freePosting.bno}">
								<button class="xi-trash-o xi-x" id="cdelete"></button>
							</form>
						</c:if>
					</div>
					<div class="line"></div>


		<!-- 댓글 신고하기 -->
				<div id="commentReportModal" class="modal">
					<div class="modal-content">
						<span class="close" id="closeModal2">&times;</span>
						<h2>신고하기</h2>
						신고 사유
						<form action="/reportFreeComment" method="post"
							id="commentReportForm">
							<input type="hidden" name="crpdate" id="crpdate"> <input
								type="hidden" name="crpno" id="crpno" value="${comment.cno}">
							<input type="hidden" name="bno" id="bno"
								value="${freePosting.bno}">
							<textarea rows="5" cols="13" name="rpcontent" id="rpcontent"></textarea>
							<button id="submitReport" type="submit">신고하기</button>
						</form>
					</div>
				</div>
			</c:forEach>
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

	<footer>

		<form action="/writeFreeComment" method="post" id="freeCommentForm">
			<div id="formContainer">
				<textarea name="ccontent" id="ccontent"></textarea>
				<input type="hidden" name="cdate" id="cdate"> <input
					type="hidden" name="bno" id="bno" value="${freePosting.bno}">
				<button type="submit" id="submitCommentButton"
					class="commentButton"><img src='https://cdn-icons-png.flaticon.com/512/10024/10024072.png' style=" width: 32px; transform: scaleX(-1);"/></button>
			</div>
		</form>


	</footer>


	<script>
	
	//로그인 모달
	$(".dh-modal-wrapper").hide();
	$(document).on("click", ".dh-close-modal", function(){
		$(".dh-modal-wrapper").hide();
	});
	
	//댓글 삭제 모달
	$(".del-modal-wrapper").hide();

	$(document).on("click", "#cdelete", function(event) {
	    event.preventDefault();
	    
	    $(".del-modal-wrapper").show();
	    $(".del-modal-wrapper .h3").text("삭제하시겠습니까?");
	    $(".del-modal-button-yes").on("click", function() {
	        
	        $("#deleteFreeComment").submit();
	    });

	    $(document).on("click", ".del-modal-button-no", function() {
	        $(".del-modal-wrapper").hide();
	    });
	});
	
	//게시글 삭제 모달
	$(document).on("click", "#deleteButton", function(event) {
	    event.preventDefault();
	    
	    $(".del-modal-wrapper").show();
	    $(".del-modal-wrapper .h3").text("삭제하시겠습니까?");
	    $(".del-modal-button-yes").on("click", function() {
	        
	        $("#deleteFreeForm").submit();
	    });

	    $(document).on("click", ".del-modal-button-no", function() {
	        $(".del-modal-wrapper").hide();
	    });
	});
	
	//게시글 수정 모달
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

		
		//날짜, 시간 데이터 형식 적용
		document.addEventListener("DOMContentLoaded", function() {
			// bdate, cdate에 적용
			const bdateElements = document.querySelectorAll(".bdate");
			bdateElements.forEach(function(element) {
				updateDate(element, element.textContent);
			});

			const cdateElements = document.querySelectorAll(".cdate");
			cdateElements.forEach(function(element) {
				updateDate(element, element.textContent);
			});
		});

		
		//댓글 작성
		document.getElementById('freeCommentForm').addEventListener(
				'submit',
				function(event) {

					var content = document.getElementById('ccontent').value
							.trim();

					if (content.trim() === '') {
						
						//알림
					    $("#dh-modal-alert").addClass("active").fadeIn();
					    setTimeout(function() {
					        $("#dh-modal-alert").fadeOut(function(){
					            $(this).removeClass("active");
					        });
					    }, 1000);
					

						event.preventDefault(); // 폼 전송 막기
						return false;
					}

					
					this.submit();
				});

		
		//본문 줄바꿈 적용
		const bcontent = `${freePosting.bcontent}`; 
		const formattedContent = bcontent.replace(/\r?\n/g, '<br>');
		document.querySelector('.bdetail').innerHTML = formattedContent;
	
		 const cdetailElements = document.querySelectorAll('.cdetail');
		   cdetailElements.forEach((element) => {
		      const ccontent = element.innerHTML;
		        const formattedContent = ccontent.replace(/\r?\n/g, '<br>');
		      element.innerHTML = formattedContent;
		    });


			// 버튼 클릭 시 모달 열기
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

			
			

			$(document)
					.on(
							"click",
							"#commentReportButton",
							function() {
								
								const mno = "${mno}"; 
								const bno = $(this).data("bno");
								const cno = $(this).data("cno");


								 if (mno === null || mno === undefined || mno === "") {
									 $(".dh-modal-wrapper").show();
								 } else {
								
								
								$.ajax({
											url : "/commentReportCount",
											type : "post",
											data : {
												bno : bno,
												cno : cno
											},
											success : function(result) {
												const data = JSON.parse(result);

												if (data.result !== 0) {
													
													 $("#dh-modal-alert").addClass("active").fadeIn();
													    $("#dh-modal-alert .dh-modal-text").text("이미 신고한 댓글입니다.");
													    setTimeout(function() {
													        $("#dh-modal-alert").fadeOut(function(){
													            $(this).removeClass("active");
													        });
													    }, 1000);
													    
												} else {
													document
															.getElementById("commentReportModal").style.display = "block";

													// 닫기 버튼 클릭 시 모달 닫기
													closeModal2
															.addEventListener(
																	"click",
																	function() {
																		document
																				.getElementById("commentReportModal").style.display = "none";
																	});

													// 모달 외부 클릭 시 모달 닫기
													window
															.addEventListener(
																	"click",
																	function(event) {
																		if (event.target == document
																				.getElementById("commentReportModal")) {
																			document
																					.getElementById("commentReportModal").style.display = "none";
																		}
																	});
												}

											},
											error : function() {
												// 오류 처리
											}
										});
								
								 }
							});



			// 닫기 버튼 클릭 시 모달 닫기
			closeModal.addEventListener("click", function() {
				document.getElementById("reportModal").style.display = "none";
			});

			// 모달 외부 클릭 시 모달 닫기
			window.addEventListener("click", function(event) {
				if (event.target == document.getElementById("reportModal")) {
					document.getElementById("reportModal").style.display = "none";
				}
			});
		   
		   
		   
		//찜버튼 유효성검사
		document.getElementById("dibsButtonFalse").addEventListener("click",
				function(event) {
					const mno = "${mno}";

					if (mno === null || mno === undefined || mno === "") {
						event.preventDefault();

						$(".dh-modal-wrapper").show();
					}
				});
		
		
	</script>


</body>
</html>