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
<title>Find ID</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link href="./css/findID.css" rel="stylesheet" />
<link href="./css/aram.css" rel="stylesheet" />
<script src="/js/jquery-3.7.0.min.js"></script>

<script type="text/javascript">

   $(function(){
      
      $("#findIDBtn").click(function(){
         let notNum = /[^0-9]/g;
         let kor = /[가-힣]/;
         let mname = $("#mname").val();
         let phoneNumber = $("#firstNumber").val() + $("#MiddleNumber").val() + $("#lastNumber").val();
         let mphonenumber = $("#firstNumber").val() + "-" + $("#MiddleNumber").val() + "-" + $("#lastNumber").val();
         
         $("#nameInfo").text("");
         $("#phoneInfo").text("");
         $("#findIDInfo").text("");
         $("#findIDInfo2").text("");
         
          if (mname == "") {
              $("#nameInfo").text("이름을 입력해주세요.");
              $("#nameInfo").css("color","red");
              return;
          }
          
          if (!kor.test(mname)) {
              $("#nameInfo").text("한글만 입력 가능합니다.");
              $("#nameInfo").css("color","red");
              return;
          }
          
          if (phoneNumber == "") {
              $("#phoneInfo").text("전화번호를 입력해주세요.");
              $("#phoneInfo").css("color","red");
              return;
          }
         
          if(notNum.test(phoneNumber) || phoneNumber.length !== 11) {
              $("#phoneInfo").text("올바른 전화번호를 입력해주세요.");
              $("#phoneInfo").css("color","red");
              return;
          }
          
          //ajax
          $.ajax({
                url: "./findID",
                type: "post",
                data: {"mname": mname, "mphonenumber": mphonenumber},
                dataType: "json",
                success: function(data){
                   
                    if(data.findID.mname != null || data.findID.mid != null){
                        $("#findIDInfo").css("color","green");
                        $("#findIDInfo").text(data.findID.mname +" 님의 아이디는 " + data.findID.mid + " 입니다.  "); 
                  let id = data.findID.mid;
                        
                        if ($(".copyIDBtn").length === 0) {
                            const copyBtn = $("<button id='copyIDBtn'>복사하기</button>");
                            $("#findIDInfo").append(copyBtn);
                            
                            copyBtn.click(function() {
                                const idText = id;
                                copyToClipboard(idText);
                            });
                        }

                        function copyToClipboard(text) {
                            const textarea = document.createElement("textarea");
                            textarea.value = text;
                            document.body.appendChild(textarea);
                            textarea.select();
                            document.execCommand("copy");
                            document.body.removeChild(textarea);
                        }
                       
                      } else {
                             $("#dh-modal-alert2").addClass("active").fadeIn();
                             setTimeout(function() {
                                 $("#dh-modal-alert2").fadeOut(function(){
                                     $(this).removeClass("active");
                                    $("#findIDInfo").html("<div class='form-area'><div class='form'><span>회원가입이 필요하신가요? </span><a href='./join'>&nbsp;&nbsp;회원가입 하러 가기</a></div></div>");
                                 });
                             }, 1000);
                       }

                }, 
                error : function(error){
                    $("#findIDInfo").css("color","red");
                    $("#findIDInfo").text("아이디 찾기 중 오류가 발생했습니다."); 
                }//에러끝
            });//ajax 끝
      }); //findIDBtn 끝
   }); //function 끝

   $(document).on("click", "#copyIDBtn", function(){
        $("#dh-modal-alert").addClass("active").fadeIn();
        setTimeout(function() {
            $("#dh-modal-alert").fadeOut(function(){
                $(this).removeClass("active");
            });
        }, 1000);
    });

</script>

</head>
<body>
   <header>
      <a href="/login"><i class="xi-angle-left xi-x"></i></a>
      <div class="headerTitle">아이디 찾기</div>
      <div class="blank"></div>
   </header>

   <!-- 본문내용 -->
   <main>
<!--       <div class="center-circle-area">
         <div class="center-circle">
            <div class="center-img">
               <img alt="없음" src="/img/hospital2.png" onclick="location.href='/main'">
            </div>
         </div>
      </div>    -->
      
      <div class="main-area">
      <div class="top-area">
         <p class="top-title">🪪 아이디가 기억나지 않으세요?</p>
      </div>
      <div class="input-area">
         <p>이름</p>
         <input type="text" id="mname" name="mname" placeholder="이름을 입력해주세요." maxlength="11">
          <p id="nameInfo" class="info" ></p>
      </div>
      <div class="input-area">    
         <p>전화번호</p>
         <input type="text" id="firstNumber"  name="firstNumber" maxlength="3" placeholder="010">-
         <input type="text" id="MiddleNumber"  name="MiddleNumber" maxlength="4" placeholder="xxxx">
         <input type="text" id="lastNumber"  name="lastNumber" maxlength="4" placeholder="xxxx">
         <p id="phoneInfo" class="info"></p>
         <p id="findIDInfo" class="info"></p>
         <p id="findIDInfo2" class="info"></p>
      </div>
      <button class="button" type="button" id="findIDBtn" >아이디 찾기</button>
      <div class="bottom-area">   
         <div class="bottom"><a href="/main">&nbsp;&nbsp;메인화면으로 가기</a></div>
      </div>
      </div>   
   </main>
   
   <div style="height: 9vh"></div>
   
   
      <!-- 알람모달 -->
   
   <div id="dh-modal-alert">
      <div class="dh-modal">
         <div class="dh-modal-content">
            <div class="dh-modal-title">
               <img class="dh-alert-img" src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
               알림
            </div>
            <div class="dh-modal-text">아이디가 클립보드에 복사되었습니다.</div>
         </div>
      </div>
      <div class="dh-modal-blank" style="height: 14vh;"></div>
   </div>
   
         <!-- 알람모달2 -->
   
   <div id="dh-modal-alert2">
      <div class="dh-modal">
         <div class="dh-modal-content">
            <div class="dh-modal-title">
               <img class="dh-alert-img" src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
               알림
            </div>
            <div class="dh-modal-text">일치하는 정보가 없습니다.</div>
         </div>
      </div>
      <div class="dh-modal-blank" style="height: 18vh;"></div>
   </div>
   
</body>
</html>