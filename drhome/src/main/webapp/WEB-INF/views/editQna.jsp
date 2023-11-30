<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="initial-scale=1, width=device-width, user-scalable=no"/>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="./css/editQna.css">
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



	<form action="/submitEditQna" method="post" id="editForm">
	
	<!-- 필터 리스트 -->
            <div class="selectDepartment">
            	<div class="sortTitle margin-right">진료과목</div>
            	<i class="xi-angle-down-thin"></i>
            </div>
		
		<div id="openSortList">
	         	<div class="selectSortList" style="display: none;">  
		            <div class="소아과" data-department="소아과">소아과</div>
		            <div class="치과" data-department="치과">치과</div>
		            <div class="내과" data-department="내과">내과</div>
		            <div class="이비인후과" data-department="이비인후과">이비인후과</div>
		            <div class="피부과" data-department="피부과">피부과</div>
		            <div class="산부인과" data-department="산부인과">산부인과</div>
		            <div class="안과" data-department="안과">안과</div>
		            <div class="정형외과" data-department="정형외과">정형외과</div>
		            <div class="한의학과" data-department="한의학과">한의학과</div>
		            <div class="비뇨기과" data-department="비뇨기과">비뇨기과</div>
		            <div class="신경과" data-department="신경과">신경과</div>
		            <div class="외과" data-department="외과">외과</div>
		            <div class="정신의학과" data-department="정신의학과">정신의학과</div>
		            <div class="unknown" data-department="unknown">잘 모름</div>
	            </div>
	         </div>
	          <input type="hidden" name="selectedDepartment" id="selectedDepartment">
	
	
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






<div style="height: 9vh"></div>
</main>

<footer>
<button type="submit" class="submit">완료</button>
</form>
</footer>

<script>
		
  // 게시물 분류
    $(document).on("click", ".selectDepartment", function(){
        $("#openSortList").toggleClass("maxList");
        $(".selectSortList").slideToggle("fast");
    });
  
    $(document).on("click", ".selectSortList > div", function(){
        const selectedDepartment = $(this).data("department");
        const sortTitle = $(this).text();
    
        $(".sortTitle").text(sortTitle);

        $("#openSortList").removeClass("maxList");
        $(".selectSortList").slideUp("fast");
        
        $("#selectedDepartment").val(selectedDepartment);
        

    });

    $("#dh-modal-alert").hide();
    
    document.getElementById('editForm').addEventListener('submit', function(event) {
        event.preventDefault();
        
    
        const title = document.querySelector('input[name="btitle"]').value;
        const content = document.querySelector('textarea[name="bcontent"]').value;
        const selectedDepartment = document.getElementById('selectedDepartment').value;

        
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
        } else if (content.trim() === '') {
        	

		    $("#dh-modal-alert").addClass("active").fadeIn();
		    $("#dh-modal-alert .dh-modal-text").text("내용을 입력해주세요");
		    setTimeout(function() {
		        $("#dh-modal-alert").fadeOut(function(){
		            $(this).removeClass("active");
		        });
		    }, 1000);
		    
            event.preventDefault();
            return false;
        } else if (!selectedDepartment) {
        	
        	 $("#dh-modal-alert").addClass("active").fadeIn();
      	    $("#dh-modal-alert .dh-modal-text").text("진료과목을 선택해주세요.");
      	    setTimeout(function() {
      	        $("#dh-modal-alert").fadeOut(function(){
      	            $(this).removeClass("active");
      	        });
      	    }, 1000);
      	    
            event.preventDefault(); 
            return false;
        } else {
        	
            this.submit();
        }
    });

	</script>

</body>
</html>