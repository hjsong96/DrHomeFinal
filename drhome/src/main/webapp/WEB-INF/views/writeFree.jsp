<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="initial-scale=1, width=device-width, user-scalable=no"/> 
<link rel="stylesheet" href="./css/writeFree.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="/js/jquery-3.7.0.min.js"></script>
<title>Insert title here</title>
</head>
<body>


<header>
    <i class="xi-angle-left xi-x" onclick="location.href = '/qnaBoard'"></i>
    <div class="headerTitle">작성하기</div>
    <div class="blank"></div>
</header>


	<main>



	<!-- <h2>[자유 게시판 글쓰기]</h2> -->
	<form action='<c:url value='/postFree'/>' method="post" id="freeForm">
		<div>
			<input type="text" name="btitle" class="btitle">
		</div>
		<div>
			<textarea rows="5" cols="13" name="bcontent" class="bcontent"></textarea>
		</div>
		<input type="hidden" name="bdate" id="bdate">
		<!--<div class="rightSide">
		<button type="button" onclick="location.href='qnaBoard'" class="cancel">목록</button>
		</div>-->

	
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

	<!-- <div id="imagePreview"></div> -->
<div style="height: 9vh"></div>
</main>


	<footer>
	<button type="submit" class="submit">완료</button>
	</form>
	</footer>


	<script>

	document.getElementById('freeForm').addEventListener('submit', function(event) {
	    event.preventDefault();

	    const currentDatetime = new Date();
	    const utcDatetime = new Date(currentDatetime.toISOString().slice(0, 19) + "Z");
	    const formattedDatetime = new Date(utcDatetime.getTime() + 9 * 60 * 60 * 1000);

	    document.getElementById('bdate').value = formattedDatetime.toISOString().slice(0, 19).replace("T", " ");

	    const title = document.querySelector('input[name="btitle"]').value;
	    const content = document.querySelector('textarea[name="bcontent"]').value;

	    // 제목이나 내용 중 하나라도 비어있으면 경고창을 띄우고 전송을 막음
	    if (title.trim() === '') {

	        $("#dh-modal-alert").addClass("active").fadeIn();
	        $("#dh-modal-alert .dh-modal-text").text("제목을 입력해주세요");
	        setTimeout(function() {
	            $("#dh-modal-alert").fadeOut(function(){
	                $(this).removeClass("active");
	            });
	        }, 1000);
	    } else if (content.trim() === '') {
	    	
	        $("#dh-modal-alert").addClass("active").fadeIn();
	        $("#dh-modal-alert .dh-modal-text").text("내용을 입력해주세요");
	        setTimeout(function() {
	            $("#dh-modal-alert").fadeOut(function(){
	                $(this).removeClass("active");
	            });
	        }, 1000);
	    } else {
	        this.submit();
	    }
	});
	</script>

</body>
</html>