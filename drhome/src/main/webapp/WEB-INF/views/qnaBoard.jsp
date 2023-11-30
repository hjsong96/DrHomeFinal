<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1, width=device-width, user-scalable=no"/> 
<link rel="stylesheet" href="./css/qnaBoard.css">

<script src="./js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="loginAlert.jsp"%>
	

	<header>
		 <i class="xi-angle-left xi-x" onclick="location.href = '/main'"></i>
		<div class="headerTitle">커뮤니티</div>
		<div class="blank"></div>
	</header>

	<main>

	<!-- 게시판 탭 -->
		<div id="boardButtonsContainer">
			<button id="qnaBoardButton" onclick="toggleBoard('qnaBoard')"
				style="display: none;">Q&A게시판</button>
			<button id="qnaBoardBoldButton">Q&A게시판</button>
			<button id="freeBoardButton" onclick="toggleBoard('freeBoard')">자유게시판</button>
			<button id="freeBoardBoldButton" style="display: none;">자유게시판</button>
		</div>
		<!-- <button id="hospitalMapButton" onclick="location.href='hospitalMap'">병원지도</button> -->


<div style="height:7vh";></div>
	<!-- 게시물 검색 -->
				<form action="/searchWord" method="post" id="searchForm">
	<div class="space">
			<div class="searchForm">
				<div class="selectOptionTitle">
            		<div class="optionTitle">제목+내용</div>
            		<i class="xi-angle-down-thin"></i>
           		 </div>
           		 <div class="inputButton">
	         <input type="hidden" name="selectedOptionInput" id="selectedOptionInput">
<input type="text" name="searchWord" id="searchWordInput"
						placeholder="검색 할 내용을 입력하세요">
					<button type="submit" class="xi-search xi-x"></button>
					</div>
			</div>
			<div id="openOptionList">
		         	<div class="selectOptionList" style="display: none;">
		            <div class="allOption" data-option="allOption">제목+내용</div>
		            <div class="titleOption" data-option="titleOption">제목만</div>
		            <div class="contentsOption" data-option="contentsOption"">내용만</div>
	            </div>
	         </div>
		</div>
				</form>
		


	<!-- 자유게시판 불러오기 -->
<div id="freeBoard" style="display: none;">

    <c:choose>
        <c:when test="${not empty boardSearchData}">
        <div class="backGroundBar">
	<div class="space" style= "text-align: right;">
<button class="writeButton" onclick="confirmWriteFree()">작성하기</button>
</div>
</div>
            <c:forEach items="${boardSearchData}" var="search">
                <c:if test="${search.btype eq 1}">
                    <a href="<c:url value='/freeDetail'><c:param name='bno' value='${search.bno}' /></c:url>">
                        <div class="freeList">
                            <div class="space">
                                <div class="title">${search.btitle}</div>
                                <div class="fcontent">${search.bcontent}</div>
                                <div class="bottomContainer">
                                    <div class="nickname">${search.mnickname}</div>
                                    <div class="rightSide">
                                        <div class="commentLogo"><img style="width: 20px;"
                                                src='https://cdn-icons-png.flaticon.com/512/1041/1041916.png' /></div>
                                        <div class="countComment"
                                            style="margin-right: 13px;">${search.comment_count}</div>
                                        <div class="heartLogo"><img style="width: 20px;"
                                                src='https://cdn-icons-png.flaticon.com/128/210/210545.png' /></div>
                                        <div class="countCalldibs">${search.bcalldibsCount}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="line"></div>
                    </a>
                </c:if>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <jsp:include page="freeBoard.jsp">
                <jsp:param name="freeList" value="${requestScope.freeList}" />
            </jsp:include>
        </c:otherwise>
    </c:choose>
</div>


			<!-- QnA 게시판 -->
		<div id="qnaBoard" style="display: block;">

			<div class="backGroundBar">
				<div class="space filter">
			
						<!-- 필터 리스트 -->
            <div class="selectDepartment">
            	<div class="sortTitle margin-right">진료과목</div>
            	<i class="xi-angle-down-thin"></i>
            </div>
          


					<!-- 글 작성하기 버튼 -->
					<button class="writeButton" onclick="confirmWriteQna()">작성하기</button>
				</div>
			</div>
			
				         <div id="openSortList">
	         	<div class="selectSortList" style="display: none;">
		            <div class="전체">전체</div>
		            <div class="소아과">소아과</div>
		            <div class="치과">치과</div>
		             <div class="내과">내과</div>
		            <div class="이비인후과">이비인후과</div>
		            <div class="피부과">피부과</div>
		            <div class="산부인과">산부인과</div>
		            <div class="안과">안과</div>
		            <div class="정형외과">정형외과</div>
		              <div class="한의학과">한의학과</div>
		            <div class="비뇨기과">비뇨기과</div>
		            <div class="신경과">신경과</div>
		            <div class="외과">외과</div>
		            <div class="정신의학과">정신의학과</div>
	            </div>
	         </div>
			
			
			

