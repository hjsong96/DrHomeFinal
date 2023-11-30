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
<link rel="stylesheet" href="./css/hospitalMap.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="./js/wnInterface.js"></script>
<script src="./js/mcore.min.js"></script>
<script src="./js/mcore.extends.js"></script>
<script src="/js/jquery.plugin.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">



<title>Insert title here</title>

<style>
</style>

</head>
<body>

	<header>

		<div class="xi-angle-left xi-x" onclick="location.href = '/main'"></div>
		<div id="searchContainer">
			<input type="text" id="searchInput" placeholder="병원 이름 검색">
			<button id="searchButton">검색</button>
		</div>
	</header>
	<main>


		<button onclick="location.href='/pharmacyMap'" id="pharmacyMap">
			약국<br>지도
		</button>

		<button onclick="refreshPage()" id="currentLocation"
			class="xi-gps xi-x"></button>

		<div class="map_wrap">
			<div id="map"></div>
			<ul id="searchResults"></ul>
		</div>

		<div style="height: 9vh"></div>
	</main>
</body>

<script>

function refreshPage() {
    location.reload();
    var currentLocationButton = document.getElementById('currentLocation');
    currentLocationButton.style.bottom = '30px'; 
}

    var newDiv = document.createElement("div");

    newDiv.id = "infoDiv";
    newDiv.textContent = "";
    newDiv.style.border = "1px solid lightgrey";
    newDiv.style.padding = "10px";
    newDiv.style.position = "absolute";
    newDiv.style.bottom = "-7px"; 
    newDiv.style.left = "0px";
    newDiv.style.zIndex = "1000";
    newDiv.style.backgroundColor = "#fff"; 
    newDiv.style.width = "100%"; 
    newDiv.style.height = "150px";
    newDiv.style.boxShadow = "0px 4px 4px rgba(0, 0, 0, 0.25)";
    newDiv.style.borderRadius = "20px";
     
    document.body.appendChild(newDiv);
</script>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=80e6cca959046a32e36bfd9340bd8485&libraries=services"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=80e6cca959046a32e36bfd9340bd8485"></script>


<script>
var map;

document.addEventListener("DOMContentLoaded", function () {
    var dynamicContainer = document.getElementById("infoDiv");
    dynamicContainer.style.display = 'none';
});

