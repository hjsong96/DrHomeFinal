<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<title>Pay</title>
<link href="/css/pay.css" rel="stylesheet" />
<link href="/css/aram.css" rel="stylesheet" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="../js/jquery-3.7.0.min.js"></script> 
<script type="text/javascript">

$(function() {
	
    $("#payBtn").click(function(){
		let firstNum = $("#firstNum").val();
		let secondNum = $("#secondNum").val();
		let thirdNum = $("#thirdNum").val();
		let lastNum = $("#lastNum").val();
		let svc = $("#svc").val();
		let cdcard = $("#cdcard").val();
    	
        let nullFirstNum = firstNum === "";
        let nullSecondNum = secondNum === "";
        let nullThirdNum = thirdNum === "";
        let nullLastNum = lastNum === "";
        let nullSvs = svc === "";
        let nullCdcard = cdcard === "카드사선택";
        
        if (nullFirstNum || nullSecondNum || nullThirdNum || nullLastNum || nullSvs || nullCdcard) {
			//카드사 alert
			$("#dh-modal-alert").addClass("active").fadeIn();
    		setTimeout(function() {
        		$("#dh-modal-alert").fadeOut(function(){
            		$(this).removeClass("active");
        		});
    		}, 1000);
        	$("#payBtn").attr('disabled', true);
        } 
    });
    
			$("#cardCheck").click(
			function() {
			$("#payBtn").attr('disabled', true);
				
			let firstNum = $("#firstNum").val();
			let secondNum = $("#secondNum").val();
			let thirdNum = $("#thirdNum").val();
			let lastNum = $("#lastNum").val();
			let svc = $("#svc").val();
			let cdcard = $("#cdcard").val();
			let cardNum = $("#firstNum").val() + $("#secondNum").val() + $("#thirdNum").val() + $("#lastNum").val();
			let notNum = /[^0-9]/g; //숫자아닌지 확인
			
			
		    if (firstNum == "" || secondNum=="" || thirdNum=="" || lastNum==""|| notNum.test(cardNum)) {
		        $("#cardInfo").text("카드번호를 모두 올바르게 입력해주세요.(특수문자x)");
		        $("#cardInfo").css("color", "red");
		        return false;
		     } else if(svc == "" || notNum.test(svc) || svc.length != 3) {
		         $("#cardInfo").text("svc를 올바르게 입력해주세요.(3자리)");
		         $("#cardInfo").css("color", "red");
		         return false;
		     } else if(cdcard == "카드사선택") {
		         $("#cardInfo").text("카드사를 선택해주세요.");
		         $("#cardInfo").css("color", "red");
		     } else {
				
				let cdnumber = $("#firstNum").val() + "-" + $("#secondNum").val() + "-" + $("#thirdNum").val() + "-" + $("#lastNum").val();
				let cdsvc = $("#svc").val();
				let cdcard = $("select[name='cdcard']").val();
				 $.ajax({
					 url : "/cardCheck/"+${sessionScope.mno}, //어디로 갈지
					type : "post", //타입
					data : {"cdnumber" : cdnumber, "cdsvc" : cdsvc, "cdcard": cdcard },
					dataType : "json", 
					success : function(data) {
						if (data.cardCheck.count == 1) {
							$("#cardInfo").text("카드 조회가 완료되었습니다.");
							$("#cardInfo").css("color", "green").css("font-weight", "bold").css("font-size","10pt")
							$("#cdbalance").val(data.cardCheck.cdbalance);
							$("#cdno").val(data.cardCheck.cdno);
							$('#payBtn').attr('disabled', false);
							
							let expectPay = parseFloat($("#expectPay").val()); 
							let myPoint = 0;
							let usePoint = parseFloat($("#usePoint").val());
							
							let totalPay = expectPay;
							let totalPoint = myPoint;
							
							let finalPay = expectPay - myPoint;
							
							$("#totalPay").val(totalPay.toString());
							$("#totalPoint").val(totalPoint.toString());
							$("#usePoint").val(myPoint.toString());
							$("#finalPay").val(finalPay.toString());
							
							$("#finalPay2").text(finalPay.toString());
							$("#totalPay2").text(totalPay.toString());
							$("#totalPoint2").text(totalPoint.toString());
							$("#finalPay3").text(finalPay.toString());

							
							let comma = document.getElementById('finalPay2');
							let comma2 = document.getElementById('totalPay2');
							let comma3 = document.getElementById('totalPoint2');
							let comma4 = document.getElementById('finalPay3');
							comma.textContent = new Intl.NumberFormat('en-US').format(finalPay) + ' 원';
							comma2.textContent = new Intl.NumberFormat('en-US').format(totalPay) + ' 원';
							comma3.textContent = new Intl.NumberFormat('en-US').format(totalPoint) + ' 포인트';
							comma4.textContent = new Intl.NumberFormat('en-US').format(finalPay) + ' 원';
							
							console.log(totalPay2, totalPoint2, finalPay3);
							
						} else {
							$("#cardInfo").text(
									"존재하지 않는 카드입니다. 다시 입력해주세요.");
							$("#cardInfo").css("color", "red").css(
									"font-weight", "bold").css("font-size",
									"10pt")
							$("#firstNum").focus();
							return false;
						}
					}, //success 끝 
					error : function(request, status, error) {
						$("#cardInfo").text("카드 조회 중 오류가 발생했습니다." + error);
						$("#cardInfo").css("color", "red").css("font-weight", "bold").css("font-size","10pt");
					}
				}); //ajax 끝 
			}
		}); //cardCheck 끝
	
	$("#usePoint").on("blur", function() {
		$("#pointInfo").text("");
		
		let expectPay = parseFloat($("#expectPay").val()); 
		let myPoint = parseFloat($("#myPoint").val());
		let usePoint = parseFloat($("#usePoint").val());
		let notNum = /[^0-9]/g;
		
	    if(notNum.test(usePoint)) {
	        $("#pointInfo").text("포인트를 입력해주세요.");
	        $("#pointInfo").css("color","red");
	        $("#payBtn").attr('disabled', true);
	        return false;
	    } else{
	    	$("#payBtn").attr('disabled', false);
	    }
		
		if(usePoint > myPoint) {
			$("#pointInfo").text("보유포인트보다 초과포인트를 입력할 수 없습니다.");
			$("#pointInfo").css("color", "red").css("font-weight", "bold").css("font-size","10pt");
			$("#usePoint").val("");
			$("#totalPay").val("");
			$("#totalPoint").val("");
			$("#finalPay").val("");
			
			$("#finalPay2").text("");
			$("#totalPay2").text("");
			$("#totalPoint2").text("");
			$("#finalPay3").text("");
			
			$("#usePoint").focus();
			$("#payBtn").attr('disabled', true);
			return false
		} else {
			$("#pointInfo").text("");
			let totalPay = expectPay;
			let totalPoint = usePoint;
			
			let finalPay = totalPay - totalPoint
			
			  $("#totalPay").val(totalPay.toString());
			  $("#totalPoint").val(totalPoint.toString());
			  $("#finalPay").val(finalPay.toString());
			  
			  $("#finalPay2").text(finalPay.toString());
			  $("#totalPay2").text(totalPay.toString());
			  $("#totalPoint2").text(totalPoint.toString());
		      $("#finalPay3").text(finalPay.toString());
			  
			  
			  
			  $("#payBtn").attr('disabled', false);
			  
			  let comma = document.getElementById('finalPay2');
			  let comma2 = document.getElementById('totalPay2');
			  let comma3 = document.getElementById('totalPoint2');
			  let comma4 = document.getElementById('finalPay3');
				comma.textContent = new Intl.NumberFormat('en-US').format(finalPay) + ' 원';
				comma2.textContent = new Intl.NumberFormat('en-US').format(totalPay) + ' 원';
				comma3.textContent = new Intl.NumberFormat('en-US').format(totalPoint) + ' 포인트';
				comma4.textContent = new Intl.NumberFormat('en-US').format(finalPay) + ' 원';
			  
			  
		}
				  
		
		});
 
			
	$("#useAllPoint").click(function(){
		$("#payBtn").attr('disabled', false);
		$("#pointInfo").text("");
		
		let expectPay = parseFloat($("#expectPay").val()); 
		let myPoint = parseFloat($("#myPoint").val());
		let usePoint = parseFloat($("#usePoint").val());
		
		let totalPay = expectPay;
		let totalPoint = myPoint;
		
		let finalPay = expectPay - myPoint;
		
		$("#totalPay").val(totalPay.toString());
		$("#totalPoint").val(totalPoint.toString());
		$("#usePoint").val(myPoint.toString());
		$("#finalPay").val(finalPay.toString());
		
		$("#finalPay2").text(finalPay.toString());
		$("#totalPay2").text(totalPay.toString());
		$("#totalPoint2").text(totalPoint.toString());
		$("#finalPay3").text(finalPay.toString());
		
		let comma = document.getElementById('finalPay2');
		let comma2 = document.getElementById('totalPay2');
		let comma3 = document.getElementById('totalPoint2');
		let comma4 = document.getElementById('finalPay3');
		comma.textContent = new Intl.NumberFormat('en-US').format(finalPay) + ' 원';
		comma2.textContent = new Intl.NumberFormat('en-US').format(totalPay) + ' 원';
		comma3.textContent = new Intl.NumberFormat('en-US').format(totalPoint) + ' 포인트';
		comma4.textContent = new Intl.NumberFormat('en-US').format(finalPay) + ' 원';
		
	}); //useAllPoint 끝
	
	$("#payBtn").click(function(){
		event.preventDefault(); //폼 전송 막기
		
		let cdnumber = $("#firstNum").val() + "-" + $("#secondNum").val() + "-" + $("#thirdNum").val() + "-" + $("#lastNum").val();
		let cdsvc = $("#svc").val();
		let cdcard = $("select[name='cdcard']").val();
		 $.ajax({
			url : "/cardCheck/"+${sessionScope.mno}, //어디로 갈지
			type : "post", //타입
			data : {"cdnumber" : cdnumber, "cdsvc" : cdsvc, "cdcard": cdcard },
			dataType : "json", 
			success : function(data) {
				if (data.cardCheck.count == 1) {
					$("#cardInfo").text("카드 조회가 완료되었습니다.");
					$("#cardInfo").css("color", "green").css("font-weight", "bold").css("font-size","10pt")
					$("#cdbalance").val(data.cardCheck.cdbalance);
					$("#cdno").val(data.cardCheck.cdno);
					$('#payBtn').attr('disabled', false);
					
				} else {
					$("#cardInfo").text(
							"존재하지 않는 카드입니다. 다시 입력해주세요.");
					$("#cardInfo").css("color", "red").css(
							"font-weight", "bold").css("font-size",
							"10pt")
					$("#firstNum").focus();
					return false;
				}
				
				let cdbalance = parseFloat($("#cdbalance").val()); 
				let finalPay = parseFloat($("#finalPay").val()); 
				
				if(finalPay > cdbalance) {
					$("#cardInfo").text("카드 결제 잔액이 부족합니다. 다른 카드를 선택해주세요.");
					$("#cardInfo").css("color", "red").css("font-weight", "bold").css("font-size","10pt");
					$("#totalPay").val("");
					$("#cdbalance").val("");
					$("#cdno").val("");
					$("#totalPoint").val("");
					$("#finalPay").val("");
					
					$("#finalPay2").text("");
					$("#totalPay2").text("");
					$("#totalPoint2").text("");
					$("#finalPay3").text("");
					
					
					$("#payBtn").attr('disabled', true);
					return false
				} else {
					$("#completePay").submit();
				}
			}, //success 끝 
			error : function(request, status, error) {
				$("#cardInfo").text("카드 조회 중 오류가 발생했습니다." + error);
				$("#cardInfo").css("color", "red").css("font-weight", "bold").css("font-size","10pt");
			}
		}); //ajax 끝 
	});
}); //function끝