<!-- 게시글 목록 -->
			<div id="qnaListContainer">
    <c:choose>
        <c:when test="${not empty boardSearchData}">
            <!-- 검색 결과가 있는 경우 -->
            <c:forEach items="${boardSearchData}" var="search">
                <c:if test="${search.btype eq 0}">
                    <!-- 각 항목의 표시 내용 -->
                    <a href="<c:url value='/qnaDetail'><c:param name='bno' value='${search.bno}' /></c:url>">
                        <div class="list">
                            <div class="space">
                                <div class="title">${search.btitle}</div>
                                <c:if test="${search.dpkind ne 'unknown'}">
                                    <div class="kind">${search.dpkind}</div>
                                </c:if>
                                <div class="content">${search.bcontent}</div>
                                <c:choose>
                                    <c:when test="${search.comment_count == 0}">
                                        <div class="wait">
                                            <img class="margin-right"
                                                src="https://cdn-icons-png.flaticon.com/512/1686/1686823.png"
                                                alt="답변 대기 중 이미지" style="width: 20px; height: auto;">
                                            답변 대기 중
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="count">
                                            <img class="margin-right"
                                                src="https://cdn-icons-png.flaticon.com/512/9616/9616817.png"
                                                alt="답변 완료 이미지" style="width: 20px; height: auto;">
                                            ${search.comment_count}개의 답변
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="line"></div>
                    </a>
                </c:if>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <!-- 검색 결과가 없는 경우 -->
            <c:forEach items="${qnaList}" var="qna">
                <!-- 각 항목의 표시 내용 -->
                <a href="<c:url value='/qnaDetail'><c:param name='bno' value='${qna.bno}' /></c:url>">
                    <div class="list">
                        <div class="space">
                            <div class="title">${qna.btitle}</div>
                            <c:if test="${qna.dpkind ne 'unknown'}">
                                <div class="kind">${qna.dpkind}</div>
                            </c:if>
                            <div class="content">${qna.bcontent}</div>
                            <c:choose>
                                <c:when test="${qna.comment_count == 0}">
                                    <div class="wait">
                                        <img class="margin-right"
                                            src="https://cdn-icons-png.flaticon.com/512/1686/1686823.png"
                                            alt="답변 대기 중 이미지" style="width: 20px; height: auto;">
                                        답변 대기 중
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="count">
                                        <img class="margin-right"
                                            src="https://cdn-icons-png.flaticon.com/512/9616/9616817.png"
                                            alt="답변 완료 이미지" style="width: 20px; height: auto;">
                                        ${qna.comment_count}개의 답변
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="line"></div>
                </a>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>
	
			
		</div>
		
		
		<!-- 검색 알림 -->
     <div id="dh-modal-alert">
		<div class="dh-modal">
			<div class="dh-modal-content">
				<div class="dh-modal-title">
					<img class="dh-alert-img" src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
					알림
				</div>
				<div class="dh-modal-text">검색 할 내용을 입력해주세요.</div>
			</div>
		</div>
		<div class="dh-modal-blank"></div>
	</div>

		<div style="height: 9vh"></div>



	</main>

	<footer>

      <a class="footer20" href="./main">
         <div class="footerIcon now">
            <img alt="없음" src="/img/mainHomebefore.png">
            <p>홈</p>
         </div>
      </a> <a class="footer20" href="./search">
         <div class="footerIcon">
            <img alt="없음" src="/img/mainSearchBefore.png">
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
            <img alt="없음" src="/img/mainQnAafter.png">
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

<script>

$(".dh-modal-wrapper").hide();
$(document).on("click", ".dh-close-modal", function(){
	$(".dh-modal-wrapper").hide();
});
	

//검색옵션
$(document).on("click", ".selectOptionTitle", function(){
  	  $("#openOptionList").toggleClass("maxOptionList");
        $(".selectOptionList").slideToggle("fast");
    });



$(document).on("click", ".selectOptionList > div", function(){
    const selectedOptionInput = $(this).data("option");
    const optionTitle = $(this).text();

    $(".optionTitle").text(optionTitle);

    $("#openOptionList").removeClass("maxOptionList");
    $(".selectOptionList").slideUp("fast");
    
    $("#selectedOptionInput").val(selectedOptionInput);
});

