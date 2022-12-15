<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>주소로 장소 표시하기</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

<div id="map" style="width:100%;height:700px;"> </div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5c64487a2bc34f26ca438a731c49428a&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 약국 정보 JSON url
let url = "https://api.odcloud.kr/api/15051494/v1/uddi:65a2cf4b-158c-4c5f-8475-c50f28b24ead?page=1&perPage=20&serviceKey=TeASiLVOpaWAX3zH%2BuZSjaPK%2BXmCXmY34elLort62EQZVqDToLE4Sywb19hlf0ghIq5Z3Ml44tus7UtJ57F7nQ%3D%3D";

// get 방식으로 데이터를 요청할때 사용하는 json 전용 메서드  
// JSON의 객체 데이터를 data가 받음  
    
$.getJSON(url , function(data){
	for( let i = 0 ; i < data.currentCount; i++){
		let txt ;
		txt += "<tr>";
		txt += 		"<td>"	+ data.data[i].연번	+ "</td>";
		txt += 		"<td>"	+ data.data[i].약국명칭	+ "</td>";
		txt += 		"<td>"	+ data.data[i].전화번호	+ "</td>";
		txt += 		"<td>"	+ data.data[i].도로명주소 	+ "</td>";
		txt += "</tr>";
		
		$("table").append(txt);
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(data.data[i].지번주소, function(result, status) {
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		        // 인포윈도우로 장소에 대한 설명을 표시합니다
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+ data.data[i].약국명칭  +'</div>'
		        });
		        infowindow.open(map, marker);
		        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		        map.setCenter(coords);
		    } 
		}); 
	}
});
		
   
</script>

<table border=1 style="width:100%; text-align:center;">
	<tr> 
		<th>약국 연번</th>
		<th>약국 이름</th>
		<th>약국 번호</th>
		<th>약국 주소</th>
	</tr>
</table>

</body>
</html>