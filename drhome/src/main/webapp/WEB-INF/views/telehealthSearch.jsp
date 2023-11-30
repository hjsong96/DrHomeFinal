<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Calendar, java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<title>telehealthSearch</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="./css/telehealthSearch.css">
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	$(function() {

		/* 뒤로가기 버튼 */
		$(document).on("click", ".xi-angle-left", function() {
			location.href = '/main';
		});

		$(".seletedDepartmentBox").show();
		$(".seletedSymptomBox").hide();

		/* 입력할 때 내용 지우기 */
		if ($("#keyword").val() !== '') {
			$(".icon").addClass("xi-close-circle");
		} else {
			$(".icon").removeClass("xi-close-circle");
		}
		$(document).on("input", "#keyword", function() {
			if ($("#keyword").val() !== '') {
				$(".icon").addClass("xi-close-circle");
			} else {
				$(".icon").removeClass("xi-close-circle");
			}
		});
		$(document).on("click", ".deleteSearch", function() {
			$(".icon").removeClass("xi-close-circle");
			$("#keyword").val('').focus();
		});

		/* 진료과 선택했을 때 */
		$(document).on(
				"click",
				".optionDepartment",
				function() {
					$(".fixMenu").addClass("fixed");
					$(this).addClass("selectOption");
					$(".optionSymptom").removeClass("selectOption");
					$(".seletedDepartmentBox").show();
					$(".seletedSymptomBox").hide();
					let offset = $(".seletedDepartmentBox").offset().top
							- (20 * window.innerHeight / 100);
					$("html, body").animate({
						scrollTop : offset
					}, 450);
				});

		/* 진료과 검색하기 */
		$(document).on("click", ".departmentBox", function() {
			let departmentKind = $(this).find($(".departmentKeyword")).text();
			$("#keyword").val(departmentKind).submit();
			$("#searchForm").submit();
		});

		/* 증상 선택했을 때 */
		$(document).on("click",".optionSymptom",function() {
			$(this).addClass("selectOption");
			$(".optionDepartment").removeClass("selectOption");
			$(".seletedDepartmentBox").hide();
			$(".seletedSymptomBox").show();
			let offset = $(".seletedSymptomBox").offset().top
					- (20 * window.innerHeight / 100);
			$("html, body").animate({
				scrollTop : offset
			}, 450);
		});

		/* 증상 그룹별로 보여주기 */
		let keywordClass = $(".symptomBox:first .symptomText").nextAll();
		toggleClass(keywordClass);
		$(document).on("click", ".symptomText", function() {
			let togglKeyword = $(this).siblings();
			toggleClass(togglKeyword);
		});

		/* 증상 검색하기 */
		$(document).on("click", ".symptomKind", function() {
			let symptomKind = $(this).text();
			$("#keyword").val(symptomKind);
		});

		/* 자주 찾는 버튼 선택해서 검색하기 */
		$(document).on("click", ".randomKeyword", function() {
			let randomKeyword = $(this).text();
			$('#keyword').val(randomKeyword);
		});
	});

	/* Collection of functions */

	/* 모달에서 증상별 토글 효과 */
	function toggleClass(keyword) {
		let otherKeyword = $(".symptomExample").not(keyword);
		if (otherKeyword.is(":visible")) {
			otherKeyword.slideUp();
			toggleIcon(otherKeyword);
		}
		if (keyword.is(":visible")) {
			toggleIcon(keyword);
			keyword.slideUp();
		} else {
			toggleIcon(keyword);
			keyword.slideDown();
		}
	}

	/* 증상별 토글 아이콘 변경 */
	function toggleIcon(keyword) {
		if (keyword.is(":visible")) {
			let toggle = keyword.siblings().children(".xi-angle-up-thin");
			toggle.removeClass("xi-angle-up-thin").addClass(
					"xi-angle-down-thin");
		} else {
			let toggle = keyword.siblings().children(".xi-angle-down-thin");
			toggle.removeClass("xi-angle-down-thin").addClass(
					"xi-angle-up-thin");
		}
	}
</script>

</head>
<body>
	<form id="searchForm" action="telehealthSearch" method="post">
		<!-- header -->
		<header>
			<i class="xi-angle-left xi-x"></i>
			<div class="headerTitle">비대면 진료 검색</div>
			<div class="blank"></div>
		</header>

		<main class="telehealthSearchContainer container">

			<div class="fixed">
				<!-- search -->
				<div class="search">
					<div class="searchInput">
						<input placeholder="진료과, 증상, 의사를 검색하세요." name="keyword"
							id="keyword">
						<div class="deleteSearch">
							<i class="icon"></i>
						</div>
					</div>
					<button class="searchButton">
						<img src="./img/search.png">
					</button>
				</div>

				<!-- menu bar -->
				<div class="selectedOption">
					<div class="optionDepartment selectOption">과목</div>
					<div class="optionSymptom">증상</div>
				</div>
			</div>

			<div id="placeHolderDiv" style="height: 10vh;"></div>
			<!-- 진료과 -->
			<div class="seletedDepartmentBox">
				<div class="favoriteBox">
					<div class="favoriteTitle">자주 찾는 과목</div>
					<div class="favoriteKeyword">
						<c:forEach items="${departmentRandomKeyword}" var="row">
							<button class="randomKeyword">${row}</button>
						</c:forEach>
					</div>
					<div class="grayLine"></div>
					<c:forEach items="${departmentKeyword}" var="row">
						<div class="departmentBox">
							<div class="departmentText">
								<div class="departmentKeyword">${row.dpkind}</div>
								<div class="departmentExample">${row.dpexample}</div>
							</div>
							<div class="departmentImg">
								<img src="./img/dp${row.dpno}.png">
							</div>
						</div>
						<div class="grayLine"></div>
					</c:forEach>
				</div>
			</div>
			<!-- 증상 -->
			<div class="seletedSymptomBox">
				<div class="favoriteBox">
					<div class="favoriteTitle">자주 찾는 증상</div>
					<div class="favoriteKeyword">
						<c:forEach items="${symptomRandomKeyword}" var="row">
							<button class="randomKeyword">${row}</button>
						</c:forEach>
					</div>
					<div class="grayLine"></div>
					<c:forEach items="${departmentKeyword}" var="row">
						<div class="symptomBox">
							<div class="symptomText">
								<div class="symptomImg">
									<img src="./img/dp${row.dpno}.png">
								</div>
								<div class="symptomKeyword">${row.dpsymptom}</div>
								<div class="xi-angle-down-thin"></div>
							</div>
							<div class="symptomExample">
								<c:set var="keywords" value="${row.dpkeyword.split(',')}" />
								<c:forEach var="keyword" items="${keywords}">
									<button class="symptomKind">${keyword}</button>
								</c:forEach>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</main>
	</form>
</body>
</html>