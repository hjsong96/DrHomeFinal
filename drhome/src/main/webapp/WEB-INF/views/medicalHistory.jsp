<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MedicalHistory</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="/css/medicalHistory.css" rel="stylesheet" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="/js/jquery-3.7.0.min.js"></script> 

<script type="text/javascript">

$(function(){
   /* 뒤로가기 버튼 */
   $(document).on("click", ".xi-angle-left", function(){
      history.back();
   });
});

</script>

<style type="text/css">
th, td {
  text-align: center;
}
</style>

</head>
<body>
   <header>
      <i class="xi-angle-left xi-x"></i>
      <div class="headerTitle">진료내역</div>
      <div class="blank"></div>
   </header>
   
   <main>
   <div class="main-area">
   <p class="top-title">🏥 내 예약 진료내역</p>
       <div class="table-area">
          <div class="table">
             <div class="table-head">
                 <div class="tr">
                      <div class="th">날짜</div>
                       <div class="th" id="hospital-name">병원</div>
                      <div class="th" id="hospital-dpkind">진료과</div>
                      <div class="th" id="hospital-dname">담당의사</div>
                      <div class="th" id="hospital-asymptomInfo">진단내용</div>
                 </div>
              </div>
               <div class="table-body">
                 <c:forEach items="${appointmentHistory}" var="row">
                 <div class="tr">
                     <div class="td" >${row.adate}</div>
                     <div class="td" id="hospital-name">${row.hname}</div>
                     <div class="td" id="hospital-dpkind">${row.dpkind}</div>
                     <div class="td" id="hospital-dname">${row.dname}</div>
                     <div class="td" id="hospital-asymptomInfo">${row.asymptomInfo}</div>
                 </div>
                 </c:forEach>
             </div>
         </div>
      </div> <!-- 예약진료 끝 -->
   <p class="top-title">💉 내 비대면 진료내역</p>
       <div class="table-area">
          <div class="table">
             <div class="table-head">
                 <div class="tr">
                      <div class="th">날짜</div>
                       <div class="th" id="hospital-name">병원</div>
                      <div class="th">진료과</div>
                      <div class="th">담당의사</div>
                      <div class="th">진단내용</div>
                 </div>
              </div>
               <div class="table-body">
                 <c:forEach items="${telehealthHistory}" var="row">
                 <div class="tr">
                     <div class="td" >${row.tdate}</div>
                     <div class="td" >${row.hname}</div>
                     <div class="td" >${row.dpkind}</div>
                     <div class="td" >${row.dname}</div>
                     <div class="td" >${row.tdiagnosisdetail}</div>
                 </div>
                 </c:forEach>
             </div>
         </div>
      </div> <!-- 비대면 진료 끝 -->
    </div>
    </main>
</body>
</html>