document.getElementById('searchForm').addEventListener('submit', function(event) {
    event.preventDefault();
    
    const searchWordInput = document.getElementById("searchWordInput");
	const searchWord = searchWordInput.value.trim(); 
    const selectedOptionInput = document.getElementById('selectedOptionInput').value;

   
    
    if (searchWord === "") {
    	
		//알림
	    $("#dh-modal-alert").addClass("active").fadeIn();
	    setTimeout(function() {
	        $("#dh-modal-alert").fadeOut(function(){
	            $(this).removeClass("active");
	        });
	    }, 1000);
	    
		event.preventDefault();
		
	} else {
		
		  this.submit();
	}
    
      
    
});



//실시간채팅으로 가기
$('.chatting').click(function() { 
	 if(${sessionScope.mno == null || sessionScope.mno == ''}){
		 $('.dh-modal-wrapper').show();
	 }else{
      location.href='./chatting'
	 }
});

//글자수 제한
	var maxLength = 60; // 최대 문자열 길이
	var contentElements = document.querySelectorAll(".content");

	contentElements.forEach(function(contentElement) {
		var text = contentElement.textContent;

		if (text.length > maxLength) {
			var truncatedText = text.slice(0, maxLength) + "...";
			contentElement.textContent = truncatedText;
		}
	});

	

	//로그인 확인
	function confirmWriteQna() {
		
		const mno = "${mno}";

		if (mno === null || mno === undefined || mno === "") {
			$(".dh-modal-wrapper").show();
			
		} else {
			window.location.href = 'writeQna';
		}
	}

	function toggleBoardLogic(boardType) {

		var qnaBoard = document.getElementById("qnaBoard");
		var freeBoard = document.getElementById("freeBoard");

		if (boardType === 'qnaBoard') {
			qnaBoard.style.display = "block";
			freeBoard.style.display = "none";
		} else if (boardType === 'freeBoard') {
			qnaBoard.style.display = "none";
			freeBoard.style.display = "block";
		}
	}

	function toggleBoard(boardType) {

		// 클릭된 버튼 강조
		if (boardType === 'qnaBoard') {
			document.getElementById("qnaBoardButton").style.display = "none";
			document.getElementById("qnaBoardBoldButton").style.display = "block";
			document.getElementById("freeBoardButton").style.display = "block";
			document.getElementById("freeBoardBoldButton").style.display = "none";
		} else if (boardType === 'freeBoard') {
			document.getElementById("qnaBoardButton").style.display = "block";
			document.getElementById("qnaBoardBoldButton").style.display = "none";
			document.getElementById("freeBoardButton").style.display = "none";
			document.getElementById("freeBoardBoldButton").style.display = "block";
		}

		toggleBoardLogic(boardType);

	}
	
	//게시물 분류
	$(document).on("click", ".selectDepartment", function(){
  	  $("#openSortList").toggleClass("maxList");
        $(".selectSortList").slideToggle("fast");
    });
	
	$(document).on("click", ".selectSortList > div", function(){
		 $("#openSortList").toggleClass("maxList");
	        $(".selectSortList").slideToggle("fast");
	});
	

	
	//게시물 분류 선택
	document.addEventListener("DOMContentLoaded", function () {
		  // 진료과목 선택
		var selectDepartment = document.querySelector(".selectDepartment");

		  // 키워드에 해당하는 게시글만 필터링
		  function filterByKeyword(keyword) {
		    var qnaListContainer = document.getElementById("qnaListContainer");
		    var qnaItems = qnaListContainer.getElementsByClassName("list");

		    for (var i = 0; i < qnaItems.length; i++) {
		      var qnaItem = qnaItems[i];
		      var kindElement = qnaItem.querySelector(".kind");
		      

		      if (keyword === "전체") {
		        qnaItem.style.display = "block";
		      } else {
		       
		        if (kindElement && kindElement.textContent !== keyword) {
		          qnaItem.style.display = "none";
		        } else {
		          qnaItem.style.display = "block";
		        }
		      }
		    }
		  }
		
		  
		  var sortItems = document.querySelectorAll("#openSortList .selectSortList > div");
		  sortItems.forEach(function (item) {
		    item.addEventListener("click", function () {
		     
		      var selectedKeyword = item.textContent.trim();

		      
		      selectDepartment.querySelector(".sortTitle").textContent = selectedKeyword;

		      
		      filterByKeyword(selectedKeyword);
		    });
		  });
		});
	
	
	 
	
</script>
</html>