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
<title>CompleteHosDoc</title>
<link href="/css/completeHosDoc.css" rel="stylesheet" />
<script src="../js/jquery-3.7.0.min.js"></script> 
<script type="text/javascript">

</script>

</head>
<body>
	
	<div class="complete-area">
	<div class="img-area">
		<img class="img" alt="없음" src="/img/checkBlue.png">
	</div>
	<div class="comment-area">
		<p class="top-title">등록이 완료되었습니다.</p>
		<div class="introduce-area">
		<p class="top-introduce">조금만 기다려 주세요!</p>
		<p class="top-introduce">곧 관리자가 승인할거예요🧑‍⚕️</p>
		</div>
	</div>
	</div>
	<div style="height: 9vh"></div>
	
	<footer>
		<button style="margin-right: 15px;" type="button" onclick="location.href='/login'">확인</button>
		<button type="button" onclick="location.href='/newDoctor?rhno=${param.rhno }'">추가</button>
	</footer>
	
</body>
</html>