(function () {

	M.plugin("location").current({
	    timeout: 10000,
	    maximumAge: 1,
	    callback: function( result ) {
        if (result.status === 'NS') {
          console.log('This Location Plugin is not supported');
         
        } else if (result.status !== 'SUCCESS') {
        
          if (result.message) {
        	// gps off
        	  console.log(result.status + ':' + result.message);
              initializeMap(37.498599, 127.028575); // 기본 중심 좌표
       
          } else {
            console.log('Getting GPS coords is failed');
           
          }
        } else {
   
          if (result.coords) {
        	  
            var { latitude, longitude } = result.coords;
            var lat = parseFloat(latitude);
            var lon = parseFloat(longitude);
            console.log(lat, lon);
            initializeMap(lat, lon); // 현재 위치의 중심 좌표
           
            var circle;

         // 현위치 표시
            function drawCircle() {
                var currentLevel = map.getLevel();
                // 확대 레벨에 따라 반지름을 조절
                var radius = Math.pow(2, currentLevel - 2) * 10;

                if (circle) {
                    circle.setMap(null);
                }

                circle = new kakao.maps.Circle({
                    center: new kakao.maps.LatLng(lat, lon),
                    radius: radius,
                    strokeWeight: 2,
                    strokeColor: '#00C9FF',
                    strokeOpacity: 0.7,
                    fillColor: '#00C9FF',
                    fillOpacity: 0.3
                });

                circle.setMap(map);
            }         
            drawCircle();

            kakao.maps.event.addListener(map, 'zoom_changed', function() {
                drawCircle();
            });
           
          } else {
            console.log("It cann't get GPS Coords.");
          }
        }
	    }
	});
   
   
 // 지도 초기화
    function initializeMap(centerLat, centerLon) {
        var mapContainer = document.getElementById('map'); 
        var mapOption = {
            center: new kakao.maps.LatLng(centerLat, centerLon), // 지도의 중심좌표
            level: 5 
        };

        map = new kakao.maps.Map(mapContainer, mapOption);

        // 장소의 상세정보
        var placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 1 }),
            contentNode = document.createElement('div'),
            markers = [],
            currCategory = ''; 

        // 주소-좌표 변환 객체
        var geocoder = new kakao.maps.services.Geocoder();
        var hospitals = [];

        var overlay = new kakao.maps.CustomOverlay({
            content: contentNode,
            map: map
        });


        <c:forEach items="${hospitalList}" var="h">
        	var hospitalNumber = "${h.hno}";
            var title = "${h.hname}";
            var address = "${h.haddr}";
            var opentime = "${h.hopentime}";
            var closetime = "${h.hclosetime}";
            var nightday = "${h.hnightday}";
            var nightendtime = "${h.hnightendtime}";
            var hImg = "${h.himg}";
            var hBreakTime = "${h.hbreaktime}";
            var hBreakEndTime = "${h.hbreakendtime}";
            var hHoliday = "${h.hholiday}";
            var hHolidayEndTime = "${h.hholidayendtime}";
            
            
            hospitals.push({
            	hospitalNumber: hospitalNumber,
                title: title,
                address: address,
                opentime: opentime,
                closetime: closetime,
                nightday: nightday,
                nightendtime: nightendtime,
                hImg: hImg,
                hBreakTime: hBreakTime,
                hBreakEndTime: hBreakEndTime,
                hHoliday : hHoliday,
                hHolidayEndTime : hHolidayEndTime
            });
        </c:forEach>
        
        

     // 클릭 이벤트
        document.addEventListener('click', function (event) {
            if (event.target.closest('#searchResults') || event.target.closest('#searchButton')) {
                return;
            }

            if (searchResults.style.display === 'block') {
                searchResults.style.display = 'none';
            }
        });
        


        var searchButton = document.getElementById('searchButton');

     // 검색 버튼 클릭
        searchButton.addEventListener('click', function () {
            var keyword = searchInput.value.trim();
            searchResults.innerHTML = '';
          if (!keyword) {
                return;
            }

            hospitals.forEach(function (hospital) {
                if (hospital.title.includes(keyword)) {
                    var listItem = document.createElement('li');
                    listItem.textContent = hospital.title;

                 // 해당 병원을 지도에 표시
                    listItem.addEventListener('click', function () {
                        geocoder.addressSearch(hospital.address, function (result, status) { 
                            if (status === kakao.maps.services.Status.OK) {
                                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                                map.panTo(coords);
                            }
                        });
                    });
                 
                   listItem.style.marginTop = '5px';
                   listItem.style.marginBottom = '5px';
                    listItem.style.fontSize = '14px';
                    listItem.style.borderBottom = '1px solid lightgray'; 
                    listItem.style.padding = '2%';


                    searchResults.appendChild(listItem);
                }
            });

            if (searchResults.children.length > 0) {
                searchResults.style.display = 'block';
            } else {
                searchResults.style.display = 'none';
            }
        });


        function timeToMinutes(time) {
            const parts = time.split(":");
            if (parts.length === 2) {
                const hours = parseInt(parts[0], 10);
                const minutes = parseInt(parts[1], 10);
                return hours * 60 + minutes;
            }
            return 0; // 예외 처리
        }

        function checkBusinessStatus(opentime, closetime, nightday, nightendtime, hHoliday, hHolidayEndTime) {
            const now = new Date();
            const currentDay = now.getDay(); // 0: 일요일, 1: 월요일, ..., 6: 토요일
            const currentTime = now.getHours() * 60 + now.getMinutes(); 

            const openMinutes = timeToMinutes(opentime);
            const closeMinutes = timeToMinutes(closetime);
            const nightEndMinutes = timeToMinutes(nightendtime);
            const holidayEndMinutes = timeToMinutes(hHolidayEndTime);

           
            if(currentDay == 0 || currentDay == 6) {
            	if(hHoliday == 1){   		
            		if (currentTime >= openMinutes && currentTime <= holidayEndMinutes) {
                     return "진료중";        
                 } else { 
                     return "진료종료";
                 }
            	} else {    		
            		 return "휴진일";
            	}          	
            } else {          	
            	if(currentTime >= hBreakTime && currentTime <= hBreakEndTime){
                    return "점심시간";        
                } else {

                	 if (nightday == currentDay) {
                         if (currentTime >= openMinutes && currentTime <= nightEndMinutes) {
                             return "진료중";        
                         } else {
                             return "진료종료";
                         }
                     } else {
                         if (currentTime >= openMinutes && currentTime <= closeMinutes) {
                             return "진료중";
                         } else { 
                             return "진료종료";
                         }
                     }  
                }
          
            }
        }


        function handleMarkerClick(position) {

            var hospitalNumber = position.hospitalNumber;
            var title = position.title;
            var address = position.address;
            var opentime = position.opentime;
            var closetime = position.closetime;
            var nightendtime = position.nightendtime;
            var nightday = position.nightday;
            var hImg = position.hImg;
            var hBreakTime = position.hBreakTime;
            var hBreakEndTime = position.hBreakEndTime;
            var hHoliday = position.hHoliday;
            var hHolidayEndTime = position.hHolidayEndTime;

            const currentDay = new Date().getDay(); // 0: 일요일, 1: 월요일, ..., 6: 토요일         
            
            // 영업 상태를 확인
            var status = checkBusinessStatus(opentime, closetime, nightday, nightendtime, hHoliday, hHolidayEndTime);

            var dotClass = "";

            if (status === "진료중") {
                dotClass = "availableDot";
            } else {
                dotClass = "unavailableDot";
            }
            
            // 컨테이너에 정보 추가
            var dynamicContainer = document.getElementById("infoDiv");
            dynamicContainer.innerHTML =
                '<div class="wrap">' +
                '    <div class="info"><a href="/hospitalDetail/' + hospitalNumber + '" target="_blank" class="link">' +
                '        <div class="title">' +
                '            ' + title +
                '        </div>' +
                '        <div class="body">' +
                '            <div class="img">' +
                '                <img src="' + hImg + '" width="73" height="70">' +
                '           </div>' +
                '            <div class="desc">' +
                '                <div class="ellipsis">' + address + '</div>' +
                '                <div class="time">' + opentime + "~" + (nightday == currentDay ? nightendtime : (hHoliday == 1 ? hHolidayEndTime : closetime)) + '</div>' +
                '            </div>' +
                '            <div class="' + dotClass + '">' + "●" + '</div>' +
                '                <div class="status">' + status + '</div>' +
                '        </div>' +
                '    </a></div>' +       
                '</div>';


            dynamicContainer.style.display = 'block';
             
            var currentLocationButton = document.getElementById('currentLocation');
            currentLocationButton.style.bottom = '160px';
        }
        
    

        hospitals.forEach(function (position) {
            // 주소로 좌표 검색
            geocoder.addressSearch(position.address, function (result, status) {
                // 검색 완료
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                    var imageSrc = '/img/hospitalMarker.png',  
                        imageSize = new kakao.maps.Size(32, 34.5),
                        imageOption = {offset: new kakao.maps.Point(20, 50)};
           

                    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
                 
 
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords,
                        image: markerImage
                    });

                    kakao.maps.event.addListener(marker, 'click', function () {
                        handleMarkerClick(position);
                    });


                    kakao.maps.event.addListener(map, 'click', function (mouseEvent) {
                        
                        if (!mouseEvent.target || !mouseEvent.target.toString().includes('Marker')) {
                            var dynamicContainer = document.getElementById("infoDiv");
                            dynamicContainer.style.display = 'none';
                            
                            var currentLocationButton = document.getElementById('currentLocation');
                            currentLocationButton.style.bottom = '30px'; 
                        }
                    });
                    
              
                }
            });
        });
    } 
   
  })();


</script>




</html>