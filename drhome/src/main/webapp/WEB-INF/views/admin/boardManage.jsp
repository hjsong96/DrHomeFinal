<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardManage</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/admin.css">
<style type="text/css">

.input-form {
	margin: 0 auto;
	margin-top: 10px;
	width: 90%;
	height: 30px;
	line-height: 30px;
	padding: 5px;
	background-color: gray;
}
.input-form input, .input-form button {
	width: 19%;
	border: 0px;
	margin: 0;
	padding: 0;
	height: 20px;
	vertical-align: middle;
}
</style>
</head>
<body>
<div class="container">
	<div class="main">
		<div class="article">
			<h1>게시판 관리</h1>
			<div class="div-table">
				<div class="div-row table-head">
					<div class="div-cell table-head">번호</div>
					<div class="div-cell table-head">제목</div>
					<div class="div-cell table-head">내용</div>
					<div class="div-cell table-head">날짜</div>
					<div class="div-cell table-head">유형</div>
				</div>
				<c:forEach items="${manageBoardList }" var="row">
				<div class="div-row">
					<div class="div-cell">${row.bno }</div>
					<div class="div-cell">${row.btitle }</div>
					<div class="div-cell">${row.bcontent }</div>
					<div class="div-cell">${row.bdate }</div>
					<div class="div-cell url"><c:if test="${row.btype eq 0 }">QnA</c:if><c:if test="${row.btype eq 1 }">자유</c:if><c:if test="${row.btype eq 2 }">삭제</c:if></div>
				</div>
				</c:forEach>
			</div>

			<div class="input-form">
				<form action="./multiBoard" method="post">
					<input type="number" name="cateNum" required="required" placeholder="게시판 번호 입력">	
					<input type="text" name="name" required="required" placeholder="게시판 이름 입력">	
					<input type="text" name="comment" required="required" placeholder="참고를 남겨주세요.">							
					<button type="submit">저장</button>	
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>