</script>

</head>
<body>

	<header>
		<a href="/main"><i class="xi-angle-left xi-x"></i></a>
		<div class="headerTitle">결제하기</div>
		<div class="blank"></div>
	</header>
	
	<main>
	<div class="middle-area">
		<div class="title-span">
			<span class="title">결제 예정금액 : </span><span class="title"><fmt:formatNumber type="number" maxFractionDigits="3" value="${payMoney.tprice}"></fmt:formatNumber></span><span class="title"> 원</span><br>
		</div>
		<input type="hidden" id="expectPay" value="${payMoney.tprice}">
	</div>
	
	<div class="graySeperate"></div>
	
	<div class="middle-area">
		<p class="title">카드 조회하기</p>
		<div class="card-area">
		<p class="p-title">카드번호</p>
			<input type="text" id="firstNum" name="firstMrrn" maxlength="4" placeholder="1234"> -
			<input type="text" id="secondNum" name="secondNum" maxlength="4" placeholder="5678"> -
			<input type="password" id="thirdNum" name="thirdNum" maxlength="4" placeholder="1111"> -
			<input type="password" id="lastNum" name="lastNum" maxlength="4" placeholder="2222">
		</div>
	
		<p class="p-title">svc</p>
		<div class="card-area">
			<input type="text" id="svc" name="svc" placeholder="ex)123" maxlength="3" >
		</div>
	
		<p class="p-title">카드사</p>
		<div class="card-area">
			<select id="cdcard" name="cdcard">
				<option value="카드사선택">카드사선택</option>
				<option value="NH농협">NH농협</option>
				<option value="카카오">카카오</option>
				<option value="KB국민">KB국민</option>
				<option value="신한">신한</option>
				<option value="우리">우리</option>
				<option value="토스">토스</option>
				<option value="하나">하나</option>
			</select><button id="cardCheck">카드확인</button>
			<p id="cardInfo" class="info"></p>
		</div>
	</div>
	
	<div class="graySeperate"></div>
	
	<form action="/completePay/${sessionScope.mno}" method="post" id="completePay">
	<div class="middle-area">
		<p class="title">포인트 사용하기</p>
		<span>보유포인트 : </span><span>${myPoint.mpoint} 포인트</span><br>
		<input type="number" id="usePoint" value="0"><button type="button" id="useAllPoint">전액사용</button><br>
		<p id="pointInfo" class="info"></p>
		<input type="hidden" id="myPoint" value="${myPoint.mpoint}" name="myPoint">
		<input type="hidden" id="cdbalance" name="cdbalance">
		<input type="hidden" id="cdno" name="cdno">
		<input type="hidden" id="tno" name="tno" value="30">
	</div>
	
	<div class="graySeperate"></div>
	
	<div class="bottom-area">
		<div class="middle-area">
			<span class="title">결제 총 금액 : </span><span class="title" id="finalPay2"></span><br>
			<div class="calculate">
				<span class="pay-span" id="totalPay2"></span>&nbsp;&nbsp;-&nbsp;&nbsp;<span class="pay-span" id="totalPoint2"></span>&nbsp;&nbsp;=&nbsp;&nbsp;<span class="pay-span" id="finalPay3"></span><br>
			</div>
			<input type="hidden" id="totalPay" name="totalPay" readonly><input type="hidden" id="totalPoint" name="totalPoint" readonly><input type="hidden" id="finalPay" name="finalPay" readonly>
		</div>
	</div>
	
	<footer>
		<button id="payBtn" type="submit">결제하기</button>
	</footer>
	</form>
	</main>
	
					<!-- 알람모달 -->
	
	<div id="dh-modal-alert">
		<div class="dh-modal">
			<div class="dh-modal-content">
				<div class="dh-modal-title">
					<img class="dh-alert-img" src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
					알림
				</div>
				<div class="dh-modal-text">카드사를 먼저 조회해주세요.</div>
			</div>
		</div>
		<div class="dh-modal-blank"></div>
	</div>
	
	
</body>
</html>