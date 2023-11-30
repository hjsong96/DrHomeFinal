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
<title>Login</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link href="./css/login.css" rel="stylesheet" />
<link href="./css/aram.css" rel="stylesheet" />
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.8/clipboard.min.js"></script>
<script
   src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
   integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
   crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"
   integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g="
   crossorigin="anonymous"></script>
<script src="/js/wnInterface.js"></script>
<script src="/js/mcore.min.js"></script>
<script src="/js/mcore.extends.js"></script>

<script type="text/javascript">

$(document).ready(function(){
    $('.login-save i').on('click',function(){
        $('input').toggleClass('active');
        if($('input').hasClass('active')){
            $(this).attr('class',"xi-eye-off xi-2x")
            .prev('input').attr('type',"password");
        }else{
            $(this).attr('class',"xi-eye xi-2x")
            .prev('input').attr('type','text');
        }
    });
});

   //getCookie() 사용 전 미리 로드할 수 있도록 배치 필요!!
   function getCookie(cookieName) {
      let x, y;
      let val = document.cookie.split(";");
      for (let i = 0; i < val.length; i++) {
         x = val[i].substr(0, val[i].indexOf("="));
         y = val[i].substr(val[i].indexOf("=") + 1); // 저 시작위치부터 끝까지
         //x = x.replace(/^\s+|\s+$/g, '');
         x = x.trim();
         if (x == cookieName) {
            return y;
         }
      }
   }

   //setCookie()
   function setCookie(cookieName, value, exdays) {
      let exdate = new Date();
      exdate.setDate(exdate.getDate() + exdays);
      let cookieValue = value
            + ((exdays == null) ? "" : ";expires=" + exdate.toGMTString());
      document.cookie = cookieName + "=" + cookieValue;
   }

   //deleteCookie()
   function deleteCookie(cookieName) {
      let expireDate = new Date();
      expireDate.setDate(expireDate.getDate() - 1);
      document.cookie = cookieName + "= " + ";expires="
            + expireDate.toGMTString();
   }

   $(function() {
      //쿠키 값 가져오기
      let userID = getCookie("userID");
      let setCookieY = getCookie("setCookie");
      console.log(userID, setCookieY);

      //쿠키 검사 -> 쿠키가 있다면 해당 쿠키에서 id값 가져와서 id칸에 붙여넣기
      if (setCookieY == 'Y') {
         $("#saveID").prop("checked", true);
         $("#mid").val(userID);
         $("#mpw").focus();
      } else {
         $("#saveID").prop("checked", false);
      }

      $('.loginBtn').click(
            function(event) {
               let mid = $("#mid").val();
               let mpw = $("#mpw").val();
               let notNum = /[^0-9]/g;

               $(".info").text("");

               if ($("#saveID").is(":checked")) {
                  //setCookie
                  setCookie("userID", mid, 7);
                  setCookie("setCookie", "Y", 7);
               } else {
                  //deleteCookie()
                  deleteCookie("userID");
                  deleteCookie("setCookie");

               }

               if (mid == "") {
                  $("#mid").val("");
                  $("#mpw").val("");
                  $(".info").css("color", "red");
                  $(".info").text("아이디를 입력하세요.");
                  $("#mid").focus();
                  return false;
               }

               if (mpw == "") {
                  $("#mpw").val("");
                  $(".info").css("color", "red");
                  $(".info").text("비밀번호를 입력해주세요.");
                  $("#mpw").focus();
                  return false;
               }

               if (notNum.test(mpw)) {
                  $("#mpw").val("");
                  $(".info").css("color", "red");
                  $(".info").text("숫자를 입력해주세요.");
                  $("#mpw").focus();
                  return false;
               }

               /*          //모피어스 암호화 해서 로그인 처리하기
                let encrypt = M.sec.encrypt(mpw);
                M.tool.log(encrypt);
               
                // JSON.stringify(encrypt)의 결과 문자열
                let jsonString = JSON.stringify(encrypt); 

                try {
                let jsonObject = JSON.parse(jsonString); // JSON 문자열을 파싱하여 객체로 변환
                let resultValue = jsonObject.result; // result 속성에 해당하는 값 추출

                // resultValue를 사용하면 원하는 값에 접근할 수 있습니다.
                console.log(resultValue); 
                $("#mpw").val(resultValue);
                mpw = resultValue;
                } catch (error) {
                console.error("JSON 파싱 에러: " + error);
                } */

               //ajax
               $.ajax({
                  url : "./loginCheck",
                  type : "post",
                  data : {
                     "mid" : mid,
                     "mpw" : mpw
                  },
                  dataType : "json",
                  success : function(data) {

                     if (data.PWresult == 1 || data.PWresult == 3) {

                        let form = $('<form></form>')
                        form.attr("action", "./main");
                        form.attr("method", "get");

                        form.appendTo("body");

                        form.submit();
                     }

                     if (data.PWresult == 2) {
                        let form = $('<form></form>')
                        form.attr("action", "./docMain/" + data.mno
                              + "/" + data.dno);
                        form.attr("method", "get");

                        form.appendTo("body");

                        form.submit();
                     }

                     if (data.PWresult == 4) {
                        $(".info").css("color", "red");
                        $("#mid").focus();
                        $(".info").html("휴면 또는 탈퇴회원입니다. 관리자 문의 바랍니다.");
                     }

                     if (data.IDresult == 0) {
                        $(".info").css("color", "red");
                        $(".info").text("아이디를 다시 확인해주세요.");
                        $("#mid").focus();
                     }

                     if (data.PWresult == 0) {
                        $(".info").css("color", "red");
                        $(".info").text("비밀번호를 다시 확인해주세요.");
                        $("#mpw").focus();
                     }

                  },//success 끝
                  error : function(error) {
                     $(".info").css("color", "red");
                     $(".info").text("로그인 중 오류가 발생했습니다.");
                  }//에러끝
               });//ajax 끝

            });//로그인 버튼 클릭            
   });
   

   $(document).on("click", ".cm-toggle", function(){
      
      if ($(this).is(":checked")) {
             $("#dh-modal-alert").addClass("active").fadeIn();
             setTimeout(function() {
                 $("#dh-modal-alert").fadeOut(function(){
                     $(this).removeClass("active");
                 });
             }, 1000);
      } else{
         $("#dh-modal-alert").removeClass("active").fadeOut();
      }
         });
