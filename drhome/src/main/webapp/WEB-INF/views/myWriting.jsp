<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyWriting</title>
<meta name="viewport"
   content="initial-scale=1, width=device-width, user-scalable=no" />
<link href="/css/myWriting.css" rel="stylesheet" />
<link rel="stylesheet"
   href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">

$(function(){
   /* 뒤로가기 버튼 */
   $(document).on("click", ".xi-angle-left", function(){
      history.back();
   });
});

function choiceDetail(bno, btype) {
    if (btype === 0) {
      location.href = '../qnaDetail?bno=' + bno;
    } else {
      location.href = '../freeDetail?bno=' + bno;
    }
  }
</script>
<style type="text/css">
</style>

</head>
<body>
   <header>
      <i class="xi-angle-left xi-x"></i>
      <div class="headerTitle">나의 게시글</div>
      <div class="blank"></div>
   </header>


   <main>
      <div class="main-area">
         <p class="top-title">⭐ 내가 찜한 글</p>
         <div class="table-area">
            <div class="table">
               <div class="table-head">
                  <div class="tr">
                     <div class="th">제목</div>
                     <div class="th">글쓴이</div>
                     <div class="th">날짜</div>
                     <div class="th">유형</div>
                  </div>
               </div>
               <div class="table-body">
                  <c:forEach items="${callDibs}" var="row">
                     <div class="tr">
                        <div class="td" id="tdtitle"
                           onclick="choiceDetail(${row.bno}, ${row.btype})">${row.btitle}</div>
                        <div class="td">${row.mnickname}</div>
                        <div class="td">${row.bdate}</div>
                        <c:choose>
                           <c:when test="${row.btype eq 0}">
                              <div class="td" id="tstatus">상담게시판</div>
                           </c:when>
                           <c:when test="${row.btype eq 1}">
                              <div class="td" id="tstatus">자유게시판</div>
                           </c:when>
                           <c:otherwise>
                              <div class="td" style="color: red" id="tstatus">삭제된 글</div>
                           </c:otherwise>
                        </c:choose>
                     </div>
                  </c:forEach>
               </div>
            </div>
         </div>
         <!-- 내가 찜한 글 -->

         <p class="top-title">📝 내가 작성하신 글</p>
         <div class="table-area">
            <div class="table">
               <div class="table-head">
                  <div class="tr">
                     <div class="th">제목</div>
                     <div class="th">글쓴이</div>
                     <div class="th">날짜</div>
                     <div class="th">유형</div>
                  </div>
               </div>
               <div class="table-body">
                  <c:forEach items="${myWriting}" var="row">
                     <div class="tr">
                        <div class="td" id="tdtitle"
                           onclick="choiceDetail(${row.bno}, ${row.btype})">${row.btitle}</div>
                        <div class="td" class="tdtitle">${row.mnickname}</div>
                        <div class="td" class="tdtitle">${row.bdate}</div>
                        <c:choose>
                           <c:when test="${row.btype eq 0}">
                              <div class="td" id="tstatus">상담게시판</div>
                           </c:when>
                           <c:when test="${row.btype eq 1}">
                              <div class="td" id="tstatus">자유게시판</div>
                           </c:when>
                           <c:otherwise>
                              <div class="td" style="color: red" id="tstatus">삭제된 글</div>
                           </c:otherwise>
                        </c:choose>
                     </div>
                  </c:forEach>
               </div>
            </div>
         </div>
         <!-- 내가 작성한 글 -->

         <p class="top-title">📬 내가 작성한 댓글</p>
         <div class="table-area">
            <div class="table">
               <div class="table-head">
                  <div class="tr">
                     <div class="th">댓글내용</div>
                     <div class="th">글쓴이</div>
                     <div class="th">날짜</div>
                     <div class="th">유형</div>
                  </div>
               </div>
               <div class="table-body">
                  <c:forEach items="${myComment}" var="row">
                     <div class="tr">
                        <div class="td" id="tdtitle"
                           onclick="location.href='../commentDetail?cno=${row.cno}'">${row.ccontent}</div>
                        <div class="td">${row.mnickname}</div>
                        <div class="td">${row.cdate}</div>
                        <c:choose>
                           <c:when test="${row.btype eq 0}">
                              <div class="td" id="tstatus">상담게시판</div>
                           </c:when>
                           <c:when test="${row.btype eq 1}">
                              <div class="td" id="tstatus">자유게시판</div>
                           </c:when>
                           <c:otherwise>
                              <div class="td" style="color: red" id="tstatus">삭제된 글</div>
                           </c:otherwise>
                        </c:choose>
                     </div>
                  </c:forEach>
               </div>
            </div>
         </div>
         <!-- 내가 작성한 댓글 -->
      </div>
   </main>
</body>
</html>