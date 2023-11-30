<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 승인 및 등급</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/memberManage.css">
<script src="../js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">

function gradeCh(mno, name, value, count) {
    $("#dh-modal-alert").addClass("active").fadeIn();
       setTimeout(function() {
           $("#dh-modal-alert").fadeOut(function(){
               $(this).removeClass("active");
           });
          location.href="./gradeChange?mno="+mno+"&mname"+name+"&mgrade="+value+"&mboardcount="+count;
       }, 1000);
}; 

function goback() {
	   window.history.back();
	}


</script>

</head>
<body>

   <div id="dh-modal-alert" style="display: none">
      <div class="dh-modal">
         <div class="dh-modal-content">
            <div class="dh-modal-title">
               <img class="dh-alert-img"
                  src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
               알림
            </div>
            <div class="dh-modal-text">회원 등급이 변경되었습니다.</div>
         </div>
      </div>
      <div class="dh-modal-blank"></div>
   </div>

   <header>
     <a href="javascript:history.back();"><i class="xi-angle-left xi-x"></i></a>
      <div class="headerTitle">회원 관리</div>
      <div class="blank"></div>
   </header>

   <main>
      <div class="container">
         <div class="article">
            <div class="div-table">
               <div class="div-row table-head">
                  <div class="div-cell table-head">번호</div>
                  <div class="div-cell table-head">아이디</div>
                  <div class="div-cell table-head">이름</div>
                  <div class="div-cell table-head">등급</div>
               </div>
               <c:forEach items="${memberList }" var="row">

                  <div id="clickData"
                     class="div-row <c:if test="${row.mgrade gt 6 }">manager</c:if><c:if test="${row.mgrade gt 4 && row.mgrade lt 7}">doctor</c:if><c:if test="${row.mgrade lt 1 }">cancel</c:if>">

                     <div class="div-cell">${row.mno }</div>
                     <div class="div-cell">${row.mid }</div>
                     <div class="div-cell">${row.mname }</div>

                     <div class="div-cell">
                        <select class="grade"
                           onchange="gradeCh(${row.mno}, '${row.mname}', this.value, ${row.mboardcount})">
                           <optgroup label="이용불가">
                              <option value="0"
                                 <c:if test="${row.mgrade eq 0}">selected="selected"</c:if>>탈퇴회원</option>
                              <option value="1"
                                 <c:if test="${row.mgrade eq 1}">selected="selected"</c:if>>휴먼계정</option>
                           </optgroup>
                           <optgroup label="이용가능">
                              <option value="2"
                                 <c:if test="${row.mgrade eq 2}">selected="selected"</c:if>>일반회원</option>
                              <option value="3"
                                 <c:if test="${row.mgrade eq 3}">selected="selected"</c:if>>우수회원</option>
                              <option value="4"
                                 <c:if test="${row.mgrade eq 4}">selected="selected"</c:if>>VIP회원</option>
                              <option value="5"
                                 <c:if test="${row.mgrade eq 5}">selected="selected"</c:if>>일반의사</option>
                              <option value="6"
                                 <c:if test="${row.mgrade eq 6}">selected="selected"</c:if>>전문의사</option>
                           </optgroup>
                           <optgroup label="관리자">
                              <option value="7"
                                 <c:if test="${row.mgrade eq 7}">selected="selected"</c:if>>일반관리자</option>
                              <option value="8"
                                 <c:if test="${row.mgrade eq 8}">selected="selected"</c:if>>최고관리자</option>
                           </optgroup>
                        </select>
                     </div>
                  </div>
               </c:forEach>
            </div>
         </div>
      </div>
   </main>
   <footer>
      <button onclick=goback()>돌아가기</button>
   </footer>
</body>
</html>