</script>
   
</head>
<body>
    <%-- <%@ include file="footer.jsp"%> --%> 
   <header> </header>
   

   <!-- 본문내용 -->
   <main>
   <div class="top-area"></div>
      <div class="center-circle-area">
      <div class="center-circle">
         <div class="center-img">
            <img alt="없음" src="/img/DrHome_logo_icon.png">
         </div>
      </div>
      </div>
      
      <div class="logo-area">
         <div class="logo-title"><img alt="없음" src="/img/DrHome_logo_text.png"></div>
      </div>
      
      <div class="login-form">
         <div class="login-save">
            <input class="login-input" type="text" id="mid" name="mid" placeholder="아이디" maxlength="11">
            <input class="login-input" type="password" id="mpw" name="mpw" placeholder="패스워드" maxlength="8">
            <i class="xi-eye-off xi-2x"></i>
            <input id="saveID" type="checkbox" class="cm-toggle">
         </div>
      </div>
         
         <div class="middle-area">
         <p class="info"></p>
         <div class="find-form">
            <a href="./findID" class="find">&nbsp;&nbsp;아이디 찾기 | </a> 
            <a href="./findPW" class="find">&nbsp;&nbsp;비밀번호 찾기 | </a> 
            <a href="./join" class="find"> &nbsp;&nbsp;회원가입</a>
         </div>
         
         <div class="joinHospital-area">
             <div class="joinHospital"><a href="/newHospital" class="joinHospital">&nbsp;&nbsp;병원 등록하러 가기</a></div>
         </div>
         </div>
         
         <div class="bottom-area">
            <div class="button-area">
               <button class="loginBtn">Sign In →</button>
            </div>
            
            <div class="joinHospital-area">
               <div class="joinHospital"><a href="/main" class="joinHospital">&nbsp;&nbsp;메인화면으로 가기</a></div>
            </div>
         </div>
            
<%--             <div>비대면 진료 페이지<a href="/docReception/${sessionScope.mno}/${sessionScope.dno}">&nbsp;&nbsp;바로가기</a></div>
            <div>건강기록<a href="/healthRecord/${sessionScope.mno}">&nbsp;&nbsp;바로가기</a></div>
            <div>내정보<a href="/myInfo/${sessionScope.mno}">&nbsp;&nbsp;바로가기</a></div>
            <div>내글보기<a href="/myWriting/${sessionScope.mno}">&nbsp;&nbsp;바로가기</a></div>
            <div>예약내역확인<a href="/medicalHistory/${sessionScope.mno}">&nbsp;&nbsp;바로가기</a></div>
            <div>결제<a href="/pay/${sessionScope.mno}?tno=1">&nbsp;&nbsp;바로가기</a></div>
            <div>결제완료<a href="/completePay/${sessionScope.mno}">&nbsp;&nbsp;바로가기</a></div>   --%>
   </main>
   
   
   <!-- 알람모달 -->
   
   <div id="dh-modal-alert">
      <div class="dh-modal">
         <div class="dh-modal-content">
            <div class="dh-modal-title">
               <img class="dh-alert-img" src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
               알림
            </div>
            <div class="dh-modal-text">아이디를 저장합니다.</div>
         </div>
      </div>
      <div class="dh-modal-blank" style="height: 13vh;"></div>
   </div>
   
</body>
</html>













