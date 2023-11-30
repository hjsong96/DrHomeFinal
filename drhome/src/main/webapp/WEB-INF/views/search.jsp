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
<title>search</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="./css/telehealthSearch.css">
<script src="./js/jquery-3.7.0.min.js"></script>
<script src="./js/wnInterface.js"></script>
<script src="./js/mcore.min.js"></script>
<script src="./js/mcore.extends.js"></script>
<script type="text/javascript">

	window.onload = function() {
	    document.getElementById('keyword').focus();
	};
	
	$(function(){
		
		/* 실시간채팅으로 가기 */
		 $('.chatting').click(function() { 
			 if(${sessionScope.mno == null || sessionScope.mno == ''}){
				 $('.dh-modal-wrapper').show();
			 }else{
		       location.href='./chatting'
			 }
		 });

		/* 뒤로가기 버튼 */
		$(document).on("click", ".xi-angle-left", function(){
			location.href = '/main';
		});
		
		/* 최근 검색어 키워드 넣기 */
		if ( M.data.storage("recentKeyword") == '' ) {
			$(".searchRecentItems").html('');
		} else {
			let storageKeyword = M.data.storage("recentKeyword").trim();
			let stringArray = separationString(storageKeyword);
			let searchRecentItems = '';
			for(let item of stringArray) {
				searchRecentItems += '<div class="recentItemBox"><button class="recentItem">' + item + '</button><div class="deleteKeyword"><i class="xi-close-min"></i></div></div>';
			}
			$(".searchRecentItems").html(searchRecentItems);
		}

		/* 최근 검색어 전체 삭제 */
		$(".searchDelete").click(function(){
			M.data.removeStorage("recentKeyword");
			$(".searchRecentItems").html('');
		});
		
		/* 검색 */
		$(".recommendItem, .recommendRandomItem, .recentItem").click(function(){
		    let keyword = $(this).text();
		    $('#keyword').val(keyword);
		});
		
		/* 최근 검색어 저장하기 */
		$(document).on("submit", "#searchForm", function(){
			let searchKeyword = $("#keyword").val().trim();
			if ( searchKeyword != '' && searchKeyword != null ) {
				if( M.data.storage("recentKeyword") == '' || M.data.storage("recentKeyword") == null ) {
					M.data.storage("recentKeyword", searchKeyword);
				} else {
					let storageKeyword = M.data.storage("recentKeyword");
					/* 중복값 제거하고 추가하기 */
					let allCookieArray = separationString(storageKeyword);// 스트링 -> 배열
					if ( !(allCookieArray.includes(searchKeyword)) ) {
						let combine = M.data.storage("recentKeyword") + "," + searchKeyword;
						M.data.storage("recentKeyword", combine);
				    }
				}
			}
		});
		
		/* 최근검색어 한개 삭제 */
		$(document).on("click", ".deleteKeyword", function(){
			let deleteKeyword = $(this).siblings().text();
			let storageKeyword = M.data.storage("recentKeyword");
			let allCookieArray = separationString(storageKeyword);// 스트링 -> 배열
			let deleteCookieArray = allCookieArray.filter(item => item !== deleteKeyword);// 삭제하고 다시 배열
			let newKeyword = deleteCookieArray.join(",");// 새로운 배열
			M.data.storage("recentKeyword", newKeyword);
			$(this).parent().html('').removeClass('recentItemBox');
		});
		
		/* 입력할 때 내용 지우기 */
		if ($("#keyword").val() !== '') {
			$(".icon").addClass("xi-close-circle");
		} else {
			$(".icon").removeClass("xi-close-circle");
		}
		$(document).on("input", "#keyword", function(){
			if ($("#keyword").val() !== '') {
				$(".icon").addClass("xi-close-circle");
			} else {
				$(".icon").removeClass("xi-close-circle");
			}
		});
		
		$(document).on("click", ".deleteSearch", function(){
			$(".icon").removeClass("xi-close-circle");
			$("#keyword").val('').focus();
		});
		
	});
	
	/* String 잘라서 배열로 만들기 */
	function separationString(stringList) {
	    if (stringList) {
	        return stringList.split(",").map(function(item) {
	            return item.trim();
	        });
	    } else {
	        return false;
	    }
	}
</script>

</head>
<body>
	<%@ include file="loginAlert.jsp"%>
	<form id="searchForm" action="/search" method="post">
		<header>
			<i class="xi-angle-left xi-x"></i>
			<div class="headerTitle">병원 검색</div>
			<div class="blank"></div>
		</header>

		<main class="searchBox container">

			<!-- search -->
			<div class="search">
				<div class="searchInput">
					<input placeholder="진료과, 증상, 병원을 검색하세요." name="keyword"
						id="keyword">
					<div class="deleteSearch">
						<i class="icon"></i>
					</div>
				</div>
				<button class="searchButton">
					<img src="./img/search.png">
				</button>
			</div>

			<div class="serachItem">
				<!-- 최근 검색 -->
				<div class="searchRecent">
					<div class="titleSection">
						<div class="searchTitle">최근 검색어</div>
						<div class="searchDelete">전체삭제</div>
					</div>
					<div class="searchRecentItems">
						<div class="recentItemBox">
							<button class="recentItem"></button>
							<div class="deleteKeyword">
								<i class="xi-close-min"></i>
							</div>
						</div>
					</div>
				</div>
				<!-- 추천 검색어 -->
				<div class="searchRecommend">
					<div class="searchTitle">추천 검색어</div>
					<div class="searchRecommendItems">
						<button class="recommendItem">전문의</button>
						<button class="recommendItem">야간진료</button>
						<button class="recommendItem">여의사</button>
						<button class="recommendItem">휴일진료</button>
						<!-- 추가하기 -->
						<c:forEach items="${randomKeyword}" var="row">
							<button class="recommendRandomItem">${row}</button>
						</c:forEach>
					</div>
				</div>
			</div>
			<div style="height: 9vh"></div>
		</main>
	</form>
	
	
	   <footer>
	      <a class="footer20" href="./main">
	         <div class="footerIcon now">
	            <img alt="없음" src="/img/mainHomebefore.png">
	            <p>홈</p>
	         </div>
	      </a> <a class="footer20" href="./search">
	         <div class="footerIcon">
	            <img alt="없음" src="/img/mainSearchAfter.png">
	            <p>검색</p>
	         </div>
	      </a> <a class="footer20 footerMap" href="./hospitalMap">
	         <div class="footerMain">
	            <div class="footerIcon" id="mapIcon">
	               <img alt="없음" src="/img/mainMap.png">
	            </div>
	         </div>
	      </a> <a class="footer20" href="./qnaBoard">
	         <div class="footerIcon">
	            <img alt="없음" src="/img/mainQnAbefore.png">
	            <p>고민 상담</p>
	         </div>
	      </a><a class="footer20 chatting">
	         <div class="footerIcon">
	            <img alt="없음" src="/img/myChatting3.png">
	            <p>실시간 채팅</p>
	         </div>
	      </a>
	   </footer>

</body>
</html>