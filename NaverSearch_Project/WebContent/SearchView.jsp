<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">

// 검색 요청 버튼 클릭시 실행할 메서드 정의 
	$(function () {
		$('#searchBtn').click(function(){
			$.ajax({
				url : "./NaverSearchAPI.do",
				type : "get" ,
				data : {
					keyword : $('#keyword').val(),
					startNum : $('#startNum option:selected').val()
				},
				dataType : "json",
				success : sucFuncJson ,
				error : errFunc
			});
		});
	});
	
	// 검색 성공시 실행될 메서드 each 메서드를 사용해 콜백 데이터중 items 부분을 반복 파싱 
	// 콜백 데이터에는 검색 결과가 담겨있으며 items 요소에는 개별 블로그 정보가 원소로 들어가 있음 
	// 파싱된 데이터는 10개씩 문자열에 누적 저장된 후 id 가 searchResult인 영역에 HTML 형태로 출력 
	
	/* * $.each()의 두가지 사용 형식 
		1. DOM 요소를 선택한 후 반복 실행 
			$('선택자').each(function(index , item )){
				선택한 요소의 반복 실행 문장 ; 
			}
		(선택자 : DOM 선택후 반복 )
		2. 배역을 첫 번째 인수로 받아 반복 실행 
			$.each(배열 , function(index , item){
				배열 요소의 반복 실행 문장 ;
			}
		 index : 반복 요소의 인덱스 ( 0부터 시작 ) , item : 반복 요소의 데이터 
	*/
	function sucFuncJson(d){
		var str = "";
		$.each(d.items, function(index , item){
			str += "<ul>";
			str += "	<li> " + (index + 1) + "</li>";
			str += "	<li> " + item.title + "</li>";
			str += "	<li> " + item.description + "</li>";
			str += "	<li> " + item.bloggername + "</li>";
			str += "	<li> " + item.bloggerlink + "</li>";
			str += "	<li> " + item.postdate + "</li>";
			str += "	<li> <a href='" + item.link + "' target=_blank'> 바로가기 </a></li>";
			str += "</ul>";
		});
		$('#searchResult').html(str);
	}
	
	function errFunc(e){
		alert("실패 : " + e.status);
	}
</script>

<style type="text/css">
	ul{ border : 2px #cccccc solid;}
	
	</style>
</head>
<body>
<div>
	<div>
		<form id="searchFrm"> 
			한 페이지에 10개씩 출력됨 <br/>
			<select id="startNum">
				<option value="1"> 1페이지 </option>
				<option value="11"> 2페이지 </option>
				<option value="21"> 3페이지 </option>
				<option value="31"> 4페이지 </option>
				<option value="41"> 5페이지 </option>
			</select>
			<input type="text" id="keyword" placeholder="검색어를 입력하세요." />
			<button type="button" id="searchBtn" > 검색 요청 </button>
		</form>
	</div>
	<div class="row" id="searchResult"> 여기에 검색 결과가 출력됩니다. 
	</div>
</div>
</body>
</html>