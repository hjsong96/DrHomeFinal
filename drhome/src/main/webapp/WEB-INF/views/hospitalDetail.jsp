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
<title>Insert title here</title>
<link rel="stylesheet" href="../css/hospitalDetail.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script src="../js/jquery-3.7.0.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5e6035c5b6dc0c23f98779b6f6fded6d&libraries=services"></script>
<script src="/js/wnInterface.js"></script>
<script src="/js/mcore.min.js"></script>
<script src="/js/mcore.extends.js"></script>

<script type="text/javascript">

$(function() {
		let hospitalname = $('.hospitalName').text()
		let openTime = timeToNumber($('.openTime').text());
		let closeTime = timeToNumber($('.closeTime').text());
		let nowTime = timeToNumber($('#nowTime').val());
		let sortValue;
		let currentReview = 0; 
		let maxReview = 5;
		let reviwer;
        let today = new Date();
        let options = { year: 'numeric', month: '2-digit', day: '2-digit' };
        let todayDate = today.toISOString().split('T')[0]; // '2022-06-09T09:15:50.162Z'

		let verygood = parseInt(${reviewCount.veryGood});
		let good = parseInt(${reviewCount.good});
		let normal = parseInt(${reviewCount.normal});
		let bad = parseInt(${reviewCount.bad});
		let verybad = parseInt(${reviewCount.veryBad});

		let maxCount = Math.max(verygood, good, normal, bad, verybad);

		displayBar(document.getElementById('verygood-bar'), (verygood / maxCount) * 100);
		displayBar(document.getElementById('good-bar'), (good / maxCount) * 100);
		displayBar(document.getElementById('normal-bar'), (normal / maxCount) * 100);
		displayBar(document.getElementById('bad-bar'), (bad / maxCount) * 100);
		displayBar(document.getElementById('verybad-bar'), (verybad / maxCount) * 100);

		sortReview(1)

		
			//모피어스 콜
		document.getElementById("hospitalNum").addEventListener("click", function() {
		  let phoneNumber = $(this).val();
		  M.sys.call(phoneNumber);
		});
		
        $('#share').click(function() {
            let hname = $(this).val();
            copyToClipboard(hname);
            
		    $("#dh-modal-alert").addClass("active").fadeIn();
		    setTimeout(function() {
		        $("#dh-modal-alert").fadeOut(function(){
		            $(this).removeClass("active");
		        });
		    }, 1000);
        });
        
        function copyToClipboard(text) {
            let textarea = document.createElement('textarea');
            textarea.value = text;
            textarea.style.position = 'fixed';
            textarea.style.opacity = 0;
            document.body.appendChild(textarea);
            textarea.select();
            document.execCommand('copy');
            document.body.removeChild(textarea);
        }


		//진료 여부 보여주기
		if (($('.openTime').text() == '') || ($('.closeTime').text() == '')) {
			$('#todayHours').html('휴진')
		} else {
			$('#todayHours').html(
					$('.openTime').text() + " ~ " + $('.closeTime').text())

		}
		
		


		//서브메뉴 고정시키기
		let offsetSubMenu = $(".subMenu").offset().top;
		
		//특정 div 위치에 도달시 서브 메뉴 바꾸기
		let offsetMedical = $(".medicalInfo").offset().top - (18 * window.innerHeight / 100);
		let offsetHospital = $(".hospitalInfo").offset().top - (18 * window.innerHeight / 100);
		let offsetDoctor = $(".doctorInfo").offset().top - (18 * window.innerHeight / 100);
		let offsetReview = $(".reviewContainer").offset().top - (18 * window.innerHeight / 100);
		
		$(window).scroll(function() {
		    let scrollPos = $(window).scrollTop();
			//고정
		    if (scrollPos >= offsetSubMenu - (7 * window.innerHeight / 100)) {
		    	 $(".subMenu").addClass("fixed");
		        $('#placeHolderDiv').show();
		    } else {
		    	 $(".subMenu").removeClass("fixed");
		        $('#placeHolderDiv').hide();
		    }
			
			//하이라이트
		    if (scrollPos >= offsetMedical && scrollPos < offsetHospital) {
		        $('#subMenu1').addClass('selectedSubMenu').siblings().removeClass('selectedSubMenu');
		    }
		    if (scrollPos >= offsetHospital && scrollPos < offsetDoctor) {
		        $('#subMenu2').addClass('selectedSubMenu').siblings().removeClass('selectedSubMenu');
		    }
		    if (scrollPos >= offsetDoctor) {
		        $('#subMenu3').addClass('selectedSubMenu').siblings().removeClass('selectedSubMenu');

		    } 
		    if(scrollPos >= offsetReview) {
		    	$('#subMenu4').addClass('selectedSubMenu').siblings().removeClass('selectedSubMenu');	
		    	
		
		    } 
		});

		
		// 서브 메뉴 클릭시 보내기
		$('.subMenu>ul>li').click(function() {
		    let offset;
		    
		    if ($(this).text() == '진료정보') {
		        offset = $(".medicalInfo").offset().top - (15 * window.innerHeight / 100);
		    } else if ($(this).text() == '병원정보') {
		        offset = $(".hospitalInfo").offset().top - (15 * window.innerHeight / 100);
		    } else if ($(this).text() == '의사정보') {
		        offset = $(".doctorInfo").offset().top - (15 * window.innerHeight / 100);
		    } else {
		        offset = $(".reviewContainer").offset().top - (15 * window.innerHeight / 100);
		    }

		    $("html, body").animate({
		        scrollTop: offset
		    }, 450);
		});
		
		
		//리뷰 작성
		$('#writeReview').click(function(){
			if(${sessionScope.mno == null || sessionScope.mno == ''}){
				 $('.dh-modal-wrapper').show();
			} else{
				location.href='../writeReview?mno=${sessionScope.mno}&hno=${hospital.hno}';
			}
		});

		

		//찜하기
		$(document).on("click", ".xi-heart, .xi-heart-o", function() {
			
			if(${sessionScope.mno == null || sessionScope.mno == ''}){
				 $('.dh-modal-wrapper').show();
			}else{
				if ($(this).hasClass("xi-heart")) {
					$(this).parent().html('<i class="xi-heart-o xi-x"></i>');
					$.ajax({
						type : "POST",
						url : "../unlike",
						data : {
							hospitalname : hospitalname
						}
					});
	
				} else {
					$(this).parent().html('<i class="xi-heart xi-x"></i>');
					$.ajax({
						type : "POST",
						url : "../like",
						data : {
							hospitalname : hospitalname
						}
					});
				}
			}
		});
		 
		

		//진료 가능 여부
		if (nowTime > openTime && nowTime < closeTime) {
			$('#available').show()
		} else {
			$('#unavailable').show()
			$('.appointmentTodayButton').addClass('unavailable');
			$('.appointmentTodayButton').prop('disabled', true);
		}
		
		//정렬기준
		$("#sort1").click(function() {
			$(this).addClass('selectedSort').siblings().removeClass('selectedSort')
			sortValue = $(this).val();
			sortReview(sortValue);
			
		});
		$("#sort2").click(function() {
			$(this).addClass('selectedSort').siblings().removeClass('selectedSort')
			sortValue = $(this).val();
			sortReview(sortValue);
		});
		$("#sort3").click(function() {
			$(this).addClass('selectedSort').siblings().removeClass('selectedSort')
			sortValue = $(this).val();
			sortReview(sortValue);
		});
		$("#sort4").click(function() {
			$(this).addClass('selectedSort').siblings().removeClass('selectedSort')
			sortValue = $(this).val();
			sortReview(sortValue);
		});

	
		
	//시간 숫자로
	function timeToNumber(time) {
		let parts = time.split(":");
		return parseInt(parts[0] + parts[1]);
	}
	

	//그래프로 보여주기
	function displayBar(barElement, targetValue) {
	    barElement.style.width = targetValue + '%';
	}
		 
	 
	 
	// 정렬 메소드
	function sortReview(sortValue) {
	    $.ajax({
	        url: "/sort/" + ${hospital.hno},
	        type: "GET",
	        data: {"sortValue": sortValue},
	        success: function (data) {
	            let newData = JSON.parse(data);

	            if (currentReview === 0) {
	                $("#reviewListContainer").empty();
	            }


	            for (let i = currentReview; i < maxReview && i < newData.review.length; i++) {
	            	//형식변환
	                let n = newData.review[i];
	                let rateInt = n.rrate;

	                let item = "<div class='reviewList'>";
	                item += "<div class='reviewRate'>";
	                
	              //채워진 스타
	                for (let i = 1; i <= rateInt; i++) {
	                    item += "<i class='star xi-star xi-x'></i>";
	                }
					//빈 스타
	                for (let j = 1; j <= 5 - rateInt; j++) {
	                    item += "<i class='star xi-star-o xi-x'></i>";
	                } 
	                
	                item += "<span class='rateInt'>" + rateInt + ".0</span>"
	                item += "</div>";
	                item += "<div class='reviewKeyword'>";
					
	                //키워드 넣기
	                let keywords = n.rkeyword.split(',');
	                for (let k = 0; k < keywords.length; k++) {
	                    item += "<div class='keyword'># " + keywords[k] + "</div>";
	                }
	                //content넣기
	                item += "</div>";
	                item += "<div class='reviewContent'>" + n.rcontent + "</div>";
	                
	                let reviewDate = new Date(n.rdate);
	                
	                //오늘 쓴 날짜면 시간만 / 아니면 날짜만
					if(today.toDateString() == reviewDate.toDateString()){
						item += "<div class='botwrap'><div class='reviewbottom'><div class='reviewDate'>" + n.rdate.substring(11,16) + "</div>";
					}else{
						 item += "<div class='botwrap'><div class='reviewbottom'><div class='reviewDate'>" + todayDate + "</div>";
					}
	             
	                item += "<div class='reviewer'> &nbsp &nbsp" + n.mname + "</div></div>";
	                item += "<div class='reviewLike'><img src='../img/thumbs_up.png' style='width: 18px'>&nbsp&nbsp"+n.rlike +" 개</div></div>";
	                
	                item += "<input class='rno' type='hidden' value='"+ n.rno +"'>"
	                item += "<input class='sortValue' type='hidden' value='"+ sortValue +"'</div>"
					item += "</div><div class='reviewGrayLine'>"
	            $('#reviewListContainer').append(item);
	            }
	            // 보여질게 있으면 버튼 생성
	            if (maxReview < newData.review.length) {
	                
	                $('#reviewListContainer').append("<button id='moreReview'>더보기</button>");

	                //클릭 maxreview +5
	                $('#moreReview').one('click', function () {
	                    maxReview += 5;
	                    sortReview(sortValue);
	                });
	            }
	        }
	    });
	}
	
	
	
		//리뷰 좋아요
		$(document).on("click", ".reviewLike", function() {
			if(${sessionScope.mno == null || sessionScope.mno == ''}){
				 $('.dh-modal-wrapper').show();
			} else{
			
			reviewer =  $(this).parent().siblings(".rno").val()
			let sortnum = $(this).parent().siblings(".sortValue").val()
			   $.ajax({
		        url: "/countReviewLike",
		        type: "POST",
		        data: {"reviewer" :reviewer },
		        success: function (data) {
		        	
		        	sortReview(sortnum);
		        	
		        }
		     
			   });		
			}
		});
		
	
		//예약하기
		$('.appointmentButton').click(function(){
			if(${sessionScope.mno == null || sessionScope.mno == ''}){
				 $('.dh-modal-wrapper').show();
			}else{
				location.href='../appointment/'+${hno};
			}
		});
		
		//진료하기
		$('.appointmentTodayButton').click(function(){
			if(${sessionScope.mno == null || sessionScope.mno == ''}){
				 $('.dh-modal-wrapper').show();
			}else{
				location.href='../appointmentToday/'+${hno};
			}
		});
	});
			



