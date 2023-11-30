<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<script src="../js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<script type="text/javascript">
	$(function() {
		let ncgoto = 0;
		let item = '';
		let container = document.getElementById('navigationContainer');
		
		
		 $(window).scroll(function() {
		        var scrollPosition = $(window).scrollTop();
		        var divPosition = $('main').offset().top-(8 * window.innerHeight / 100);

		        if (scrollPosition >= divPosition) {
		            $('header').css('background-color', 'white');
		            $('#notificationIcon').attr('src', './img/mainNotification.png');
		            $('#hamburgerIcon').attr('src', './img/mainHamburger.png');

		        } else {
		            $('header').css('background-color', 'transparent');
		            $('#notificationIcon').attr('src', './img/mainNotificationWhite.png');
		            $('#hamburgerIcon').attr('src', './img/mainHamburgerWhite.png');
		        }
		    });
		 
		

		 
		 $('#hamburgerIcon, .ham-close').click(function(){
			 $('.menuContainer').toggleClass('openMenu');
			 $('.menuSubContainer').toggle(250);
			 
		 })
		 
		 //enter눌러도 메세지 보내기
		$('#inputSearch').keyup(function(a) {
			if (a.keyCode === 13) {
				send();
			}
		});

		//버튼 눌러도 메세지 보내기
		$('.xi-search').click(function() {
			send();
		});
		
		//검색하기
		function send(){
			let inputValue =$('#inputSearch').val();
			let form = $('<form></form>');
			form.attr("action","./search");
			form.attr("method", "post");
			form.append($("<input>",{type:'hidden', name:"keyword", value:inputValue}));
			form.appendTo("body");
			form.submit();
		}
		
		//퀴즈 올리기
		$('#todayQuizAnswer>button').click(function() {
			 if(${sessionScope.mno == null || sessionScope.mno == ''}){
				 $('.dh-modal-wrapper').show();
			 }else{
				 if($(this).val() == ${quiz.qanswer}){
					 $('.dh-modal-text').html("정답입니다");
					 
					    $("#dh-modal-alert").addClass("active").fadeIn();
					    setTimeout(function() {
					        $("#dh-modal-alert").fadeOut(function(){
					            $(this).removeClass("active");
					        });
					   	 $('#doneTodayQuiz').show();
					    }, 1000);
					

				}else{
				 	$('.dh-modal-text').html("오답입니다.");
				 
				    $("#dh-modal-alert").addClass("active").fadeIn();
				    setTimeout(function() {
				        $("#dh-modal-alert").fadeOut(function(){
				            $(this).removeClass("active");
				        });
				        $('#doneTodayQuiz').show();
				    }, 1000);
				  
				}
			 }
		})
		
		//실시간채팅으로 가기
		 $('.chatting').click(function() { 
			 if(${sessionScope.mno == null || sessionScope.mno == ''}){
				 $('.dh-modal-wrapper').show();
			 }else{
		       location.href='./chatting'
			 }
		 });

		//네비게이션 열기
		 $('#navigationIcon, .mainTopChatBot').click(function() { 
			 if(${sessionScope.mno == null || sessionScope.mno == ''}){
				 $('.dh-modal-wrapper').show();
			 }else{
		        $('#navigationBackGround').toggleClass('max');
		        $('#introduction').toggle();
			 }
		 });
		
		
		//네비게이션
		$(document).on('click', '.choice', function() {
			ncgoto = $(this).siblings('.ncgoto').val();
			getQuestion(ncgoto);
			$(this).addClass('selectedChoice');
			$(this).attr('disabled', 'disabled');
			$(this).parent().siblings().find('button').addBack().attr('disabled', 'disabled');
		});

		$('#startNavigation').click(function() {
			$(this).attr('disabled', 'disabled');
			$(this).hide();
			$('#resetQuestions').show();
			getQuestion(1);
		})

		$('#resetQuestions').click(function() {
			$('#startNavigation').attr('disabled', false);
			$('#startNavigation').show();
			$('#resetQuestions').hide();
			item = '';
			$('#navigationContainer').empty();
		})

		function getQuestion(ncgoto) {
			$.ajax({
				url : "/getQuestion",
				type : "GET",
				data : {
					"ncgoto" : ncgoto
				},
				success : function(data) {

					let jsonData = JSON.parse(data);
					let question = jsonData.nextQuestion.nqquestion;
					let choices = jsonData.nextChoices;
					let hospitalList = jsonData.hospitalList;
					
					item = "<div class='qna'>";
					item += "<div class='question'>" + question + "</div>";

					if (ncgoto == 22) {
						item += "<div class='choices'>"
						item += "<button class='choice' onclick=\"location.href='../chatting'\">시작하기</button>"
					} else if (ncgoto >= 29 && ncgoto <= 40) {
						item += "<div class='choices'>"
						for (let i = 0; i < hospitalList.length; i++) {
							let hospital = hospitalList[i];
							if(hospital.reviewAverage == null || hospital.reviewAverage == ''){
								hospital.reviewAverage = '리뷰가 없습니다'
							}
								item += "<div class='hospitalWrapper'><div class='hospitalRank'>" + (i+1) + "</div>";
								item += "<div class='hospitalName'>" + hospital.hname;
							
								item += "<div class='hospitalRate'><i class='xi-star xi-x'></i>" + hospital.reviewAverage + "</div></div>";
	
								item += "<button class='goto' onclick=\"location.href='/hospitalDetail/" + hospital.hno + "'\"><i class='xi-angle-right xi-x'></i></button> </div>";

						}

					} else {
						item += "<div class='choices'>"
						for (let i = 0; i < choices.length; i++) {
							let choice = choices[i];
							item += "<div><button class='choice'>" + choice.ncchoice+ "</button>";
							item += "<input type='hidden' class='ncgoto' value=" + choice.ncgoto + "></div>";
						}
					}

					item += "</div></div>";
					$('#navigationContainer').append(item);
					container.scrollTop = container.scrollHeight;	
				}
			});
		}
		//알림창 열고 닫기
		$('#notificationIcon').click(function(){
			 $('#notificationContainer').toggle();
		});
		
		//알림차 숫자 줄이기
		$('.messageAlert').click(function(){
			let nno = $(this).children('.nno').val()
			
			 $.ajax({
			        url: "./updateNotificationNum",
			        type: "post", 
			        data: {"nno" : nno},
			        dataType: "json",
			        success: function(response) {
			            $("#result").text("서버 응답: " + response);
			        },
			        error: function(xhr, status, error) {
			            console.error("오류 발생: " + status, error);
			        }
			    });
			
		})
		
		/* 진료과별 모달 */
		$(document).on("click", ".selectByDepartment", function(){
			$(".symptomContainer").hide();
			$(".symptomModal").modal("show");
			$(".modalDepartment").addClass("modal-title-css");
		});
		
		/* 진료과 선택했을 때 */
		$(document).on("click", ".modalDepartment", function(){
			$(this).addClass("modal-title-css");
			$(".modalSymptom").removeClass("modal-title-css");
			$(".departmentGroup").show();
			$(".symptomContainer").hide();
		});
		
		/* 진료과 검색하기 */
		$(document).on("click", ".departmentKind", function(){
			let departmentKind = $(this).text();
			$('#inputSearch').val(departmentKind);
			send();
		});
		
		/* 증상 선택했을 때 */
		$(document).on("click", ".modalSymptom", function(){
			$(this).addClass("modal-title-css");
			$(".modalDepartment").removeClass("modal-title-css");
			$(".departmentGroup").hide();
			$(".symptomContainer").show();
		});
		
		/* 증상 그룹별로 보여주기 */
		let keywordClass = $(".symptomKindBox:first .symptomGroup").nextAll();
		toggleClass(keywordClass);
		$(document).on("click", ".symptomGroup", function(){
			let togglKeyword = $(this).siblings();
			toggleClass(togglKeyword);
		});
		
		/* 모달에서 증상별 토글 효과 */
		function toggleClass(keyword) {
			let otherKeyword = $(".symptomKindButton").not(keyword);
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
		
		/* 모달에서 증상별 토글 아이콘 변경 */
		function toggleIcon(keyword) {
			if (keyword.is(":visible")) {
		        let toggle = keyword.siblings().children(".xi-angle-up-thin");
		        keyword.siblings().children(".symptomGroupText").removeClass("font-css");
		        toggle.removeClass("xi-angle-up-thin").addClass("xi-angle-down-thin");
		    } else {
		    	let toggle = keyword.siblings().children(".xi-angle-down-thin");
		    	keyword.siblings().children(".symptomGroupText").addClass("font-css");
		    	toggle.removeClass("xi-angle-down-thin").addClass("xi-angle-up-thin");
		    }
		}
		
		/* 증상 검색하기 */
		$(document).on("click", ".symptomKind", function(){
			let symptomKind = $(this).text();
			$('#inputSearch').val(symptomKind)
			send();
		});
		
		function send(){
			let inputValue =$('#inputSearch').val();
			let form = $('<form></form>'); 
			form.attr("action","./search");
			form.attr("method", "post");
			form.append($("<input>",{type:'hidden', name:"keyword", value:inputValue}));
			form.appendTo("body");
			form.submit();
		}
		
				$(function() {
					/* 로그인 창 */
					 if(${sessionScope.mno == null || sessionScope.mno == ''}){
						$(".ham-menu").addClass("ham-noLogin");
					} else {
						$(".ham-menu").removeClass("ham-noLogin");
					}
				});
	});
	
	/* 로그인 확인 */
	function link(url) {
		 if(${sessionScope.mno == null || sessionScope.mno == ''}){
			$(".dh-modal-wrapper").show();
		} else {
			$(".dh-modal-wrapper").hide();
			location.href = "./" + url;
		}
	}

	function noCheckLink(url) {
		location.href = "./" + url;
	}
	
</script>
</head>
<body>
	<%@ include file="loginAlert.jsp"%>

	<%@ include file="menu.jsp"%>
	<%@ include file="loginAlert.jsp"%>

	<header>
		<div>
			<img id="logo" alt="로고" src="./img/DrHome_logo_text.png">
		</div>
		<div>
			<img id="notificationIcon" alt=""
				src="./img/mainNotificationWhite.png"> <img id="hamburgerIcon"
				alt="" src="./img/mainHamburgerWhite.png">
		</div>
	</header>


	<div class="swiper swiper1">
		<!-- Additional required wrapper -->
		<div class="swiper-wrapper">
			<!-- Slides -->
			<img class="swiper-slide" alt=""
				src="https://www.applovin.com/wp-content/uploads/2021/10/1440x810-in-app_advertising.jpeg">
			<img class="swiper-slide" alt=""
				src="https://www.applovin.com/wp-content/uploads/2022/07/1440x810_MAX_FB_Banner_ads-1440x810-1.jpg">
		</div>
	</div>


	</div>

	<div id="mainSearch">
		<i class="xi-search xi-x"></i> <input id="inputSearch"
			placeholder="질병, 진료과, 병원을 검색하세요">
	</div>

	<main>
		<div class="section" id="mainQuickSlot">
			<a class="mainTop" href="./hospital"> <img alt="병원사진"
				src="./img/mainHospital.png">
				<p>병원 예약</p>
			</a> <a class="mainTop" href="./telehealthSearch"> <img alt="비대면 사진"
				src="https://cdn2.iconfinder.com/data/icons/coronavirus-information/128/coronovirus_call_doctor_hospital-512.png">
				<p>비대면 진료</p>
			</a> <a class="mainTop mainTopChatBot"> <img alt="챗봇"
				src="./img/mainChatbot.png">
				<p>챗봇</p>
			</a> <a class="mainTop" href="./qnaBoard"> <img alt="커뮤니티"
				src="https://cdn0.iconfinder.com/data/icons/business-startup-10/50/61-512.png">
				<p>커뮤니티</p>
			</a>
		</div>

		<div class="graySeperate"></div>

		<!-- 진료과별 -->
		<div class="section" id="selectDepartment">
			<div class="mainTitle selectByDepartment">
				진료과별 <i class="xi-angle-right xi-x"></i>
			</div>
			<div id="departmentWrapper">
				<a id="dp1" href="./hospital?kindKeyword=소아과"> <img alt="소아과"
					src="./img/dp1.png"> <span>소아과</span>
				</a> <a id="dp2" href="./hospital?kindKeyword=치과"> <img alt="이비인후과"
					src="./img/dp2.png"> <span>치과</span>
				</a> <a id="dp3" href="./hospital?kindKeyword=내과"> <img alt="내과"
					src="./img/dp3.png"> <span>내과</span>
				</a> <a id="dp4" href="./hospital?kindKeyword=이비인후과"> <img
					alt="이비인후과" src="./img/dp4.png"> <span>이비인후과</span>
				</a>
			</div>
		</div>

		<div id="mapMedicine">
			<a href="./pharmacyMap"> <img alt="주변약국"
				src="./img/mapmedicine.png">
				<div>
					<span>내주변 약국 찾기</span>
					<p>지도에서 내 주변 약국을 확인해보세요</p>
				</div> <i class="xi-angle-right xi-x"></i>
			</a>
		</div>

		<div class="graySeperate"></div>

		<div class="section" id="todayQuiz">
			<div class="mainTitle">
				오늘의 퀴즈 <span>${quiz.ptno }P</span>
			</div>
			<div id="todayQuizQuestion">${quiz.qquestion }</div>
			<div id="todayQuizAnswer">
				<button value="0">
					<img alt="" src="./img/mainCheck.png"> 그렇다
				</button>
				<button value="1">
					<img alt="" src="./img/mainCancel.png">아니다
				</button>
			</div>
			<!-- 오늘 푼 퀴즈 -->
			<div id="doneTodayQuiz" style="display: none;">오늘은 이미 퀴즈를
				완료하였습니다</div>
		</div>





		<div class="graySeperate"></div>

		<div class="section" id="newQnaContainer">
			<div class="mainTitle">새로운 질문</div>
			<div class="swiper swiper2">
				<div class="swiper-wrapper qna-wrapper">
					<c:forEach var="qna" items="${newQna }">
						<div class="swiper-slide qna-slide">
							<img alt="" src="./img/dp${qna.dpno }.png">
							<div class="wrapper">
								<a href="./qnaDetail?bno=${qna.bno }">
									<div class="qnaTitle">${qna.btitle }</div>
									<div class="qnaContent">${qna.bcontent }</div>
								</a>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<a href="./qnaBoard"><div id="goToBoard">전체 질문 보기</div></a>
		</div>



		<div class="graySeperate"></div>


		<div class="section" id="chattingContainer">
			<div class="mainTitle">실시간 채팅</div>

			<div id="navigation">
				<img alt="챗봇사진2" src="./img/sectionChatbot.png">
				<div>
					<span><strong style="color: #00c9ff; font-size: 18px;">네비게이션</strong>을<br>
						통해 빠르게 검색해보세요</span><br> <a class="mainTopChatBot">지금 검색하러가기 <i
						class="xi-angle-right xi-x"></i></a>
				</div>

			</div>
			<div id="livechat">
				<div>
					<span><strong style="color: #00c9ff; font-size: 18px;">실시간
							채팅</strong>을<br> 사용해서 궁굼증을 해결해보세요</span><br> <a class="chatting"><i
						class="xi-angle-left xi-x"></i> 지금 검색하러가기</i> </a>
				</div>
				<img alt="실시간 상담" src="./img/sectionLivechat.png">

			</div>

		</div>
		<div class="graySeperate"></div>
		<div style="height: 11vh; width: 100%;"></div>



		<!-- 네비게이션 -->
		<div id="navigationBackGround">
			<div id="introduction" style="display: none">
				<div id="navigationHeader">
					<span>DR.HOME</span>
					<div id="startNavigation">시작</div>
					<div id="resetQuestions" style="display: none;">
						<img alt="초기화" src="./img/mainReset.png">
					</div>
				</div>
				<div id="navigationContainer"></div>
			</div>
		</div>
		<img id="navigationIcon" alt="" src="./img/mainChatbotIcon.png">



		<!-- 알람 -->
		<div id="notificationContainer">
			<div class="triangle"></div>
			<div id="notificationTitle">알림</div>
			<div id="notificationContent">
				<c:forEach var="noti" items="${notification }">
					<div class="notiItems ${noti.nread eq 0 ? 'blue' : ''}">
						<c:choose>

							<c:when test="${noti.nchattingNoti ne null }">
								<a class="messageAlert" href="./chatting"><div
										class="message">${noti.nchattingNoti }님이메세지를요청합니다.</div>
									<div class="notiDate">${noti.ndate }</div> <input class="nno"
									type="hidden" name="nno" value="${noti.nno }"> </a>
							</c:when>

							<c:when test="${noti.nqnaboardNoti ne null }">
								<a class="messageAlert"
									href="./qnaDetail?bno=${noti.nqnaboardNoti }"><div
										class="message">질문 게시글에 댓글이 달렸습니다.</div>
									<div class="notiDate">${noti.ndate }</div> <input class="nno"
									type="hidden" name="nno" value="${noti.nno }"> </a>
							</c:when>
							<c:when test="${noti.nfreeboardNoti ne null }">
								<a class="messageAlert"
									href="./freeDetail?bno=${noti.nfreeboardNoti }"><div
										class="message">자유계시판 게시글에 댓글이 달렸습니다.</div>
									<div class="notiDate">${noti.ndate }</div> <input class="nno"
									type="hidden" name="nno" value="${noti.nno }"></a>
							</c:when>

							<c:when test="${noti.nappointmentNoti ne null }">
								<a class="messageAlert"
									href="./medicalHistory/${sessionScope.mno }">
									<div class="message">진료예약이 완료되었습니다.</div>
									<div class="notiDate">${noti.ndate }</div> <input class="nno"
									type="hidden" name="nno" value="${noti.nno }">
								</a>
							</c:when>

							<c:when test="${noti.ntelehealthNoti ne null }">
								<a class="messageAlert"
									href="./medicalHistory/${sessionScope.mno }"><div>비대면
										진료가 완료되었습니다</div>
									<div class="notiDate">${noti.ndate }</div> <input class="nno"
									type="hidden" name="nno" value="${noti.nno }"> </a>
							</c:when>
						</c:choose>

					</div>
					<div class="seperate"></div>
				</c:forEach>
			</div>
		</div>


		<!-- 알림 갯수 -->
		<c:if
			test="${not empty countNotification and countNotification.countNoti ne 0}">
			<div id="countNotification">${countNotification.countNoti}</div>
		</c:if>

		<!-- 경고창 알람 -->
		<div id="dh-modal-alert">
			<div class="dh-modal">
				<div class="dh-modal-content">
					<div class="dh-modal-title">
						<img class="dh-alert-img"
							src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
						알림
					</div>
					<div class="dh-modal-text">문구를 넣어주세요.</div>
				</div>
			</div>
			<div class="dh-modal-blank"></div>
		</div>

		<!-- 메뉴 슬라이드 -->



	</main>







	<footer>
		<a class="footer20" href="./main">
			<div class="footerIcon now">
				<img alt="없음" src="/img/mainHomeafter.png">
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

	<!-- 진료과/증상 모달 -->
	<div class="modal fade symptomModal" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- 모달 헤더 -->
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">
						<button type="button" class="modalDepartment">진료과</button>
						<button type="button" class="modalSymptom">증상·질환</button>
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<!-- 모달 바디 -->
				<div class="modal-body">
					<!-- 진료과 -->
					<div class="departmentGroup">
						<button class="departmentKind">전체</button>
						<c:forEach items="${departmentKeyword}" var="row">
							<button class="departmentKind">${row.dpkind}</button>
						</c:forEach>
					</div>
					<!-- 증상 -->
					<div class="symptomContainer">
						<c:forEach items="${departmentKeyword}" var="row">
							<div class="symptomKindBox">
								<div class="symptomGroup">
									<div class="symptomGroupText">${row.dpsymptom}</div>
									<div class="xi-angle-down-thin"></div>
								</div>
								<div class="symptomKindButton">
									<c:set var="keywords" value="${row.dpkeyword.split(',')}" />
									<c:forEach var="keyword" items="${keywords}">
										<button class="symptomKind">${keyword}</button>
									</c:forEach>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		//스와이퍼 시작
		const swiper1 = new Swiper('.swiper1', {
			// Optional parameters
			direction : 'horizontal',
			loop : true,
			autoplay : {
				delay : 2000, // 3초마다 변경
			},
		});

		const swiper2 = new Swiper('.swiper2', {
			slidesPerView : '3',
			direction : 'vertical',
			loop : true,
			autoplay : {
				delay : 2000, // 3초마다 변경
			},
	
		});
		

	</script>

	<!-- Bootstrap core JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>