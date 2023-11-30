<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<link rel="stylesheet" href="./css/editBoard.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>
</head>
<body>

<header>
    <i class="xi-angle-left xi-x" onclick="history.back()"></i>
    <div class="headerTitle">글 수정하기</div>
    <div class="blank"></div>
</header>

<main>

<!-- <h2>[게시판 글 수정하기]</h2> -->


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

	<form action="/submitEditBoard" method="post" id="editForm">
		<div>
		<input type="text" name="btitle" class="btitle" value="${btitle}">
		</div>
		<div>
			<textarea rows="5" cols="13" name="bcontent" class="bcontent">${bcontent}</textarea>
		</div>
		<input type="hidden" name="bno" id="bno"
			value="${bno}">
			<!-- <div class="rightSide">
		<button type="button" class="cancel" onclick="history.back()">취소</button>
		</div> -->
	
	
	</main>
	
	<footer>
	<button type="submit" class="submit">완료</button>
	</form>
	</footer>

<script>
$("#dh-modal-alert").hide();
		
		document.getElementById('editForm').addEventListener(
				'submit',
				function(event) {
					
					const title = document
					.querySelector('input[name="btitle"]').value;
			const content = document
					.querySelector('textarea[name="bcontent"]').value;
					
	
					if (title.trim() === '') {
						 $("#dh-modal-alert").addClass("active").fadeIn();
					 	    $("#dh-modal-alert .dh-modal-text").text("제목을 입력해주세요");
					 	    setTimeout(function() {
					 	        $("#dh-modal-alert").fadeOut(function(){
					 	            $(this).removeClass("active");
					 	        });
					 	    }, 1000);
					 	    
					            event.preventDefault(); 
					            return false;
					}
					if (content.trim() === '') {

					    $("#dh-modal-alert").addClass("active").fadeIn();
					    $("#dh-modal-alert .dh-modal-text").text("내용을 입력해주세요");
					    setTimeout(function() {
					        $("#dh-modal-alert").fadeOut(function(){
					            $(this).removeClass("active");
					        });
					    }, 1000);
					    event.preventDefault(); 
			            return false;
					    
					} else {
						// 폼 제출
					this.submit();
					}
					
				});
	</script>

</body>
</html>