</script>


</head>
<body>
	<%@ include file="loginAlert.jsp"%>

	<header>
		<a href="../hospital"><i class="xi-angle-left xi-x"></i></a>

		<div class="headerTitle">${hospital.hname }</div>

		<div id="hospitalLike">
			<c:set var="found" value="false" />
			<c:forEach var="hospitalLike" items="${sessionScope.mhospitallike}">
				<c:if test="${hospitalLike == hospital.hname}">
					<div class="like" style="color: red">
						<i class="xi-heart xi-x"></i>
					</div>
					<c:set var="found" value="true" />
				</c:if>
			</c:forEach>
			<c:if test="${not found}">
				<div class="notlike" style="color: red">
					<i class="xi-heart-o xi-x"></i>
				</div>
			</c:if>
		</div>

	</header>



	<main>
		<div class="imageContainer">
			<!-- 스오이퍼 -->
			<div class="swiper">
				<!-- Additional required wrapper -->
				<div class="swiper-wrapper">
					<!-- Slides -->
					<c:forEach var="img" items="${hospital.himg.split(',') }">
						<img class="swiper-slide" alt="" src="${img }">
					</c:forEach>
				</div>
			</div>
		</div>


		<div class="departmentList">
			<span> ${hospital.hospitalDepartments.replace(',', ' · ')}</span>
		</div>

		<div class="hospitalName">${hospital.hname }</div>


		<div class="wrapper">
			<div class="status">
				<input type="hidden" id="nowTime" value="${now.time }">
				<div id="available" style="display: none;">
					<span class="availableCircle">● </span> 진료중
				</div>
				<div id="unavailable" style="display: none;">
					<span class="unavailableCircle">● </span> 진료종료
				</div>
			</div>

			<div class="consulationHours">
				<span>오늘&nbsp</span>
				<c:if
					test="${!(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && now.dayOfWeek != hospital.hnightday}">
					<span class="openTime">${hospital.hopentime }</span> ~
			<span class="closeTime">${hospital.hclosetime }</span>
				</c:if>

				<c:if test="${now.dayOfWeek == hospital.hnightday}">
					<span class="openTime">${hospital.hopentime }</span> ~ 
			<span class="closeTime">${hospital.hnightendtime }</span>
				</c:if>

				<c:if
					test="${(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && hospital.hholiday !=0}">
					<span class="openTime">${hospital.hopentime }</span> ~
			<span class="closeTime">${hospital.hholidayendtime }</span>
				</c:if>

				<c:if
					test="${(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && hospital.hholiday ==0}">
					<span>휴진</span>
				</c:if>
			</div>
		</div>

		<div class="call">
			<button id="hospitalNum" value="${hospital.htelnumber }">
				<!-- 모피어스 활용하기 -->
				<i class="xi-call xi-x"></i>전화하기
			</button>
			<button id="share" value="${hospital.hname }">
				<i class="xi-share-alt xi-x"></i>공유하기
			</button>
		</div>

		<div class="graySeperate"></div>

		<div class="subMenu">
			<ul>
				<li class="selectedSubMenu" id="subMenu1">진료정보</li>
				<li id="subMenu2">병원정보</li>
				<li id="subMenu3">의사정보</li>
				<li id="subMenu4">리뷰</li>
			</ul>
		</div>

		<div id="placeHolderDiv" style="height: 7vh; display: none;"></div>


		<div class="section medicalInfo">

			<div class="hospitalTitle">진료시간</div>

			<div class="todayInfo">
				<div class="today todayTimeInfo">
					<div class="dayTitle">오늘</div>
					<span id="todayHours"></span>
				</div>

				<div class="today todayBreakInfo">
					<div class="dayTitle">점심시간</div>
					<span id="todayBreak"> <c:if
							test="${(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && hospital.hholiday ==0}">
						휴진
					</c:if> <c:if
							test="${(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && hospital.hholiday ==1}">
						없음
					</c:if> <c:if
							test="${now.dayOfWeek == '월요일' || now.dayOfWeek == '화요일' || now.dayOfWeek == '수요일' || now.dayOfWeek == '목요일' || now.dayOfWeek == '금요일'}">
				${hospital.hbreaktime } ~ ${hospital.hbreakendtime }
					</c:if>
					</span>
				</div>
			</div>

			<div class="timeInfo">
				<div class="day monday">
					<c:choose>
						<c:when test="${hospital.hnightday == '월요일'}">
							<div class="dayTitle">월요일 (야간)</div> ${hospital.hopentime } ~ ${hospital.hnightendtime }
					</c:when>
						<c:otherwise>
							<div class="dayTitle">월요일</div> ${hospital.hopentime } ~ ${hospital.hclosetime }
					</c:otherwise>
					</c:choose>
				</div>
				<div class="day tuesday">
					<c:choose>
						<c:when test="${hospital.hnightday == '화요일'}">
							<div class="dayTitle">화요일 (야간)</div> ${hospital.hopentime } ~ ${hospital.hnightendtime }
					</c:when>
						<c:otherwise>
							<div class="dayTitle">화요일</div> ${hospital.hopentime } ~ ${hospital.hclosetime }
					</c:otherwise>
					</c:choose>
				</div>
				<div class="day wednesday">
					<c:choose>
						<c:when test="${hospital.hnightday == '수요일'}">
							<div class="dayTitle">수요일 (야간)</div>${hospital.hopentime } ~ ${hospital.hnightendtime }
					</c:when>
						<c:otherwise>
							<div class="dayTitle">수요일</div> ${hospital.hopentime } ~ ${hospital.hclosetime }
					</c:otherwise>
					</c:choose>
				</div>
				<div class="day thursday">
					<c:choose>
						<c:when test="${hospital.hnightday == '목요일'}">
							<div class="dayTitle">목요일 (야간)</div> ${hospital.hopentime } ~ ${hospital.hnightendtime }
					</c:when>
						<c:otherwise>
							<div class="dayTitle">목요일</div> ${hospital.hopentime } ~ ${hospital.hclosetime }
					</c:otherwise>
					</c:choose>
				</div>
				<div class="day friday">
					<c:choose>
						<c:when test="${hospital.hnightday == '금요일'}">
							<div class="dayTitle">금요일 (야간)</div> ${hospital.hopentime } ~ ${hospital.hnightendtime }
					</c:when>
						<c:otherwise>
							<div class="dayTitle">금요일</div> ${hospital.hopentime } ~ ${hospital.hclosetime }
					</c:otherwise>
					</c:choose>
				</div>
				<div class="day saturday">
					<c:choose>
						<c:when test="${hospital.hholiday == 1}">
							<div class="dayTitle">토요일</div> ${hospital.hopentime } ~ ${hospital.hholidayendtime }
					</c:when>
						<c:otherwise>
							<div class="dayTitle">토요일</div> 휴진
					</c:otherwise>
					</c:choose>
				</div>
				<div class="day sunday">
					<c:choose>
						<c:when test="${hospital.hholiday == 1}">
							<div class="dayTitle">일요일</div> ${hospital.hopentime } ~ ${hospital.hholidayendtime }
					</c:when>
						<c:otherwise>
							<div class="dayTitle">일요일</div> 휴진
					</c:otherwise>
					</c:choose>
				</div>

				<div class="day holiday">
					<c:choose>
						<c:when test="${hospital.hholiday == 1}">
							<div class="dayTitle">공휴일</div> ${hospital.hopentime } ~ ${hospital.hholidayendtime }
					</c:when>
						<c:otherwise>
							<div class="dayTitle">공휴일</div> 휴진
					</c:otherwise>
					</c:choose>
				</div>
				<div class="day weekendBreakTime">
					<div class="dayTitle">주말 점심시간</div>
					없음
				</div>

				<div class="day breaktime">
					<div class="dayTitle">평일 점심시간</div>
					${hospital.hbreaktime } ~ ${hospital.hbreakendtime }
				</div>
			</div>

		</div>
		<div class="graySeperate"></div>



		<div class="section department">
			<div class="hospitalTitle">
				진료 과목
				<p id="countDepartment">총
					${fn:length(hospital.hospitalDepartments.split(','))}개</p>
			</div>

			<div class="departments">
				<c:forEach var="department"
					items="${hospital.hospitalDepartments.split(',')}">
					<div>${department }</div>
				</c:forEach>
			</div>


			<div class="symptomKeywords">
				<c:forEach var="keyword"
					items="${hospital.symptomKeywords.split(',')}" varStatus="loop">
					<c:if test="${loop.index < 10}">
						<div>#${keyword}</div>
					</c:if>
				</c:forEach>
			</div>


		</div>

		<div class="graySeperate"></div>

		<div class="section hospitalInfo">
			<div class="hospitalIntro">
				<div class="hospitalTitle">병원 소개</div>
				<div class="infoContent">${hospital.hinfo }</div>
			</div>
		</div>

		<div class="graySeperate"></div>

		<div class="section hospitalLocation">
			<div class="hospitalTitle">위치</div>
			<div class="mapAddr">
				${hospital.haddr } <input type="hidden" id="hosptialAddr"
					value="${hospital.haddr }">
				<div id="map"></div>
			</div>
		</div>


		<div class="graySeperate"></div>

		<div class="section doctorInfo">
			<div class="hospitalTitle">
				의사 정보
				<p id='countDoctorList'>총 ${fn:length(doctorList)}명</p>
			</div>
			<c:forEach var="doctorList" items="${doctorList}">
				<div class="doctorDetail">
					<div class="doctorImg">
						<img alt="의사사진" src="${doctorList.dimg }">
						<div class="doctorName">${doctorList.dname }
							의사
							<p>${doctorList.dpkind }</p>
							<c:if test="${doctorList.dspecialist ==1  }">
								<span>전문의</span>
							</c:if>
							<c:if test="${doctorList.dgender ==1  }">
								<span>여의사</span>
							</c:if>
						</div>
					</div>
					<i class="xi-angle-right xi-x"
						onclick="location.href='../doctorDetail/'+${doctorList.dno}">
					</i>
				</div>
			</c:forEach>

		</div>

		<div class="graySeperate"></div>

		<div class="section reviewContainer">
			<div class="hospitalTitle">
				리뷰 <span id="countReview"> ${fn:length(reviewList)}</span>
			</div>

			<c:if test="${reviewList == null || reviewList.isEmpty() }">
				<div id="noReview">리뷰가 없어요. 리뷰를 작성해주세요.</div>
			</c:if>
			<div class="reviewHeader">
				<div class="averageHospitalRate">
					<div id="averageNum">
						<c:choose>
							<c:when test="${reviewList != null && !reviewList.isEmpty() }"> 
							${averageHospitalRate }
							</c:when>
							<c:otherwise>0.0</c:otherwise>
						</c:choose>
					</div>
					<div id="averageStar">
						<c:set var="averageInt"
							value="${fn:substringBefore(averageHospitalRate, '.')}" />
						<c:forEach var="i" begin="1" end="${averageInt }">
							<i class="star xi-star xi-x"></i>
						</c:forEach>
						<c:forEach var="i" begin="1" end="${5 - averageInt }">
							<i class="star xi-star-o xi-x"></i>
						</c:forEach>
					</div>
				</div>


				<div class="bar-container">
					<div class="count-container">
						<span>매우 만족</span>
						<div class="count-star" id="verygood-container">
							<div class="bar" id="verygood-bar"></div>
						</div>
					</div>

					<div class="count-container">
						<span>만족</span>
						<div class="count-star" id="good-container">
							<div class="bar" id="good-bar"></div>
						</div>
					</div>
					<div class="count-container">
						<span>보통</span>
						<div class="count-star" id="normal-container">
							<div class="bar" id="normal-bar"></div>
						</div>
					</div>
					<div class="count-container">
						<span>불만족</span>
						<div class="count-star" id="bad-container">
							<div class="bar" id="bad-bar"></div>
						</div>
					</div>
					<div class="count-container">
						<span>매우 불만족</span>
						<div class="count-star" id="verybad-container">
							<div class="bar" id="verybad-bar"></div>
						</div>
					</div>
				</div>
			</div>

			<div id="writeReview"">리뷰 작성</div>

			<div class="graySeperate"></div>






			<div class="sort">
				<c:if test="${reviewList != null && !reviewList.isEmpty() }">
					<button class="selectedSort" id="sort1" value="1">최신순</button>
					<button id="sort2" value="2">오래된순</button>
					<button id="sort3" value="3">별점높은순</button>
					<button id="sort4" value="4">별점낮은순</button>
				</c:if>
			</div>
			<div class="grayLine"></div>



			<div id="reviewListContainer"></div>



		</div>


		<div style="height: 7vh"></div>

		<div id="dh-modal-alert">
			<div class="dh-modal">
				<div class="dh-modal-content">
					<div class="dh-modal-title">
						<img class="dh-alert-img"
							src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
						알림
					</div>
					<div class="dh-modal-text">복사가 완료되었습니다</div>
				</div>
			</div>
			<div class="dh-modal-blank"></div>
		</div>

	</main>

	<footer>
		<button class="appointmentTodayButton">접수하기</button>
		<button class="appointmentButton">예약하기</button>
	</footer>



	<script type="text/javascript">
	
	//스와이퍼 시작
	const swiper = new Swiper('.swiper', {
		// Optional parameters
		direction : 'horizontal',
		loop : true,
		autoplay : {
			delay : 2000, // 3초마다 변경
		},


	});
    

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = { 
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다


	//주소-좌표 변환 객체를 생성
	let geocoder = new kakao.maps.services.Geocoder();
	// 주소로 좌표를 검색
	geocoder.addressSearch($('#hosptialAddr').val(), function (result, status) {
	  console.log(result);
	  // 정상적으로 검색이 완료됐으면
	  if (status === kakao.maps.services.Status.OK) {
	    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	    var imageSrc = '../img/hospitalMarker.png', // 마커이미지의 주소입니다    
        imageSize = new kakao.maps.Size(32, 34.5), // 마커이미지의 크기입니다
        imageOption = {offset: new kakao.maps.Point(20, 40)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

		    
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
	 
    


	    // 결과값으로 받은 위치를 마커로 표시합니다
	    var marker = new kakao.maps.Marker({
	      map: map,
	      position: coords,
	      image : markerImage
	    });

	    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	    map.setCenter(coords);
	  }
	});
 
</script>
</body>
</html>