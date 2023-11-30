<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin || 관리 목록</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/admin.css">
<script type="text/javascript">
	function url(url) {
		location.href="./" + url;
	}
</script>
</head>
<body>
	<div class="container">
		<div class="main">
			<div class="article">			
				<h1>관리 목록</h1>
				<div class="name">
					<c:choose>
						<c:when test="${sessionScope.mgrade gt 6}">
							${sessionScope.mname } 관리자님 환영합니다.						
						</c:when>
						<c:otherwise>
							${sessionScope.mname } 의사님 환영합니다.
						</c:otherwise>
					</c:choose>
				</div>
				<div class="box" style="background-color: #2EFEF7;" onclick="url('boardManage')">
					게시판 관리
					<div id="comment">QnA 및 자유게시판을 관리합니다</div>
				</div>
				
				<div class="box" style="background-color: #2EFEF7;" onclick="url('report')">
					게시글 신고 관리
					<div id="comment">게시글 신고를 관리합니다</div>
				</div>
				
				<div class="box" style="background-color: #2EFEF7;" onclick="url('member')">
					회원 관리
					<div id="comment">회원을 관리합니다</div>
				</div>
				
				<div class="box" style="background-color: #2EFEF7;" onclick="url('hospitalOpen')">
					병원 개설 관리
					<div id="comment">병원의 개설을 관리합니다</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
